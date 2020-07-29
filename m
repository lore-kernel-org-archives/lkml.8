Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794942076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmLSAop2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgG2Jcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgG2Jcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:32:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D04C061794;
        Wed, 29 Jul 2020 02:32:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a65so7861337otc.8;
        Wed, 29 Jul 2020 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHhG5jxleK/NwjMdPfb9zjsQp7xv4ruX3ZHlREQ/R1E=;
        b=nmLSAop2RYQFa35KUVOM2bkx8RGjiDGd+1v/AENuODxfInSpb26mCs/SjVwJQQnVtY
         cGS0UE214SE4mLBt9tMzHb2FEFQwScLPSAcXRouJVT4b3rUIoHlitRpT/+zPgcefAsIU
         NLsQpITaLj1WmaSSiktae8CjQe8qbIslEZrWgHQT+TQhoPACSUqggoUNl52EsQJM3jRR
         25nN4oHhDF7Uy1DGDfb7oQuYgTkdgsC/+bq7rYrPvt5mQFGv96hOYlsvihO5+52XPQgU
         FMxm+RswV/flgIa1qSVhUB8oTYgJXCH/8CIr9ppYcf0zor0kfHvsJluCoPmkdMZpdWAU
         +qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHhG5jxleK/NwjMdPfb9zjsQp7xv4ruX3ZHlREQ/R1E=;
        b=dHfRfeBSo2uZaW3xAuZhcdgYdQNIrwNVty+j9YUkC7GP2ErbbvjQlhm/pI5U6HTwJr
         1RogRAzdAH04Q8nSbvDIPIO3WOL0BAecAlcmhVXToFaD3S4Bp2+QC/h6tOCU/jsGPrSR
         lyRYmQrAJWyKOvnYn/yHEUqUJMMXdgVqM1XR2MWhNxk7YFDbHnQic8lRPDHvVku5Zl/X
         dTS8kzhM4D7J6Rr5LKBKshbC383mLyyVMQIJMgwyJQaU+N/fTCZ293hBAgoC5CMjyEer
         /GA152UFGz7a8pnOwQNEB65TfDvL4US+CqXwEzFzEFMaH9gxLu4pMYXyzHBULiwvSOfB
         ivMA==
X-Gm-Message-State: AOAM531qvLSk6ApE2lI+YrQ/6uo0+OPSoearVKiO2zC+z9NZI3J8kxCL
        LGyB7Bj6j5p3Q4dyVtJeYG7GwkU984yWr//Ledw=
X-Google-Smtp-Source: ABdhPJz+lDYyzS5yNdRSnrCl60tunB7jRkBS4DJ55b3j6mWjIyEdpCm8HqT7jQEXlNi/0E21pKrDEHxYKk+ZQhV6CEY=
X-Received: by 2002:a9d:d57:: with SMTP id 81mr26959371oti.184.1596015171996;
 Wed, 29 Jul 2020 02:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com> <1596012277-8448-6-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1596012277-8448-6-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 29 Jul 2020 11:32:40 +0200
Message-ID: <CAFqH_50_xi5WkokS3WmV2Z-yAK06bpXBMgTQomwmJHcQmfX9yw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] clk: mediatek: Add MT8192 clock support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Thank you for your patch. Some few comment below, I'll focus on
clk-mt8192-mm file, but I think can apply to other files too.

[snip]

> diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
> new file mode 100644
> index 0000000..02eef24
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8192-mm.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0

nit: Although is a valid license identifier for the kernel would be
better to use the non-deprecated form by SPDX, GPL-2.0-only

> +//
> +// Copyright (c) 2020 MediaTek Inc.
> +// Author: Weiyi Lu <weiyi.lu@mediatek.com>
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +
> +#include <dt-bindings/clock/mt8192-clk.h>
> +
> +static const struct mtk_gate_regs mm0_cg_regs = {
> +       .set_ofs = 0x104,
> +       .clr_ofs = 0x108,
> +       .sta_ofs = 0x100,
> +};
> +
> +static const struct mtk_gate_regs mm1_cg_regs = {
> +       .set_ofs = 0x114,
> +       .clr_ofs = 0x118,
> +       .sta_ofs = 0x110,
> +};
> +
> +static const struct mtk_gate_regs mm2_cg_regs = {
> +       .set_ofs = 0x1a4,
> +       .clr_ofs = 0x1a8,
> +       .sta_ofs = 0x1a0,
> +};
> +
> +#define GATE_MM0(_id, _name, _parent, _shift)                  \
> +       GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift,     \
> +               &mtk_clk_gate_ops_setclr)

nit: You can take advantage of the new line length limit, which is now
100 characters.

> +
> +#define GATE_MM1(_id, _name, _parent, _shift)                  \
> +       GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift,     \
> +               &mtk_clk_gate_ops_setclr)
> +

ditto

> +#define GATE_MM2(_id, _name, _parent, _shift)                  \
> +       GATE_MTK(_id, _name, _parent, &mm2_cg_regs, _shift,     \
> +               &mtk_clk_gate_ops_setclr)
> +

ditto

> +static const struct mtk_gate mm_clks[] = {
> +       /* MM0 */
> +       GATE_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0", "disp_sel", 0),
> +       GATE_MM0(CLK_MM_DISP_CONFIG, "mm_disp_config", "disp_sel", 1),
> +       GATE_MM0(CLK_MM_DISP_OVL0, "mm_disp_ovl0", "disp_sel", 2),
> +       GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "disp_sel", 3),
> +       GATE_MM0(CLK_MM_DISP_OVL0_2L, "mm_disp_ovl0_2l", "disp_sel", 4),
> +       GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "disp_sel", 5),
> +       GATE_MM0(CLK_MM_DISP_UFBC_WDMA0, "mm_disp_ufbc_wdma0", "disp_sel", 6),
> +       GATE_MM0(CLK_MM_DISP_RSZ0, "mm_disp_rsz0", "disp_sel", 7),
> +       GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "disp_sel", 8),
> +       GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "disp_sel", 9),
> +       GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "disp_sel", 10),
> +       GATE_MM0(CLK_MM_SMI_INFRA, "mm_smi_infra", "disp_sel", 11),
> +       GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "disp_sel", 12),
> +       GATE_MM0(CLK_MM_DISP_POSTMASK0, "mm_disp_postmask0", "disp_sel", 13),
> +       GATE_MM0(CLK_MM_DISP_DSC_WRAP0, "mm_disp_dsc_wrap0", "disp_sel", 14),
> +       GATE_MM0(CLK_MM_DSI0, "mm_dsi0", "disp_sel", 15),
> +       GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "disp_sel", 16),
> +       GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "disp_sel", 17),
> +       GATE_MM0(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0", "disp_sel", 18),
> +       GATE_MM0(CLK_MM_DISP_FAKE_ENG1, "mm_disp_fake_eng1", "disp_sel", 19),
> +       GATE_MM0(CLK_MM_MDP_TDSHP4, "mm_mdp_tdshp4", "disp_sel", 20),
> +       GATE_MM0(CLK_MM_MDP_RSZ4, "mm_mdp_rsz4", "disp_sel", 21),
> +       GATE_MM0(CLK_MM_MDP_AAL4, "mm_mdp_aal4", "disp_sel", 22),
> +       GATE_MM0(CLK_MM_MDP_HDR4, "mm_mdp_hdr4", "disp_sel", 23),
> +       GATE_MM0(CLK_MM_MDP_RDMA4, "mm_mdp_rdma4", "disp_sel", 24),
> +       GATE_MM0(CLK_MM_MDP_COLOR4, "mm_mdp_color4", "disp_sel", 25),
> +       GATE_MM0(CLK_MM_DISP_Y2R0, "mm_disp_y2r0", "disp_sel", 26),
> +       GATE_MM0(CLK_MM_SMI_GALS, "mm_smi_gals", "disp_sel", 27),
> +       GATE_MM0(CLK_MM_DISP_OVL2_2L, "mm_disp_ovl2_2l", "disp_sel", 28),
> +       GATE_MM0(CLK_MM_DISP_RDMA4, "mm_disp_rdma4", "disp_sel", 29),
> +       GATE_MM0(CLK_MM_DISP_DPI0, "mm_disp_dpi0", "disp_sel", 30),
> +       /* MM1 */
> +       GATE_MM1(CLK_MM_SMI_IOMMU, "mm_smi_iommu", "disp_sel", 0),
> +       /* MM2 */
> +       GATE_MM2(CLK_MM_DSI_DSI0, "mm_dsi_dsi0", "disp_sel", 0),
> +       GATE_MM2(CLK_MM_DPI_DPI0, "mm_dpi_dpi0", "dpi_sel", 8),
> +       GATE_MM2(CLK_MM_26MHZ, "mm_26mhz", "clk26m", 24),
> +       GATE_MM2(CLK_MM_32KHZ, "mm_32khz", "clk32k", 25),
> +};
> +
> +static int clk_mt8192_mm_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = dev->parent->of_node;
> +       struct clk_onecell_data *clk_data;
> +
> +       clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);

mtk_alloc_clk_data can return NULL

           if (!clk_data)
              return -ENOMEM;

> +
> +       mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
> +                       clk_data);
> +

The above function can fail, better check for error

         if (ret)
             return ret;

> +       return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +

No need for double line spacing.

> +static struct platform_driver clk_mt8192_mm_drv = {
> +       .probe = clk_mt8192_mm_probe,
> +       .driver = {
> +               .name = "clk-mt8192-mm",
> +       },
> +};
> +
> +builtin_platform_driver(clk_mt8192_mm_drv);

[snip]
