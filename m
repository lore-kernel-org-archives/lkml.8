Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2674C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5132075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgG3IzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:55:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54232 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbgG3IzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:55:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F5ED2011FB;
        Thu, 30 Jul 2020 10:55:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91B3B200263;
        Thu, 30 Jul 2020 10:55:08 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7932920340;
        Thu, 30 Jul 2020 10:55:08 +0200 (CEST)
Date:   Thu, 30 Jul 2020 11:55:08 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/17] clk: imx: Add blk_ctrl combo driver
Message-ID: <20200730085508.ddxhb4rjnzwooh2z@fsr-ub1664-175>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-12-git-send-email-abel.vesa@nxp.com>
 <d44e88a1408add6491897a8793b57ee0090fa4c6.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44e88a1408add6491897a8793b57ee0090fa4c6.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-29 14:46:28, Philipp Zabel wrote:
> Hi Abel,
> 
> On Wed, 2020-07-29 at 15:07 +0300, Abel Vesa wrote:
> > On i.MX8MP, there is a new type of IP which is called BLK_CTRL in

[...]

> > +
> > +static int imx_blk_ctrl_reset_set(struct reset_controller_dev *rcdev,
> > +				  unsigned long id, bool assert)
> > +{
> > +	struct imx_blk_ctrl_drvdata *drvdata = container_of(rcdev,
> > +			struct imx_blk_ctrl_drvdata, rcdev);
> > +	unsigned int offset = drvdata->rst_hws[id].offset;
> > +	unsigned int shift = drvdata->rst_hws[id].shift;
> > +	unsigned int mask = drvdata->rst_hws[id].mask;
> > +	void __iomem *reg_addr = drvdata->base + offset;
> > +	unsigned long flags;
> > +	u32 reg;
> > +
> > +	if (assert) {
> > +		pm_runtime_get_sync(rcdev->dev);
> > +		spin_lock_irqsave(&drvdata->lock, flags);
> > +		reg = readl(reg_addr);
> > +		writel(reg & ~(mask << shift), reg_addr);
> > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > +	} else {
> > +		spin_lock_irqsave(&drvdata->lock, flags);
> > +		reg = readl(reg_addr);
> > +		writel(reg | (mask << shift), reg_addr);
> > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > +		pm_runtime_put(rcdev->dev);
> 
> This still has the issue of potentially letting exclusive reset control
> users break the device usage counter.
> 
> Also shared reset control users start with deassert(), and you end probe
> with pm_runtime_put(), so the first shared reset control user that
> deasserts its reset will decrement the dev->power.usage_count to -1 ?
> For multiple resets being initially deasserted this would decrement
> multiple times.
> 
> I think you'll have to track the (number of) asserted reset bits in this
> reset controller and limit when to call pm_runtime_get/put_sync().
> 

Yes, you're right.

I'll add a mask, and for each assert, the according bit will get set, and 
for each deasssert the same bit will get cleared. And when the mask has at least
one bit set, the pm_runtime_get gets called and when the mask is 0, the 
pm_runtime_put_sync will be called.

Does that sound OK ?

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_blk_ctrl_reset_reset(struct reset_controller_dev *rcdev,
> > +					   unsigned long id)
> > +{
> > +	imx_blk_ctrl_reset_set(rcdev, id, true);
> > +	return imx_blk_ctrl_reset_set(rcdev, id, false);
> 
> Does this work for all peripherals? Are there none that require the
> reset line to be asserted for a certain number of bus clocks or similar?

As of now, there is no user that calls reset. All the users call the assert
and then deassert. As for the number of clocks for reset, I'll try to have a
chat to the HW design team and then come back with the information.

> 
> > +}
> > +

