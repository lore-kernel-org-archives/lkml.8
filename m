Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6CC20772
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593905712;
	bh=wyCmrZT1/F4MWf7J6vRrTXwurSok2IlwZH3Atvuq5aQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jxx0oizWer5wfMXzdS4B8szJmZ3klkeCkb8A/nqL6IsY/2YjsMGaMSlGbC5jmaYCC
	 Jyo7uutsEF95u81sIsDkmS7aAP0uOZlgBx4DGT/ThLmWvY4xiJBgq++pnu/I9x8i9R
	 na6KoMUk4HK+8MBV2d1ExLwndoJRzIKNtTuW558U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGDXeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgGDXeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:34:15 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F047214D8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593905654;
        bh=wyCmrZT1/F4MWf7J6vRrTXwurSok2IlwZH3Atvuq5aQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OgUVh5IawpbA03Cd65mr+rtfG8one+8prFLbxf52uY5MF/ArJg28vLuTXl0TpvFrl
         qfgfltP55JzDYEUPO79dddZBo3aYTovUbjX6vi1No4JKEaxlQJBRdiekV4KxsccoEh
         ece5ueWRzEHk3bNC2HOWqyQpadpPj+lRLOPmarYM=
Received: by mail-ej1-f50.google.com with SMTP id w16so38587166ejj.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:34:14 -0700 (PDT)
X-Gm-Message-State: AOAM5320a5NV+dYcN2FS7lYhuX13axDFCLNYkWIwZ3dMXgzmrZDAL8G9
        2IcFg+11yekxQGUsbNk1IU9y8vlJi0JPjRAJWQ==
X-Google-Smtp-Source: ABdhPJzM1lQhvawcJNzhzdJ+FEFnk6MNbEQYBs3zdIQOEtzvrsWmGsJ0Ij1tyUtGSv+R+lSANVreuxdTH/jr0gBH8K8=
X-Received: by 2002:a17:906:404e:: with SMTP id y14mr37027241ejj.260.1593905653033;
 Sat, 04 Jul 2020 16:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com> <20200615203108.786083-5-enric.balletbo@collabora.com>
In-Reply-To: <20200615203108.786083-5-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 07:34:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__amgJj-dJA_ngV9yF7X-y_pB-P-EBqGfD=hNbgVbZSkA@mail.gmail.com>
Message-ID: <CAAOTY__amgJj-dJA_ngV9yF7X-y_pB-P-EBqGfD=hNbgVbZSkA@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 4/7] drm/mediatek: mtk_dsi: Convert to bridge driver
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
> Convert mtk_dsi to a bridge driver with built-in encoder support for
> compatibility with existing component drivers.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 117 +++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 208f49bf14a01..759a5b37fb4d2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -181,6 +181,7 @@ struct mtk_dsi {
>         struct device *dev;
>         struct mipi_dsi_host host;
>         struct drm_encoder encoder;
> +       struct drm_bridge bridge;
>         struct drm_connector conn;
>         struct drm_panel *panel;
>         struct drm_bridge *next_bridge;
> @@ -206,9 +207,9 @@ struct mtk_dsi {
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
> @@ -788,32 +789,52 @@ static void mtk_output_dsi_disable(struct mtk_dsi *=
dsi)
>         dsi->enabled =3D false;
>  }
>
> -static bool mtk_dsi_encoder_mode_fixup(struct drm_encoder *encoder,
> -                                      const struct drm_display_mode *mod=
e,
> -                                      struct drm_display_mode *adjusted_=
mode)
> +static void mtk_dsi_encoder_destroy(struct drm_encoder *encoder)
>  {
> -       return true;
> +       drm_encoder_cleanup(encoder);
>  }
>
> -static void mtk_dsi_encoder_mode_set(struct drm_encoder *encoder,
> -                                    struct drm_display_mode *mode,
> -                                    struct drm_display_mode *adjusted)
> +static const struct drm_encoder_funcs mtk_dsi_encoder_funcs =3D {
> +       .destroy =3D mtk_dsi_encoder_destroy,
> +};
> +
> +static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_ds=
i *dsi);
> +static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
> +
> +static int mtk_dsi_bridge_attach(struct drm_bridge *bridge,
> +                                enum drm_bridge_attach_flags flags)
> +{
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +       return mtk_dsi_create_conn_enc(bridge->dev, dsi);
> +}
> +
> +static void mtk_dsi_bridge_detach(struct drm_bridge *bridge)
>  {
> -       struct mtk_dsi *dsi =3D encoder_to_dsi(encoder);
> +       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +       mtk_dsi_destroy_conn_enc(dsi);
> +}
> +
> +static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
> +                                   const struct drm_display_mode *mode,
> +                                   const struct drm_display_mode *adjust=
ed)
> +{
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
> @@ -825,11 +846,12 @@ static int mtk_dsi_connector_get_modes(struct drm_c=
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
> @@ -880,20 +902,6 @@ static int mtk_dsi_create_conn_enc(struct drm_device=
 *drm, struct mtk_dsi *dsi)
>  {
>         int ret;
>
> -       ret =3D drm_simple_encoder_init(drm, &dsi->encoder,
> -                                     DRM_MODE_ENCODER_DSI);
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
> @@ -1115,6 +1123,34 @@ static const struct mipi_dsi_host_ops mtk_dsi_ops =
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
> @@ -1128,11 +1164,9 @@ static int mtk_dsi_bind(struct device *dev, struct=
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
> @@ -1147,7 +1181,7 @@ static void mtk_dsi_unbind(struct device *dev, stru=
ct device *master,
>         struct drm_device *drm =3D data;
>         struct mtk_dsi *dsi =3D dev_get_drvdata(dev);
>
> -       mtk_dsi_destroy_conn_enc(dsi);
> +       drm_encoder_cleanup(&dsi->encoder);
>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>  }
>
> @@ -1257,6 +1291,12 @@ static int mtk_dsi_probe(struct platform_device *p=
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
> @@ -1275,6 +1315,7 @@ static int mtk_dsi_remove(struct platform_device *p=
dev)
>         struct mtk_dsi *dsi =3D platform_get_drvdata(pdev);
>
>         mtk_output_dsi_disable(dsi);
> +       drm_bridge_remove(&dsi->bridge);
>         component_del(&pdev->dev, &mtk_dsi_component_ops);
>         mipi_dsi_host_unregister(&dsi->host);
>
> --
> 2.27.0
>
