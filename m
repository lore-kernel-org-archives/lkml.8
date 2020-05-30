Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D7EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CC2208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590836877;
	bh=MMpNizw22T/SVrKyvdrwVbDY0nEpfHMXgU4xhOyblP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XBtiChqmz14dhs2T2bL+bcmpKXlX/zKnTE1F9kA8xnl+/sfO7uP4GS6pdj31Jv6z5
	 PDc/vU+4+13wNfqYXUnXZvx3uGGhD+vY8HqASkkXsK7WEFUR4RMGvVdPTQC/LBO3c1
	 FcWPrC9sSyaNKgrUkYKaNCPrVUrR6jQXnXwKy6jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgE3LH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 07:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgE3LHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 07:07:53 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAE9C207BC;
        Sat, 30 May 2020 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590836872;
        bh=MMpNizw22T/SVrKyvdrwVbDY0nEpfHMXgU4xhOyblP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V/NnWS5uJtIwXapGHqiQtVBIUyndW8uUHGkbkLVHyvpqL9nFEpxpt6tAp6Sp765LH
         XOpceGxVanLRRfwmuvYfR+SqxAihMGxx9itb4cjP2ej0PuvAN5plBuqPQJZlhkA0RS
         8pVb1zZUQKFthklELghhpg8yBvdlSGPWtbumMBbM=
Received: by mail-ej1-f48.google.com with SMTP id h21so4628677ejq.5;
        Sat, 30 May 2020 04:07:51 -0700 (PDT)
X-Gm-Message-State: AOAM531OXZ3W70c0b51tiCLRhhJ3GoLBseuuWXIuVaIKEVzQq3TGp972
        pnPrLb63oC+vdl/LGYKAbEvZEGsLDliBUWODjA==
X-Google-Smtp-Source: ABdhPJwbqALGtjsXoVQ6sMmzaJdwDjP1dsTnmjtc176Tkfx/IQ4lidJGHxxHXWQK87s0mfK+KUzRUyvMEMSZwdSp0ng=
X-Received: by 2002:a17:906:d111:: with SMTP id b17mr2209578ejz.267.1590836870150;
 Sat, 30 May 2020 04:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com> <1590826218-23653-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1590826218-23653-11-git-send-email-yong.wu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 May 2020 19:07:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY__ZvG7UbbSsvv0H8ZKBovqTtHaq4+oiGNZrgF-6eKmi2g@mail.gmail.com>
Message-ID: <CAAOTY__ZvG7UbbSsvv0H8ZKBovqTtHaq4+oiGNZrgF-6eKmi2g@mail.gmail.com>
Subject: Re: [PATCH v4 10/17] drm/mediatek: Add pm runtime support for ovl and rdma
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Evan Green <evgreen@chromium.org>, eizan@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        cui.zhang@mediatek.com, Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, ming-fan.chen@mediatek.com,
        anan.sun@mediatek.com, acourbot@chromium.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yong:

Yong Wu <yong.wu@mediatek.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=8830=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> Display use the dispsys device to call pm_rumtime_get_sync before.
> This patch add pm_runtime_xx with ovl and rdma device whose nodes has
> "iommus" property, then display could help pm_runtime_get for smi via
> ovl or rdma device.
>
> This is a preparing patch that smi cleaning up "mediatek,larb".
>

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> CC: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  9 ++++++++-
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |  9 ++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 12 +++++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  2 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
>  5 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/me=
diatek/mtk_disp_ovl.c
> index 891d80c..17c9baa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>
>  #include "mtk_drm_crtc.h"
> @@ -399,9 +400,13 @@ static int mtk_disp_ovl_probe(struct platform_device=
 *pdev)
>                 return ret;
>         }
>
> +       pm_runtime_enable(dev);
> +
>         ret =3D component_add(dev, &mtk_disp_ovl_component_ops);
> -       if (ret)
> +       if (ret) {
> +               pm_runtime_disable(dev);
>                 dev_err(dev, "Failed to add component: %d\n", ret);
> +       }
>
>         return ret;
>  }
> @@ -410,6 +415,8 @@ static int mtk_disp_ovl_remove(struct platform_device=
 *pdev)
>  {
>         component_del(&pdev->dev, &mtk_disp_ovl_component_ops);
>
> +       pm_runtime_disable(&pdev->dev);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index 0cb848d..5ea8fb6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -9,6 +9,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>
>  #include "mtk_drm_crtc.h"
> @@ -313,9 +314,13 @@ static int mtk_disp_rdma_probe(struct platform_devic=
e *pdev)
>
>         platform_set_drvdata(pdev, priv);
>
> +       pm_runtime_enable(dev);
> +
>         ret =3D component_add(dev, &mtk_disp_rdma_component_ops);
> -       if (ret)
> +       if (ret) {
> +               pm_runtime_disable(dev);
>                 dev_err(dev, "Failed to add component: %d\n", ret);
> +       }
>
>         return ret;
>  }
> @@ -324,6 +329,8 @@ static int mtk_disp_rdma_remove(struct platform_devic=
e *pdev)
>  {
>         component_del(&pdev->dev, &mtk_disp_rdma_component_ops);
>
> +       pm_runtime_disable(&pdev->dev);
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index fe85e48..c9bc844 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -538,9 +538,15 @@ static void mtk_drm_crtc_atomic_enable(struct drm_cr=
tc *crtc,
>                 return;
>         }
>
> +       ret =3D pm_runtime_get_sync(comp->dev);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(comp->dev, "Failed to enable power domain: =
%d\n",
> +                             ret);
> +
>         ret =3D mtk_crtc_ddp_hw_init(mtk_crtc);
>         if (ret) {
>                 mtk_smi_larb_put(comp->larb_dev);
> +               pm_runtime_put(comp->dev);
>                 return;
>         }
>
> @@ -553,7 +559,7 @@ static void mtk_drm_crtc_atomic_disable(struct drm_cr=
tc *crtc,
>  {
>         struct mtk_drm_crtc *mtk_crtc =3D to_mtk_crtc(crtc);
>         struct mtk_ddp_comp *comp =3D mtk_crtc->ddp_comp[0];
> -       int i;
> +       int i, ret;
>
>         DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
>         if (!mtk_crtc->enabled)
> @@ -577,6 +583,10 @@ static void mtk_drm_crtc_atomic_disable(struct drm_c=
rtc *crtc,
>         drm_crtc_vblank_off(crtc);
>         mtk_crtc_ddp_hw_fini(mtk_crtc);
>         mtk_smi_larb_put(comp->larb_dev);
> +       ret =3D pm_runtime_put(comp->dev);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(comp->dev, "Failed to disable power domain:=
 %d\n",
> +                             ret);
>
>         mtk_crtc->enabled =3D false;
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 57c88de..593027a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -493,6 +493,8 @@ int mtk_ddp_comp_init(struct device *dev, struct devi=
ce_node *node,
>
>         comp->larb_dev =3D &larb_pdev->dev;
>
> +       comp->dev =3D dev;
> +
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         if (of_address_to_resource(node, 0, &res) !=3D 0) {
>                 dev_err(dev, "Missing reg in %s node\n", node->full_name)=
;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index debe363..4c063e0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -99,6 +99,7 @@ struct mtk_ddp_comp {
>         void __iomem *regs;
>         int irq;
>         struct device *larb_dev;
> +       struct device *dev;
>         enum mtk_ddp_comp_id id;
>         const struct mtk_ddp_comp_funcs *funcs;
>         resource_size_t regs_pa;
> --
> 1.9.1
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
