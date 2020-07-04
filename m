Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C52C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EA8206F8
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593907061;
	bh=FxX+3x4XmC0gS4P8L46NJ5QrfRw67wHMwGdwWiaOKVQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mMVzFHyBUAo5hIqvrffe7U23DjBVql7bp9KRc7zsiW08F7sFeRtvSyC98HxoLkLAf
	 oc1+1Px0k3vP4lHRmqTjYirHizTcuiDgJ/LFJuRKVXGmk5a0P070RJCtkbAxjz7QDt
	 BtdnZX9BSgUOprxtakSghDKzTptAdjHicsv5ZYbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGDX5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgGDX5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:57:35 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E96208E4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593907053;
        bh=FxX+3x4XmC0gS4P8L46NJ5QrfRw67wHMwGdwWiaOKVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ftP8FTzQD/Ls94DQrV+CBcn8+H8PPy2fPJJVi4YU1fmAvmOOO4xwPsNo96XLSeueB
         /icTqJHA4CfdUg6KIyk4bhcYM0CiU7cXSyZDoNGAvpeun6o2kLK92+W92Q3xh6kdGB
         PIRnMp6D2WgXsDkUrf0BkNCY1GAeROs5B1uR+2ok=
Received: by mail-ej1-f53.google.com with SMTP id f12so12450292eja.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:57:33 -0700 (PDT)
X-Gm-Message-State: AOAM530eUFNhozqpi7ToXtTCZBMSFXAl8xLsDTpGPzpcfESpy9O+FRhF
        cpMhLuqtz085Fwc9UBg53FOLduNu78199P60Bw==
X-Google-Smtp-Source: ABdhPJzr+X0roEAAYu97bPSAEMPjTnE5KTE0oK9yMQ07DiscBCGYg5HYbl0bp7mCkiSQHcEhSeQnaOyNbgZx1aNKFmo=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr37507207ejb.124.1593907051828;
 Sat, 04 Jul 2020 16:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com> <20200615203108.786083-7-enric.balletbo@collabora.com>
In-Reply-To: <20200615203108.786083-7-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 07:57:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8QsSw1gcc+M8muo15DEE6wYG-e2+zsqWMee506rod7Sg@mail.gmail.com>
Message-ID: <CAAOTY_8QsSw1gcc+M8muo15DEE6wYG-e2+zsqWMee506rod7Sg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 6/7] drm/mediatek: mtk_dsi: Use the
 drm_panel_bridge API
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
> Replace the manual panel handling code by a drm_panel_bridge. This
> simplifies the driver and allows all components in the display pipeline
> to be treated as bridges, paving the way to generic connector handling.
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>
> Changes in v4: None
> Changes in v3:
> - Use next_bridge field to store the panel bridge. (Laurent Pinchart)
> - Add the bridge.type field. (Laurent Pinchart)
> - This patch requires https://lkml.org/lkml/2020/4/16/2080 to work
>   properly.
>
> Changes in v2:
> - Do not set connector_type for panel here. (Sam Ravnborg)
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 173 +++--------------------------
>  1 file changed, 14 insertions(+), 159 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index e02d16a086ac0..4f3bd095c1eee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -182,8 +182,6 @@ struct mtk_dsi {
>         struct mipi_dsi_host host;
>         struct drm_encoder encoder;
>         struct drm_bridge bridge;
> -       struct drm_connector conn;
> -       struct drm_panel *panel;
>         struct drm_bridge *next_bridge;
>         struct phy *phy;
>
> @@ -212,11 +210,6 @@ static inline struct mtk_dsi *bridge_to_dsi(struct d=
rm_bridge *b)
>         return container_of(b, struct mtk_dsi, bridge);
>  }
>
> -static inline struct mtk_dsi *connector_to_dsi(struct drm_connector *c)
> -{
> -       return container_of(c, struct mtk_dsi, conn);
> -}
> -
>  static inline struct mtk_dsi *host_to_dsi(struct mipi_dsi_host *h)
>  {
>         return container_of(h, struct mtk_dsi, host);
> @@ -682,16 +675,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         mtk_dsi_lane0_ulp_mode_leave(dsi);
>         mtk_dsi_clk_hs_mode(dsi, 0);
>
> -       if (dsi->panel) {
> -               if (drm_panel_prepare(dsi->panel)) {
> -                       DRM_ERROR("failed to prepare the panel\n");
> -                       goto err_disable_digital_clk;
> -               }
> -       }
> -
>         return 0;
> -err_disable_digital_clk:
> -       clk_disable_unprepare(dsi->digital_clk);
>  err_disable_engine_clk:
>         clk_disable_unprepare(dsi->engine_clk);
>  err_phy_power_off:
> @@ -718,15 +702,7 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
>          */
>         mtk_dsi_stop(dsi);
>
> -       if (!mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500)) {
> -               if (dsi->panel) {
> -                       if (drm_panel_unprepare(dsi->panel)) {
> -                               DRM_ERROR("failed to unprepare the panel\=
n");
> -                               return;
> -                       }
> -               }
> -       }
> -
> +       mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
>         mtk_dsi_reset_engine(dsi);
>         mtk_dsi_lane0_ulp_mode_enter(dsi);
>         mtk_dsi_clk_ulp_mode_enter(dsi);
> @@ -757,19 +733,7 @@ static void mtk_output_dsi_enable(struct mtk_dsi *ds=
i)
>
>         mtk_dsi_start(dsi);
>
> -       if (dsi->panel) {
> -               if (drm_panel_enable(dsi->panel)) {
> -                       DRM_ERROR("failed to enable the panel\n");
> -                       goto err_dsi_power_off;
> -               }
> -       }
> -
>         dsi->enabled =3D true;
> -
> -       return;
> -err_dsi_power_off:
> -       mtk_dsi_stop(dsi);
> -       mtk_dsi_poweroff(dsi);
>  }
>
>  static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
> @@ -777,34 +741,19 @@ static void mtk_output_dsi_disable(struct mtk_dsi *=
dsi)
>         if (!dsi->enabled)
>                 return;
>
> -       if (dsi->panel) {
> -               if (drm_panel_disable(dsi->panel)) {
> -                       DRM_ERROR("failed to disable the panel\n");
> -                       return;
> -               }
> -       }
> -
>         mtk_dsi_poweroff(dsi);
>
>         dsi->enabled =3D false;
>  }
>
> -static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_ds=
i *dsi);
> -static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi);
> -
>  static int mtk_dsi_bridge_attach(struct drm_bridge *bridge,
>                                  enum drm_bridge_attach_flags flags)
>  {
>         struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
>
> -       return mtk_dsi_create_conn_enc(bridge->dev, dsi);
> -}
> -
> -static void mtk_dsi_bridge_detach(struct drm_bridge *bridge)
> -{
> -       struct mtk_dsi *dsi =3D bridge_to_dsi(bridge);
> -
> -       mtk_dsi_destroy_conn_enc(dsi);
> +       /* Attach the panel or bridge to the dsi bridge */
> +       return drm_bridge_attach(bridge->encoder, dsi->next_bridge,
> +                                &dsi->bridge, flags);
>  }
>
>  static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
> @@ -830,101 +779,13 @@ static void mtk_dsi_bridge_enable(struct drm_bridg=
e *bridge)
>         mtk_output_dsi_enable(dsi);
>  }
>
> -static int mtk_dsi_connector_get_modes(struct drm_connector *connector)
> -{
> -       struct mtk_dsi *dsi =3D connector_to_dsi(connector);
> -
> -       return drm_panel_get_modes(dsi->panel, connector);
> -}
> -
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs =3D {
>         .attach =3D mtk_dsi_bridge_attach,
> -       .detach =3D mtk_dsi_bridge_detach,
>         .disable =3D mtk_dsi_bridge_disable,
>         .enable =3D mtk_dsi_bridge_enable,
>         .mode_set =3D mtk_dsi_bridge_mode_set,
>  };
>
> -static const struct drm_connector_funcs mtk_dsi_connector_funcs =3D {
> -       .fill_modes =3D drm_helper_probe_single_connector_modes,
> -       .destroy =3D drm_connector_cleanup,
> -       .reset =3D drm_atomic_helper_connector_reset,
> -       .atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate=
_state,
> -       .atomic_destroy_state =3D drm_atomic_helper_connector_destroy_sta=
te,
> -};
> -
> -static const struct drm_connector_helper_funcs
> -       mtk_dsi_connector_helper_funcs =3D {
> -       .get_modes =3D mtk_dsi_connector_get_modes,
> -};
> -
> -static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_d=
si *dsi)
> -{
> -       int ret;
> -
> -       ret =3D drm_connector_init(drm, &dsi->conn, &mtk_dsi_connector_fu=
ncs,
> -                                DRM_MODE_CONNECTOR_DSI);
> -       if (ret) {
> -               DRM_ERROR("Failed to connector init to drm\n");
> -               return ret;
> -       }
> -
> -       drm_connector_helper_add(&dsi->conn, &mtk_dsi_connector_helper_fu=
ncs);
> -
> -       dsi->conn.dpms =3D DRM_MODE_DPMS_OFF;
> -       drm_connector_attach_encoder(&dsi->conn, &dsi->encoder);
> -
> -       if (dsi->panel) {
> -               ret =3D drm_panel_attach(dsi->panel, &dsi->conn);
> -               if (ret) {
> -                       DRM_ERROR("Failed to attach panel to drm\n");
> -                       goto err_connector_cleanup;
> -               }
> -       }
> -
> -       return 0;
> -
> -err_connector_cleanup:
> -       drm_connector_cleanup(&dsi->conn);
> -       return ret;
> -}
> -
> -static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_ds=
i *dsi)
> -{
> -       int ret;
> -
> -       /* If there's a next bridge, attach to it and let it create the c=
onnector */
> -       if (dsi->next_bridge) {
> -               ret =3D drm_bridge_attach(&dsi->encoder, dsi->next_bridge=
, NULL,
> -                                       0);
> -               if (ret) {
> -                       DRM_ERROR("Failed to attach bridge to drm\n");
> -                       goto err_encoder_cleanup;
> -               }
> -       } else {
> -               /* Otherwise create our own connector and attach to a pan=
el */
> -               ret =3D mtk_dsi_create_connector(drm, dsi);
> -               if (ret)
> -                       goto err_encoder_cleanup;
> -       }
> -
> -       return 0;
> -
> -err_encoder_cleanup:
> -       drm_encoder_cleanup(&dsi->encoder);
> -       return ret;
> -}
> -
> -static void mtk_dsi_destroy_conn_enc(struct mtk_dsi *dsi)
> -{
> -       drm_encoder_cleanup(&dsi->encoder);
> -       /* Skip connector cleanup if creation was delegated to the bridge=
 */
> -       if (dsi->conn.dev)
> -               drm_connector_cleanup(&dsi->conn);
> -       if (dsi->panel)
> -               drm_panel_detach(dsi->panel);
> -}
> -
>  static void mtk_dsi_ddp_start(struct mtk_ddp_comp *comp)
>  {
>         struct mtk_dsi *dsi =3D container_of(comp, struct mtk_dsi, ddp_co=
mp);
> @@ -953,20 +814,6 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host =
*host,
>         dsi->format =3D device->format;
>         dsi->mode_flags =3D device->mode_flags;
>
> -       if (dsi->conn.dev)
> -               drm_helper_hpd_irq_event(dsi->conn.dev);
> -
> -       return 0;
> -}
> -
> -static int mtk_dsi_host_detach(struct mipi_dsi_host *host,
> -                              struct mipi_dsi_device *device)
> -{
> -       struct mtk_dsi *dsi =3D host_to_dsi(host);
> -
> -       if (dsi->conn.dev)
> -               drm_helper_hpd_irq_event(dsi->conn.dev);
> -
>         return 0;
>  }
>
> @@ -1110,7 +957,6 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi=
_host *host,
>
>  static const struct mipi_dsi_host_ops mtk_dsi_ops =3D {
>         .attach =3D mtk_dsi_host_attach,
> -       .detach =3D mtk_dsi_host_detach,
>         .transfer =3D mtk_dsi_host_transfer,
>  };
>
> @@ -1185,6 +1031,7 @@ static int mtk_dsi_probe(struct platform_device *pd=
ev)
>  {
>         struct mtk_dsi *dsi;
>         struct device *dev =3D &pdev->dev;
> +       struct drm_panel *panel;
>         struct resource *regs;
>         int irq_num;
>         int comp_id;
> @@ -1203,10 +1050,18 @@ static int mtk_dsi_probe(struct platform_device *=
pdev)
>         }
>
>         ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -                                         &dsi->panel, &dsi->next_bridge)=
;
> +                                         &panel, &dsi->next_bridge);
>         if (ret)
>                 goto err_unregister_host;
>
> +       if (panel) {
> +               dsi->next_bridge =3D devm_drm_panel_bridge_add(dev, panel=
);
> +               if (IS_ERR(dsi->next_bridge)) {
> +                       ret =3D PTR_ERR(dsi->next_bridge);
> +                       goto err_unregister_host;
> +               }
> +       }
> +
>         dsi->driver_data =3D of_device_get_match_data(dev);
>
>         dsi->engine_clk =3D devm_clk_get(dev, "engine");
> --
> 2.27.0
>
