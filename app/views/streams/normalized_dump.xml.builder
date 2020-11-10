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
    xml.url(removed_since_previous_stream_organization_stream_url(@stream))

    full = if params[:flavor] == 'marc21'
             @normalized_dump.full_dump_binary
           else
             @normalized_dump.full_dump_xml
           end

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

    # deltas

    deltas = if params[:flavor] == 'marc21'
               @normalized_dump.delta_dump_binary
             else
               @normalized_dump.delta_dump_xml
             end

    deltas.each do |file|
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
  end
end