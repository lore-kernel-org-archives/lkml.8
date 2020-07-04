Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A674DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B77F208D5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593906162;
	bh=tKeXckq/cljxhi5PiM5Dr9pzZi/BIbGaNVQdbwe/LTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Gk412GILANsBdzqVLuqNwe2YKDqlEWiwv7e4oFfi+02QmSw5YUkGoSj0vtjcpy1/
	 PEtoz5ysZz9hv9lK+bKdrPHCjOdung/mBJ0AENwrqL9u0oRYIXBXgAhwr0aZrFVtYD
	 3dO0W0+nXijmpf+8nnpvsaXwxXO2JPvtkU3LU+io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGDXml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgGDXmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:42:40 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC9A8214D8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593906160;
        bh=tKeXckq/cljxhi5PiM5Dr9pzZi/BIbGaNVQdbwe/LTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XOTnF7WFbN+I3+4XbpNUfQdU9F2XN8kWx2sQS96lM0g+xtAJffleOtqFCHmgYwUyw
         8mmAP1WBG857Srm8CXxA6AQXXLRl+bAa+Cek+IuM9wmJz8JvEUGQYHKSM7KUshNJ6j
         N4X77ofJAoIvqifk6YTo2zEE5epKUYsfe2G1PyoQ=
Received: by mail-ej1-f43.google.com with SMTP id l12so38573413ejn.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:42:39 -0700 (PDT)
X-Gm-Message-State: AOAM5329FZkoD2Q2iXju9aH4uWhYAtWvmKpziyN7/OxOw+yXEMHTzHCg
        IFG0U995wqN2JTqgbWZ3AANCtHZs3xP7d9FvyA==
X-Google-Smtp-Source: ABdhPJwfuIFm+ZpQSysHQPpOfHT3QfoveqSeIAFpPPao09rGA3nmGZIPzTn+hkhaV5sDiarPLt0IrUMCan35uDuvI3A=
X-Received: by 2002:a17:906:1e83:: with SMTP id e3mr23048914ejj.7.1593906158358;
 Sat, 04 Jul 2020 16:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com> <20200615203108.786083-6-enric.balletbo@collabora.com>
In-Reply-To: <20200615203108.786083-6-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 07:42:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9pLOMSx+8YzP6YQFJM+rqjoaJUzg3Y8xf3+GqYJCCf7Q@mail.gmail.com>
Message-ID: <CAAOTY_9pLOMSx+8YzP6YQFJM+rqjoaJUzg3Y8xf3+GqYJCCf7Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 5/7] drm/mediatek: mtk_dsi: Use simple encoder
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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
=B46=E6=9C=8816=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=884:31=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> The mtk_dsi driver uses an empty implementation for its encoder. Replace
> the code with the generic simple encoder.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 759a5b37fb4d2..e02d16a086ac0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -789,15 +789,6 @@ static void mtk_output_dsi_disable(struct mtk_dsi *d=
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
> @@ -1127,8 +1118,8 @@ static int mtk_dsi_encoder_init(struct drm_device *=
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
> 2.27.0
>
