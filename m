Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB0C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7536420716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584012986;
	bh=LKWtGGI9AnwEudfUs8VdWf8pChWSEoS/sWmnLwQTbwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cDhvpEXFmcr0QHdXBhrBbV+uM3ZmQbNW0tgoxeaHdIzBXkCLbXsY1JNN+9FvwXQBu
	 9nZZZ6M2L+Am4tYgxHVw/8mtUYYKUDsm23/rTxEed7tU26kH73qo0ySAJ9ChRpzr9a
	 ylERw1ZNA3qd0SHCG/ZA3NWV5Z5+yyLyYfeeBN6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCLLgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:36:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39594 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:36:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id df19so782401edb.6;
        Thu, 12 Mar 2020 04:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SU5e8ThZ/jC6l2UHW2mQ5E13HASsfjr4EObVUxdLUKU=;
        b=hE6aLurI21dc7rP1w4ZEV0CdNNOTs8HeoGRJ+kK9fYyS6q1sr3btQUR5OGdyIcE9Nj
         ClQFjBiIclBgc3AwZpuwqn3F92g8/Gk2ps0vEsmXvXUUWZ0TDylXnJrms3hbChicWeZA
         3C4lYlKmI4Z9v65IAGVubl2hlWr7bfHaCmL+U1FpNLxjxqr7RyMwrhX9UMZZc2MQQ2lR
         46afVyie7xl22BBa3/GN3XWQH/Mm+mayVbXZQfnzVWP8s0uEL3uw/dSES+mLa6JJYso4
         UaWnbFM+w9dNS+b/5CO4dpDzjxNIsgghdZe0RcAoelqCUtl08RPOcwPA3hCKIzFZCgjy
         6Spw==
X-Gm-Message-State: ANhLgQ0qM1LNkwD3DQoLdxG4oY/uR8pEe6cxmjJLYqAn73dh4/VQgy2d
        fUSHZf7oe8oe/05dnKAMh2o=
X-Google-Smtp-Source: ADFU+vsylhNgZSPB6ysmt4xorqw0nqsEk6Kn+5R8nMgLFy+Xyx8N/GRpEYUw1R9C56oPpL4PPbVHKQ==
X-Received: by 2002:a50:ec0b:: with SMTP id g11mr7520505edr.80.1584012982435;
        Thu, 12 Mar 2020 04:36:22 -0700 (PDT)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id v5sm377196edt.43.2020.03.12.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 04:36:21 -0700 (PDT)
Date:   Thu, 12 Mar 2020 12:36:18 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
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
Subject: Re: [PATCHv3 5/5] clk: samsung: exynos542x: Move FSYS subsystem
 clocks to its sub-CMU
Message-ID: <20200312113618.GA6206@pi3>
References: <20200310194854.831-1-linux.amoon@gmail.com>
 <20200310194854.831-6-linux.amoon@gmail.com>
 <20200311144248.GA4455@kozik-lap>
 <CANAwSgQWYdh3awuMCjUvz6EvnwMq9rDOSBn5EkNcA7OfsjoEwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgQWYdh3awuMCjUvz6EvnwMq9rDOSBn5EkNcA7OfsjoEwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:04:57PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> Thanks for your review comments.
> 
> On Wed, 11 Mar 2020 at 20:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Tue, Mar 10, 2020 at 07:48:54PM +0000, Anand Moon wrote:
> > > FSYS power domain support usbdrd3, pdma and usb2 power gaiting,
> > > hence move FSYS clk setting to sub-CMU block to support power domain
> > > on/off sequences for device nodes.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > New patch in the series
> > > ---
> > >  drivers/clk/samsung/clk-exynos5420.c | 45 +++++++++++++++++++++-------
> > >  1 file changed, 34 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> > > index c9e5a1fb6653..6c4c47dfcdce 100644
> > > --- a/drivers/clk/samsung/clk-exynos5420.c
> > > +++ b/drivers/clk/samsung/clk-exynos5420.c
> > > @@ -859,12 +859,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
> > >       DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
> > >       DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
> > >
> > > -     /* USB3.0 */
> > > -     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > > -     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > > -     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > > -     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> >
> > According to clock diagram these are still in CMU TOP, not FSYS.
> >
> > > -
> > >       /* MMC */
> > >       DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
> > >       DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
> > > @@ -1031,8 +1025,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> > />
> > >       /* FSYS Block */
> > >       GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
> > > -     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > > -     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > >       GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
> > >       GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
> > >       GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
> > > @@ -1040,9 +1032,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> > >       GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
> > >       GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
> > >                       GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
> > > -     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > > -     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > > -     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > >       GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
> > >                       SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
> > >
> > > @@ -1258,6 +1247,28 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
> > >       { DIV2_RATIO0, 0, 0x30 },       /* DIV dout_gscl_blk_300 */
> > >  };
> > >
> > > +/* USB3.0 */
> > > +static const struct samsung_div_clock exynos5x_fsys_div_clks[] __initconst = {
> > > +     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > > +     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > > +     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > > +     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> > > +};
> > > +
> > > +static const struct samsung_gate_clock exynos5x_fsys_gate_clks[] __initconst = {
> > > +     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > > +     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > > +     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > > +     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > > +     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > > +};
> > > +
> > > +static struct exynos5_subcmu_reg_dump exynos5x_fsys_suspend_regs[] = {
> > > +     { GATE_IP_FSYS, 0xffffffff, 0xffffffff }, /* FSYS gates */
> >
> > This looks wrong. GATE_IP_FSYS has fields also for FSYS2 clocks which
> > you are not suspending. They do not belong to this CMU.
> >
> 
> Ok. I change the from GATE_IP_FSYS to GATE_BUS_FSYS0 in the above
> exynos5x_fsys_gate_clks to make this consistent to used GATE_BUS_FSYS0 for CMU,
> with this change it works as per previously.

Wait, you should set here proper registers with proper mask.
> 
> > Don't you need to save also parts of GATE_BUS_FSYS0?
> 
> GATE_BUS_FSYS0 and GATE_IP_FSYS are already part of list
> of control register which are saved and restored during suspend and resume
> so no point in adding this here, I should drop the GATE_IP_FSYS reg
> dump over here.

Since registers are used in separate sub CMU devices, each should
save/restore its part.

Best regards,
Krzysztof

