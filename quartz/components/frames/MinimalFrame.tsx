import { PageFrame, PageFrameProps } from "./types"

export const MinimalFrame: PageFrame = {
  name: "minimal",
  render({ componentData, pageBody: Content, footer }: PageFrameProps) {
    return (
      <>
        <a class="skip-link" href="#main-content">
          Skip to main content
        </a>
        <main class="center minimal" id="main-content" tabindex={-1}>
          <Content {...componentData} />
        </main>
        {footer.map((FooterComponent) => (
          <FooterComponent {...componentData} />
        ))}
      </>
    )
  },
}
