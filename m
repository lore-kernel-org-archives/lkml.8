Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35592075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgG3Jjc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgG3Jjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:39:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B10C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:39:31 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k1523-0007Np-Ud; Thu, 30 Jul 2020 11:39:23 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1k1522-0005le-Vb; Thu, 30 Jul 2020 11:39:22 +0200
Message-ID: <3f4fd963bdf58e61715524fdb246481fb2b2d137.camel@pengutronix.de>
Subject: Re: [PATCH 11/17] clk: imx: Add blk_ctrl combo driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
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
Date:   Thu, 30 Jul 2020 11:39:22 +0200
In-Reply-To: <20200730085508.ddxhb4rjnzwooh2z@fsr-ub1664-175>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
         <1596024483-21482-12-git-send-email-abel.vesa@nxp.com>
         <d44e88a1408add6491897a8793b57ee0090fa4c6.camel@pengutronix.de>
         <20200730085508.ddxhb4rjnzwooh2z@fsr-ub1664-175>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-30 at 11:55 +0300, Abel Vesa wrote:
> On 20-07-29 14:46:28, Philipp Zabel wrote:
> > Hi Abel,
> > 
> > On Wed, 2020-07-29 at 15:07 +0300, Abel Vesa wrote:
> > > On i.MX8MP, there is a new type of IP which is called BLK_CTRL in
> 
> [...]
> 
> > > +
> > > +static int imx_blk_ctrl_reset_set(struct reset_controller_dev *rcdev,
> > > +				  unsigned long id, bool assert)
> > > +{
> > > +	struct imx_blk_ctrl_drvdata *drvdata = container_of(rcdev,
> > > +			struct imx_blk_ctrl_drvdata, rcdev);
> > > +	unsigned int offset = drvdata->rst_hws[id].offset;
> > > +	unsigned int shift = drvdata->rst_hws[id].shift;
> > > +	unsigned int mask = drvdata->rst_hws[id].mask;
> > > +	void __iomem *reg_addr = drvdata->base + offset;
> > > +	unsigned long flags;
> > > +	u32 reg;
> > > +
> > > +	if (assert) {
> > > +		pm_runtime_get_sync(rcdev->dev);
> > > +		spin_lock_irqsave(&drvdata->lock, flags);
> > > +		reg = readl(reg_addr);
> > > +		writel(reg & ~(mask << shift), reg_addr);
> > > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > > +	} else {
> > > +		spin_lock_irqsave(&drvdata->lock, flags);
> > > +		reg = readl(reg_addr);
> > > +		writel(reg | (mask << shift), reg_addr);
> > > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > > +		pm_runtime_put(rcdev->dev);
> > 
> > This still has the issue of potentially letting exclusive reset control
> > users break the device usage counter.
> > 
> > Also shared reset control users start with deassert(), and you end probe
> > with pm_runtime_put(), so the first shared reset control user that
> > deasserts its reset will decrement the dev->power.usage_count to -1 ?
> > For multiple resets being initially deasserted this would decrement
> > multiple times.
> > 
> > I think you'll have to track the (number of) asserted reset bits in this
> > reset controller and limit when to call pm_runtime_get/put_sync().
> > 
> 
> Yes, you're right.
> 
> I'll add a mask, and for each assert, the according bit will get set, and 
> for each deasssert the same bit will get cleared.

> And when the mask has at least one bit set, the pm_runtime_get gets called

^ When the mask was 0 before but now has a bit set.

> and when the mask is 0, the pm_runtime_put_sync will be called.

^ When the mask had a bit set but now is 0.

> Does that sound OK ?

And the mask starts out as 0, as after the pm_runtime_put() in probe all
reset lines are deasserted?

> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int imx_blk_ctrl_reset_reset(struct reset_controller_dev *rcdev,
> > > +					   unsigned long id)
> > > +{
> > > +	imx_blk_ctrl_reset_set(rcdev, id, true);
> > > +	return imx_blk_ctrl_reset_set(rcdev, id, false);
> > 
> > Does this work for all peripherals? Are there none that require the
> > reset line to be asserted for a certain number of bus clocks or similar?
> 
> As of now, there is no user that calls reset. All the users call the assert
> and then deassert. As for the number of clocks for reset, I'll try to have a
> chat to the HW design team and then come back with the information.

Ok. If this is not required or can't be guaranteed to work, it may be
better to just leave it out.

regards
Philipp
