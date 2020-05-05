Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F412078D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588685103;
	bh=Rac7y5rYSK/2G4X72RSjogk7F2/1A77BkfY4aonMNHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sSrKsG6E5G3uyTqW991cPbKkZ6DsyMGL0auzIlZeDWdvO9CtFsetyJqP9IX+L0BYX
	 H4p0eWAGNAG/fNT0GcDFlwXcWcE8jY8pXOko7+Wdbf1h2r9+HBnI+D/Z2jXCYsDa4D
	 DTZAGL7mjiiMnE6d/UlM6CR0GSS4X1CAgIqkAMwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgEENZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgEENZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:25:01 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7550B2085B
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588685100;
        bh=Rac7y5rYSK/2G4X72RSjogk7F2/1A77BkfY4aonMNHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i5xHfyBiuY7p3DIDikoONdvivQLQ4kFoUccnvcJjFvhJv1HKqhIO1mf1meaLdx+2n
         1i52/G4OxRdFuW6VaiyUE7nR7/tQPKjvGlAde5qF2T8Af5nG/vVWTQ8pOq44RNLASN
         r9288oja66bgZ4akeUN8C1WjZHZMIBknn7sB+hGY=
Received: by mail-ej1-f54.google.com with SMTP id s9so1707481eju.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:25:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuY3b8O5MXiaGsslpbj8eBOaRMht0MntT6bX950s+QuNr0amA2EI
        MBtGROgg5IiaRgsg7Z7Kc7iEHnULDNRoiun8yg==
X-Google-Smtp-Source: APiQypLJ2xfzocGLFFYqsJeJ4aQuzD3rk0l4tQD4X9JUcGCFrXJoKm4Ml5gb0eu1ufwRXvYazmB6synEUoz0VY1lpns=
X-Received: by 2002:a17:906:7717:: with SMTP id q23mr2732910ejm.38.1588685098796;
 Tue, 05 May 2020 06:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200504141408.60877-1-enric.balletbo@collabora.com> <20200504141408.60877-3-enric.balletbo@collabora.com>
In-Reply-To: <20200504141408.60877-3-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 5 May 2020 21:24:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8ZV3UDanHDnVmUESPfaNBjwFBKi9-i7ctSFVWGOHAR2g@mail.gmail.com>
Message-ID: <CAAOTY_8ZV3UDanHDnVmUESPfaNBjwFBKi9-i7ctSFVWGOHAR2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/mediatek: mtk_dpi: Convert to bridge driver
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
=B45=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:14=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Convert mtk_dpi to a bridge driver with built-in encoder support for
> compatibility with existing component drivers.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 66 +++++++++++++++---------------
>  1 file changed, 34 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index 7112125dc3d1..baad198c69eb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -61,6 +61,7 @@ enum mtk_dpi_out_color_format {
>  struct mtk_dpi {
>         struct mtk_ddp_comp ddp_comp;
>         struct drm_encoder encoder;
> +       struct drm_bridge bridge;
>         struct drm_bridge *next_bridge;
>         void __iomem *regs;
>         struct device *dev;
> @@ -77,9 +78,9 @@ struct mtk_dpi {
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
> @@ -518,50 +519,44 @@ static const struct drm_encoder_funcs mtk_dpi_encod=
er_funcs =3D {
>         .destroy =3D mtk_dpi_encoder_destroy,
>  };
>
> -static bool mtk_dpi_encoder_mode_fixup(struct drm_encoder *encoder,
> -                                      const struct drm_display_mode *mod=
e,
> -                                      struct drm_display_mode *adjusted_=
mode)
> +static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
> +                                enum drm_bridge_attach_flags flags)
>  {
> -       return true;
> +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> +
> +       return drm_bridge_attach(bridge->encoder, dpi->next_bridge,
> +                                &dpi->bridge, flags);
>  }
>
> -static void mtk_dpi_encoder_mode_set(struct drm_encoder *encoder,
> -                                    struct drm_display_mode *mode,
> -                                    struct drm_display_mode *adjusted_mo=
de)
> +static void mtk_dpi_bridge_mode_set(struct drm_bridge *bridge,
> +                               const struct drm_display_mode *mode,
> +                               const struct drm_display_mode *adjusted_m=
ode)
>  {
> -       struct mtk_dpi *dpi =3D mtk_dpi_from_encoder(encoder);
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
> @@ -602,16 +597,13 @@ static int mtk_dpi_bind(struct device *dev, struct =
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
> -       if (ret) {
> -               dev_err(dev, "Failed to attach bridge: %d\n", ret);
> +       ret =3D drm_bridge_attach(&dpi->encoder, &dpi->bridge, NULL, 0);
> +       if (ret)
>                 goto err_cleanup;
> -       }
>
>         dpi->bit_num =3D MTK_DPI_OUT_BIT_NUM_8BITS;
>         dpi->channel_swap =3D MTK_DPI_OUT_CHANNEL_SWAP_RGB;
> @@ -768,8 +760,15 @@ static int mtk_dpi_probe(struct platform_device *pde=
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
> @@ -779,7 +778,10 @@ static int mtk_dpi_probe(struct platform_device *pde=
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
> 2.26.2
>
