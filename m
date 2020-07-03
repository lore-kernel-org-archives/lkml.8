Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76991C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A0DF2088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGCPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:03:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265CAC08C5C1;
        Fri,  3 Jul 2020 08:03:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 210AC2A188D
Message-ID: <8d667ae2554ebf3d9867f6f449973825c969b062.camel@collabora.com>
Subject: Re: [PATCH v4 1/2] clk: rockchip: rk3288: Handle clock tree for
 rk3288w
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     =?ISO-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 03 Jul 2020 12:02:52 -0300
In-Reply-To: <1793210.9Kb5SQUFvz@phil>
References: <20200602080644.11333-1-mylene.josserand@collabora.com>
         <20200602080644.11333-2-mylene.josserand@collabora.com>
         <CAMty3ZDx-_-VHEwjbV05GBb-hQbPpo21aZbCrQ+GTaoT_gxAMg@mail.gmail.com>
         <1793210.9Kb5SQUFvz@phil>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 16:11 +0200, Heiko Stuebner wrote:
> Hi Jagan,
> 
> Am Montag, 29. Juni 2020, 21:11:03 CEST schrieb Jagan Teki:
> > On Tue, Jun 2, 2020 at 1:37 PM Mylène Josserand
> > <mylene.josserand@collabora.com> wrote:
> > > The revision rk3288w has a different clock tree about "hclk_vio"
> > > clock, according to the BSP kernel code.
> > > 
> > > This patch handles this difference by detecting which device-tree
> > > we are using. If it is a "rockchip,rk3288-cru", let's register
> > > the clock tree as it was before. If the device-tree node is
> > > "rockchip,rk3288w-cru", we will apply the difference with this
> > > version of this SoC.
> > > 
> > > Noticed that this new device-tree compatible must be handled in
> > > bootloader such as u-boot.
> > > 
> > > Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
> > > ---
> > >  drivers/clk/rockchip/clk-rk3288.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> > > index cc2a177bbdbf..204976e2d0cb 100644
> > > --- a/drivers/clk/rockchip/clk-rk3288.c
> > > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > > @@ -425,8 +425,6 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
> > >         COMPOSITE(0, "aclk_vio0", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
> > >                         RK3288_CLKSEL_CON(31), 6, 2, MFLAGS, 0, 5, DFLAGS,
> > >                         RK3288_CLKGATE_CON(3), 0, GFLAGS),
> > > -       DIV(0, "hclk_vio", "aclk_vio0", 0,
> > > -                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
> > >         COMPOSITE(0, "aclk_vio1", mux_pll_src_cpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
> > >                         RK3288_CLKSEL_CON(31), 14, 2, MFLAGS, 8, 5, DFLAGS,
> > >                         RK3288_CLKGATE_CON(3), 2, GFLAGS),
> > > @@ -819,6 +817,16 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
> > >         INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
> > >  };
> > > 
> > > +static struct rockchip_clk_branch rk3288w_hclkvio_branch[] __initdata = {
> > > +       DIV(0, "hclk_vio", "aclk_vio1", 0,
> > > +                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
> > > +};
> > > +
> > > +static struct rockchip_clk_branch rk3288_hclkvio_branch[] __initdata = {
> > > +       DIV(0, "hclk_vio", "aclk_vio0", 0,
> > > +                       RK3288_CLKSEL_CON(28), 8, 5, DFLAGS),
> > > +};
> > > +
> > >  static const char *const rk3288_critical_clocks[] __initconst = {
> > >         "aclk_cpu",
> > >         "aclk_peri",
> > > @@ -936,6 +944,14 @@ static void __init rk3288_clk_init(struct device_node *np)
> > >                                    RK3288_GRF_SOC_STATUS1);
> > >         rockchip_clk_register_branches(ctx, rk3288_clk_branches,
> > >                                   ARRAY_SIZE(rk3288_clk_branches));
> > > +
> > > +       if (of_device_is_compatible(np, "rockchip,rk3288w-cru"))
> > > +               rockchip_clk_register_branches(ctx, rk3288w_hclkvio_branch,
> > > +                                              ARRAY_SIZE(rk3288w_hclkvio_branch));
> > > +       else
> > > +               rockchip_clk_register_branches(ctx, rk3288_hclkvio_branch,
> > > +                                              ARRAY_SIZE(rk3288_hclkvio_branch));
> > > +
> > 
> > Sorry for the late query on this. I am a bit unclear about this
> > compatible change, does Linux expect to replace rockchip,rk3288-cru
> > with rockchip,rk3288w-cru in bootloader if the chip is RK3288w? or
> > append the existing cru compatible node with rockchip,rk3288w-cru?
> > because replace new cru node make clock never probe since the
> > CLK_OF_DECLARE checking rockchip,rk3288-cru
> 
> I guess right now we'd expect "rockchip,rk3288w-cru", "rockchip,rk3288-cru",
> 
> Thinking again about this, I'm wondering if we should switch to having
> only one per variant ... like on the two rk3188 variants,
> so declaring separate rk3288-cru and rk3288w-cru of-clks with shared
> common code.
> 

If we want to take this route (which I think makes sense), we should
do that sooner than later, so we don't release two different implementations
with two different requirements.

This change should be quite simple, no?

Thanks,
Ezequiel



