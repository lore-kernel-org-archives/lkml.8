Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A61C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B0B20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgHYMHx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgHYMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:07:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B1FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:07:50 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kAXje-0000BL-IT; Tue, 25 Aug 2020 14:07:30 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kAXjd-0004kj-KW; Tue, 25 Aug 2020 14:07:29 +0200
Message-ID: <8e8e33386eea12036bb17529b4d578704bf735d1.camel@pengutronix.de>
Subject: Re: [PATCH v2 11/17] clk: imx: Add blk_ctrl combo driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 25 Aug 2020 14:07:29 +0200
In-Reply-To: <20200825112421.eut7gx3i4eirhnfw@fsr-ub1664-175>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
         <1597406966-13740-12-git-send-email-abel.vesa@nxp.com>
         <ea2563fcb456830b37b0031455e5054d6b81c680.camel@pengutronix.de>
         <20200825112421.eut7gx3i4eirhnfw@fsr-ub1664-175>
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

On Tue, 2020-08-25 at 14:24 +0300, Abel Vesa wrote:
[...]
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
> > > +	unsigned int asserted_before = 0, asserted_after = 0;
> > > +	u32 reg;
> > > +	int i;
> > > +
> > > +	spin_lock_irqsave(&drvdata->lock, flags);
> > > +
> > > +	for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> > > +		if (drvdata->rst_hws[i].asserted)
> > > +			asserted_before++;
> > > +
> > > +	if (asserted_before == 0 && assert)
> > > +		pm_runtime_get(rcdev->dev);
> > 
> > Shouldn't that be pm_runtime_get_sync() ?
> > 
> > I would do that unconditionally before locking drvdata->lock and then
> > drop unnecessary refcounts afterwards.
> > 
> 
> I thought we already discussed this on the last's version thread.

This is about something different. pm_runtime_get() just queues the
device to be enabled at a later point, but I presume you want to have it
enabled before writing to its registers. (The question here is can you
write to the registers, and have the device update its internal state,
while the power domain is disabled?)
Either way, if you want the reset to be asserted after the function
returns (as is required by the reset API), as I understand it, you have
to make sure that the power domain is activated before the function
returns.
Therefore pm_runtime_get_sync() is required instead of pm_runtime_get(),
and that must be called outside of the spin locked section. My
suggestion would be:

	if (assert)
		pm_runtime_get_sync();
	spin_lock_irqsave();
	/* ... */
	spin_unlock_irqrestore();
	if (assert && asserted_before)
		pm_runtime_put();

unless the following might be an issue:

> > > +
> > > +	if (assert) {
> > > +		reg = readl(reg_addr);
> > > +		writel(reg & ~(mask << shift), reg_addr);
> > > +		drvdata->rst_hws[id].asserted = true;
> > > +	} else {
> > > +		reg = readl(reg_addr);
> > > +		writel(reg | (mask << shift), reg_addr);

Could this cause problems if the power domain is already disabled? If
so, it would be best to either temporarily enable power, or to skip the
register writes if asserted_before == 0 && !assert.

> > > +		drvdata->rst_hws[id].asserted = false;
> > > +	}
> > > +
> > > +	for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> > > +		if (drvdata->rst_hws[i].asserted)
> > > +			asserted_after++;
> > > +
> > > +	if (asserted_before == 1 && asserted_after == 0)
> > > +		pm_runtime_put(rcdev->dev);
> > > +
> > > +	spin_unlock_irqrestore(&drvdata->lock, flags);
> > > +
> > > +	return 0;
> > > +}

regards
Philipp
