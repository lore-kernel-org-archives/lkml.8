Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC17C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C963208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588382594;
	bh=dxSF0No1e15SKH5NUgUA5//83JdEsDPEm+n7PIUb85o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ld7KufzVaT5WDo0d7HqMTtJvAftYyOdzshCqetHwLzYO4MVppbLRSIm9TCTx8bfR6
	 UFyN3fO8Wjt1043y86Jsi7sU5kC8aPoEarwMcFWV/BP+HIwagOfsqbJRe982ZEN2TQ
	 OhshinTiNb+TIS30nCigVSxAo+uegrLQs5kqRacg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgEBBXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 21:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgEBBXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 21:23:13 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2233C208C3
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588382592;
        bh=dxSF0No1e15SKH5NUgUA5//83JdEsDPEm+n7PIUb85o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SbLpgUCfe17mBmU35cDhGFkbG6DdKnk8kR19LLmGR8nlbscdjzExrOaQkIEV021yW
         IKPTxi5EJyhgK0pnhpKnkkPR1UmUVN66iYjZngUgkcsmoajFhpEIaVKJlFD92k62PN
         TpmjPGmSj3yoG00BMai6MFdpH4HolDTWlxgCfk30=
Received: by mail-ej1-f49.google.com with SMTP id rh22so8953084ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 18:23:12 -0700 (PDT)
X-Gm-Message-State: AGi0PubYfQXVp3XZuLzHcsP38fwa5V4kdmELzjQWW1UI40xRbntiUuGO
        9o/kt7g++JqX4tHfuNU1D5cVPjgd4CrqpQNAZA==
X-Google-Smtp-Source: APiQypKavwExl4klXPgph/FWzsO/Vw6UxGMUPAm0zC1cMq31p8tjEXsYJv7ujmOrMomhlYiAcdM1WxLy9/EdFPoC1KQ=
X-Received: by 2002:a17:906:7717:: with SMTP id q23mr5886549ejm.38.1588382590359;
 Fri, 01 May 2020 18:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200501152335.1805790-1-enric.balletbo@collabora.com> <20200501152335.1805790-5-enric.balletbo@collabora.com>
In-Reply-To: <20200501152335.1805790-5-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 2 May 2020 09:22:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-RENbFomQ93BPE35akAKDSmo0beznOvUUrZPeYPRbpEQ@mail.gmail.com>
Message-ID: <CAAOTY_-RENbFomQ93BPE35akAKDSmo0beznOvUUrZPeYPRbpEQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] drm/mediatek: mtk_dsi: Convert to bridge driver
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
=B45=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:23=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Convert mtk_dsi to a bridge driver with built-in encoder support for
> compatibility with existing component drivers.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> Changes in v4:
> - Remove double call to drm_encoder_init(). (Chun-Kuang Hu)
> - Cleanup the encoder in mtk_dsi_unbind(). (Chun-Kuang Hu)
>
> Changes in v3:
> - Add the bridge.type. (Laurent Pinchart)
>
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 108 +++++++++++++++++++----------
>  1 file changed, 70 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 37b8d7ffd835..38cbdcb15fff 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -180,6 +180,7 @@ struct mtk_dsi {
>         struct device *dev;
>         struct mipi_dsi_host host;
>         struct drm_encoder encoder;
> +       struct drm_bridge bridge;
>         struct drm_connector conn;
>         struct drm_panel *panel;
>         struct drm_bridge *next_bridge;
> @@ -205,9 +206,9 @@ struct mtk_dsi {
>         const struct mtk_dsi_driver_data *driver_data;
>  };
>
> -static inline struct mtk_dsi *encoder_to_dsi(struct drm_encoder *e)
> +static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
>  {
> -       return container_of(e, struct mtk_dsi, encoder);
> +       return container_of(b, struct mtk_dsi, bridge);
>  }
>
>  static inline struct mtk_dsi *connector_to_dsi(struct drm_connector *c)
> @@ -796,32 +797,43 @@ static const struct drm_encoder_funcs mtk_dsi_encod=
er_funcs =3D {
>         .destroy =3D mtk_dsi_encoder_destroy,
>  };
>
> -static bool mtk_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
> -                                      const struct drm_display_mode *mod=
e,
> -                                      struct drm_display_mode *adjusted_=
mode)
> +static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_ds=
i *dsi);
> +static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
> +
> +static int mtk_dsi_bridge_attach(struct drm_bridge *bridge,
> +                                enum drm_bridge_attach_flags flags)
>  {
> -       return true;
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +       return mtk_dsi_create_conn_enc(bridge->dev, dsi);
> +}
> +
> +static void mtk_dsi_bridge_detach(struct drm_bridge *bridge)
> +{
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +       mtk_dsi_destroy_conn_enc(dsi);
>  }
>
> -static void mtk_dsi_encoder_mode_set(struct drm_encoder *encoder,
> -                                    struct drm_display_mode *mode,
> -                                    struct drm_display_mode *adjusted)
> +static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
> +                                   const struct drm_display_mode *mode,
> +                                   const struct drm_display_mode *adjust=
ed)
>  {
> -       struct mtk_dsi *dsi =3D encoder_to_dsi(encoder);
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
>
>         drm_display_mode_to_videomode(adjusted, &dsi->vm);
>  }
>
> -static void mtk_dsi_encoder_disable(struct drm_encoder *encoder)
> +static void mtk_dsi_bridge_disable(struct drm_bridge *bridge)
>  {
> -       struct mtk_dsi *dsi =3D encoder_to_dsi(encoder);
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
>
>         mtk_output_dsi_disable(dsi);
>  }
>
> -static void mtk_dsi_encoder_enable(struct drm_encoder *encoder)
> +static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
>  {
> -       struct mtk_dsi *dsi =3D encoder_to_dsi(encoder);
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
>
>         mtk_output_dsi_enable(dsi);
>  }
> @@ -833,11 +845,12 @@ static int mtk_dsi_connector_get_modes(struct drm_c=
onnector *connector)
>         return drm_panel_get_modes(dsi->panel, connector);
>  }
>
> -static const struct drm_encoder_helper_funcs mtk_dsi_encoder_helper_func=
s =3D {
> -       .mode_fixup =3D mtk_dsi_encoder_mode_fixup,
> -       .mode_set =3D mtk_dsi_encoder_mode_set,
> -       .disable =3D mtk_dsi_encoder_disable,
> -       .enable =3D mtk_dsi_encoder_enable,
> +static const struct drm_bridge_funcs mtk_dsi_bridge_funcs =3D {
> +       .attach =3D mtk_dsi_bridge_attach,
> +       .detach =3D mtk_dsi_bridge_detach,
> +       .disable =3D mtk_dsi_bridge_disable,
> +       .enable =3D mtk_dsi_bridge_enable,
> +       .mode_set =3D mtk_dsi_bridge_mode_set,
>  };
>
>  static const struct drm_connector_funcs mtk_dsi_connector_funcs =3D {
> @@ -888,20 +901,6 @@ static int mtk_dsi_create_conn_enc(struct drm_device=
 *drm, struct mtk_dsi *dsi)
>  {
>         int ret;
>
> -       ret =3D drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_fun=
cs,
> -                              DRM_MODE_ENCODER_DSI, NULL);
> -       if (ret) {
> -               DRM_ERROR("Failed to encoder init to drm\n");
> -               return ret;
> -       }
> -       drm_encoder_helper_add(&dsi->encoder, &mtk_dsi_encoder_helper_fun=
cs);
> -
> -       /*
> -        * Currently display data paths are statically assigned to a crtc=
 each.
> -        * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
> -        */
> -       dsi->encoder.possible_crtcs =3D 1;
> -
>         /* If there's a next bridge, attach to it and let it create the c=
onnector */
>         if (dsi->next_bridge) {
>                 ret =3D drm_bridge_attach(&dsi->encoder, dsi->next_bridge=
, NULL,
> @@ -1123,6 +1122,34 @@ static const struct mipi_dsi_host_ops mtk_dsi_ops =
=3D {
>         .transfer =3D mtk_dsi_host_transfer,
>  };
>
> +static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *=
dsi)
> +{
> +       int ret;
> +
> +       ret =3D drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_fun=
cs,
> +                              DRM_MODE_ENCODER_DSI, NULL);
> +       if (ret) {
> +               DRM_ERROR("Failed to encoder init to drm\n");
> +               return ret;
> +       }
> +
> +       /*
> +        * Currently display data paths are statically assigned to a crtc=
 each.
> +        * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
> +        */
> +       dsi->encoder.possible_crtcs =3D 1;
> +
> +       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
> +       if (ret)
> +               goto err_cleanup_encoder;
> +
> +       return 0;
> +
> +err_cleanup_encoder:
> +       drm_encoder_cleanup(&dsi->encoder);
> +       return ret;
> +}
> +
>  static int mtk_dsi_bind(struct device *dev, struct device *master, void =
*data)
>  {
>         int ret;
> @@ -1136,11 +1163,9 @@ static int mtk_dsi_bind(struct device *dev, struct=
 device *master, void *data)
>                 return ret;
>         }
>
> -       ret =3D mtk_dsi_create_conn_enc(drm, dsi);
> -       if (ret) {
> -               DRM_ERROR("Encoder create failed with %d\n", ret);
> +       ret =3D mtk_dsi_encoder_init(drm, dsi);
> +       if (ret)
>                 goto err_unregister;
> -       }
>
>         return 0;
>
> @@ -1155,7 +1180,7 @@ static void mtk_dsi_unbind(struct device *dev, stru=
ct device *master,
>         struct drm_device *drm =3D data;
>         struct mtk_dsi *dsi =3D dev_get_drvdata(dev);
>
> -       mtk_dsi_destroy_conn_enc(dsi);
> +       drm_encoder_cleanup(&dsi->encoder);
>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>  }
>
> @@ -1265,6 +1290,12 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>
>         platform_set_drvdata(pdev, dsi);
>
> +       dsi->bridge.funcs =3D &mtk_dsi_bridge_funcs;
> +       dsi->bridge.of_node =3D dev->of_node;
> +       dsi->bridge.type =3D DRM_MODE_CONNECTOR_DSI;
> +
> +       drm_bridge_add(&dsi->bridge);
> +
>         ret =3D component_add(&pdev->dev, &mtk_dsi_component_ops);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to add component: %d\n", ret)=
;
> @@ -1283,6 +1314,7 @@ static int mtk_dsi_remove(struct platform_device *p=
dev)
>         struct mtk_dsi *dsi =3D platform_get_drvdata(pdev);
>
>         mtk_output_dsi_disable(dsi);
> +       drm_bridge_remove(&dsi->bridge);
>         component_del(&pdev->dev, &mtk_dsi_component_ops);
>         mipi_dsi_host_unregister(&dsi->host);
>
> --
> 2.26.2
>
