Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F66C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9376720715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgHYLYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:24:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49232 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgHYLYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:24:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E3EB21A12CE;
        Tue, 25 Aug 2020 13:24:21 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D5D4E1A059F;
        Tue, 25 Aug 2020 13:24:21 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BEA35203CB;
        Tue, 25 Aug 2020 13:24:21 +0200 (CEST)
Date:   Tue, 25 Aug 2020 14:24:21 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/17] clk: imx: Add blk_ctrl combo driver
Message-ID: <20200825112421.eut7gx3i4eirhnfw@fsr-ub1664-175>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-12-git-send-email-abel.vesa@nxp.com>
 <ea2563fcb456830b37b0031455e5054d6b81c680.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2563fcb456830b37b0031455e5054d6b81c680.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-25 12:48:41, Philipp Zabel wrote:
> On Fri, 2020-08-14 at 15:09 +0300, Abel Vesa wrote:
> > On i.MX8MP, there is a new type of IP which is called BLK_CTRL in
> > RM and usually is comprised of some GPRs that are considered too
> > generic to be part of any dedicated IP from that specific subsystem.
> > 
> > In general, some of the GPRs have some clock bits, some have reset bits,
> > so in order to be able to use the imx clock API, this needs to be
> > in a clock driver. From there it can use the reset controller API and
> > leave the rest to the syscon.
> > 
> > This driver is intended to work with the following BLK_CTRL IPs found in
> > i.MX8MP (but it might be reused by the future i.MX platforms that
> > have this kind of IP in their design):
> >  - Audio
> >  - Media
> >  - HDMI
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/clk/imx/Makefile       |   2 +-
> >  drivers/clk/imx/clk-blk-ctrl.c | 327 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk-blk-ctrl.h |  81 ++++++++++
> >  3 files changed, 409 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/clk/imx/clk-blk-ctrl.c
> >  create mode 100644 drivers/clk/imx/clk-blk-ctrl.h
> > 
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > index 928f874c..7afe1df 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -27,7 +27,7 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
> >  
> >  obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
> >  obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
> > -obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
> > +obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-blk-ctrl.o
> >  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> >  obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
> >  
> > diff --git a/drivers/clk/imx/clk-blk-ctrl.c b/drivers/clk/imx/clk-blk-ctrl.c
> > new file mode 100644
> > index 00000000..1672646
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-blk-ctrl.c
> > @@ -0,0 +1,327 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2020 NXP.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/reset-controller.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +
> > +#include "clk.h"
> > +#include "clk-blk-ctrl.h"
> > +
> > +struct reset_hw {
> > +	u32 offset;
> > +	u32 shift;
> > +	u32 mask;
> > +	bool asserted;
> > +};
> > +
> > +struct pm_safekeep_info {
> > +	uint32_t *regs_values;
> > +	uint32_t *regs_offsets;
> > +	uint32_t regs_num;
> > +};
> > +
> > +struct imx_blk_ctrl_drvdata {
> > +	void __iomem *base;
> > +	struct reset_controller_dev rcdev;
> > +	struct reset_hw *rst_hws;
> > +	struct pm_safekeep_info pm_info;
> > +
> > +	spinlock_t lock;
> > +};
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
> > +	unsigned int asserted_before = 0, asserted_after = 0;
> > +	u32 reg;
> > +	int i;
> > +
> > +	spin_lock_irqsave(&drvdata->lock, flags);
> > +
> > +	for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> > +		if (drvdata->rst_hws[i].asserted)
> > +			asserted_before++;
> > +
> > +	if (asserted_before == 0 && assert)
> > +		pm_runtime_get(rcdev->dev);
> 
> Shouldn't that be pm_runtime_get_sync() ?
> 
> I would do that unconditionally before locking drvdata->lock and then
> drop unnecessary refcounts afterwards.
> 

I thought we already discussed this on the last's version thread.

The assert and deassert do not necessary get called in pairs,
leading to the device power domain staying always on because
some use called assert multiple times without doig the same number
of deasserts.

> > +
> > +	if (assert) {
> > +		reg = readl(reg_addr);
> > +		writel(reg & ~(mask << shift), reg_addr);
> > +		drvdata->rst_hws[id].asserted = true;
> > +	} else {
> > +		reg = readl(reg_addr);
> > +		writel(reg | (mask << shift), reg_addr);
> > +		drvdata->rst_hws[id].asserted = false;
> > +	}
> > +
> > +	for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> > +		if (drvdata->rst_hws[i].asserted)
> > +			asserted_after++;
> > +
> > +	if (asserted_before == 1 && asserted_after == 0)
> > +		pm_runtime_put(rcdev->dev);
> > +
> > +	spin_unlock_irqrestore(&drvdata->lock, flags);
> > +
> > +	return 0;
> > +}
> 
> regards
> Philipp
