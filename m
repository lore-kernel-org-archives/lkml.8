Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D8C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEACB2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595643082;
	bh=MiK1PVba9d6hMg6wGLKI8oBgC2V0lNCvk+9hka8SO+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CiCZHsqx1UkpeH0e/DO25fa79ZrQXeD1XMFkMbDWpwTgiWiE/DUZ9PZcMEQGE7MAf
	 Ggph0w+5jh457D8P1mN/gP4roC1VfjyGR8LTS145VDxnawKgep6ZL8FtbRM/OUaFd9
	 nn8ksYvgzgUpSBU5ozNcFUYijcBY8MijKR+pHJlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGYCLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgGYCLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:11:20 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C89920768;
        Sat, 25 Jul 2020 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595643079;
        bh=MiK1PVba9d6hMg6wGLKI8oBgC2V0lNCvk+9hka8SO+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R0ARucDOpPXl8q8xzkpdzxpN/0aLP4sB7Dxc+7cT8HrVRKXigAOuvNVPzQGZkChPm
         JPSma0lw83Wo8kCro44XBKrztoV04mZ/TNxXowA8ZfLip4jEVs95br/T7EziapNc2j
         2fSMvLdRyLVCpvMaAU76YE7yTn5Hl3up4A+i6zOs=
Received: by mail-ej1-f46.google.com with SMTP id y10so11803339eje.1;
        Fri, 24 Jul 2020 19:11:19 -0700 (PDT)
X-Gm-Message-State: AOAM5338pKK24p4GSWzXvBoxdMhmB1+gHgNN/Qp1H7ow8/ty1wA4NwZN
        2UHli/OkWYjVvEG0N3VVA3+/AVLUqC8XGPu56A==
X-Google-Smtp-Source: ABdhPJwN4QCvJGX+aHwkNCAkKNmSR1ftSbRuurw8gS+0nF4FVDXZN2SkQuDo/nPWuuv4Nd6/79c3mpHhn0j/pwLsjJs=
X-Received: by 2002:a17:906:6959:: with SMTP id c25mr11593383ejs.375.1595643077613;
 Fri, 24 Jul 2020 19:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com> <1595469798-3824-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1595469798-3824-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 25 Jul 2020 10:11:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9jE1=ff9YU8WT7RJ4_27G+BKu335GT7_iTw1x2t0=UkA@mail.gmail.com>
Message-ID: <CAAOTY_9jE1=ff9YU8WT7RJ4_27G+BKu335GT7_iTw1x2t0=UkA@mail.gmail.com>
Subject: Re: [v7, PATCH 2/7] mtk-mmsys: add mmsys private data
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

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8810:05=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> add mmsys private data
>
> Feature: drm/mediatek
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/soc/mediatek/Makefile             |   1 +
>  drivers/soc/mediatek/mmsys/Makefile       |   2 +
>  drivers/soc/mediatek/mmsys/mt2701-mmsys.c | 250 ++++++++++++++++++++++++=
+++
>  drivers/soc/mediatek/mtk-mmsys.c          | 271 +++++-------------------=
------
>  include/linux/soc/mediatek/mtk-mmsys.h    |  15 ++
>  5 files changed, 314 insertions(+), 225 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mmsys/Makefile
>  create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
>
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefil=
e
> index 2afa7b9..b37ac2c 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_MTK_CMDQ) +=3D mtk-cmdq-helper.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) +=3D mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) +=3D mtk-scpsys.o
>  obj-$(CONFIG_MTK_MMSYS) +=3D mtk-mmsys.o
> +obj-$(CONFIG_MTK_MMSYS) +=3D mmsys/
> diff --git a/drivers/soc/mediatek/mmsys/Makefile b/drivers/soc/mediatek/m=
msys/Makefile
> new file mode 100644
> index 0000000..33b0dab
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y +=3D mt2701-mmsys.o
> diff --git a/drivers/soc/mediatek/mmsys/mt2701-mmsys.c b/drivers/soc/medi=
atek/mmsys/mt2701-mmsys.c
> new file mode 100644
> index 0000000..b8e53b0
> --- /dev/null
> +++ b/drivers/soc/mediatek/mmsys/mt2701-mmsys.c
> @@ -0,0 +1,250 @@
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
> +#define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN      0x040
> +#define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN      0x044
> +#define DISP_REG_CONFIG_DISP_OD_MOUT_EN                0x048
> +#define DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN     0x04c
> +#define DISP_REG_CONFIG_DISP_UFOE_MOUT_EN      0x050
> +#define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN     0x084
> +#define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN     0x088
> +#define DISP_REG_CONFIG_DSIE_SEL_IN            0x0a4
> +#define DISP_REG_CONFIG_DSIO_SEL_IN            0x0a8
> +#define DISP_REG_CONFIG_DPI_SEL_IN             0x0ac
> +#define DISP_REG_CONFIG_DISP_RDMA2_SOUT                0x0b8
> +#define DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN     0x0c4
> +#define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN     0x0c8
> +#define DISP_REG_CONFIG_MMSYS_CG_CON0          0x100
> +
> +#define DISP_REG_CONFIG_DISP_OVL_MOUT_EN       0x030
> +#define DISP_REG_CONFIG_OUT_SEL                        0x04c
> +#define DISP_REG_CONFIG_DSI_SEL                        0x050
> +#define DISP_REG_CONFIG_DPI_SEL                        0x064
> +
> +#define OVL0_MOUT_EN_COLOR0                    0x1
> +#define OD_MOUT_EN_RDMA0                       0x1
> +#define OD1_MOUT_EN_RDMA1                      BIT(16)
> +#define UFOE_MOUT_EN_DSI0                      0x1
> +#define COLOR0_SEL_IN_OVL0                     0x1
> +#define OVL1_MOUT_EN_COLOR1                    0x1
> +#define GAMMA_MOUT_EN_RDMA1                    0x1
> +#define RDMA0_SOUT_DPI0                                0x2
> +#define RDMA0_SOUT_DPI1                                0x3
> +#define RDMA0_SOUT_DSI1                                0x1
> +#define RDMA0_SOUT_DSI2                                0x4
> +#define RDMA0_SOUT_DSI3                                0x5
> +#define RDMA1_SOUT_DPI0                                0x2
> +#define RDMA1_SOUT_DPI1                                0x3
> +#define RDMA1_SOUT_DSI1                                0x1
> +#define RDMA1_SOUT_DSI2                                0x4
> +#define RDMA1_SOUT_DSI3                                0x5
> +#define RDMA2_SOUT_DPI0                                0x2
> +#define RDMA2_SOUT_DPI1                                0x3
> +#define RDMA2_SOUT_DSI1                                0x1
> +#define RDMA2_SOUT_DSI2                                0x4
> +#define RDMA2_SOUT_DSI3                                0x5
> +#define DPI0_SEL_IN_RDMA1                      0x1
> +#define DPI0_SEL_IN_RDMA2                      0x3
> +#define DPI1_SEL_IN_RDMA1                      (0x1 << 8)
> +#define DPI1_SEL_IN_RDMA2                      (0x3 << 8)
> +#define DSI0_SEL_IN_RDMA1                      0x1
> +#define DSI0_SEL_IN_RDMA2                      0x4
> +#define DSI1_SEL_IN_RDMA1                      0x1
> +#define DSI1_SEL_IN_RDMA2                      0x4
> +#define DSI2_SEL_IN_RDMA1                      (0x1 << 16)
> +#define DSI2_SEL_IN_RDMA2                      (0x4 << 16)
> +#define DSI3_SEL_IN_RDMA1                      (0x1 << 16)
> +#define DSI3_SEL_IN_RDMA2                      (0x4 << 16)
> +#define COLOR1_SEL_IN_OVL1                     0x1
> +
> +#define OVL_MOUT_EN_RDMA                       0x1
> +#define BLS_TO_DSI_RDMA1_TO_DPI1               0x8
> +#define BLS_TO_DPI_RDMA1_TO_DSI                        0x2
> +#define DSI_SEL_IN_BLS                         0x0
> +#define DPI_SEL_IN_BLS                         0x0
> +#define DSI_SEL_IN_RDMA                                0x1
> +
> +static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> +                                         enum mtk_ddp_comp_id next,
> +                                         unsigned int *addr)
> +{
> +       unsigned int value;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL0 && next =3D=3D DDP_COMPONENT_CO=
LOR0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
> +               value =3D OVL0_MOUT_EN_COLOR0;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL0 && next =3D=3D DDP_COMPO=
NENT_RDMA0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
> +               value =3D OVL_MOUT_EN_RDMA;
> +       } else if (cur =3D=3D DDP_COMPONENT_OD0 && next =3D=3D DDP_COMPON=
ENT_RDMA0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> +               value =3D OD_MOUT_EN_RDMA0;
> +       } else if (cur =3D=3D DDP_COMPONENT_UFOE && next =3D=3D DDP_COMPO=
NENT_DSI0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_UFOE_MOUT_EN;
> +               value =3D UFOE_MOUT_EN_DSI0;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL1 && next =3D=3D DDP_COMPO=
NENT_COLOR1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_OVL1_MOUT_EN;
> +               value =3D OVL1_MOUT_EN_COLOR1;
> +       } else if (cur =3D=3D DDP_COMPONENT_GAMMA && next =3D=3D DDP_COMP=
ONENT_RDMA1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
> +               value =3D GAMMA_MOUT_EN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_OD1 && next =3D=3D DDP_COMPON=
ENT_RDMA1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> +               value =3D OD1_MOUT_EN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA0 && next =3D=3D DDP_COMP=
ONENT_DPI0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +               value =3D RDMA0_SOUT_DPI0;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA0 && next =3D=3D DDP_COMP=
ONENT_DPI1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +               value =3D RDMA0_SOUT_DPI1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA0 && next =3D=3D DDP_COMP=
ONENT_DSI1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +               value =3D RDMA0_SOUT_DSI1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA0 && next =3D=3D DDP_COMP=
ONENT_DSI2) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +               value =3D RDMA0_SOUT_DSI2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA0 && next =3D=3D DDP_COMP=
ONENT_DSI3) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +               value =3D RDMA0_SOUT_DSI3;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +               value =3D RDMA1_SOUT_DSI1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI2) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +               value =3D RDMA1_SOUT_DSI2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI3) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +               value =3D RDMA1_SOUT_DSI3;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DPI0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +               value =3D RDMA1_SOUT_DPI0;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DPI1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> +               value =3D RDMA1_SOUT_DPI1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DPI0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +               value =3D RDMA2_SOUT_DPI0;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DPI1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +               value =3D RDMA2_SOUT_DPI1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +               value =3D RDMA2_SOUT_DSI1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI2) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +               value =3D RDMA2_SOUT_DSI2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI3) {
> +               *addr =3D DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> +               value =3D RDMA2_SOUT_DSI3;
> +       } else {
> +               value =3D 0;
> +       }
> +
> +       return value;
> +}
> +
> +static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
> +                                        enum mtk_ddp_comp_id next,
> +                                        unsigned int *addr)
> +{
> +       unsigned int value;
> +
> +       if (cur =3D=3D DDP_COMPONENT_OVL0 && next =3D=3D DDP_COMPONENT_CO=
LOR0) {
> +               *addr =3D DISP_REG_CONFIG_DISP_COLOR0_SEL_IN;
> +               value =3D COLOR0_SEL_IN_OVL0;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DPI0) {
> +               *addr =3D DISP_REG_CONFIG_DPI_SEL_IN;
> +               value =3D DPI0_SEL_IN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DPI1) {
> +               *addr =3D DISP_REG_CONFIG_DPI_SEL_IN;
> +               value =3D DPI1_SEL_IN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI0) {
> +               *addr =3D DISP_REG_CONFIG_DSIE_SEL_IN;
> +               value =3D DSI0_SEL_IN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI1) {
> +               *addr =3D DISP_REG_CONFIG_DSIO_SEL_IN;
> +               value =3D DSI1_SEL_IN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI2) {
> +               *addr =3D DISP_REG_CONFIG_DSIE_SEL_IN;
> +               value =3D DSI2_SEL_IN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA1 && next =3D=3D DDP_COMP=
ONENT_DSI3) {
> +               *addr =3D DISP_REG_CONFIG_DSIO_SEL_IN;
> +               value =3D DSI3_SEL_IN_RDMA1;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DPI0) {
> +               *addr =3D DISP_REG_CONFIG_DPI_SEL_IN;
> +               value =3D DPI0_SEL_IN_RDMA2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DPI1) {
> +               *addr =3D DISP_REG_CONFIG_DPI_SEL_IN;
> +               value =3D DPI1_SEL_IN_RDMA2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI0) {
> +               *addr =3D DISP_REG_CONFIG_DSIE_SEL_IN;
> +               value =3D DSI0_SEL_IN_RDMA2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI1) {
> +               *addr =3D DISP_REG_CONFIG_DSIO_SEL_IN;
> +               value =3D DSI1_SEL_IN_RDMA2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI2) {
> +               *addr =3D DISP_REG_CONFIG_DSIE_SEL_IN;
> +               value =3D DSI2_SEL_IN_RDMA2;
> +       } else if (cur =3D=3D DDP_COMPONENT_RDMA2 && next =3D=3D DDP_COMP=
ONENT_DSI3) {
> +               *addr =3D DISP_REG_CONFIG_DSIE_SEL_IN;
> +               value =3D DSI3_SEL_IN_RDMA2;
> +       } else if (cur =3D=3D DDP_COMPONENT_OVL1 && next =3D=3D DDP_COMPO=
NENT_COLOR1) {
> +               *addr =3D DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
> +               value =3D COLOR1_SEL_IN_OVL1;
> +       } else if (cur =3D=3D DDP_COMPONENT_BLS && next =3D=3D DDP_COMPON=
ENT_DSI0) {
> +               *addr =3D DISP_REG_CONFIG_DSI_SEL;
> +               value =3D DSI_SEL_IN_BLS;
> +       } else {
> +               value =3D 0;
> +       }
> +
> +       return value;
> +}
> +
> +static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
> +                                  enum mtk_ddp_comp_id cur,
> +                                  enum mtk_ddp_comp_id next)
> +{
> +       if (cur =3D=3D DDP_COMPONENT_BLS && next =3D=3D DDP_COMPONENT_DSI=
0) {
> +               writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> +                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> +       } else if (cur =3D=3D DDP_COMPONENT_BLS && next =3D=3D DDP_COMPON=
ENT_DPI0) {
> +               writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> +                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> +               writel_relaxed(DSI_SEL_IN_RDMA,
> +                              config_regs + DISP_REG_CONFIG_DSI_SEL);
> +               writel_relaxed(DPI_SEL_IN_BLS,
> +                              config_regs + DISP_REG_CONFIG_DPI_SEL);
> +       }
> +}
> +
> +static struct mtk_mmsys_conn_funcs mmsys_funcs =3D {
> +       .mout_en =3D mtk_mmsys_ddp_mout_en,
> +       .sel_in =3D mtk_mmsys_ddp_sel_in,
> +       .sout_sel =3D mtk_mmsys_ddp_sout_sel,

I think you could implement these three function to be the same as the
three of mt8183 with mt2701 version of mmsys_mout_en[],
mmsys_sel_in[], mmsys_sout_sel[]. If you worry that you could not test
on mt2701, we could temporarily accept this and wait for someone has
mt2701 (or mt8173) to rewrite these three function to be the same as
mt8183.

Regards,
Chun-Kuang.

> +};
> +
