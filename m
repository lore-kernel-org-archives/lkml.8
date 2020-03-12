Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09FBC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2D206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf69EOqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCLMyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:54:43 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37703 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgCLMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:54:43 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so5339094ilc.4;
        Thu, 12 Mar 2020 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGkwaq8lw7fMLDfPL6B7cGksh4Hi48p1DuxNEtaP3pU=;
        b=Gf69EOqM6TQqgC3wTSdK4qgWrFm6DxXSZiHEFmOgcazELU2xKkWAc34F0RRQnw/lK3
         4G/DvyEWuH19UdafLL1H23PvJhDfp0Pdr71urqsapvnAiLFBQgDM3wA0sW1ve9xjjl4S
         /AKA22xX1nbuFgAgevXyKLe6S0tLzx+OYqrtVIfpUfBFcbjn+BsvxwL0kiNsQRnqrH4/
         7zf3wLdW5yBqU5GwijW4WYHa85kLU+Mgv3aZXzqM17oeKYST466xcCKjrQK4my/vUV+A
         oEWswayw/ljYT+wL81GJ0oFCBewwYM0i0acOAAReKGqAi7j8uNHXgz1jEKmjyD1yQ+TL
         lPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGkwaq8lw7fMLDfPL6B7cGksh4Hi48p1DuxNEtaP3pU=;
        b=JXmy4lUJ4BkEkURIVpe8jme1sqwd/RfoR7binpn1Ae4wqfhRs+01Dp/VOAEwlf8wMK
         +t/T5rTLfPUXuICaFVYK3wGJicysgDy9T99BTMHLvwWo0iTVnJL57ICLelBfuvhd8uvQ
         dxpoCt/td8WYSe+3hPBFbRI/ndZ1VzZcDwQ7i+hH4gxrE8hnmRiRSzNlCmNi279wkz3q
         vOAoPttVJ6HBiOGGwBUeCy6j6tdQVYoJ7hWFqG75IfnaFwCkpnvZJq5+/2PcFJZy0Fc1
         XKC5smhRTNA3zc9dF6oQjdMmDdVR2NVrU4L29aiTrbuo/C3q8bRtzmaiqApqrvhdQr5e
         9Pzg==
X-Gm-Message-State: ANhLgQ2m3jOJad0c1OlnCSKmmd5JAbrDdBu8DGNU9musO3TSwLhn5H74
        KuXtJwcQexQg0ebOKvVbnhxaiz3ezufTlOe01QriaXZ+
X-Google-Smtp-Source: ADFU+vv+kpji+ynroJiBDzsRd7WhZYytunKgmF0KXs+VSTXf5eOLwMqu0/hlD41bGO5/ir6ecQTiSgXijOGmBe/G3yA=
X-Received: by 2002:a92:c008:: with SMTP id q8mr4757821ild.221.1584017681454;
 Thu, 12 Mar 2020 05:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-6-linux.amoon@gmail.com>
 <20200311144248.GA4455@kozik-lap> <CANAwSgQWYdh3awuMCjUvz6EvnwMq9rDOSBn5EkNcA7OfsjoEwA@mail.gmail.com>
 <20200312113618.GA6206@pi3>
In-Reply-To: <20200312113618.GA6206@pi3>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 12 Mar 2020 18:24:30 +0530
Message-ID: <CANAwSgQOLRAW8zTBfPgBxXkJ8AaXyjGXc8+eQ9PUowOo5zDP6A@mail.gmail.com>
Subject: Re: [PATCHv3 5/5] clk: samsung: exynos542x: Move FSYS subsystem
 clocks to its sub-CMU
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 12 Mar 2020 at 17:06, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Mar 12, 2020 at 04:04:57PM +0530, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > Thanks for your review comments.
> >
> > On Wed, 11 Mar 2020 at 20:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 07:48:54PM +0000, Anand Moon wrote:
> > > > FSYS power domain support usbdrd3, pdma and usb2 power gaiting,
> > > > hence move FSYS clk setting to sub-CMU block to support power domain
> > > > on/off sequences for device nodes.
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > New patch in the series
> > > > ---
> > > >  drivers/clk/samsung/clk-exynos5420.c | 45 +++++++++++++++++++++-------
> > > >  1 file changed, 34 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> > > > index c9e5a1fb6653..6c4c47dfcdce 100644
> > > > --- a/drivers/clk/samsung/clk-exynos5420.c
> > > > +++ b/drivers/clk/samsung/clk-exynos5420.c
> > > > @@ -859,12 +859,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
> > > >       DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
> > > >       DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
> > > >
> > > > -     /* USB3.0 */
> > > > -     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > > > -     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > > > -     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > > > -     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> > >
> > > According to clock diagram these are still in CMU TOP, not FSYS.
> > >
> > > > -
> > > >       /* MMC */
> > > >       DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
> > > >       DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
> > > > @@ -1031,8 +1025,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> > > />
> > > >       /* FSYS Block */
> > > >       GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
> > > > -     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > > > -     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > > >       GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
> > > >       GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
> > > >       GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
> > > > @@ -1040,9 +1032,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> > > >       GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
> > > >       GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
> > > >                       GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
> > > > -     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > > > -     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > > > -     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > > >       GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
> > > >                       SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
> > > >
> > > > @@ -1258,6 +1247,28 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
> > > >       { DIV2_RATIO0, 0, 0x30 },       /* DIV dout_gscl_blk_300 */
> > > >  };
> > > >
> > > > +/* USB3.0 */
> > > > +static const struct samsung_div_clock exynos5x_fsys_div_clks[] __initconst = {
> > > > +     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > > > +     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > > > +     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > > > +     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> > > > +};
> > > > +
> > > > +static const struct samsung_gate_clock exynos5x_fsys_gate_clks[] __initconst = {
> > > > +     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > > > +     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > > > +     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > > > +     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > > > +     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > > > +};
> > > > +
> > > > +static struct exynos5_subcmu_reg_dump exynos5x_fsys_suspend_regs[] = {
> > > > +     { GATE_IP_FSYS, 0xffffffff, 0xffffffff }, /* FSYS gates */
> > >
> > > This looks wrong. GATE_IP_FSYS has fields also for FSYS2 clocks which
> > > you are not suspending. They do not belong to this CMU.
> > >
> >
> > Ok. I change the from GATE_IP_FSYS to GATE_BUS_FSYS0 in the above
> > exynos5x_fsys_gate_clks to make this consistent to used GATE_BUS_FSYS0 for CMU,
> > with this change it works as per previously.
>
> Wait, you should set here proper registers with proper mask.

Yes I will set the proper mask for each as per the Exynos 5422 User Manual.

Here is what I feel
CLK_GATE_BUS_FSYS0 controls the PHY clock
CLK_GATE_IP_FSYS controls the IP clock.

So both these field should be part of this FSYS CMU.

> >
> > > Don't you need to save also parts of GATE_BUS_FSYS0?
> >
> > GATE_BUS_FSYS0 and GATE_IP_FSYS are already part of list
> > of control register which are saved and restored during suspend and resume
> > so no point in adding this here, I should drop the GATE_IP_FSYS reg
> > dump over here.
>
> Since registers are used in separate sub CMU devices, each should
> save/restore its part.

Ok I will add both GATE_BUS_FSYS0 and GATE_IP_FSYS
reset value over here.

>
> Best regards,
> Krzysztof
>

-Anand
