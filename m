Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC55C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CCD20706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMGOSHIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHRLmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:42:12 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A23C061389;
        Tue, 18 Aug 2020 04:42:12 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so14970491edk.6;
        Tue, 18 Aug 2020 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTXpjudUrx7UjUIxlgYDZW31r7xfKJ9b94bCxejQQxY=;
        b=cMGOSHIxYLN3e4zbM7bGglqJCRNnLcX3IV9iptwqUHAx1wbzOXF9vdW+ObJdvkwE5h
         5Nl4pY8qvH0pdzUoHpdXKh0axZVFAGBD1kzGxvqT4HaV88bj3OGktIXG0/pm6JL8HetT
         qVtrA12roDl4BTnsKLZItvyxpLFwqrwno4xBkgeJfWC9qBZRtccaxDT4XFLS5u6RCVpk
         NrFJfzsEPVj0Sjp7bdCFUq6v+JtAYmU4DpH90VxJb8S75XB9y6f7xGa2vYzpR/LoMfj4
         CGWBTlBv6MHSiJkVgUTCC10q0j1Jn+hw2QKSFjOd8UIyigMMZYYaArnnjrw7xW/zS7CZ
         g7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTXpjudUrx7UjUIxlgYDZW31r7xfKJ9b94bCxejQQxY=;
        b=uA+oxOVkW0SlfCBf5or7YI/GjIuEh8IyVUAgylVjFgBc7PCDMsWdMtsdYpEV4jAQuz
         WY+AMJqpja5ig7kn6nqC/FhV+1dhUNhZttz+kXvM/vnH6FCj+ZGDx9b72YEGSYzsuZPm
         EYkBP04P31l5HhkpPQv9Yf+OAFYY4/wG+ikh1426u/QoBi/1myQyGuxwzYnVNu55xcfH
         LuQ6i+q5HvS15YB1j2HdMboDts2pov63N3vnLL0fZKcDbcme3fl+zGFMmepO8xd15+zw
         JKlZRrlmGoL/7wl1O4sItXFVcOH8x3CpikWXPV+L6VBFnjBeTblnKQvGmZwuk/5lTm/N
         dxMA==
X-Gm-Message-State: AOAM532Vi9BkKGzrt+SWibOqIOSkYMWSEXB9NJpyZlXdD7GxmHxfR9ga
        7YIio7X9ZwI/rm2lWMVKn2R+ptq6SuXnFC5J4wM=
X-Google-Smtp-Source: ABdhPJwhMMZ1jRmEqqLMuiDQNdSryiigOu7jE/DlUdcBLSUprRCGaFbsIPbn2TC/TxYGGMVoFQz4WbWb8DSGIm/z/Oo=
X-Received: by 2002:aa7:d293:: with SMTP id w19mr18816260edq.119.1597750930624;
 Tue, 18 Aug 2020 04:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-12-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-12-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 Aug 2020 19:27:03 +0800
Message-ID: <CAA+hA=R9bFBX-tFfSEO3wqC+b4P1nbfSVyBQUOzez=oZ71AhkA@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] clk: imx: Add blk_ctrl combo driver
To:     Abel Vesa <abel.vesa@nxp.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On i.MX8MP, there is a new type of IP which is called BLK_CTRL in
> RM and usually is comprised of some GPRs that are considered too
> generic to be part of any dedicated IP from that specific subsystem.
>
> In general, some of the GPRs have some clock bits, some have reset bits,
> so in order to be able to use the imx clock API, this needs to be
> in a clock driver. From there it can use the reset controller API and
> leave the rest to the syscon.
>
> This driver is intended to work with the following BLK_CTRL IPs found in
> i.MX8MP (but it might be reused by the future i.MX platforms that
> have this kind of IP in their design):
>  - Audio
>  - Media
>  - HDMI
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

The code mostly looks good to me.
Only a few minor comments.

> ---
>  drivers/clk/imx/Makefile       |   2 +-
>  drivers/clk/imx/clk-blk-ctrl.c | 327 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk-blk-ctrl.h |  81 ++++++++++
>  3 files changed, 409 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-blk-ctrl.c
>  create mode 100644 drivers/clk/imx/clk-blk-ctrl.h
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 928f874c..7afe1df 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -27,7 +27,7 @@ obj-$(CONFIG_MXC_CLK_SCU) += \
>
>  obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
>  obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
> -obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
> +obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-blk-ctrl.o
>  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>  obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
>
> diff --git a/drivers/clk/imx/clk-blk-ctrl.c b/drivers/clk/imx/clk-blk-ctrl.c
> new file mode 100644
> index 00000000..1672646
> --- /dev/null
> +++ b/drivers/clk/imx/clk-blk-ctrl.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/reset-controller.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +#include "clk-blk-ctrl.h"
> +
> +struct reset_hw {

s/reset_hw/imx_reset_hw
It helps the reader to quickly understand it's not core structure

> +       u32 offset;
> +       u32 shift;
> +       u32 mask;
> +       bool asserted;
> +};
> +
> +struct pm_safekeep_info {

imx_pm_safekeep_info

> +       uint32_t *regs_values;
> +       uint32_t *regs_offsets;
> +       uint32_t regs_num;
> +};
> +
> +struct imx_blk_ctrl_drvdata {
> +       void __iomem *base;
> +       struct reset_controller_dev rcdev;
> +       struct reset_hw *rst_hws;
> +       struct pm_safekeep_info pm_info;
> +
> +       spinlock_t lock;
> +};
> +
> +static int imx_blk_ctrl_reset_set(struct reset_controller_dev *rcdev,
> +                                 unsigned long id, bool assert)
> +{
> +       struct imx_blk_ctrl_drvdata *drvdata = container_of(rcdev,
> +                       struct imx_blk_ctrl_drvdata, rcdev);
> +       unsigned int offset = drvdata->rst_hws[id].offset;
> +       unsigned int shift = drvdata->rst_hws[id].shift;
> +       unsigned int mask = drvdata->rst_hws[id].mask;
> +       void __iomem *reg_addr = drvdata->base + offset;
> +       unsigned long flags;
> +       unsigned int asserted_before = 0, asserted_after = 0;

swap above two lines from long to short

> +       u32 reg;
> +       int i;
> +
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +
> +       for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> +               if (drvdata->rst_hws[i].asserted)
> +                       asserted_before++;
> +
> +       if (asserted_before == 0 && assert)
> +               pm_runtime_get(rcdev->dev);
> +
> +       if (assert) {
> +               reg = readl(reg_addr);
> +               writel(reg & ~(mask << shift), reg_addr);
> +               drvdata->rst_hws[id].asserted = true;
> +       } else {
> +               reg = readl(reg_addr);
> +               writel(reg | (mask << shift), reg_addr);
> +               drvdata->rst_hws[id].asserted = false;
> +       }
> +
> +       for (i = 0; i < drvdata->rcdev.nr_resets; i++)
> +               if (drvdata->rst_hws[i].asserted)
> +                       asserted_after++;

I guess the logic may be able to be simplified.
For example, put assert ref count in the private structure.
Then
call pm_runtime_get when ref count is 0 and assert is true.
call pm_runtime_put when ref ount is 0 and assert is false.
No need to go through twice for loop each time.

> +
> +       if (asserted_before == 1 && asserted_after == 0)
> +               pm_runtime_put(rcdev->dev);
> +
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int imx_blk_ctrl_reset_assert(struct reset_controller_dev *rcdev,
> +                                          unsigned long id)
> +{
> +       return imx_blk_ctrl_reset_set(rcdev, id, true);
> +}
> +
> +static int imx_blk_ctrl_reset_deassert(struct reset_controller_dev *rcdev,
> +                                            unsigned long id)
> +{
> +       return imx_blk_ctrl_reset_set(rcdev, id, false);
> +}
> +
> +static const struct reset_control_ops imx_blk_ctrl_reset_ops = {
> +       .assert         = imx_blk_ctrl_reset_assert,
> +       .deassert       = imx_blk_ctrl_reset_deassert,
> +};
> +
> +static int imx_blk_ctrl_register_reset_controller(struct device *dev)
> +{
> +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +       const struct imx_blk_ctrl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct reset_hw *hws;
> +       int max = dev_data->resets_max;

sort from long to short

> +       int i;
> +
> +       spin_lock_init(&drvdata->lock);
> +
> +       drvdata->rcdev.owner     = THIS_MODULE;
> +       drvdata->rcdev.nr_resets = max;
> +       drvdata->rcdev.ops       = &imx_blk_ctrl_reset_ops;
> +       drvdata->rcdev.of_node   = dev->of_node;
> +       drvdata->rcdev.dev       = dev;
> +
> +       drvdata->rst_hws = devm_kcalloc(dev, max, sizeof(struct reset_hw),
> +                                       GFP_KERNEL);
> +       hws = drvdata->rst_hws;
> +
> +       for (i = 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctrl_hw *hw = &dev_data->hws[i];
> +
> +               if (hw->type != BLK_CTRL_RESET)
> +                       continue;
> +
> +               hws[hw->id].offset = hw->offset;
> +               hws[hw->id].shift = hw->shift;
> +               hws[hw->id].mask = hw->mask;
> +       }
> +
> +       return devm_reset_controller_register(dev, &drvdata->rcdev);
> +}
> +static struct clk_hw *imx_blk_ctrl_register_one_clock(struct device *dev,
> +                                               struct imx_blk_ctrl_hw *hw)
> +{
> +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +       void __iomem *base = drvdata->base;
> +       struct clk_hw *clk_hw;
> +
> +       switch (hw->type) {
> +       case BLK_CTRL_CLK_MUX:
> +               clk_hw = imx_dev_clk_hw_mux_flags(dev, hw->name,
> +                                                 base + hw->offset,
> +                                                 hw->shift, hw->width,
> +                                                 hw->parents,
> +                                                 hw->parents_count,
> +                                                 hw->flags);
> +               break;
> +       case BLK_CTRL_CLK_GATE:
> +               clk_hw = imx_dev_clk_hw_gate(dev, hw->name, hw->parents,
> +                                            base + hw->offset, hw->shift);
> +               break;
> +       case BLK_CTRL_CLK_SHARED_GATE:
> +               clk_hw = imx_dev_clk_hw_gate_shared(dev, hw->name,
> +                                                   hw->parents,
> +                                                   base + hw->offset,
> +                                                   hw->shift,
> +                                                   hw->shared_count);
> +               break;
> +       case BLK_CTRL_CLK_PLL14XX:
> +               clk_hw = imx_dev_clk_hw_pll14xx(dev, hw->name, hw->parents,
> +                                               base + hw->offset, hw->pll_tbl);
> +               break;
> +       default:
> +               clk_hw = NULL;

A better way may be assign clk_hw default to NULL.
Then instead, we can add a WARN here in case the clk hw data is insane.

> +       };
> +
> +       return clk_hw;
> +}
> +
> +static int imx_blk_ctrl_register_clock_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctrl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct clk_hw **hws;
> +       int i;
> +
> +       clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> +                               dev_data->hws_num), GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))
> +               return -ENOMEM;
> +
> +       clk_hw_data->num = dev_data->clocks_max;
> +       hws = clk_hw_data->hws;
> +
> +       for (i = 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctrl_hw *hw = &dev_data->hws[i];
> +               struct clk_hw *tmp = imx_blk_ctrl_register_one_clock(dev, hw);
> +
> +               if (!tmp)
> +                       continue;
> +               hws[hw->id] = tmp;

tmp could be a non NULL error pointer.
Maybe here could be simplied as:
hws[hw->id] = imx_blk_ctrl_register_one_clock(dev, hw);

> +       }
> +
> +       imx_check_clk_hws(hws, dev_data->clocks_max);
> +
> +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +                                       clk_hw_data);
> +}
> +
> +static int imx_blk_ctrl_init_runtime_pm_safekeeping(struct device *dev)
> +{
> +       const struct imx_blk_ctrl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +       struct pm_safekeep_info *pm_info = &drvdata->pm_info;
> +       u32 regs_num = dev_data->pm_runtime_saved_regs_num;
> +       const u32 *regs_offsets = dev_data->pm_runtime_saved_regs;
> +
> +       if (!dev_data->pm_runtime_saved_regs_num)
> +               return 0;
> +
> +       pm_info->regs_values = devm_kzalloc(dev,
> +                                           sizeof(u32) * regs_num,
> +                                           GFP_KERNEL);
> +       if (WARN_ON(IS_ERR(pm_info->regs_values)))
> +               return PTR_ERR(pm_info->regs_values);
> +
> +       pm_info->regs_offsets = kmemdup(regs_offsets,
> +                                       regs_num * sizeof(u32), GFP_KERNEL);
> +       if (WARN_ON(IS_ERR(pm_info->regs_offsets)))
> +               return PTR_ERR(pm_info->regs_offsets);
> +
> +       pm_info->regs_num = regs_num;
> +
> +       return 0;
> +}
> +
> +static int imx_blk_ctrl_probe(struct platform_device *pdev)
> +{
> +       struct imx_blk_ctrl_drvdata *drvdata;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (WARN_ON(!drvdata))
> +               return -ENOMEM;
> +
> +       drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (WARN_ON(IS_ERR(drvdata->base)))
> +               return PTR_ERR(drvdata->base);
> +
> +       dev_set_drvdata(dev, drvdata);
> +
> +       ret = imx_blk_ctrl_init_runtime_pm_safekeeping(dev);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       ret = imx_blk_ctrl_register_clock_controller(dev);
> +       if (ret) {
> +               pm_runtime_put(dev);
> +               return ret;
> +       }
> +
> +       ret = imx_blk_ctrl_register_reset_controller(dev);
> +
> +       pm_runtime_put(dev);
> +
> +       return ret;
> +}
> +
> +static void imx_blk_ctrl_read_write(struct device *dev, bool write)

__maybe_unused

> +{
> +       struct imx_blk_ctrl_drvdata *drvdata = dev_get_drvdata(dev);
> +       struct pm_safekeep_info *pm_info = &drvdata->pm_info;
> +       void __iomem *base = drvdata->base;
> +       int i;
> +
> +       if (!pm_info->regs_num)
> +               return;
> +
> +       for (i = 0; i < pm_info->regs_num; i++) {
> +               u32 offset = pm_info->regs_offsets[i];
> +
> +               if (write)
> +                       writel(pm_info->regs_values[i], base + offset);
> +               else
> +                       pm_info->regs_values[i] = readl(base + offset);
> +       }
> +
> +}
> +
> +static int imx_blk_ctrl_runtime_suspend(struct device *dev)

__maybe_unused

> +{
> +       imx_blk_ctrl_read_write(dev, false);
> +
> +       return 0;
> +}
> +
> +static int imx_blk_ctrl_runtime_resume(struct device *dev)

__maybe_unused

> +{
> +       imx_blk_ctrl_read_write(dev, true);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops imx_blk_ctrl_pm_ops = {
> +       SET_RUNTIME_PM_OPS(imx_blk_ctrl_runtime_suspend,
> +                          imx_blk_ctrl_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                          pm_runtime_force_resume)
> +};
> +
> +static const struct of_device_id imx_blk_ctrl_of_match[] = {
> +       { /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_blk_ctrl_of_match);
> +
> +static struct platform_driver imx_blk_ctrl_driver = {
> +       .probe = imx_blk_ctrl_probe,
> +       .driver = {
> +               .name = "imx-blk-ctrl",
> +               .of_match_table = of_match_ptr(imx_blk_ctrl_of_match),
> +               .pm = &imx_blk_ctrl_pm_ops,
> +       },
> +};
> +module_platform_driver(imx_blk_ctrl_driver);
> diff --git a/drivers/clk/imx/clk-blk-ctrl.h b/drivers/clk/imx/clk-blk-ctrl.h
> new file mode 100644
> index 00000000..b3b7fc37
> --- /dev/null
> +++ b/drivers/clk/imx/clk-blk-ctrl.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __MACH_IMX_CLK_BLK_CTRL_H
> +#define __MACH_IMX_CLK_BLK_CTRL_H
> +
> +enum imx_blk_ctrl_hw_type {
> +       BLK_CTRL_CLK_MUX,
> +       BLK_CTRL_CLK_GATE,
> +       BLK_CTRL_CLK_SHARED_GATE,
> +       BLK_CTRL_CLK_PLL14XX,
> +       BLK_CTRL_RESET,
> +};
> +
> +struct imx_blk_ctrl_hw {
> +       int type;
> +       char *name;
> +       u32 offset;
> +       u32 shift;
> +       u32 mask;
> +       u32 width;
> +       u32 flags;
> +       u32 id;
> +       void *parents;
> +       u32 parents_count;
> +       int *shared_count;
> +       struct imx_pll14xx_clk *pll_tbl;
> +};
> +
> +struct imx_blk_ctrl_dev_data {
> +       struct imx_blk_ctrl_hw *hws;
> +       u32 hws_num;
> +
> +       u32 clocks_max;
> +       u32 resets_max;
> +
> +       u32 pm_runtime_saved_regs_num;
> +       u32 pm_runtime_saved_regs[];
> +};
> +
> +#define IMX_BLK_CTRL(_type, _name, _id, _offset, _shift, _width, _mask, _parents, _parents_count, _flags, sh_count, _pll_tbl) \
> +       {                                               \
> +               .type = _type,                          \
> +               .name = _name,                          \
> +               .id = _id,                              \
> +               .offset = _offset,                      \
> +               .shift = _shift,                        \
> +               .width = _width,                        \
> +               .mask = _mask,                          \
> +               .parents = _parents,                    \
> +               .parents_count = _parents_count,        \
> +               .flags = _flags,                        \
> +               .shared_count = sh_count,               \
> +               .pll_tbl = _pll_tbl,                    \
> +       }
> +
> +#define IMX_BLK_CTRL_CLK_MUX(_name, _id, _offset, _shift, _width, _parents) \
> +       IMX_BLK_CTRL(BLK_CTRL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), 0, NULL, NULL)
> +
> +#define IMX_BLK_CTRL_CLK_MUX_FLAGS(_name, _id, _offset, _shift, _width, _parents, _flags) \
> +       IMX_BLK_CTRL(BLK_CTRL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), _flags, NULL, NULL)
> +
> +#define IMX_BLK_CTRL_CLK_GATE(_name, _id, _offset, _shift, _parents) \
> +       IMX_BLK_CTRL(BLK_CTRL_CLK_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTRL_CLK_SHARED_GATE(_name, _id, _offset, _shift, _parents, sh_count) \
> +       IMX_BLK_CTRL(BLK_CTRL_CLK_SHARED_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, sh_count, NULL)
> +
> +#define IMX_BLK_CTRL_CLK_PLL14XX(_name, _id, _offset, _parents, _pll_tbl) \
> +       IMX_BLK_CTRL(BLK_CTRL_CLK_PLL14XX, _name, _id, _offset, 0, 0, 0, _parents, 1, 0, NULL, _pll_tbl)
> +
> +#define IMX_BLK_CTRL_RESET(_id, _offset, _shift) \
> +       IMX_BLK_CTRL(BLK_CTRL_RESET, NULL, _id, _offset, _shift, 0, 1, NULL, 0, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTRL_RESET_MASK(_id, _offset, _shift, mask) \
> +       IMX_BLK_CTRL(BLK_CTRL_RESET, NULL, _id, _offset, _shift, 0, mask, NULL, 0, 0, NULL, NULL)
> +
> +extern const struct imx_blk_ctrl_dev_data imx8mp_audio_blk_ctrl_dev_data __initconst;
> +extern const struct imx_blk_ctrl_dev_data imx8mp_media_blk_ctrl_dev_data __initconst;
> +extern const struct imx_blk_ctrl_dev_data imx8mp_hdmi_blk_ctrl_dev_data __initconst;
> +

If no special reasons, i may prefer to put those data in either
clk-blk-ctrl.c or separate clk-blk-ctrl-data.c
because there seems to be no code level dependency on the CCM
driver(clk-imx8mq.c) for clk_blk_ctrl drivers.
Then we can save those extern variables.

Regards
Aisheng

> +#endif
> +
> --
> 2.7.4
>
