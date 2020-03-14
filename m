Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F05C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D730205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584241760;
	bh=e3OYRYUgzem3sxA5lBwJc1DY9P7L/XE31z/OAEaEQs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qsnJr3T/ZQ4Rs/t+8loa3iBytAM+EHpgFq7sUHB5C68RBDS4bp1TTaD0z7FRoMbwI
	 H9MTW3LKJUfDam0xRRfOX8gpfivZ8wAY4ZluYg2hWL6PZfRxbs2m1kTFiqpgVWFm48
	 uwX2BImjXg/MpgFMUXl4d5+czEj7ORCXcjqn89oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCODJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:09:19 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43546 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgCODJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:09:18 -0400
Received: by mail-ed1-f49.google.com with SMTP id dc19so17416242edb.10;
        Sat, 14 Mar 2020 20:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgOverYYA4jA/93Ai/jb2egs1mkI7q35yYWNe0ct6c0=;
        b=V8nUU3Uk5Iqya6dDXk5gITks5cbSv3Jdl+YxNla1OG8wdGsUVwROqPEyaMQ1++uprw
         FCAjwEjXLFWtTIP8pdFsu1in/NesKW+0/qgkFczVkqu9VDszm/hjps0Itatcic3g4WTS
         LKtw+cYotu7dLCxQn6A5fvtCmFJuHqbzquiktA/Daa1YQLXo7uuHwFj6K6WWVQ6LdpA4
         YDpu1wLXkU/bG8VTtZ8pKA5jkfXHicLi5w3NhvCEV4dULYnSFhQYOxDIABY/64BvFy5Y
         R/8oO9qR9pUxMLjW6sBG2t02BL+f7gUNT+ok0+OVTBadyr6gjSu1TQGQ5dZO7qy9kcTv
         w0qg==
X-Gm-Message-State: ANhLgQ0B/BF1vHbvfSD0cxDBtrA7XBFJ0zPoVSg0Pkw0h2u6mfgHXPLz
        tc3SCzh8wT4eXrZrSpQeUWp+mVR1s68=
X-Google-Smtp-Source: ADFU+vvSO2GNlUjV6/Zp2Fz+b2P92ILGU9eEpunxkHK5UxSTsOblN74/X/UafCVORzRhQox9oPDiUQ==
X-Received: by 2002:a17:906:ece7:: with SMTP id qt7mr7281553ejb.216.1584207677447;
        Sat, 14 Mar 2020 10:41:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id ba5sm89515edb.89.2020.03.14.10.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 10:41:16 -0700 (PDT)
Date:   Sat, 14 Mar 2020 18:41:13 +0100
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
Message-ID: <20200314174113.GA17580@kozik-lap>
References: <20200310194854.831-1-linux.amoon@gmail.com>
 <20200310194854.831-6-linux.amoon@gmail.com>
 <20200311144248.GA4455@kozik-lap>
 <CANAwSgQWYdh3awuMCjUvz6EvnwMq9rDOSBn5EkNcA7OfsjoEwA@mail.gmail.com>
 <20200312113618.GA6206@pi3>
 <CANAwSgQOLRAW8zTBfPgBxXkJ8AaXyjGXc8+eQ9PUowOo5zDP6A@mail.gmail.com>
 <CANAwSgRfwr47DhehdvjhcJJ91r3XWXmQVgb6Mk+kPjPVz5uhzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgRfwr47DhehdvjhcJJ91r3XWXmQVgb6Mk+kPjPVz5uhzw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 07:38:30PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Thu, 12 Mar 2020 at 18:24, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Krzysztof,
> >
> > On Thu, 12 Mar 2020 at 17:06, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Thu, Mar 12, 2020 at 04:04:57PM +0530, Anand Moon wrote:
> > > > Hi Krzysztof,
> > > >
> > > > Thanks for your review comments.
> > > >
> > > > On Wed, 11 Mar 2020 at 20:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >
> > > > > On Tue, Mar 10, 2020 at 07:48:54PM +0000, Anand Moon wrote:
> > > > > > FSYS power domain support usbdrd3, pdma and usb2 power gaiting,
> > > > > > hence move FSYS clk setting to sub-CMU block to support power domain
> > > > > > on/off sequences for device nodes.
> > > > > >
> > > > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > > > ---
> > > > > > New patch in the series
> > > > > > ---
> > > > > >  drivers/clk/samsung/clk-exynos5420.c | 45 +++++++++++++++++++++-------
> > > > > >  1 file changed, 34 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> > > > > > index c9e5a1fb6653..6c4c47dfcdce 100644
> > > > > > --- a/drivers/clk/samsung/clk-exynos5420.c
> > > > > > +++ b/drivers/clk/samsung/clk-exynos5420.c
> > > > > > @@ -859,12 +859,6 @@ static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
> > > > > >       DIV(0, "dout_maudio0", "mout_maudio0", DIV_MAU, 20, 4),
> > > > > >       DIV(0, "dout_maupcm0", "dout_maudio0", DIV_MAU, 24, 8),
> > > > > >
> > > > > > -     /* USB3.0 */
> > > > > > -     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > > > > > -     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > > > > > -     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > > > > > -     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> > > > >
> > > > > According to clock diagram these are still in CMU TOP, not FSYS.
> > > > >
> > > > > > -
> > > > > >       /* MMC */
> > > > > >       DIV(0, "dout_mmc0", "mout_mmc0", DIV_FSYS1, 0, 10),
> > > > > >       DIV(0, "dout_mmc1", "mout_mmc1", DIV_FSYS1, 10, 10),
> > > > > > @@ -1031,8 +1025,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> > > > > />
> > > > > >       /* FSYS Block */
> > > > > >       GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
> > > > > > -     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > > > > > -     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > > > > >       GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
> > > > > >       GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
> > > > > >       GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
> > > > > > @@ -1040,9 +1032,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
> > > > > >       GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
> > > > > >       GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
> > > > > >                       GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
> > > > > > -     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > > > > > -     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > > > > > -     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > > > > >       GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
> > > > > >                       SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
> > > > > >
> > > > > > @@ -1258,6 +1247,28 @@ static struct exynos5_subcmu_reg_dump exynos5x_gsc_suspend_regs[] = {
> > > > > >       { DIV2_RATIO0, 0, 0x30 },       /* DIV dout_gscl_blk_300 */
> > > > > >  };
> > > > > >
> > > > > > +/* USB3.0 */
> > > > > > +static const struct samsung_div_clock exynos5x_fsys_div_clks[] __initconst = {
> > > > > > +     DIV(0, "dout_usbphy301", "mout_usbd301", DIV_FSYS0, 12, 4),
> > > > > > +     DIV(0, "dout_usbphy300", "mout_usbd300", DIV_FSYS0, 16, 4),
> > > > > > +     DIV(0, "dout_usbd301", "mout_usbd301", DIV_FSYS0, 20, 4),
> > > > > > +     DIV(0, "dout_usbd300", "mout_usbd300", DIV_FSYS0, 24, 4),
> > > > > > +};
> > > > > > +
> > > > > > +static const struct samsung_gate_clock exynos5x_fsys_gate_clks[] __initconst = {
> > > > > > +     GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> > > > > > +     GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
> > > > > > +     GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0, 0),
> > > > > > +     GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0, 0),
> > > > > > +     GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0, 0),
> > > > > > +};
> > > > > > +
> > > > > > +static struct exynos5_subcmu_reg_dump exynos5x_fsys_suspend_regs[] = {
> > > > > > +     { GATE_IP_FSYS, 0xffffffff, 0xffffffff }, /* FSYS gates */
> > > > >
> > > > > This looks wrong. GATE_IP_FSYS has fields also for FSYS2 clocks which
> > > > > you are not suspending. They do not belong to this CMU.
> > > > >
> > > >
> > > > Ok. I change the from GATE_IP_FSYS to GATE_BUS_FSYS0 in the above
> > > > exynos5x_fsys_gate_clks to make this consistent to used GATE_BUS_FSYS0 for CMU,
> > > > with this change it works as per previously.
> > >
> > > Wait, you should set here proper registers with proper mask.
> >
> > Yes I will set the proper mask for each as per the Exynos 5422 User Manual.
> >
> > Here is what I feel
> > CLK_GATE_BUS_FSYS0 controls the PHY clock
> > CLK_GATE_IP_FSYS controls the IP clock.
> >
> 
> Sorry I cannot register both CLK_GATE_BUS_FSYS0 and CLK_GATE_IP_FSYS
> to aclk200_fsys, so I got some error like below.
> 
> [    0.922693] samsung_clk_register_gate: failed to register clock usbh20
> [    0.922857] samsung_clk_register_gate: failed to register clock usbd300
> [    0.923000] samsung_clk_register_gate: failed to register clock usbd301
> 
> > So both these field should be part of this FSYS CMU.

I am not sure if I understand your problem. I mentioned that you need
to put proper registers with proper masks into the
exynos5_subcmu_reg_dump. I don't know what have you changed to produce
such error logs.

Best regards,
Krzysztof
