Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511AC8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBCA2137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD3KA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:00:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39260 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgD3KA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:00:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5272D2007C9;
        Thu, 30 Apr 2020 12:00:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44A092007C4;
        Thu, 30 Apr 2020 12:00:56 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C9D320397;
        Thu, 30 Apr 2020 12:00:56 +0200 (CEST)
Date:   Thu, 30 Apr 2020 13:00:55 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Andy Duan <fugang.duan@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite clk
Message-ID: <20200430100055.6rhec5rwtz2yyqbl@fsr-ub1664-175>
References: <1584008384-11578-1-git-send-email-peng.fan@nxp.com>
 <1584008384-11578-8-git-send-email-peng.fan@nxp.com>
 <AM6PR04MB4966D0EF272CAB282BF72EB580AE0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB6PR0402MB276047141A63BE756B9C06D988AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB276047141A63BE756B9C06D988AF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-27 09:11:56, Peng Fan wrote:
> > Subject: RE: [PATCH V2 07/10] clk: imx: add mux ops for i.MX8M composite
> > clk
> > 
> > > From: Peng Fan <peng.fan@nxp.com>
> > > Sent: Thursday, March 12, 2020 6:20 PM
> > >
> > > The CORE/BUS root slice has following design, simplied graph:
> > > The difference is core not have pre_div block.
> > > A composite core/bus clk has 8 inputs for mux to select, saying clk[0-7].
> > >
> > >             SEL_A  GA
> > >             +--+  +-+
> > >             |  +->+ +------+
> > > CLK[0-7]--->+  |  +-+      |
> > >        |    |  |      +----v---+    +----+
> > >        |    +--+      |pre_diva+---->    |  +---------+
> > >        |              +--------+    |mux +--+post_div |
> > >        |    +--+      |pre_divb+--->+    |  +---------+
> > >        |    |  |      +----^---+    +----+
> > >        +--->+  |  +-+      |
> > >             |  +->+ +------+
> > >             +--+  +-+
> > >             SEL_B  GB
> > >
> > > There will be system hang, when doing the following steps:
> > > 1. switch mux from clk0 to clk1
> > > 2. gate off clk0
> > > 3. swtich from clk1 to clk2, or gate off clk1
> > >
> > > Step 3 triggers system hang.
> > 
> > Why Step 3 triggers system hang? Is this a HW limitation?
> 
> It is what hardware designed.
> 
> There is a counter inside the clk root module to choose
> SEL_A or SEL_B. If choose SEL_B, the parent of SEL_B must
> be active, otherwise the change from SEL_A to SEL_B
> will cause hang.
> 
> SEL_A and SEL_B is inside the clock root module,
> It is not clk's software parentA/B. misunderstand
> this will misunderstand the whole fix.
> 
> > 
> > >
> > > If we skip step2, keep clk0 on, step 3 will not trigger system hang.
> > > However we have CLK_OPS_PARENT_ENABLE flag, which will unprepare
> > > disable the clk0 which will not be used.
> > >
> > > To address this issue, we could use following simplied software flow:
> > > After the first target register set
> > > wait the target register set finished
> > > set the target register set again
> > > wait the target register set finished
> > >
> > > The upper flow will make sure SEL_A and SEL_B both set the new mux,
> > > but with only one path gate on.
> > >
> > > And there will be no system hang anymore with step3.
> > 
> > Is this IC proposed solution?
> 
> This is what I proposed and IC team confirmed.
> 
> > 
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > >  Drop wait after write, add one line comment for write twice.
> > >
> > >  drivers/clk/imx/clk-composite-8m.c | 62
> > > +++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 61 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/clk/imx/clk-composite-8m.c
> > > b/drivers/clk/imx/clk-composite-8m.c
> > > index 99773519b5a5..eae02c151ced 100644
> > > --- a/drivers/clk/imx/clk-composite-8m.c
> > > +++ b/drivers/clk/imx/clk-composite-8m.c
> > > @@ -24,6 +24,12 @@
> > >
> > >  #define PCG_CGC_SHIFT		28
> > >
> > > +#define PRE_REG_OFF		0x30
> > > +#define PRE_MUXA_SHIFT		24
> > > +#define PRE_MUXA_MASK		0x7
> > > +#define PRE_MUXB_SHIFT		8
> > > +#define PRE_MUXB_MASK		0x7
> > 
> > Are those macros used somewhere?
> 
> Remove in v3.
> 
> > 
> > > +
> > >  static unsigned long imx8m_clk_composite_divider_recalc_rate(struct
> > > clk_hw *hw,
> > >  						unsigned long parent_rate)
> > >  {
> > > @@ -124,6 +130,57 @@ static const struct clk_ops
> > > imx8m_clk_composite_divider_ops = {
> > >  	.set_rate = imx8m_clk_composite_divider_set_rate,
> > >  };
> > >
> > > +static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw) {
> > > +	struct clk_mux *mux = to_clk_mux(hw);
> > > +	u32 val;
> > > +
> > > +	val = readl(mux->reg) >> mux->shift;
> > > +	val &= mux->mask;
> > > +
> > > +	return clk_mux_val_to_index(hw, mux->table, mux->flags, val); }
> > 
> > You don't have to redefinition them if they're the same as clk_mux_ops.
> > You have the access to clk_mux_ops.
> 
> This will require export_symbol of clk_mux_ops callbacks.
> 

Maybe you can do here:

return clk_mux_ops.get_parent(hw);

> > 
> > > +
> > > +static int imx8m_clk_composite_mux_set_parent(struct clk_hw *hw, u8
> > > +index) {
> > > +	struct clk_mux *mux = to_clk_mux(hw);
> > > +	u32 val = clk_mux_index_to_val(mux->table, mux->flags, index);
> > > +	unsigned long flags = 0;
> > > +	u32 reg;
> > > +
> > > +	if (mux->lock)
> > > +		spin_lock_irqsave(mux->lock, flags);
> > > +
> > > +	reg = readl(mux->reg);
> > > +	reg &= ~(mux->mask << mux->shift);
> > > +	val = val << mux->shift;
> > > +	reg |= val;
> > > +	/* write twice to make sure SEL_A/B point the same mux */
> > > +	writel(reg, mux->reg);
> > > +	writel(reg, mux->reg);
> > 
> > Why this affects both SEL_A/B?
> 
> The internal counter will make sure both SEL_A/B point
> to the same mux.
> 
> > Very tricky and may worth more comments.
> 
> Ah, I think RM should be clear about the target interface
> and non-target interface.
> 
> When you write once, saying use SEL_A, when
> you write the 2nd, the hardware will use SEL_B,
> when you write 3rd, the hardware will use SEL_A.
> and ...
> 

This is a very interesting behavior from HW point of view.
So every write changes the mux ? 

Unless there is an ERRATA for this, we'll get a lot of pushback from upstream.

> > 
> > Besides that, I'd like to see Abel's comments on this patch.
> 
> 
> Abel,
> 
>  Any comments?
> 
> Thanks,
> Peng.
> 
> > 
> > Regards
> > Aisheng
> > 
> > > +
> > > +	if (mux->lock)
> > > +		spin_unlock_irqrestore(mux->lock, flags);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int
> > > +imx8m_clk_composite_mux_determine_rate(struct clk_hw *hw,
> > > +				       struct clk_rate_request *req) {
> > > +	struct clk_mux *mux = to_clk_mux(hw);
> > > +
> > > +	return clk_mux_determine_rate_flags(hw, req, mux->flags); }
> > 
> > Same as bove.
> > 
> > > +
> > > +
> > > +const struct clk_ops imx8m_clk_composite_mux_ops = {
> > > +	.get_parent = imx8m_clk_composite_mux_get_parent,
> > > +	.set_parent = imx8m_clk_composite_mux_set_parent,
> > > +	.determine_rate = imx8m_clk_composite_mux_determine_rate,
> > > +};
> > > +
> > >  struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
> > >  					const char * const *parent_names,
> > >  					int num_parents, void __iomem *reg, @@ -136,6
> > > +193,7 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char
> > > +*name,
> > >  	struct clk_gate *gate = NULL;
> > >  	struct clk_mux *mux = NULL;
> > >  	const struct clk_ops *divider_ops;
> > > +	const struct clk_ops *mux_ops;
> > >
> > >  	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> > >  	if (!mux)
> > > @@ -157,10 +215,12 @@ struct clk_hw
> > > *imx8m_clk_hw_composite_flags(const char *name,
> > >  		div->shift = PCG_DIV_SHIFT;
> > >  		div->width = PCG_CORE_DIV_WIDTH;
> > >  		divider_ops = &clk_divider_ops;
> > > +		mux_ops = &imx8m_clk_composite_mux_ops;
> > >  	} else {
> > >  		div->shift = PCG_PREDIV_SHIFT;
> > >  		div->width = PCG_PREDIV_WIDTH;
> > >  		divider_ops = &imx8m_clk_composite_divider_ops;
> > > +		mux_ops = &clk_mux_ops;
> > >  	}
> > >
> > >  	div->lock = &imx_ccm_lock;
> > > @@ -176,7 +236,7 @@ struct clk_hw
> > *imx8m_clk_hw_composite_flags(const
> > > char *name,
> > >  	gate->lock = &imx_ccm_lock;
> > >
> > >  	hw = clk_hw_register_composite(NULL, name, parent_names,
> > > num_parents,
> > > -			mux_hw, &clk_mux_ops, div_hw,
> > > +			mux_hw, mux_ops, div_hw,
> > >  			divider_ops, gate_hw, &clk_gate_ops, flags);
> > >  	if (IS_ERR(hw))
> > >  		goto fail;
> > > --
> > > 2.16.4
> 
