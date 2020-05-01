Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E832173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339493;
	bh=d8OPxjX6yuJbdOTlfUXM7Zvc614YcSXkktA7q5/FxRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OT0QjhhJjS3pK0U9zzV4MjCrBxc1fQvyDpYyOHPmOD34TnlxWUuTRzbrlS6IjCvJg
	 +MSXr80niitlJbNEMAkBkkVEWnQ9Gx6aqFLIEIXewXdjI95bup4XiJFotfyjFFFL3S
	 pankQLzjC2J31LzY1q5p6GjM35aaDHHAVkdj3z2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgEANYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgEANYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:24:50 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBB924962
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339489;
        bh=d8OPxjX6yuJbdOTlfUXM7Zvc614YcSXkktA7q5/FxRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oRiwD0Q+jvvpP6sMUM7uXKK++I/eOZnt6Ikrp6rtJBAPD/6vZl/OFq4Uxzqg573dr
         HXTT0bMxoz2GibxZPq00kqvlqfP1GYpMyc+LbA3Tf2Ofs9mJFJf4NsfNvEueN0i/ZY
         ldEXuawf8h0p2ODo+BCBInJ2O4GxSh/bcIMpNLxQ=
Received: by mail-ed1-f48.google.com with SMTP id d16so7243606edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 06:24:49 -0700 (PDT)
X-Gm-Message-State: AGi0PuasxmQsQBR9LCu9jSA8Z5VWB85Yu4U60lUafAeVWEGt3KMD0npZ
        fN+Y0kwW/oPsCyfLXXnTYIe/KIPcuglQCbYD+g==
X-Google-Smtp-Source: APiQypKel2U1e5MRHXKLL7Rnuz1U41FBCv2Ii6mcl2FuZrvIApbgp6jSgjZ93cS0z2rzE3pcCu/kvy2F5YvYBuZXTp0=
X-Received: by 2002:aa7:dd95:: with SMTP id g21mr3461314edv.148.1588339487975;
 Fri, 01 May 2020 06:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200417150614.2631786-1-enric.balletbo@collabora.com> <20200417150614.2631786-6-enric.balletbo@collabora.com>
In-Reply-To: <20200417150614.2631786-6-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 1 May 2020 21:24:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Gc9uCtfcp+qo=KnVOYfyjw4rDpe15A1q6G2A-iXpSow@mail.gmail.com>
Message-ID: <CAAOTY_9Gc9uCtfcp+qo=KnVOYfyjw4rDpe15A1q6G2A-iXpSow@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drm/mediatek: mtk_dsi: Use simple encoder
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B44=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:06=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> The mtk_dsi driver uses an empty implementation for its encoder. Replace
> the code with the generic simple encoder.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 869ae0a2e9f8..d68694ff00dc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -22,6 +22,7 @@
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
>
>  #include "mtk_drm_ddp_comp.h"
>
> @@ -788,15 +789,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *d=
si)
>         dsi->enabled =3D false;
>  }
>
> -static void mtk_dsi_encoder_destroy(struct drm_encoder *encoder)
> -{
> -       drm_encoder_cleanup(encoder);
> -}
> -
> -static const struct drm_encoder_funcs mtk_dsi_encoder_funcs =3D {
> -       .destroy =3D mtk_dsi_encoder_destroy,
> -};
> -
>  static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_ds=
i *dsi);
>  static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
>
> @@ -1140,8 +1132,8 @@ static int mtk_dsi_encoder_init(struct drm_device *=
drm, struct mtk_dsi *dsi)
>  {
>         int ret;
>
> -       ret =3D drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_fun=
cs,
> -                              DRM_MODE_ENCODER_DSI, NULL);
> +       ret =3D drm_simple_encoder_init(drm, &dsi->encoder,
> +                                     DRM_MODE_ENCODER_DSI);
>         if (ret) {
>                 DRM_ERROR("Failed to encoder init to drm\n");
>                 return ret;
> --
> 2.25.1
>
