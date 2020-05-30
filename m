Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2344BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1794207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 11:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590836926;
	bh=earXz4/P68uRR/iSgsEcpzwdpo2LMphL6TdGN7XN94I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kPUUstwK9+XIqOBc1p3dhERU0aEaAIDnBVi8AdXzOm8RLocfwY8IP335oCwt+ufL0
	 I1f0TPUogZSl/L2NfKvC0XQm7/ELc/OIHGMkQKBke6d/cEZCAXp4wyLDGFOEN27Hge
	 a+oektHcvKEGPtBpShfWArziTNzdCijIKoWgc/E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgE3LIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 07:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgE3LIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 07:08:44 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E542145D;
        Sat, 30 May 2020 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590836924;
        bh=earXz4/P68uRR/iSgsEcpzwdpo2LMphL6TdGN7XN94I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I02qo87OBfKdtmsSNSsWpcRIcQR/gub2ZBVaSW2xy+XZPuUm6Bd4NecSne2rq5jOv
         a1KFNQJMUIvVg9UR2wMgWYcmZRPNs2fu8kz4xlZgpl7mT7I9wKl6enxULTLH4TOvdn
         TrgXh099LCuJU+WabcnIySUkpggkz34gI6vGiFjE=
Received: by mail-ej1-f46.google.com with SMTP id gl26so4592101ejb.11;
        Sat, 30 May 2020 04:08:43 -0700 (PDT)
X-Gm-Message-State: AOAM5326lbnzuPe35Q7yPouCFlolGSeL8F2tFzpEYdZrm0s/vfVknzhj
        DoMRGzrXmqqwAAf25e5pRYBn9hTjJ4/sdJFGpw==
X-Google-Smtp-Source: ABdhPJzSDMCU40D8bF0+JP28mWgFd65hKqdR/CfP94iWZgZQDTtaux5DHBxin4XXosAMmg6E2mex7jDQ/0FXg9nqJ+Y=
X-Received: by 2002:a17:906:538d:: with SMTP id g13mr11350028ejo.194.1590836922106;
 Sat, 30 May 2020 04:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com> <1590826218-23653-12-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1590826218-23653-12-git-send-email-yong.wu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 30 May 2020 19:08:31 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7ES_tdO4p7aSeVO3x+=0kzWVtCAve-EV_Mrj=WGEmGg@mail.gmail.com>
Message-ID: <CAAOTY_-7ES_tdO4p7aSeVO3x+=0kzWVtCAve-EV_Mrj=WGEmGg@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] drm/mediatek: Get rid of mtk_smi_larb_get/put
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Evan Green <evgreen@chromium.org>, eizan@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        cui.zhang@mediatek.com, Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, ming-fan.chen@mediatek.com,
        anan.sun@mediatek.com, acourbot@chromium.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yong:

Yong Wu <yong.wu@mediatek.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=8830=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  9 ---------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 21 ---------------------
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 -
>  3 files changed, 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index c9bc844..d4c4078 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -8,7 +8,6 @@
>  #include <linux/soc/mediatek/mtk-cmdq.h>
>
>  #include <asm/barrier.h>
> -#include <soc/mediatek/smi.h>
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
> @@ -532,12 +531,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_cr=
tc *crtc,
>
>         DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
>
> -       ret =3D mtk_smi_larb_get(comp->larb_dev);
> -       if (ret) {
> -               DRM_ERROR("Failed to get larb: %d\n", ret);
> -               return;
> -       }
> -
>         ret =3D pm_runtime_get_sync(comp->dev);
>         if (ret < 0)
>                 DRM_DEV_ERROR(comp->dev, "Failed to enable power domain: =
%d\n",
> @@ -545,7 +538,6 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crt=
c *crtc,
>
>         ret =3D mtk_crtc_ddp_hw_init(mtk_crtc);
>         if (ret) {
> -               mtk_smi_larb_put(comp->larb_dev);
>                 pm_runtime_put(comp->dev);
>                 return;
>         }
> @@ -582,7 +574,6 @@ static void mtk_drm_crtc_atomic_disable(struct drm_cr=
tc *crtc,
>
>         drm_crtc_vblank_off(crtc);
>         mtk_crtc_ddp_hw_fini(mtk_crtc);
> -       mtk_smi_larb_put(comp->larb_dev);
>         ret =3D pm_runtime_put(comp->dev);
>         if (ret < 0)
>                 DRM_DEV_ERROR(comp->dev, "Failed to disable power domain:=
 %d\n",
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 593027a..a6e7f3a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -432,8 +432,6 @@ int mtk_ddp_comp_init(struct device *dev, struct devi=
ce_node *node,
>                       const struct mtk_ddp_comp_funcs *funcs)
>  {
>         enum mtk_ddp_comp_type type;
> -       struct device_node *larb_node;
> -       struct platform_device *larb_pdev;
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         struct resource res;
>         struct cmdq_client_reg cmdq_reg;
> @@ -468,31 +466,12 @@ int mtk_ddp_comp_init(struct device *dev, struct de=
vice_node *node,
>         if (IS_ERR(comp->clk))
>                 return PTR_ERR(comp->clk);
>
> -       /* Only DMA capable components need the LARB property */
> -       comp->larb_dev =3D NULL;
>         if (type !=3D MTK_DISP_OVL &&
>             type !=3D MTK_DISP_OVL_2L &&
>             type !=3D MTK_DISP_RDMA &&
>             type !=3D MTK_DISP_WDMA)
>                 return 0;
>
> -       larb_node =3D of_parse_phandle(node, "mediatek,larb", 0);
> -       if (!larb_node) {
> -               dev_err(dev,
> -                       "Missing mediadek,larb phandle in %pOF node\n", n=
ode);
> -               return -EINVAL;
> -       }
> -
> -       larb_pdev =3D of_find_device_by_node(larb_node);
> -       if (!larb_pdev) {
> -               dev_warn(dev, "Waiting for larb device %pOF\n", larb_node=
);
> -               of_node_put(larb_node);
> -               return -EPROBE_DEFER;
> -       }
> -       of_node_put(larb_node);
> -
> -       comp->larb_dev =3D &larb_pdev->dev;
> -
>         comp->dev =3D dev;
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index 4c063e0..11c7120 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -98,7 +98,6 @@ struct mtk_ddp_comp {
>         struct clk *clk;
>         void __iomem *regs;
>         int irq;
> -       struct device *larb_dev;
>         struct device *dev;
>         enum mtk_ddp_comp_id id;
>         const struct mtk_ddp_comp_funcs *funcs;
> --
> 1.9.1
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
