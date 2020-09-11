Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C5DC2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C85A2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0IgQ1iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgIKJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:51:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE0BC061573;
        Fri, 11 Sep 2020 02:51:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so13013208ejb.1;
        Fri, 11 Sep 2020 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6h+JaP/jYM+to4bhsqndhQGXnC34C1TfawVOeJdGLIY=;
        b=a0IgQ1iRoNorrCFKqLlUE5GyTNZX2jgKYEylYsnrUYlKO/0TygpZLKxiHNg13stBD7
         NtvSga4AoEzpBtWT7AZZv9E8/n/lwlTCo9de93Q5muKNfsV2kVXaFaW+hLD0ptLoHGR8
         nLsLni6hgBXjv3wiLEugDaqfzXly/yG891RlWUn/fFwvUa9yU2Iz9hep0ySzxxNp00EU
         92wvUiX06l+mAQzVnFC3K2ifbKx1Dy1Wki1HyBiGWaP1uuBfSI/C+8D5CoSiS5FgdWmd
         xxEWGqBN+q7yOQkeCpcrsXsv+KW2ShzDxSQ17cLjs+umjdlkgAgebSeXxLspTC8DQYvO
         Ifgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6h+JaP/jYM+to4bhsqndhQGXnC34C1TfawVOeJdGLIY=;
        b=WomMmZXtel+FDV+cPhBFabzMmytaTSPa+2A4Q3Ar/GMI4OaXc1qq+SLuhPetdAnbUY
         lCOiNLO4gEZ0obLpksyFjxCDwS8I8B9sWxftAVLMvoYHzw9pL2ddHURvWIlL5cIDdjY/
         JuoMowtDkcTckMdrOEl6C31eWREIsMWn/LTZv8Qjm3nyRq5pGHPVHeo3t7zaYHQVncfO
         JQoRYuIvhbXwURKGAIUs7HnHYZxIsrYqe1X1txt2DNnbuSg6gNzFKuFR2NH0hCbio2c6
         86qPVBwOh6X4iEm1w/Ms21AQORMOTqCdbSbdZCHIRrk2y5ES6T+LTw6spx/i1ajA4nvz
         V9ig==
X-Gm-Message-State: AOAM532qDHQ0oLtxPZVGtmYN4vvlHOhVz6QMA2H4mYkF+DoVzYUGxB1o
        EKu7v4pjg+xxx1maPqZhZ6gjfctQg4mSGQUW7EwnpFLP
X-Google-Smtp-Source: ABdhPJxvni5zmkaJeM3yZWQfsf8kwuDrO18iL3su0lUaFH36BSOrM4gkb85iMbMlsHtpmK2v4ZhSSYqoyGPWXHb/Kdo=
X-Received: by 2002:a17:906:b47:: with SMTP id v7mr1201612ejg.310.1599817902866;
 Fri, 11 Sep 2020 02:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com> <1599560691-3763-11-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1599560691-3763-11-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Fri, 11 Sep 2020 17:36:06 +0800
Message-ID: <CAA+hA=Tj4hSfQpB48Rs8grb2CAzfRprFZHHZ02zHnHj_9M1pTQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] clk: imx: Add generic blk-ctl driver
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

On Tue, Sep 8, 2020 at 6:27 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> The i.MX8MP platform introduces a new type of IP which is called BLK_CTL in
> RM and usually is comprised of some GPRs that are considered too
> generic to be part of any dedicated IP from that specific subsystem.
>
> In general, some of the GPRs have some clock bits, some have reset bits,
> so in order to be able to use the imx clock API, this needs to be
> in a clock driver. From there it can use the reset controller API and
> leave the rest to the syscon.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/Makefile      |   2 +-
>  drivers/clk/imx/clk-blk-ctl.c | 297 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk-blk-ctl.h |  80 ++++++++++++
>  3 files changed, 378 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/imx/clk-blk-ctl.c
>  create mode 100644 drivers/clk/imx/clk-blk-ctl.h
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 79e53f2..105c117 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -23,7 +23,7 @@ obj-$(CONFIG_MXC_CLK) += mxc-clk.o
>
>  obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
>  obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
> -obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
> +obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o clk-blk-ctl.o
>  obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>
>  obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
> diff --git a/drivers/clk/imx/clk-blk-ctl.c b/drivers/clk/imx/clk-blk-ctl.c
> new file mode 100644
> index 00000000..1a6f1eb
> --- /dev/null
> +++ b/drivers/clk/imx/clk-blk-ctl.c
> @@ -0,0 +1,297 @@
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
> +#include "clk-blk-ctl.h"
> +
> +struct imx_reset_hw {
> +       u32 offset;
> +       u32 shift;
> +       u32 mask;
> +       volatile unsigned long asserted;

Could you clarify a bit why need 'volatile' here?

> +};
> +
> +struct imx_pm_safekeep_info {
> +       uint32_t *regs_values;
> +       uint32_t *regs_offsets;
> +       uint32_t regs_num;
> +};
> +
> +struct imx_blk_ctl_drvdata {
> +       void __iomem *base;
> +       struct reset_controller_dev rcdev;
> +       struct imx_reset_hw *rst_hws;
> +       struct imx_pm_safekeep_info pm_info;
> +
> +       spinlock_t lock;
> +};
> +
> +static void __maybe_unused imx_blk_ctl_read_write(struct device *dev,
> +                                                       bool write)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       struct imx_pm_safekeep_info *pm_info = &drvdata->pm_info;
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
> +static int __maybe_unused imx_blk_ctl_runtime_suspend(struct device *dev)
> +{
> +       imx_blk_ctl_read_write(dev, false);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused imx_blk_ctl_runtime_resume(struct device *dev)
> +{
> +       imx_blk_ctl_read_write(dev, true);
> +
> +       return 0;
> +}
> +
> +const struct dev_pm_ops imx_blk_ctl_pm_ops = {
> +       SET_RUNTIME_PM_OPS(imx_blk_ctl_runtime_suspend,
> +                          imx_blk_ctl_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                          pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> +
> +static int imx_blk_ctl_reset_set(struct reset_controller_dev *rcdev,
> +                                 unsigned long id, bool assert)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata = container_of(rcdev,
> +                       struct imx_blk_ctl_drvdata, rcdev);
> +       unsigned int offset = drvdata->rst_hws[id].offset;
> +       unsigned int shift = drvdata->rst_hws[id].shift;
> +       unsigned int mask = drvdata->rst_hws[id].mask;
> +       void __iomem *reg_addr = drvdata->base + offset;
> +       unsigned long flags;
> +       u32 reg;
> +
> +       if (assert && !test_and_set_bit(1, &drvdata->rst_hws[id].asserted))
> +               pm_runtime_get_sync(rcdev->dev);
> +

i'm a bit confused because each reset hw has a field 'asserted' which means
you're doing bit operations on each separate private variable.
Is that what we want?

BTW, what if user calling deassert first?
Will that cause writing registers without enabling power domain?

> +       spin_lock_irqsave(&drvdata->lock, flags);
> +
> +       reg = readl(reg_addr);
> +       if (assert)
> +               writel(reg & ~(mask << shift), reg_addr);
> +       else
> +               writel(reg | (mask << shift), reg_addr);
> +
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +       if (!assert && test_and_clear_bit(1, &drvdata->rst_hws[id].asserted))
> +               pm_runtime_put(rcdev->dev);
> +
> +       return 0;
> +}
> +
> +static int imx_blk_ctl_reset_assert(struct reset_controller_dev *rcdev,
> +                                          unsigned long id)
> +{
> +       return imx_blk_ctl_reset_set(rcdev, id, true);
> +}
> +
> +static int imx_blk_ctl_reset_deassert(struct reset_controller_dev *rcdev,
> +                                            unsigned long id)
> +{
> +       return imx_blk_ctl_reset_set(rcdev, id, false);
> +}
> +
> +static const struct reset_control_ops imx_blk_ctl_reset_ops = {
> +       .assert         = imx_blk_ctl_reset_assert,
> +       .deassert       = imx_blk_ctl_reset_deassert,
> +};
> +
> +static int imx_blk_ctl_register_reset_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       int max = dev_data->resets_max;
> +       struct imx_reset_hw *hws;
> +       int i;
> +
> +       spin_lock_init(&drvdata->lock);
> +
> +       drvdata->rcdev.owner     = THIS_MODULE;
> +       drvdata->rcdev.nr_resets = max;
> +       drvdata->rcdev.ops       = &imx_blk_ctl_reset_ops;
> +       drvdata->rcdev.of_node   = dev->of_node;
> +       drvdata->rcdev.dev       = dev;
> +
> +       drvdata->rst_hws = devm_kcalloc(dev, max, sizeof(struct imx_reset_hw),
> +                                       GFP_KERNEL);
> +       hws = drvdata->rst_hws;
> +
> +       for (i = 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctl_hw *hw = &dev_data->hws[i];
> +
> +               if (hw->type != BLK_CTL_RESET)
> +                       continue;
> +
> +               hws[hw->id].offset = hw->offset;
> +               hws[hw->id].shift = hw->shift;
> +               hws[hw->id].mask = hw->mask;
> +       }
> +
> +       return devm_reset_controller_register(dev, &drvdata->rcdev);
> +}
> +static struct clk_hw *imx_blk_ctl_register_one_clock(struct device *dev,
> +                                               struct imx_blk_ctl_hw *hw)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       void __iomem *base = drvdata->base;
> +       struct clk_hw *clk_hw = NULL;
> +
> +       switch (hw->type) {
> +       case BLK_CTL_CLK_MUX:
> +               clk_hw = imx_dev_clk_hw_mux_flags(dev, hw->name,
> +                                                 base + hw->offset,
> +                                                 hw->shift, hw->width,
> +                                                 hw->parents,
> +                                                 hw->parents_count,
> +                                                 hw->flags);
> +               break;
> +       case BLK_CTL_CLK_GATE:
> +               clk_hw = imx_dev_clk_hw_gate(dev, hw->name, hw->parents,
> +                                            base + hw->offset, hw->shift);
> +               break;
> +       case BLK_CTL_CLK_SHARED_GATE:
> +               clk_hw = imx_dev_clk_hw_gate_shared(dev, hw->name,
> +                                                   hw->parents,
> +                                                   base + hw->offset,
> +                                                   hw->shift,
> +                                                   hw->shared_count);
> +               break;
> +       case BLK_CTL_CLK_PLL14XX:
> +               clk_hw = imx_dev_clk_hw_pll14xx(dev, hw->name, hw->parents,
> +                                               base + hw->offset, hw->pll_tbl);
> +               break;
> +       };
> +
> +       return clk_hw;
> +}
> +
> +static int imx_blk_ctl_register_clock_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
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
> +               struct imx_blk_ctl_hw *hw = &dev_data->hws[i];
> +
> +               hws[hw->id] = imx_blk_ctl_register_one_clock(dev, hw);
> +               WARN(IS_ERR(hws[hw->id]), "failed to register clock %d", hw->id);

Is this line duplicated with the following imx_check_clk_hws()?

Regards
Aisheng

> +       }
> +
> +       imx_check_clk_hws(hws, dev_data->clocks_max);
> +
> +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +                                       clk_hw_data);
> +}
> +
> +static int imx_blk_ctl_init_runtime_pm_safekeeping(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       struct imx_pm_safekeep_info *pm_info = &drvdata->pm_info;
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
> +int imx_blk_ctl_probe(struct platform_device *pdev)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata;
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
> +       ret = imx_blk_ctl_init_runtime_pm_safekeeping(dev);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       ret = imx_blk_ctl_register_clock_controller(dev);
> +       if (ret) {
> +               pm_runtime_put(dev);
> +               return ret;
> +       }
> +
> +       ret = imx_blk_ctl_register_reset_controller(dev);
> +
> +       pm_runtime_put(dev);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_probe);
> diff --git a/drivers/clk/imx/clk-blk-ctl.h b/drivers/clk/imx/clk-blk-ctl.h
> new file mode 100644
> index 00000000..e5bf723
> --- /dev/null
> +++ b/drivers/clk/imx/clk-blk-ctl.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __MACH_IMX_CLK_BLK_CTL_H
> +#define __MACH_IMX_CLK_BLK_CTL_H
> +
> +enum imx_blk_ctl_hw_type {
> +       BLK_CTL_CLK_MUX,
> +       BLK_CTL_CLK_GATE,
> +       BLK_CTL_CLK_SHARED_GATE,
> +       BLK_CTL_CLK_PLL14XX,
> +       BLK_CTL_RESET,
> +};
> +
> +struct imx_blk_ctl_hw {
> +       int type;
> +       char *name;
> +       u32 offset;
> +       u32 shift;
> +       u32 mask;
> +       u32 width;
> +       u32 flags;
> +       u32 id;
> +       const void *parents;
> +       u32 parents_count;
> +       int *shared_count;
> +       const struct imx_pll14xx_clk *pll_tbl;
> +};
> +
> +struct imx_blk_ctl_dev_data {
> +       struct imx_blk_ctl_hw *hws;
> +       u32 hws_num;
> +
> +       u32 clocks_max;
> +       u32 resets_max;
> +
> +       u32 pm_runtime_saved_regs_num;
> +       u32 pm_runtime_saved_regs[];
> +};
> +
> +#define IMX_BLK_CTL(_type, _name, _id, _offset, _shift, _width, _mask, _parents, _parents_count, _flags, sh_count, _pll_tbl) \
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
> +#define IMX_BLK_CTL_CLK_MUX(_name, _id, _offset, _shift, _width, _parents) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_MUX_FLAGS(_name, _id, _offset, _shift, _width, _parents, _flags) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), _flags, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_GATE(_name, _id, _offset, _shift, _parents) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_SHARED_GATE(_name, _id, _offset, _shift, _parents, sh_count) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_SHARED_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, sh_count, NULL)
> +
> +#define IMX_BLK_CTL_CLK_PLL14XX(_name, _id, _offset, _parents, _pll_tbl) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_PLL14XX, _name, _id, _offset, 0, 0, 0, _parents, 1, 0, NULL, _pll_tbl)
> +
> +#define IMX_BLK_CTL_RESET(_id, _offset, _shift) \
> +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, 1, NULL, 0, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_RESET_MASK(_id, _offset, _shift, mask) \
> +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, mask, NULL, 0, 0, NULL, NULL)
> +
> +extern const struct dev_pm_ops imx_blk_ctl_pm_ops;
> +
> +int imx_blk_ctl_probe(struct platform_device *pdev);
> +
> +#endif
> --
> 2.7.4
>
