Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 03:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7B2067D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 03:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596337555;
	bh=69kZjUSWNDziqCdzHTUc/4mOGEuEQGCa68+3zSX0jzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w6kqg86wsyMkJVRlr3k8lRgyKjR/GT0IycHBCZfpsm6GRil9bqHpQosjsaMVEfQsO
	 jjAY9HM/rfZ0AKnYNkNQwyTGxqTik3upigHoXP1PkfcqYyQhlwJWKSfTKATQsAKxtr
	 xTsMP8ESqaHR9OWA86q0OQPU8s0bZ/BvEuASqcrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHBDCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 23:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHBDCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 23:02:48 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765EC2080C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596337367;
        bh=69kZjUSWNDziqCdzHTUc/4mOGEuEQGCa68+3zSX0jzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmpfRrTqdw7ywZ7jaI8zkGknqoIz3Z+lsCw+09LoYxUbxA8u697/wKTfJYsUscfI7
         ZvfWIuoCJ/7PMpR9eZBmFy3ouzl0V2QHhQOTMrLMW8plbtkUUBn+EFuR1KXV6kFPQ4
         Jyd/LDpSM9vxF2InbTRM/zoja6e78/kMuIxIzdBo=
Received: by mail-ed1-f53.google.com with SMTP id c15so15253241edj.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 20:02:47 -0700 (PDT)
X-Gm-Message-State: AOAM531L+EeqxudL76nRdOwbJ/UABRNKUas9C6dIxs57QaT2JLD/G84U
        cS7Lybx8kQ4MXJBknUZoZchQr3Uh5C2gybLlDg==
X-Google-Smtp-Source: ABdhPJxL3YzWx3FUUHJpPDKfq2eX1uVtVJzwi0mwaMzX1YCSOIhARaM52Fb4jPnqPRqSLl73JS5FF123RAsYJKlKGDg=
X-Received: by 2002:a50:9e6f:: with SMTP id z102mr10521268ede.300.1596337365962;
 Sat, 01 Aug 2020 20:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de> <20200728111800.77641-4-frank-w@public-files.de>
In-Reply-To: <20200728111800.77641-4-frank-w@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Aug 2020 11:02:33 +0800
X-Gmail-Original-Message-ID: <CAAOTY__QCoV62OZO__6Dg+r0sbJK3AgV7FzFPFYoz_DvXMj7uQ@mail.gmail.com>
Message-ID: <CAAOTY__QCoV62OZO__6Dg+r0sbJK3AgV7FzFPFYoz_DvXMj7uQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] drm: Add get_possible_crtc API for dpi, dsi
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:18=E5=AF=AB=E9=81=93=
=EF=BC=9A
>

Describe why need this patch. I think the reason is:

For current mediatek dsi encoder, its possible crtc is fixed in crtc
0, and mediatek dpi encoder's possible crtc is fixed in crtc 1. In
some SoC the possible crtc is not fixed in this case, so search
pipeline information to find out the correct possible crtc.

> From: Stu Hsieh <stu.hsieh@mediatek.com>
>
> Test: build pass and run ok
>
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Need your signed-off-by tag.

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 42 +++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 57c88de9a329..a5f2ff6bea93 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -13,6 +13,8 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/soc/mediatek/mtk-cmdq.h>
> +#include <drm/drm_print.h>
> +
>  #include "mtk_drm_drv.h"
>  #include "mtk_drm_plane.h"
>  #include "mtk_drm_ddp_comp.h"
> @@ -412,6 +414,22 @@ static const struct mtk_ddp_comp_match mtk_ddp_match=
es[DDP_COMPONENT_ID_MAX] =3D {
>         [DDP_COMPONENT_WDMA1]   =3D { MTK_DISP_WDMA,      1, NULL },
>  };
>
> +static bool mtk_drm_find_comp_in_ddp(struct mtk_ddp_comp ddp_comp,
> +                                        const enum mtk_ddp_comp_id *path=
,
> +                                        unsigned int path_len)
> +{
> +       unsigned int i;
> +
> +       if (path =3D=3D NULL)
> +               return false;

This checking is redundant, so remove it.

> +
> +       for (i =3D 0U; i < path_len; i++)
> +               if (ddp_comp.id =3D=3D path[i])
> +                       return true;
> +
> +       return false;
> +}
> +
>  int mtk_ddp_comp_get_id(struct device_node *node,
>                         enum mtk_ddp_comp_type comp_type)
>  {
> @@ -427,6 +445,30 @@ int mtk_ddp_comp_get_id(struct device_node *node,
>         return -EINVAL;
>  }
>
> +unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
> +                                               struct mtk_ddp_comp ddp_c=
omp)
> +{
> +       struct mtk_drm_private *private =3D drm->dev_private;
> +       unsigned int ret;
> +
> +       if (mtk_drm_find_comp_in_ddp(ddp_comp, private->data->main_path,
> +               private->data->main_len) =3D=3D true) {

' =3D=3D true' is redundant, so remove it.

> +               ret =3D BIT(0);
> +       } else if (mtk_drm_find_comp_in_ddp(ddp_comp,
> +               private->data->ext_path,
> +               private->data->ext_len) =3D=3D true) {

Ditto.

> +               ret =3D BIT(1);
> +       } else if (mtk_drm_find_comp_in_ddp(ddp_comp,
> +               private->data->third_path,
> +               private->data->third_len) =3D=3D true) {

Ditto.

> +               ret =3D BIT(2);
> +       } else {
> +               DRM_INFO("Failed to find comp in ddp table\n");
> +               ret =3D 0;
> +       }
> +       return ret;
> +}
> +
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>                       struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id com=
p_id,
>                       const struct mtk_ddp_comp_funcs *funcs)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.h
> index debe36395fe7..1d9e00b69462 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -202,6 +202,8 @@ static inline void mtk_ddp_ctm_set(struct mtk_ddp_com=
p *comp,
>
>  int mtk_ddp_comp_get_id(struct device_node *node,
>                         enum mtk_ddp_comp_type comp_type);
> +unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
> +                                               struct mtk_ddp_comp ddp_c=
omp);
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
>                       struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id com=
p_id,
>                       const struct mtk_ddp_comp_funcs *funcs);
> --
> 2.25.1
>
