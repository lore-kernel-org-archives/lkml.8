Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD1AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B2F2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596552037;
	bh=nkLqM9VlA8FHpZy8NwqZmUC37JV95B0bjtqMzww6cWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E/+3W2tZMITUIU8JvS3Da3NaSPwIaQJJTV5BP07Ghf2+rCqKADu5r81qqNi2cra2H
	 MYbMjrbrEZDD6nDlskd7JVQ/UfX6BhbwLlbFGImFCMJJ0Y9/D4Z6xgtCCg+zr5z+HE
	 btUGbjjnOOESKGp+JEYkiaq7g+TWr6GCcfWsLBk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgHDOkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbgHDOke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:40:34 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EC922C9F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596552034;
        bh=nkLqM9VlA8FHpZy8NwqZmUC37JV95B0bjtqMzww6cWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IYg4yyMRvQvJjQAtufiU2yKutH8FTciw5RoDowXZwc2OqkcpszzDol4aNF+s77lfn
         tJ6sDMGs5brTIajOtbnMNwLduAP3oK9i8d/DVqqakhtgB40MQ5XyhBhDDX75KkIOU1
         toZE6TOSH7kmXeaLcYRsqQoinD6ljDZiU1sP7Hu0=
Received: by mail-ed1-f41.google.com with SMTP id m20so20573352eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:40:33 -0700 (PDT)
X-Gm-Message-State: AOAM531UuqOcrLKswO7DULohSnwYZlgifPjL5ClbbpQXlOaB5+rgQ0JB
        a1XkaCdIBV7dIfgmYNcFq/GV71fcr0vUCjsI0g==
X-Google-Smtp-Source: ABdhPJzWsvc2uOluoSCcVdo0tNqnkAV63f2SDu0qjVLgSdaB7LNVXcw1IBpC1jNQcHVAPoQg8i6Oocdo+1cNikzAvHg=
X-Received: by 2002:a50:d2c7:: with SMTP id q7mr15847530edg.61.1596552032198;
 Tue, 04 Aug 2020 07:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200804105849.70876-1-linux@fw-web.de> <20200804105849.70876-4-linux@fw-web.de>
In-Reply-To: <20200804105849.70876-4-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 22:40:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8OqCNuv1Wx+79jO85zo_KJ_v+26=mGiyA+TcaUbDa4yA@mail.gmail.com>
Message-ID: <CAAOTY_8OqCNuv1Wx+79jO85zo_KJ_v+26=mGiyA+TcaUbDa4yA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm: Add get_possible_crtc API for dpi, dsi
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Stu Hsieh <stu.hsieh@mediatek.com>
>
> For current mediatek dsi encoder, its possible crtc is fixed in crtc
> 0, and mediatek dpi encoder's possible crtc is fixed in crtc 1. In
> some SoC the possible crtc is not fixed in this case, so search
> pipeline information to find out the correct possible crtc.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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
> +               ret =3D BIT(0);
> +       } else if (mtk_drm_find_comp_in_ddp(ddp_comp,
> +               private->data->ext_path,
> +               private->data->ext_len) =3D=3D true) {
> +               ret =3D BIT(1);
> +       } else if (mtk_drm_find_comp_in_ddp(ddp_comp,
> +               private->data->third_path,
> +               private->data->third_len) =3D=3D true) {
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
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
