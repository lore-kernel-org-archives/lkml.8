Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66142C433E3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36653206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596934338;
	bh=0z/Z71osg3eyFsMFe8xBmU/V7BFVUMmz+ZgNVRDikSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O+HXNoi108/Kq1mGradVmU4F/P6NJDzTFo/PwhX3TA03fYfqCmkeNClKFt7KtSMwO
	 DYLxIjZ50lf8vQgrBPeLfEw0wE8TwPL8aB2xbm2tMzAugJdaHauG/DI/O3/J3xaByC
	 E/rWJyLzqVb4wLCGVQ0MQ08Rtpkd1J7seMGNYUDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHIAwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 20:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgHIAwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 20:52:16 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B9620772;
        Sun,  9 Aug 2020 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596934335;
        bh=0z/Z71osg3eyFsMFe8xBmU/V7BFVUMmz+ZgNVRDikSA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LIoe2xE0rXdW+zvXDMvwmQKw276z7cbIc09/WdCEPlrHjcAtwP4g66M+twROS3A00
         y/obU8dbo2rACU8uFScuMhwY6fEuGZ1wOQUiAjDO5RUUw58IMML/Ad0iMcl4NksTrc
         KLL0w+lRA9YplB45x0BE3cS8nyS8oZVsGXsUpDKA=
Received: by mail-ej1-f46.google.com with SMTP id o23so5898419ejr.1;
        Sat, 08 Aug 2020 17:52:15 -0700 (PDT)
X-Gm-Message-State: AOAM531GZ6gi9GYX/N1jAasSUcciRFgINNHzqOQy18SLOznyaoASiFse
        GAnhL1gedMBZwa+1pfcZWqhAbP19YYC13jSe+w==
X-Google-Smtp-Source: ABdhPJyZt1CSoIboKSwTbNAnnwaQ2vRrvv4qzD8K8i6CZ7BvEyJ3034SciF2SNRDbzK5xcdTgDcXaD4qHRXWuJehpPA=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr15178620ejb.187.1596934333673;
 Sat, 08 Aug 2020 17:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com> <1596855231-5782-3-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1596855231-5782-3-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 9 Aug 2020 08:52:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__ZbNfRNfQ+DLdZh0WHVqUeQ6AbO=Lc-CUZpx25X=2Kyg@mail.gmail.com>
Message-ID: <CAAOTY__ZbNfRNfQ+DLdZh0WHVqUeQ6AbO=Lc-CUZpx25X=2Kyg@mail.gmail.com>
Subject: Re: [RESEND v7, PATCH 2/7] drm/mediatek: move ddp component define
 into mtk_mmsys.h
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

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:05=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> mmsys is the driver which control the routing of these ddp component,
> so the definition of mtk_ddp_comp_id should be placed in mtk-mmsys.h
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 34 +----------------------=
------
>  drivers/soc/mediatek/mtk-mmsys.c            |  4 +---
>  include/linux/soc/mediatek/mtk-mmsys.h      | 33 +++++++++++++++++++++++=
+++++
>  3 files changed, 35 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index debe363..161201f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -7,6 +7,7 @@
>  #define MTK_DRM_DDP_COMP_H
>
>  #include <linux/io.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
>
>  struct device;
>  struct device_node;
> @@ -35,39 +36,6 @@ enum mtk_ddp_comp_type {
>         MTK_DDP_COMP_TYPE_MAX,
>  };
>
> -enum mtk_ddp_comp_id {
> -       DDP_COMPONENT_AAL0,
> -       DDP_COMPONENT_AAL1,
> -       DDP_COMPONENT_BLS,
> -       DDP_COMPONENT_CCORR,
> -       DDP_COMPONENT_COLOR0,
> -       DDP_COMPONENT_COLOR1,
> -       DDP_COMPONENT_DITHER,
> -       DDP_COMPONENT_DPI0,
> -       DDP_COMPONENT_DPI1,
> -       DDP_COMPONENT_DSI0,
> -       DDP_COMPONENT_DSI1,
> -       DDP_COMPONENT_DSI2,
> -       DDP_COMPONENT_DSI3,
> -       DDP_COMPONENT_GAMMA,
> -       DDP_COMPONENT_OD0,
> -       DDP_COMPONENT_OD1,
> -       DDP_COMPONENT_OVL0,
> -       DDP_COMPONENT_OVL_2L0,
> -       DDP_COMPONENT_OVL_2L1,
> -       DDP_COMPONENT_OVL1,
> -       DDP_COMPONENT_PWM0,
> -       DDP_COMPONENT_PWM1,
> -       DDP_COMPONENT_PWM2,
> -       DDP_COMPONENT_RDMA0,
> -       DDP_COMPONENT_RDMA1,
> -       DDP_COMPONENT_RDMA2,
> -       DDP_COMPONENT_UFOE,
> -       DDP_COMPONENT_WDMA0,
> -       DDP_COMPONENT_WDMA1,
> -       DDP_COMPONENT_ID_MAX,
> -};
> -
>  struct mtk_ddp_comp;
>  struct cmdq_pkt;
>  struct mtk_ddp_comp_funcs {
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index a55f255..36ad66b 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -5,13 +5,11 @@
>   */
>
>  #include <linux/device.h>
> +#include <linux/io.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>
> -#include "../../gpu/drm/mediatek/mtk_drm_ddp.h"
> -#include "../../gpu/drm/mediatek/mtk_drm_ddp_comp.h"
> -
>  #define DISP_REG_CONFIG_DISP_OVL0_MOUT_EN      0x040
>  #define DISP_REG_CONFIG_DISP_OVL1_MOUT_EN      0x044
>  #define DISP_REG_CONFIG_DISP_OD_MOUT_EN                0x048
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 7bab5d9..2228bf6 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -9,6 +9,39 @@
>  enum mtk_ddp_comp_id;
>  struct device;
>
> +enum mtk_ddp_comp_id {
> +       DDP_COMPONENT_AAL0,
> +       DDP_COMPONENT_AAL1,
> +       DDP_COMPONENT_BLS,
> +       DDP_COMPONENT_CCORR,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_COLOR1,
> +       DDP_COMPONENT_DITHER,
> +       DDP_COMPONENT_DPI0,
> +       DDP_COMPONENT_DPI1,
> +       DDP_COMPONENT_DSI0,
> +       DDP_COMPONENT_DSI1,
> +       DDP_COMPONENT_DSI2,
> +       DDP_COMPONENT_DSI3,
> +       DDP_COMPONENT_GAMMA,
> +       DDP_COMPONENT_OD0,
> +       DDP_COMPONENT_OD1,
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_OVL_2L0,
> +       DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_OVL1,
> +       DDP_COMPONENT_PWM0,
> +       DDP_COMPONENT_PWM1,
> +       DDP_COMPONENT_PWM2,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_RDMA1,
> +       DDP_COMPONENT_RDMA2,
> +       DDP_COMPONENT_UFOE,
> +       DDP_COMPONENT_WDMA0,
> +       DDP_COMPONENT_WDMA1,
> +       DDP_COMPONENT_ID_MAX,
> +};
> +
>  void mtk_mmsys_ddp_connect(struct device *dev,
>                            enum mtk_ddp_comp_id cur,
>                            enum mtk_ddp_comp_id next);
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
