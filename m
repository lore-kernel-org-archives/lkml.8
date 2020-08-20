Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A0A20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597967641;
	bh=0+j/6QA0LygchhDILln1yfm2HCDRr0a88PJAPwRl+xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ULNDgYom5vqj6HUKdnROEBnAjplAaOnmHvEOlOpmzZpyIp9//x/yZqXVIN+9qIXLz
	 nqxdlYfL1eNe5pjsV6DGyvVmcfPcobt455i/LHcn2g5KIscqW2my6otN/0ONkVMF2k
	 OPNNh0vZeIgYB2R9jYTOw2o89BIe9bxeJ07ox15g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHTXxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgHTXxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:53:45 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3586422B3F;
        Thu, 20 Aug 2020 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597967322;
        bh=0+j/6QA0LygchhDILln1yfm2HCDRr0a88PJAPwRl+xo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N+Qu4TRQ6I7L3UpaNQexsvv1BxlVF9FL/w9CTaKc1TkL+sYA14R3lE5YU2/F2TOXW
         o63nm/yHlj80bBCLzUTPL3kFiAYQzbIWHBu9QKWQHoHazVpN1wNYJuhu+V3kE5qI4i
         0mkvVoGLDRYSC88tpmH6zvH7FChQIVsjQ5lG8WIE=
Received: by mail-ej1-f41.google.com with SMTP id o18so246933eje.7;
        Thu, 20 Aug 2020 16:48:42 -0700 (PDT)
X-Gm-Message-State: AOAM533wInGiJTAbUKr3XHiGk8aQb0nnbpsyRkHpmgXIAe3p5GmQaA1v
        l0wgtE0wF214/9R923nqS5g6WPMKupzALVAYtA==
X-Google-Smtp-Source: ABdhPJxWafAaj3k7lPbaruLTEUXILZXHlJiOWiA943fk40qr+NDtlxb9h2KyFzZEAanAf5GUY6rk5v906+J7wgBQIpo=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr193241ejl.375.1597967320752;
 Thu, 20 Aug 2020 16:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com> <1597903458-8055-15-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1597903458-8055-15-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:48:28 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9xdn3VnU3nSBc4dvxcVOG34VSaDwxHga8=29GPW3zFsw@mail.gmail.com>
Message-ID: <CAAOTY_9xdn3VnU3nSBc4dvxcVOG34VSaDwxHga8=29GPW3zFsw@mail.gmail.com>
Subject: Re: [PATCH v1 14/21] drm/mediatek: add bypass shadow register
 function call for ddp component
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
=8820=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:18=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> the shadow register for mt8192 ddp component is enable,
> we need disable it before enable ddp component

MT2701 has shadow register and use it. Why MT8192 have shadow register
but disable it? I would like to use shadow register like MT2701.

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 3 +++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index fe46c4b..16e9b88 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -299,6 +299,9 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *=
mtk_crtc)
>                 goto err_mutex_unprepare;
>         }
>
> +       for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++)
> +               mtk_ddp_comp_bypass_shadow(mtk_crtc->ddp_comp[i]);
> +
>         DRM_DEBUG_DRIVER("mediatek_ddp_ddp_path_setup\n");
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
>                 mtk_mmsys_ddp_connect(mtk_crtc->mmsys_dev,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index ae11b46..1f25705 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -45,6 +45,7 @@ struct mtk_ddp_comp_funcs {
>                        unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
>         void (*start)(struct mtk_ddp_comp *comp);
>         void (*stop)(struct mtk_ddp_comp *comp);
> +       void (*bypass_shadow)(struct mtk_ddp_comp *comp);
>         void (*enable_vblank)(struct mtk_ddp_comp *comp, struct drm_crtc =
*crtc);
>         void (*disable_vblank)(struct mtk_ddp_comp *comp);
>         unsigned int (*supported_rotations)(struct mtk_ddp_comp *comp);
> @@ -169,6 +170,12 @@ static inline void mtk_ddp_ctm_set(struct mtk_ddp_co=
mp *comp,
>                 comp->funcs->ctm_set(comp, state);
>  }
>
> +static inline void mtk_ddp_comp_bypass_shadow(struct mtk_ddp_comp *comp)
> +{
> +       if (comp->funcs && comp->funcs->bypass_shadow)
> +               comp->funcs->bypass_shadow(comp);
> +}
> +
>  int mtk_ddp_comp_get_id(struct device_node *node,
>                         enum mtk_ddp_comp_type comp_type);
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
