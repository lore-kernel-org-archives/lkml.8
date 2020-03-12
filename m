Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB95206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWlD5nyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCLKfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:35:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37855 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:35:11 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so4968846ilc.4;
        Thu, 12 Mar 2020 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d11jKh4nIXxOO14qhhlowcRFY/zdekEryEZGjxCyR4U=;
        b=dWlD5nySofCuFcC1KqOfJXf0Pm6lXznegz4dEb3SJMlcVi6TNUBD8je8acrRZWM7u6
         4YszOga5UvfaxttN2thsNJs3wyA9EB93WgLz/EkoxOj2WIxKOLfENbGt5wG+u9Q5VQT5
         zYNGkVJo1tGM99CWwAQ827pIAUgzvPM9tF0IGqEZI1G4dSY6VwfbaJfFLEB9p5g1wtbk
         kQieh2ZvT6ZXAs++6I1aRURG/WlZCJ3J2/8IBVSPNwLd6Y8RWdbQd91cXc7jUv5HaRMS
         nqpayk0UHPrXjo/+K3xd8gnASiS9z9xLZ2vOb0piFQdLeowUojeYezEGIia3++pn6Gl7
         ij/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d11jKh4nIXxOO14qhhlowcRFY/zdekEryEZGjxCyR4U=;
        b=lywhp+0tg2g6SPWERclpboChVM2kpEcc+i/kYCobC9QJcJ/MKJ/5jrlQijYcB0DdE+
         CyO7GAXX8wmJx61w++KqAnWn+NeJKuUXLTT5zYiWLubikQZxaSVxVshEE9i3Pm1Lg3VI
         PH9qePY+X7SSa0sXYPV/wtthBHUnGCBGzjNtsYGXBEGO3tQNeqQdrDLuccYOgCIwkuTV
         5KjEIfkpc+Cs5XjE4eqRVGI5iFhOmtMydZrEgwiunHrAxAN8Xg5Pp8UlEfXD7EmjCoxw
         dK5UnhwvWkgql8Tzp12qUl9Xm9nTieYkPnQAy6oDz9MvI2eSP99gEJXbHNrOQRuQ5InD
         KsTA==
X-Gm-Message-State: ANhLgQ169z8nH+AIjkCKTkkLnPgV+UHsCxWAUnV0i2/Nyvlkq0TooywP
        IU3KUoP9pVnE29plHroAZIf/Wl/mJ1geMyVhG/I=
X-Google-Smtp-Source: ADFU+vvSRlyq9Zdi/fl/WLdv2Po6WICy6RqRd2FY2vS+d6/LY3eKydss4wYnT9C5FUYvIXP6ufBuZlUYC9tzxOFzjhA=
X-Received: by 2002:a92:af8c:: with SMTP id v12mr7879184ill.6.1584009309784;
 Thu, 12 Mar 2020 03:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200310194854.831-1-linux.amoon@gmail.com> <20200310194854.831-6-linux.amoon@gmail.com>
 <20200311144248.GA4455@kozik-lap>
In-Reply-To: <20200311144248.GA4455@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 12 Mar 2020 16:04:57 +0530
Message-ID: <CANAwSgQWYdh3awuMCjUvz6EvnwMq9rDOSBn5EkNcA7OfsjoEwA@mail.gmail.com>
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

Thanks for your review comments.

On Wed, 11 Mar 2020 at 20:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 07:48:54PM +0000, Anand Moon wrote:
> > FSYS power domain support usbdrd3, pdma and usb2 power gaiting,
> > hence move FSYS clk setting to sub-CMU block to support power domain
> > on/off sequences for device nodes.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > New patch in the series
> > ---
> >  drivers/clk/samsung/clk-exynos5420.c | 45 +++++++++++++++++++++-------
> >  1 file changed, 34 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> > index c9e5a1fb6653..6c4c47dfcdce 100644
> > --- a/drivers/clk/samsung/clk-exynos5420.c
> > +++ b/drivers/clk/samsung/clk-exynos5420.c
> > @@ -859,12 +859,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
> >       DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
> >       DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
> >
> > -     /* USB3.0 */
> > -     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > -     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > -     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > -     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
>
> According to clock diagram these are still in CMU TOP, not FSYS.
>
> > -
> >       /* MMC */
> >       DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
> >       DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
> > @@ -1031,8 +1025,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> />
> >       /* FSYS Block */
> >       GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
> > -     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > -     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> >       GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
> >       GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
> >       GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
> > @@ -1040,9 +1032,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> >       GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
> >       GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
> >                       GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
> > -     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > -     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > -     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> >       GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
> >                       SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
> >
> > @@ -1258,6 +1247,28 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
> >       { DIV2_RATIO0, 0, 0x30 },       /* DIV dout_gscl_blk_300 */
> >  };
> >
> > +/* USB3.0 */
> > +static const struct samsung_div_clock exynos5x_fsys_div_clks[] __initconst = {
> > +     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > +     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > +     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > +     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> > +};
> > +
> > +static const struct samsung_gate_clock exynos5x_fsys_gate_clks[] __initconst = {
> > +     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > +     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > +     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > +     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > +     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > +};
> > +
> > +static struct exynos5_subcmu_reg_dump exynos5x_fsys_suspend_regs[] = {
> > +     { GATE_IP_FSYS, 0xffffffff, 0xffffffff }, /* FSYS gates */
>
> This looks wrong. GATE_IP_FSYS has fields also for FSYS2 clocks which
> you are not suspending. They do not belong to this CMU.
>

Ok. I change the from GATE_IP_FSYS to GATE_BUS_FSYS0 in the above
exynos5x_fsys_gate_clks to make this consistent to used GATE_BUS_FSYS0 for CMU,
with this change it works as per previously.

> Don't you need to save also parts of GATE_BUS_FSYS0?

GATE_BUS_FSYS0 and GATE_IP_FSYS are already part of list
of control register which are saved and restored during suspend and resume
so no point in adding this here, I should drop the GATE_IP_FSYS reg
dump over here.

>
> > +     { SRC_TOP3, 0, BIT(24) },                 /* SW_MUX_PCLK_200_FSYS_SEL */
> > +     { SRC_TOP3, 0, BIT(28) },                 /* SW_MUX_ACLK_200_FSYS_SEL */
>
> Name of clocks from the driver please, not from datasheet. Look at other
> examples.
>

Ok  I will update this as per the examples.

> Best regards,
> Krzysztof
>
>

-Anand

> > +};
> > +
> >  static const struct samsung_gate_clock exynos5x_g3d_gate_clks[] __initconst = {
> >       GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9,
> >            CLK_SET_RATE_PARENT, 0),
> > @@ -1376,12 +1387,23 @@ static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
> >       .pd_name        = "MAU",
> >  };
> >
> > +static const struct exynos5_subcmu_info exynos5x_fsys_subcmu = {
> > +     .div_clks       = exynos5x_fsys_div_clks,
> > +     .nr_div_clks    = ARRAY_SIZE(exynos5x_fsys_div_clks),
> > +     .gate_clks      = exynos5x_fsys_gate_clks,
> > +     .nr_gate_clks   = ARRAY_SIZE(exynos5x_fsys_gate_clks),
> > +     .suspend_regs   = exynos5x_fsys_suspend_regs,
> > +     .nr_suspend_regs = ARRAY_SIZE(exynos5x_fsys_suspend_regs),
> > +     .pd_name        = "FSYS",
> > +};
> > +
> >  static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
> >       &exynos5x_disp_subcmu,
> >       &exynos5x_gsc_subcmu,
> >       &exynos5x_g3d_subcmu,
> >       &exynos5x_mfc_subcmu,
> >       &exynos5x_mscl_subcmu,
> > +     &exynos5x_fsys_subcmu,
> >  };
> >
> >  static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
> > @@ -1391,6 +1413,7 @@ static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
> >       &exynos5x_mfc_subcmu,
> >       &exynos5x_mscl_subcmu,
> >       &exynos5800_mau_subcmu,
> > +     &exynos5x_fsys_subcmu,
> >  };
> >
> >  static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
> > --
> > 2.25.1
> >
