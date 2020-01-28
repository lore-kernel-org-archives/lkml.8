Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B65C35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F63120661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1K0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:26:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34520 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgA1K0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:26:42 -0500
Received: from p57b77a13.dip0.t-ipconnect.de ([87.183.122.19] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iwO4s-0008VL-DY; Tue, 28 Jan 2020 11:26:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, christoph.muellner@theobroma-systems.com,
        zhangqing@rock-chips.com
Subject: Re: [PATCH] clk: rockchip: convert rk3036 pll type to use internal lock status
Date:   Tue, 28 Jan 2020 11:26:37 +0100
Message-ID: <3308363.gZKxoYc2QA@phil>
In-Reply-To: <20200114050518.D3C40222C3@mail.kernel.org>
References: <20200113152656.2313846-1-heiko@sntech.de> <20200114050518.D3C40222C3@mail.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. Januar 2020, 06:05:18 CET schrieb Stephen Boyd:
> Quoting Heiko Stuebner (2020-01-13 07:26:56)
> > diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> > index 198417d56300..37378ded0993 100644
> > --- a/drivers/clk/rockchip/clk-pll.c
> > +++ b/drivers/clk/rockchip/clk-pll.c
> > @@ -118,12 +118,30 @@ static int rockchip_pll_wait_lock(struct rockchip_clk_pll *pll)
> >  #define RK3036_PLLCON1_REFDIV_SHIFT            0
> >  #define RK3036_PLLCON1_POSTDIV2_MASK           0x7
> >  #define RK3036_PLLCON1_POSTDIV2_SHIFT          6
> > +#define RK3036_PLLCON1_LOCK_STATUS             BIT(10)
> >  #define RK3036_PLLCON1_DSMPD_MASK              0x1
> >  #define RK3036_PLLCON1_DSMPD_SHIFT             12
> > +#define RK3036_PLLCON1_PWRDOWN                 BIT(13)
> >  #define RK3036_PLLCON2_FRAC_MASK               0xffffff
> >  #define RK3036_PLLCON2_FRAC_SHIFT              0
> >  
> > -#define RK3036_PLLCON1_PWRDOWN                 (1 << 13)
> > +static int rockchip_rk3036_pll_wait_lock(struct rockchip_clk_pll *pll)
> > +{
> > +       u32 pllcon;
> > +       int delay = 24000000;
> > +
> > +       /* poll check the lock status in rk3399 xPLLCON2 */
> > +       while (delay > 0) {
> > +               pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
> > +               if (pllcon & RK3036_PLLCON1_LOCK_STATUS)
> > +                       return 0;
> > +
> > +               delay--;
> 
> There isn't any udelay here. So the timeout is just as fast as the CPU
> can churn through this? Why not use an actual time? Or use the
> readl_poll_timeout() APIs?

Done in 
http://lore.kernel.org/r/20200128100204.1318450-3-heiko@sntech.de

and to keep things similar, I did a conversion to iopoll helpers for the
other variants too.

Heiko


