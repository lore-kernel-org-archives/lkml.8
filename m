Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE4CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FEE2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599690940;
	bh=AwNR/djzkSk4XRxtVgh4XpiZE4Snxnaub3K3PBVSqmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tz71g5w5M8NNfYYTlZI6ZzYUKhV3ejD9tm+HYHfsT9+ZV3RnQPREzL7OImo8e+CE7
	 iYwVrCo5EqHznU7CpUHIXTTvV+9oKMVIxQbnHmXKe5eek6Bi/5ck+xc8Ll1q1dVYPI
	 dbY9f/OND3csqhJhxhJYVlKzFIJzitlc6wmWcaR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIIWfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIIWff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:35:35 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B300D21D92
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599690934;
        bh=AwNR/djzkSk4XRxtVgh4XpiZE4Snxnaub3K3PBVSqmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p8wlph1rxCk4GJnE0PjhgFCpaXwkKMWujBZ8Ekzax/76rLyQkiU60fzf3/K4EO/iN
         IHV/Ek9XfWpACZArOTTnYN78bQcaB52XFig0W2HhIK4IHKoFF7UyKozAxXCc84cPPJ
         GUtIK74Sw5lTzY2Yf70APQE9poa1Lu/rfwtIEXrY=
Received: by mail-ed1-f54.google.com with SMTP id w1so4324119edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 15:35:33 -0700 (PDT)
X-Gm-Message-State: AOAM5326G9m+nsRFTh40qBWzXKFxmf4wAnlMWDnnzIq7t9Js/D1wRSB1
        WbiTdASWVE6GZyuzWkEpf2dXjMqQ4zY2sWgF6Q==
X-Google-Smtp-Source: ABdhPJxPt4jZbqL/+WplIwQX6wkrFsLr5gOQFG9BJqFAVU+E4SpCNfe0qJxyjkYPSf94dUKekybiQZn1ozzh90dnpNw=
X-Received: by 2002:aa7:c158:: with SMTP id r24mr6100724edp.61.1599690932276;
 Wed, 09 Sep 2020 15:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200826085317.681385-1-enric.balletbo@collabora.com> <20200826085317.681385-3-enric.balletbo@collabora.com>
In-Reply-To: <20200826085317.681385-3-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 10 Sep 2020 06:35:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY__UwVCDn_J1RWesrm7eTS=Ti4LS9FutaydomFNLBVsF2g@mail.gmail.com>
Message-ID: <CAAOTY__UwVCDn_J1RWesrm7eTS=Ti4LS9FutaydomFNLBVsF2g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] drm/mediatek: mtk_dpi: Convert to bridge driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        boris.brezillon@collabora.com,
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

Hi, Andrzej & Neil:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B48=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:53=E5=AF=AB=
=E9=81=93=EF=BC=9A

>
> Convert mtk_dpi to a bridge driver with built-in encoder support for
> compatibility with existing component drivers.
>

This is a DRM-bridge related patch, how do you think about it?

Regards,
Chun-Kuang.

> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2:
> - Maintain error message when attach to bridge fails. (Boris)
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 71 ++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index f7372dbdac0e..589ef33a1780 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -64,6 +64,7 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>         struct mtk_ddp_comp ddp_comp;
>         struct drm_encoder encoder;
> +       struct drm_bridge bridge;
>         struct drm_bridge *next_bridge;
>         void __iomem *regs;
>         struct device *dev;
> @@ -83,9 +84,9 @@ struct mtk_dpi {
>         int refcount;
>  };
>
> -static inline struct mtk_dpi *mtk_dpi_from_encoder(struct drm_encoder *e=
)
> +static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
>  {
> -       return container_of(e, struct mtk_dpi, encoder);
> +       return container_of(b, struct mtk_dpi, bridge);
>  }
>
>  enum mtk_dpi_polarity {
> @@ -521,50 +522,53 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi =
*dpi,
>         return 0;
>  }
>
> -static bool mtk_dpi_encoder_mode_fixup(struct drm_encoder *encoder,
> -                                      const struct drm_display_mode *mod=
e,
> -                                      struct drm_display_mode *adjusted_=
mode)
> +static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
>  {
> -       return true;
> +       drm_encoder_cleanup(encoder);
>  }
>
> -static void mtk_dpi_encoder_mode_set(struct drm_encoder *encoder,
> -                                    struct drm_display_mode *mode,
> -                                    struct drm_display_mode *adjusted_mo=
de)
> +static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> +       .destroy =3D mtk_dpi_encoder_destroy,
> +};
> +
> +static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
> +                                enum drm_bridge_attach_flags flags)
>  {
> -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       return drm_bridge_attach(bridge->encoder, dpi->next_bridge,
> +                                &dpi->bridge, flags);
> +}
> +
> +static void mtk_dpi_bridge_mode_set(struct drm_bridge *bridge,
> +                               const struct drm_display_mode *mode,
> +                               const struct drm_display_mode *adjusted_m=
ode)
> +{
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
>
>         drm_mode_copy(&dpi->mode, adjusted_mode);
>  }
>
> -static void mtk_dpi_encoder_disable(struct drm_encoder *encoder)
> +static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
>  {
> -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
>
>         mtk_dpi_power_off(dpi);
>  }
>
> -static void mtk_dpi_encoder_enable(struct drm_encoder *encoder)
> +static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
>  {
> -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
>
>         mtk_dpi_power_on(dpi);
>         mtk_dpi_set_display_mode(dpi, &dpi->mode);
>  }
>
> -static int mtk_dpi_atomic_check(struct drm_encoder *encoder,
> -                               struct drm_crtc_state *crtc_state,
> -                               struct drm_connector_state *conn_state)
> -{
> -       return 0;
> -}
> -
> -static const struct drm_encoder_helper_funcs mtk_dpi_encoder_helper_func=
s =3D {
> -       .mode_fixup =3D mtk_dpi_encoder_mode_fixup,
> -       .mode_set =3D mtk_dpi_encoder_mode_set,
> -       .disable =3D mtk_dpi_encoder_disable,
> -       .enable =3D mtk_dpi_encoder_enable,
> -       .atomic_check =3D mtk_dpi_atomic_check,
> +static const struct drm_bridge_funcs mtk_dpi_bridge_funcs =3D {
> +       .attach =3D mtk_dpi_bridge_attach,
> +       .mode_set =3D mtk_dpi_bridge_mode_set,
> +       .disable =3D mtk_dpi_bridge_disable,
> +       .enable =3D mtk_dpi_bridge_enable,
>  };
>
>  static void mtk_dpi_start(struct mtk_ddp_comp *comp)
> @@ -605,12 +609,11 @@ static int mtk_dpi_bind(struct device *dev, struct =
device *master, void *data)
>                 dev_err(dev, "Failed to initialize decoder: %d\n", ret);
>                 goto err_unregister;
>         }
> -       drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_fun=
cs);
>
>         /* Currently DPI0 is fixed to be driven by OVL1 */
>         dpi->encoder.possible_crtcs =3D BIT(1);
>
> -       ret =3D drm_bridge_attach(&dpi->encoder, dpi->next_bridge, NULL, =
0);
> +       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, 0);
>         if (ret) {
>                 dev_err(dev, "Failed to attach bridge: %d\n", ret);
>                 goto err_cleanup;
> @@ -791,8 +794,15 @@ static int mtk_dpi_probe(struct platform_device *pde=
v)
>
>         platform_set_drvdata(pdev, dpi);
>
> +       dpi->bridge.funcs =3D &mtk_dpi_bridge_funcs;
> +       dpi->bridge.of_node =3D dev->of_node;
> +       dpi->bridge.type =3D DRM_MODE_CONNECTOR_DPI;
> +
> +       drm_bridge_add(&dpi->bridge);
> +
>         ret =3D component_add(dev, &mtk_dpi_component_ops);
>         if (ret) {
> +               drm_bridge_remove(&dpi->bridge);
>                 dev_err(dev, "Failed to add component: %d\n", ret);
>                 return ret;
>         }
> @@ -802,7 +812,10 @@ static int mtk_dpi_probe(struct platform_device *pde=
v)
>
>  static int mtk_dpi_remove(struct platform_device *pdev)
>  {
> +       struct mtk_dpi *dpi =3D platform_get_drvdata(pdev);
> +
>         component_del(&pdev->dev, &mtk_dpi_component_ops);
> +       drm_bridge_remove(&dpi->bridge);
>
>         return 0;
>  }
> --
> 2.28.0
>
