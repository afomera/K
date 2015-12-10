module PostsHelper
  def markdownify(content)
    pipeline_context = { gfm: true }
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
    ], pipeline_context
    pipeline.call(content)[:output].to_s.html_safe
  end
end
