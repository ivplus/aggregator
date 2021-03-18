# frozen_string_literal: true

xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
xml.urlset(
  'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
  'xsi:schemaLocation' => 'http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd',
  'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9',
  'xmlns:rs' => 'http://www.openarchives.org/rs/terms/'
) do
  xml.tag!('rs:ln', rel: 'up', href: normalized_resourcelist_organizations_url)
  xml.tag!('rs:md', capability: 'resourcelist', at: @normalized_dump.updated_at&.iso8601)

  if @normalized_dump.persisted?
    xml.url do
      xml.loc(removed_since_previous_stream_organization_stream_url(@stream))
    end

    full = if params[:flavor] == 'marc21'
             @normalized_dump.marc21.attachment&.blob
           else
             @normalized_dump.marcxml.attachment&.blob
           end

    if full
      xml.url do
        xml.tag!(
          'rs:md',
          hash: "md5:#{Base64.decode64(full.checksum).unpack1('H*')}",
          type: full.content_type,
          length: full.byte_size
        )
        xml.loc(download_url(full))
        xml.lastmod(full.created_at.iso8601)
      end
    end

    # deltas

    @normalized_dump.deltas.each do |delta|
      file = if params[:flavor] == 'marc21'
               delta.marc21.attachment&.blob
             else
               delta.marcxml.attachment&.blob
             end

      if file
        xml.url do
          xml.tag!(
            'rs:md',
            hash: "md5:#{Base64.decode64(file.checksum).unpack1('H*')}",
            type: file.content_type,
            length: file.byte_size
          )
          xml.loc(download_url(file))
          xml.lastmod(file.created_at.iso8601)
        end
      end

      next unless delta.deletes.attachment

      xml.url do
        xml.tag!(
          'rs:md',
          hash: "md5:#{Base64.decode64(delta.deletes.attachment.blob.checksum).unpack1('H*')}",
          type: delta.deletes.attachment.blob.content_type,
          length: delta.deletes.attachment.blob.byte_size
        )
        xml.loc(download_url(delta.deletes.attachment.blob))
        xml.lastmod(delta.deletes.attachment.blob.created_at.iso8601)
      end
    end
  end
end
