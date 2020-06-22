Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062E320760
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592835563;
	bh=GuJeKKRg4ljASSKmnxTHSEq9Lrl4bygvq5sIO4QgElE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SgIp/aJoGon+nO9zZNZgTggKjnE4eFO8FX8qSc2+rBLVBMG4AHslOfjZd4+nC2zYy
	 GGDsfkvMKcG8Yj44XZmCu1hQmtqkBRbDDGnhE8EaMa4dkMa2utAfY/yRW4S2caLbUe
	 5iNc9cWInePwz04gc6cAgIs3F4g1MYc+u4p6ntSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgFVOTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbgFVOTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:19:20 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F8620760
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592835560;
        bh=GuJeKKRg4ljASSKmnxTHSEq9Lrl4bygvq5sIO4QgElE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrT8e2hurv/CltZNbH9ceFcN4qAv9y1dqYBxOw/Q0A1nteRR8KkFwoLLVny3IOgql
         h7SpbuiNAUYDAfEzIUqV3LoJ1/7Gs89T7ybQj+oTOq6dsjBVC2Ni5Lg0lJQOjRLlHX
         jeZTdCk+YtbAcRnqD2eH+ijlY6g2a3DNp9Kl07WU=
Received: by mail-ej1-f47.google.com with SMTP id mb16so18200860ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:19:20 -0700 (PDT)
X-Gm-Message-State: AOAM533Frs3v5MiAUOw+nh36HjGUADE9KVTVwBBYC8Hzp1l9v1xDOxH3
        DC/daVb9y/rIOO0TDZl/7Cx4s3J6/1C/r1XcLg==
X-Google-Smtp-Source: ABdhPJw+6j+Dz0ZG80oIz70/+V1sj/iA5Yn7Z4RQs/Z0zQuiq2w/YgsHfc4h1zA1uemuLKohvBbgeRWKz4d1gEyTnO4=
X-Received: by 2002:a17:906:5fc4:: with SMTP id k4mr6319741ejv.94.1592835558674;
 Mon, 22 Jun 2020 07:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200622053234.122120-1-hsinyi@chromium.org>
In-Reply-To: <20200622053234.122120-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 22 Jun 2020 22:19:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-t2-uiuLCAUONkTdLt_h3gERRdadY+nS9ZXWF28t+VTQ@mail.gmail.com>
Message-ID: <CAAOTY_-t2-uiuLCAUONkTdLt_h3gERRdadY+nS9ZXWF28t+VTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: check plane visibility in atomic_update
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
> would proceed with invalid plane and we may see vblank timeout.

Except the Fixes tag,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.c
> index c2bd683a87c8..74dc71c7f3b6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -164,6 +164,16 @@ static int mtk_plane_atomic_check(struct drm_plane *=
plane,
>                                                    true, true);
>  }
>
> +static void mtk_plane_atomic_disable(struct drm_plane *plane,
> +                                    struct drm_plane_state *old_state)
> +{
> +       struct mtk_plane_state *state =3D to_mtk_plane_state(plane->state=
);
> +
> +       state->pending.enable =3D false;
> +       wmb(); /* Make sure the above parameter is set before update */
> +       state->pending.dirty =3D true;
> +}
> +
>  static void mtk_plane_atomic_update(struct drm_plane *plane,
>                                     struct drm_plane_state *old_state)
>  {
> @@ -178,6 +188,9 @@ static void mtk_plane_atomic_update(struct drm_plane =
*plane,
>         if (!crtc || WARN_ON(!fb))
>                 return;
>
> +       if (!plane->state->visible)
> +               return mtk_plane_atomic_disable(plane, old_state);
> +
>         gem =3D fb->obj[0];
>         mtk_gem =3D to_mtk_gem_obj(gem);
>         addr =3D mtk_gem->dma_addr;
> @@ -200,16 +213,6 @@ static void mtk_plane_atomic_update(struct drm_plane=
 *plane,
>         state->pending.dirty =3D true;
>  }
>
> -static void mtk_plane_atomic_disable(struct drm_plane *plane,
> -                                    struct drm_plane_state *old_state)
> -{
> -       struct mtk_plane_state *state =3D to_mtk_plane_state(plane->state=
);
> -
> -       state->pending.enable =3D false;
> -       wmb(); /* Make sure the above parameter is set before update */
> -       state->pending.dirty =3D true;
> -}
> -
>  static const struct drm_plane_helper_funcs mtk_plane_helper_funcs =3D {
>         .prepare_fb =3D drm_gem_fb_prepare_fb,
>         .atomic_check =3D mtk_plane_atomic_check,
> --
> 2.27.0.111.gc72c7da667-goog
>
