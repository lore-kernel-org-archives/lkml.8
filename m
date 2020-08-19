Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D36207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHSUb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:31:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44444 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHSUb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:31:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 775DE201200;
        Wed, 19 Aug 2020 22:31:50 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6780C2011AA;
        Wed, 19 Aug 2020 22:31:50 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D45E20328;
        Wed, 19 Aug 2020 22:31:50 +0200 (CEST)
Date:   Wed, 19 Aug 2020 23:31:50 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 11/17] clk: imx: Add blk_ctrl combo driver
Message-ID: <20200819203150.bddziq2m75sccixj@fsr-ub1664-175>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-12-git-send-email-abel.vesa@nxp.com>
 <CAA+hA=R9bFBX-tFfSEO3wqC+b4P1nbfSVyBQUOzez=oZ71AhkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=R9bFBX-tFfSEO3wqC+b4P1nbfSVyBQUOzez=oZ71AhkA@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-18 19:27:03, Dong Aisheng wrote:
> On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
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
> 
> The code mostly looks good to me.
> Only a few minor comments.
> 
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
> 
> s/reset_hw/imx_reset_hw
> It helps the reader to quickly understand it's not core structure
> 
> > +       u32 offset;
> > +       u32 shift;
> > +       u32 mask;
> > +       bool asserted;
> > +};
> > +
> > +struct pm_safekeep_info {
> 
> imx_pm_safekeep_info
> 

Will do in the next version.

> > +       uint32_t *regs_values;
> > +       uint32_t *regs_offsets;
> > +       uint32_t regs_num;
> > +};
> > +
> > +struct imx_blk_ctrl_drvdata {
> > +       void __iomem *base;
> > +       struct reset_controller_dev rcdev;
> > +       struct reset_hw *rst_hws;
> > +       struct pm_safekeep_info pm_info;
> > +
> > +       spinlock_t lock;
> > +};
> > +
> > +static int imx_blk_ctrl_reset_set(struct reset_controller_dev *rcdev,
> > +                                 unsigned long id, bool assert)
> > +{
> > +       struct imx_blk_ctrl_drvdata *drvdata = container_of(rcdev,
> > +                       struct imx_blk_ctrl_drvdata, rcdev);
> > +       unsigned int offset = drvdata->rst_hws[id].offset;
> > +       unsigned int shift = drvdata->rst_hws[id].shift;
> > +       unsigned int mask = drvdata->rst_hws[id].mask;
> > +       void __iomem *reg_addr = drvdata->base + offset;
> > +       unsigned long flags;
> > +       unsigned int asserted_before = 0, asserted_after = 0;
> 
> swap above two lines from long to short

Will do.

> 
> > +       u32 reg;
> > +       int i;
> > +
> > +       spin_lock_irqsave(&drvdata->lock, flags);
> > +
> > +       for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> > +               if (drvdata->rst_hws[i].asserted)
> > +                       asserted_before++;
> > +
> > +       if (asserted_before == 0 && assert)
> > +               pm_runtime_get(rcdev->dev);
> > +
> > +       if (assert) {
> > +               reg = readl(reg_addr);
> > +               writel(reg & ~(mask << shift), reg_addr);
> > +               drvdata->rst_hws[id].asserted = true;
> > +       } else {
> > +               reg = readl(reg_addr);
> > +               writel(reg | (mask << shift), reg_addr);
> > +               drvdata->rst_hws[id].asserted = false;
> > +       }
> > +
> > +       for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> > +               if (drvdata->rst_hws[i].asserted)
> > +                       asserted_after++;
> 
> I guess the logic may be able to be simplified.
> For example, put assert ref count in the private structure.
> Then
> call pm_runtime_get when ref count is 0 and assert is true.
> call pm_runtime_put when ref ount is 0 and assert is false.
> No need to go through twice for loop each time.
> 

Not really. For example, nothing stops a user to assert the same reset twice
before deasserting. The refcount will increase twice while decreasing once.
So we need to keep track of all the assertions and deassertions for each bit.

If the assert is requested twice, the asserted member is already set so no change.
Same logic goes for the deassertion. 

In the end we need to know when the last asserted bit is deasserted in order
to call the pm_runtime_put. Also when the there was no bit asserted and an
assertion is happening in order to do the pm_runtime_get. 

The alternative to the current implementation would be a mask, but the number
of bits could be virtually unlimited for a BLK_CTL IP, therefore, the two
loops and the asserted member seem a cleaner approach.

> > +
> > +       if (asserted_before == 1 && asserted_after == 0)
> > +               pm_runtime_put(rcdev->dev);
> > +
> > +       spin_unlock_irqrestore(&drvdata->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx_blk_ctrl_reset_assert(struct reset_controller_dev *rcdev,
> > +                                          unsigned long id)
> > +{
> > +       return imx_blk_ctrl_reset_set(rcdev, id, true);
> > +}
> > +
> > +static int imx_blk_ctrl_reset_deassert(struct reset_controller_dev *rcdev,
> > +                                            unsigned long id)
> > +{
> > +       return imx_blk_ctrl_reset_set(rcdev, id, false);
> > +}
> > +
> > +static const struct reset_control_ops imx_blk_ctrl_reset_ops = {
> > +       .assert         = imx_blk_ctrl_reset_assert,
> > +       .deassert       = imx_blk_ctrl_reset_deassert,
> > +};
> > +
> > +static int imx_blk_ctrl_register_reset_controller(struct device *dev)
> > +{
> > +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       const struct imx_blk_ctrl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct reset_hw *hws;
> > +       int max = dev_data->resets_max;
> 
> sort from long to short

Will do.

> 
> > +       int i;
> > +
> > +       spin_lock_init(&drvdata->lock);
> > +
> > +       drvdata->rcdev.owner     = THIS_MODULE;
> > +       drvdata->rcdev.nr_resets = max;
> > +       drvdata->rcdev.ops       = &imx_blk_ctrl_reset_ops;
> > +       drvdata->rcdev.of_node   = dev->of_node;
> > +       drvdata->rcdev.dev       = dev;
> > +
> > +       drvdata->rst_hws = devm_kcalloc(dev, max, sizeof(struct reset_hw),
> > +                                       GFP_KERNEL);
> > +       hws = drvdata->rst_hws;
> > +
> > +       for (i = 0; i < dev_data->hws_num; i++) {
> > +               struct imx_blk_ctrl_hw *hw = &dev_data->hws[i];
> > +
> > +               if (hw->type != BLK_CTRL_RESET)
> > +                       continue;
> > +
> > +               hws[hw->id].offset = hw->offset;
> > +               hws[hw->id].shift = hw->shift;
> > +               hws[hw->id].mask = hw->mask;
> > +       }
> > +
> > +       return devm_reset_controller_register(dev, &drvdata->rcdev);
> > +}
> > +static struct clk_hw *imx_blk_ctrl_register_one_clock(struct device *dev,
> > +                                               struct imx_blk_ctrl_hw *hw)
> > +{
> > +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       void __iomem *base = drvdata->base;
> > +       struct clk_hw *clk_hw;
> > +
> > +       switch (hw->type) {
> > +       case BLK_CTRL_CLK_MUX:
> > +               clk_hw = imx_dev_clk_hw_mux_flags(dev, hw->name,
> > +                                                 base + hw->offset,
> > +                                                 hw->shift, hw->width,
> > +                                                 hw->parents,
> > +                                                 hw->parents_count,
> > +                                                 hw->flags);
> > +               break;
> > +       case BLK_CTRL_CLK_GATE:
> > +               clk_hw = imx_dev_clk_hw_gate(dev, hw->name, hw->parents,
> > +                                            base + hw->offset, hw->shift);
> > +               break;
> > +       case BLK_CTRL_CLK_SHARED_GATE:
> > +               clk_hw = imx_dev_clk_hw_gate_shared(dev, hw->name,
> > +                                                   hw->parents,
> > +                                                   base + hw->offset,
> > +                                                   hw->shift,
> > +                                                   hw->shared_count);
> > +               break;
> > +       case BLK_CTRL_CLK_PLL14XX:
> > +               clk_hw = imx_dev_clk_hw_pll14xx(dev, hw->name, hw->parents,
> > +                                               base + hw->offset, hw->pll_tbl);
> > +               break;
> > +       default:
> > +               clk_hw = NULL;
> 
> A better way may be assign clk_hw default to NULL.
> Then instead, we can add a WARN here in case the clk hw data is insane.
> 

Will do.

> > +       };
> > +
> > +       return clk_hw;
> > +}
> > +
> > +static int imx_blk_ctrl_register_clock_controller(struct device *dev)
> > +{
> > +       const struct imx_blk_ctrl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct clk_hw_onecell_data *clk_hw_data;
> > +       struct clk_hw **hws;
> > +       int i;
> > +
> > +       clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> > +                               dev_data->hws_num), GFP_KERNEL);
> > +       if (WARN_ON(!clk_hw_data))
> > +               return -ENOMEM;
> > +
> > +       clk_hw_data->num = dev_data->clocks_max;
> > +       hws = clk_hw_data->hws;
> > +
> > +       for (i = 0; i < dev_data->hws_num; i++) {
> > +               struct imx_blk_ctrl_hw *hw = &dev_data->hws[i];
> > +               struct clk_hw *tmp = imx_blk_ctrl_register_one_clock(dev, hw);
> > +
> > +               if (!tmp)
> > +                       continue;
> > +               hws[hw->id] = tmp;
> 
> tmp could be a non NULL error pointer.
> Maybe here could be simplied as:
> hws[hw->id] = imx_blk_ctrl_register_one_clock(dev, hw);
> 

Will do.

> > +       }
> > +
> > +       imx_check_clk_hws(hws, dev_data->clocks_max);
> > +
> > +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> > +                                       clk_hw_data);
> > +}
> > +
> > +static int imx_blk_ctrl_init_runtime_pm_safekeeping(struct device *dev)
> > +{
> > +       const struct imx_blk_ctrl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       struct pm_safekeep_info *pm_info = &drvdata->pm_info;
> > +       u32 regs_num = dev_data->pm_runtime_saved_regs_num;
> > +       const u32 *regs_offsets = dev_data->pm_runtime_saved_regs;
> > +
> > +       if (!dev_data->pm_runtime_saved_regs_num)
> > +               return 0;
> > +
> > +       pm_info->regs_values = devm_kzalloc(dev,
> > +                                           sizeof(u32) * regs_num,
> > +                                           GFP_KERNEL);
> > +       if (WARN_ON(IS_ERR(pm_info->regs_values)))
> > +               return PTR_ERR(pm_info->regs_values);
> > +
> > +       pm_info->regs_offsets = kmemdup(regs_offsets,
> > +                                       regs_num * sizeof(u32), GFP_KERNEL);
> > +       if (WARN_ON(IS_ERR(pm_info->regs_offsets)))
> > +               return PTR_ERR(pm_info->regs_offsets);
> > +
> > +       pm_info->regs_num = regs_num;
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx_blk_ctrl_probe(struct platform_device *pdev)
> > +{
> > +       struct imx_blk_ctrl_drvdata *drvdata;
> > +       struct device *dev = &pdev->dev;
> > +       int ret;
> > +
> > +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +       if (WARN_ON(!drvdata))
> > +               return -ENOMEM;
> > +
> > +       drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (WARN_ON(IS_ERR(drvdata->base)))
> > +               return PTR_ERR(drvdata->base);
> > +
> > +       dev_set_drvdata(dev, drvdata);
> > +
> > +       ret = imx_blk_ctrl_init_runtime_pm_safekeeping(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       pm_runtime_set_active(dev);
> > +       pm_runtime_enable(dev);
> > +
> > +       ret = imx_blk_ctrl_register_clock_controller(dev);
> > +       if (ret) {
> > +               pm_runtime_put(dev);
> > +               return ret;
> > +       }
> > +
> > +       ret = imx_blk_ctrl_register_reset_controller(dev);
> > +
> > +       pm_runtime_put(dev);
> > +
> > +       return ret;
> > +}
> > +
> > +static void imx_blk_ctrl_read_write(struct device *dev, bool write)
> 
> __maybe_unused
> 

Will do.

> > +{
> > +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       struct pm_safekeep_info *pm_info = &drvdata->pm_info;
> > +       void __iomem *base = drvdata->base;
> > +       int i;
> > +
> > +       if (!pm_info->regs_num)
> > +               return;
> > +
> > +       for (i = 0; i < pm_info->regs_num; i++) {
> > +               u32 offset = pm_info->regs_offsets[i];
> > +
> > +               if (write)
> > +                       writel(pm_info->regs_values[i], base + offset);
> > +               else
> > +                       pm_info->regs_values[i] = readl(base + offset);
> > +       }
> > +
> > +}
> > +
> > +static int imx_blk_ctrl_runtime_suspend(struct device *dev)
> 
> __maybe_unused
> 

Will do.

> > +{
> > +       imx_blk_ctrl_read_write(dev, false);
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx_blk_ctrl_runtime_resume(struct device *dev)
> 
> __maybe_unused
> 

Will do.

> > +{
> > +       imx_blk_ctrl_read_write(dev, true);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops imx_blk_ctrl_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(imx_blk_ctrl_runtime_suspend,
> > +                          imx_blk_ctrl_runtime_resume, NULL)
> > +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +                          pm_runtime_force_resume)
> > +};
> > +
> > +static const struct of_device_id imx_blk_ctrl_of_match[] = {
> > +       { /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_blk_ctrl_of_match);
> > +
> > +static struct platform_driver imx_blk_ctrl_driver = {
> > +       .probe = imx_blk_ctrl_probe,
> > +       .driver = {
> > +               .name = "imx-blk-ctrl",
> > +               .of_match_table = of_match_ptr(imx_blk_ctrl_of_match),
> > +               .pm = &imx_blk_ctrl_pm_ops,
> > +       },
> > +};
> > +module_platform_driver(imx_blk_ctrl_driver);
> > diff --git a/drivers/clk/imx/clk-blk-ctrl.h b/drivers/clk/imx/clk-blk-ctrl.h
> > new file mode 100644
> > index 00000000..b3b7fc37
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-blk-ctrl.h
> > @@ -0,0 +1,81 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __MACH_IMX_CLK_BLK_CTRL_H
> > +#define __MACH_IMX_CLK_BLK_CTRL_H
> > +
> > +enum imx_blk_ctrl_hw_type {
> > +       BLK_CTRL_CLK_MUX,
> > +       BLK_CTRL_CLK_GATE,
> > +       BLK_CTRL_CLK_SHARED_GATE,
> > +       BLK_CTRL_CLK_PLL14XX,
> > +       BLK_CTRL_RESET,
> > +};
> > +
> > +struct imx_blk_ctrl_hw {
> > +       int type;
> > +       char *name;
> > +       u32 offset;
> > +       u32 shift;
> > +       u32 mask;
> > +       u32 width;
> > +       u32 flags;
> > +       u32 id;
> > +       void *parents;
> > +       u32 parents_count;
> > +       int *shared_count;
> > +       struct imx_pll14xx_clk *pll_tbl;
> > +};
> > +
> > +struct imx_blk_ctrl_dev_data {
> > +       struct imx_blk_ctrl_hw *hws;
> > +       u32 hws_num;
> > +
> > +       u32 clocks_max;
> > +       u32 resets_max;
> > +
> > +       u32 pm_runtime_saved_regs_num;
> > +       u32 pm_runtime_saved_regs[];
> > +};
> > +
> > +#define IMX_BLK_CTRL(_type, _name, _id, _offset, _shift, _width, _mask, _parents, _parents_count, _flags, sh_count, _pll_tbl) \
> > +       {                                               \
> > +               .type = _type,                          \
> > +               .name = _name,                          \
> > +               .id = _id,                              \
> > +               .offset = _offset,                      \
> > +               .shift = _shift,                        \
> > +               .width = _width,                        \
> > +               .mask = _mask,                          \
> > +               .parents = _parents,                    \
> > +               .parents_count = _parents_count,        \
> > +               .flags = _flags,                        \
> > +               .shared_count = sh_count,               \
> > +               .pll_tbl = _pll_tbl,                    \
> > +       }
> > +
> > +#define IMX_BLK_CTRL_CLK_MUX(_name, _id, _offset, _shift, _width, _parents) \
> > +       IMX_BLK_CTRL(BLK_CTRL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), 0, NULL, NULL)
> > +
> > +#define IMX_BLK_CTRL_CLK_MUX_FLAGS(_name, _id, _offset, _shift, _width, _parents, _flags) \
> > +       IMX_BLK_CTRL(BLK_CTRL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), _flags, NULL, NULL)
> > +
> > +#define IMX_BLK_CTRL_CLK_GATE(_name, _id, _offset, _shift, _parents) \
> > +       IMX_BLK_CTRL(BLK_CTRL_CLK_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, NULL, NULL)
> > +
> > +#define IMX_BLK_CTRL_CLK_SHARED_GATE(_name, _id, _offset, _shift, _parents, sh_count) \
> > +       IMX_BLK_CTRL(BLK_CTRL_CLK_SHARED_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, sh_count, NULL)
> > +
> > +#define IMX_BLK_CTRL_CLK_PLL14XX(_name, _id, _offset, _parents, _pll_tbl) \
> > +       IMX_BLK_CTRL(BLK_CTRL_CLK_PLL14XX, _name, _id, _offset, 0, 0, 0, _parents, 1, 0, NULL, _pll_tbl)
> > +
> > +#define IMX_BLK_CTRL_RESET(_id, _offset, _shift) \
> > +       IMX_BLK_CTRL(BLK_CTRL_RESET, NULL, _id, _offset, _shift, 0, 1, NULL, 0, 0, NULL, NULL)
> > +
> > +#define IMX_BLK_CTRL_RESET_MASK(_id, _offset, _shift, mask) \
> > +       IMX_BLK_CTRL(BLK_CTRL_RESET, NULL, _id, _offset, _shift, 0, mask, NULL, 0, 0, NULL, NULL)
> > +
> > +extern const struct imx_blk_ctrl_dev_data imx8mp_audio_blk_ctrl_dev_data __initconst;
> > +extern const struct imx_blk_ctrl_dev_data imx8mp_media_blk_ctrl_dev_data __initconst;
> > +extern const struct imx_blk_ctrl_dev_data imx8mp_hdmi_blk_ctrl_dev_data __initconst;
> > +
> 
> If no special reasons, i may prefer to put those data in either
> clk-blk-ctrl.c or separate clk-blk-ctrl-data.c
> because there seems to be no code level dependency on the CCM
> driver(clk-imx8mq.c) for clk_blk_ctrl drivers.
> Then we can save those extern variables.
> 

The rationale here is to have the SoC specific definitions in the SoC specific
clock provider driver. Otherwise with every new SoC that will use the blk_ctl
IPs we will increase the size of clk-blk-ctrl driver. Plus the kernel names of
the clocks used by each blk_ctl IP as parents are also defined in the SoC
specific clock provider driver.

I'll find a way, though, to move those so that they would not be shared between
all the clock drivers that needs a blk_ctl implementation.

> Regards
> Aisheng
> 
> > +#endif
> > +
> > --
> > 2.7.4
> >
