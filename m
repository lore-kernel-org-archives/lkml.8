Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46742C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBE1206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F78bU+N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgGXNtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:49:29 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A5C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:49:28 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id h18so2966614uao.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSrp1L0eUQyzHpgZnMO7fi3+svViuZdK8HvAiaNtnzM=;
        b=F78bU+N1HV7Wf9RlToBEZUQmyTEQaGIODTRiaDKs4yyB4G0U6YuJVaYuj/IlLQ3oZM
         O1NCJCME2Xb1tyaz1/5GjQxVDXctNV1lXegkvewW8GUF6DGajF+dzrAy6d93FepB9vAW
         RDXsxkvTuWmVchB9VfqVQaKuv6wbtFVFJ9FPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSrp1L0eUQyzHpgZnMO7fi3+svViuZdK8HvAiaNtnzM=;
        b=POJEYl1+0cI/XVfc4zKbIlUaEgp/IRBKNJJP5F+o0IE4OOgBjasVyqwK8Y5mZW00lB
         lzmym845ty5RJ1EkIwlprJFf+EsXm8Z+F07woe4du6rdGni1VsuHIUo/Nu4p9gw94J22
         AqRPRYMrS/wdjWWvl3FI0TuB9iS/quyC9MSNXT7D5/F+K8aZZ/dRctJeB4XKPaAgKSVa
         JSzemUVxxIr6N5UbX6A/xzgIRFdufVXeBzzTTir2q6L3W0B73MswZpFwtBDKhW1iV9qp
         i0gwNqYOKFUQdFmMpHlkN7PL50aQ5Ind0YgEwCXirbCElBgmToXMzulXHLcoN9FkidNQ
         sZnQ==
X-Gm-Message-State: AOAM5325G1OYWxRcWbW6hNEKaIHg5OD0AKMpg+SA4pWvX0nBAWpu+U3E
        QsdgzDNsLI1ktzjHfvj5r2gy79twCdlgM4eMtVY53Q==
X-Google-Smtp-Source: ABdhPJz94abl2f4Bnx416rASWBY0nE0lUyqccXyLfxR6VRy06jZ8yfaI8YvKbdr25RJZ98fCM0mF202mtckT20J9JZs=
X-Received: by 2002:a9f:2338:: with SMTP id 53mr8106439uae.129.1595598567715;
 Fri, 24 Jul 2020 06:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com> <1595469798-3824-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1595469798-3824-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 24 Jul 2020 21:49:16 +0800
Message-ID: <CANMq1KDnk4QgO0=LdXY3zftRgOa_90qXPJHOrKsG2RgJeVVh5g@mail.gmail.com>
Subject: Re: [v7, PATCH 3/7] mtk-mmsys: add mt8183 mmsys support
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:05 AM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> add mt8183 mmsys support
>
> Feature: drm/mediatek
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/Makefile       |   1 +
>  drivers/soc/mediatek/mmsys/mt8183-mmsys.c | 161 ++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c          |   1 +
>  3 files changed, 163 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8183-mmsys.c
>
> diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/mmsys/Makefile
> index 33b0dab..62cfedf 100644
> --- a/drivers/soc/mediatek/mmsys/Makefile
> +++ b/drivers/soc/mediatek/mmsys/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y += mt2701-mmsys.o
> +obj-y += mt8183-mmsys.o
> diff --git a/drivers/soc/mediatek/mmsys/mt8183-mmsys.c b/drivers/soc/mediatek/mmsys/mt8183-mmsys.c
> new file mode 100644
> index 0000000..9d5f276
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/mt8183-mmsys.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2020 MediaTek Inc.
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
> +
> +#define DISP_OVL0_MOUT_EN              0xf00
> +#define DISP_OVL0_2L_MOUT_EN           0xf04
> +#define DISP_OVL1_2L_MOUT_EN           0xf08
> +#define DISP_DITHER0_MOUT_EN           0xf0c
> +#define DISP_PATH0_SEL_IN              0xf24
> +#define DISP_DSI0_SEL_IN               0xf2c
> +#define DISP_DPI0_SEL_IN               0xf30
> +#define DISP_RDMA0_SOUT_SEL_IN         0xf50
> +#define DISP_RDMA1_SOUT_SEL_IN         0xf54
> +
> +#define OVL0_MOUT_EN_OVL0_2L                   BIT(4)
> +#define OVL0_2L_MOUT_EN_DISP_PATH0             BIT(0)
> +#define OVL1_2L_MOUT_EN_RDMA1                  BIT(4)
> +#define DITHER0_MOUT_IN_DSI0                   BIT(0)
> +#define DISP_PATH0_SEL_IN_OVL0_2L              0x1
> +#define DSI0_SEL_IN_RDMA0                      0x1
> +#define DSI0_SEL_IN_RDMA1                      0x3
> +#define DPI0_SEL_IN_RDMA0                      0x1
> +#define DPI0_SEL_IN_RDMA1                      0x2
> +#define RDMA0_SOUT_COLOR0                      0x1
> +#define RDMA1_SOUT_DSI0                                0x1
> +
> +struct mmsys_path_sel {
> +       enum mtk_ddp_comp_id cur;
> +       enum mtk_ddp_comp_id next;
> +       u32 addr;
> +       u32 val;
> +};
> +
> +static struct mmsys_path_sel mmsys_mout_en[] = {
> +       {
> +               DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
> +               DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_OVL0_2L,
> +       },
> +       {
> +               DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +               DISP_OVL0_2L_MOUT_EN, OVL0_2L_MOUT_EN_DISP_PATH0,
> +       },
> +       {
> +               DDP_COMPONENT_OVL_2L1, DDP_COMPONENT_RDMA1,
> +               DISP_OVL1_2L_MOUT_EN, OVL1_2L_MOUT_EN_RDMA1,
> +       },
> +       {
> +               DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +               DISP_DITHER0_MOUT_EN, DITHER0_MOUT_IN_DSI0,
> +       },
> +};
> +
> +static struct mmsys_path_sel mmsys_sel_in[] = {
> +       {
> +               DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +               DISP_PATH0_SEL_IN, DISP_PATH0_SEL_IN_OVL0_2L,
> +       },
> +       {
> +               DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
> +               DISP_DPI0_SEL_IN, DPI0_SEL_IN_RDMA1,
> +       },
> +};
> +
> +static struct mmsys_path_sel mmsys_sout_sel[] = {
> +       {
> +               DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
> +               DISP_RDMA0_SOUT_SEL_IN, RDMA0_SOUT_COLOR0,
> +       },
> +};
> +
> +static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> +                                         enum mtk_ddp_comp_id next,
> +                                         unsigned int *addr)
> +{
> +       u32 i;
> +       u32 val = 0;
> +       struct mmsys_path_sel *path;
> +
> +       for (i = 0; i < ARRAY_SIZE(mmsys_mout_en); i++) {
> +               path = &mmsys_mout_en[i];
> +               if (cur == path->cur && next == path->next) {
> +                       *addr = path->addr;
> +                       val = path->val;

return path->val?

> +                       break;
> +               }
> +       }
> +
> +       return val;

Then this becomes just return 0;

> +}
> +
> +static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
> +                                        enum mtk_ddp_comp_id next,
> +                                        unsigned int *addr)
> +{
> +       u32 i;
> +       u32 val = 0;
> +       struct mmsys_path_sel *path;
> +
> +       for (i = 0; i < ARRAY_SIZE(mmsys_sel_in); i++) {
> +               path = &mmsys_sel_in[i];
> +               if (cur == path->cur && next == path->next) {
> +                       *addr = path->addr;
> +                       val = path->val;
> +                       break;
> +               }
> +       }
> +
> +       return val;

ditto

> +}
> +
> +static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
> +                                  enum mtk_ddp_comp_id cur,
> +                                  enum mtk_ddp_comp_id next)
> +{
> +       u32 i;
> +       u32 val = 0;
> +       u32 addr = 0;
> +       struct mmsys_path_sel *path;
> +
> +       for (i = 0; i < ARRAY_SIZE(mmsys_sout_sel); i++) {
> +               path = &mmsys_sout_sel[i];
> +               if (cur == path->cur && next == path->next) {
> +                       addr = path->addr;
> +                       val = path->val;
> +                       break;

writel_relaxed(path->val, config_regs + path->addr);
return;

> +               }
> +       }
> +
> +       if (val)
> +               writel_relaxed(val, config_regs + addr);
> +}
> +
> +static struct mtk_mmsys_conn_funcs mmsys_funcs = {
> +       .mout_en = mtk_mmsys_ddp_mout_en,
> +       .sel_in = mtk_mmsys_ddp_sel_in,
> +       .sout_sel = mtk_mmsys_ddp_sout_sel,
> +};
> +
> +static int mmsys_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +
> +       mtk_mmsys_register_conn_funcs(dev->parent, &mmsys_funcs);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver mmsys_drv = {
> +       .probe = mmsys_probe,
> +       .driver = {
> +               .name = "mt8183-mmsys",
> +       },
> +};
> +
> +builtin_platform_driver(mmsys_drv);
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 605b992..6a451ac 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -47,6 +47,7 @@ struct mtk_mmsys_private_data {
>
>  static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>         .clk_driver = "clk-mt8183-mm",
> +       .mmsys_driver = "mt8183-mmsys",
>  };
>
>  void mtk_mmsys_ddp_connect(struct device *dev,
> --
> 1.8.1.1.dirty
