Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA1EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3422072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597966538;
	bh=liAuRg5Rej4YmwcBjkY8n0f/tmyXRRoBRQ4qaTdkfm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FYf3LnbXRUd1/KlkXxKf04UugRcdhYC6JFaN38L60m5b7hshinVWXZba4UnYccqbI
	 MAd+f6g63jGalPaHzUd+pdHqNK+p37A7Z2u2ppmoWatu/GN6hU1NpPg8rQCbcGY0gx
	 wKWHrNjJCeJqVstb0wftqOrMm3ux9YeHosfS/kr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgHTXfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgHTXff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:35:35 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25382207DF;
        Thu, 20 Aug 2020 23:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597966534;
        bh=liAuRg5Rej4YmwcBjkY8n0f/tmyXRRoBRQ4qaTdkfm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p39NFF2N5v4Ts0BZXAh7stjpHZvRllSbTUgMwYZ1sTcNEpuRHBYTnp2hyHCjFdZy5
         k+HUELxjQgNyzD7dx4hxqKjparUxzIiDZwW3E8QC66ob4//YkJ+SOkwpfXM8BEc2ZK
         fBUF9+3R1kh1I7TBt4DMyMmsoh/AgjoEgTFYK+xg=
Received: by mail-ed1-f42.google.com with SMTP id m20so17387eds.2;
        Thu, 20 Aug 2020 16:35:34 -0700 (PDT)
X-Gm-Message-State: AOAM531bp6VbLzK+ovQOXsCuUe3+TtqAgzGeD78+81RbJtSQJ4FRrK7E
        FqUugxaMqsk1OrIGI2+xK3mlyb8a7I/Myx7ZAQ==
X-Google-Smtp-Source: ABdhPJxc1zoXaax0lawfpxhH4RkIE/MQ7k2AAa4+yAYqE6q6bk/uUEKtRba8EHNrWjtSPcsccONyrsAUWh2/KyhWn0g=
X-Received: by 2002:a50:d9c6:: with SMTP id x6mr162434edj.271.1597966532764;
 Thu, 20 Aug 2020 16:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-5-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-5-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:35:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY__RxokjAop3cY3Xmh9KdmeZi8HbMixdvSn+41=Kg9LMiQ@mail.gmail.com>
Message-ID: <CAAOTY__RxokjAop3cY3Xmh9KdmeZi8HbMixdvSn+41=Kg9LMiQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/21] mtk-mmsys: add mt8192 mmsys support
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:16=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add mt8192 mmsys support
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/mmsys/Makefile       |   1 +
>  drivers/soc/mediatek/mmsys/mt8192-mmsys.c | 159 ++++++++++++++++++++++++=
++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8192-mmsys.c
>
> diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/m=
msys/Makefile
> index 62cfedf..c4bb6be 100644
> --- a/drivers/soc/mediatek/mmsys/Makefile
> +++ b/drivers/soc/mediatek/mmsys/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y +=3D mt2701-mmsys.o
>  obj-y +=3D mt8183-mmsys.o
> +obj-y +=3D mt8192-mmsys.o
> diff --git a/drivers/soc/mediatek/mmsys/mt8192-mmsys.c b/drivers/soc/medi=
atek/mmsys/mt8192-mmsys.c
> new file mode 100644
> index 0000000..006d41d
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/mt8192-mmsys.c
> @@ -0,0 +1,159 @@
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
> +#define MT8192_MMSYS_OVL_MOUT_EN               0xf04
> +#define DISP_OVL0_GO_BLEND                             BIT(0)
> +#define DISP_OVL0_GO_BG                                        BIT(1)
> +#define DISP_OVL0_2L_GO_BLEND                          BIT(2)
> +#define DISP_OVL0_2L_GO_BG                             BIT(3)
> +#define MT8192_DISP_OVL0_2L_MOUT_EN            0xf18
> +#define MT8192_DISP_OVL0_MOUT_EN               0xf1c
> +#define OVL0_MOUT_EN_DISP_RDMA0                                BIT(0)
> +#define MT8192_DISP_RDMA0_SEL_IN               0xf2c
> +#define MT8192_RDMA0_SEL_IN_OVL0_2L                    0x3
> +#define MT8192_DISP_RDMA0_SOUT_SEL             0xf30
> +#define MT8192_RDMA0_SOUT_COLOR0                       0x1
> +#define MT8192_DISP_CCORR0_SOUT_SEL            0xf34
> +#define MT8192_CCORR0_SOUT_AAL0                                0x1
> +#define MT8192_DISP_AAL0_SEL_IN                        0xf38
> +#define MT8192_AAL0_SEL_IN_CCORR0                      0x1
> +#define MT8192_DISP_DITHER0_MOUT_EN            0xf3c
> +#define MT8192_DITHER0_MOUT_DSI0                       BIT(0)
> +#define MT8192_DISP_DSI0_SEL_IN                        0xf40
> +#define MT8192_DSI0_SEL_IN_DITHER0                     0x1
> +#define MT8192_DISP_OVL2_2L_MOUT_EN            0xf4c
> +#define MT8192_OVL2_2L_MOUT_RDMA4                      BIT(0)
> +
> +struct mmsys_path_sel {
> +       enum mtk_ddp_comp_id cur;
> +       enum mtk_ddp_comp_id next;
> +       u32 addr;
> +       u32 val;
> +};
> +
> +static struct mmsys_path_sel mmsys_mout_en[] =3D {
> +       {
> +               DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +               MT8192_DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_DISP_RDMA0,
> +       },
> +       {
> +               DDP_COMPONENT_OVL_2L2, DDP_COMPONENT_RDMA4,
> +               MT8192_DISP_OVL2_2L_MOUT_EN, MT8192_OVL2_2L_MOUT_RDMA4,
> +       },
> +       {
> +               DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +               MT8192_DISP_DITHER0_MOUT_EN, MT8192_DITHER0_MOUT_DSI0,
> +       },
> +};
> +
> +static struct mmsys_path_sel mmsys_sel_in[] =3D {
> +       {
> +               DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA0,
> +               MT8192_DISP_RDMA0_SEL_IN, MT8192_RDMA0_SEL_IN_OVL0_2L,
> +       },
> +       {
> +               DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
> +               MT8192_DISP_AAL0_SEL_IN, MT8192_AAL0_SEL_IN_CCORR0,
> +       },
> +       {
> +               DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +               MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0,
> +       },
> +};
> +
> +static struct mmsys_path_sel mmsys_sout_sel[] =3D {
> +       {
> +               DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
> +               MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0,
> +       },
> +       {
> +               DDP_COMPONENT_CCORR, DDP_COMPONENT_AAL0,
> +               MT8192_DISP_CCORR0_SOUT_SEL, MT8192_CCORR0_SOUT_AAL0,
> +       }
> +};
> +
> +static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> +                                         enum mtk_ddp_comp_id next,
> +                                         unsigned int *addr)
> +{
> +       u32 i;
> +       struct mmsys_path_sel *path;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mmsys_mout_en); i++) {
> +               path =3D &mmsys_mout_en[i];
> +               if (cur =3D=3D path->cur && next =3D=3D path->next) {
> +                       *addr =3D path->addr;
> +                       return path->val;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
> +                                        enum mtk_ddp_comp_id next,
> +                                        unsigned int *addr)
> +{
> +       u32 i;
> +       struct mmsys_path_sel *path;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mmsys_sel_in); i++) {
> +               path =3D &mmsys_sel_in[i];
> +               if (cur =3D=3D path->cur && next =3D=3D path->next) {
> +                       *addr =3D path->addr;
> +                       return path->val;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
> +                                  enum mtk_ddp_comp_id cur,
> +                                  enum mtk_ddp_comp_id next)
> +{
> +       u32 i;
> +       u32 val =3D 0;
> +       u32 addr =3D 0;
> +       struct mmsys_path_sel *path;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(mmsys_sout_sel); i++) {
> +               path =3D &mmsys_sout_sel[i];
> +               if (cur =3D=3D path->cur && next =3D=3D path->next) {
> +                       addr =3D path->addr;
> +                       writel_relaxed(path->val, config_regs + addr);
> +                       return;
> +               }
> +       }
> +}
> +
> +static struct mtk_mmsys_conn_funcs mmsys_funcs =3D {
> +       .mout_en =3D mtk_mmsys_ddp_mout_en,
> +       .sel_in =3D mtk_mmsys_ddp_sel_in,
> +       .sout_sel =3D mtk_mmsys_ddp_sout_sel,
> +};

I would like to do routing control like [1].

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2345186

Regards,
Chun-Kuang.

> +
> +static int mmsys_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +
> +       mtk_mmsys_register_conn_funcs(dev->parent, &mmsys_funcs);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver mmsys_drv =3D {
> +       .probe =3D mmsys_probe,
> +       .driver =3D {
> +               .name =3D "mt8192-mmsys",
> +       },
> +};
> +
> +builtin_platform_driver(mmsys_drv);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
