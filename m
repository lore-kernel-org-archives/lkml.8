Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665EC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F682208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588382632;
	bh=fKedIT7NCjjtN+WZ+I/uAQkL+Kk76kfwMU8EfUxLit0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O19t3vacAgdUmJ8Jwj9S/RTiTID1IMgOZny0LQinh3E1tWsfKdAgS2IQ7L0Gfgd87
	 fOdlmnnEuLwrgHKBXtHAuZtz4JTmX3IpNW0dr5/k+YqWNzHm7YySHtJMsJQUEJPlEA
	 IoiLlVZjiokowjH9UEnV6mFfZubChlSRgqjpbk1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEBBXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 21:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgEBBXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 21:23:51 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DAAC21974
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588382630;
        bh=fKedIT7NCjjtN+WZ+I/uAQkL+Kk76kfwMU8EfUxLit0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2AU2x8aC7YuhK/uBVFA1aIW4u4+DqhdT73DwkckBsRhs4FWqZbRugm2hrOLAMUdCJ
         kO/F4ugCLOvHIxCX40P2aYXsKiMLlJZYCbtwZQeOPbcq3Ovk3ukFe9Dz1AWr+vt/x1
         b/NNHg2IinE81Fc9sU4ud1VdAEY0uDluxBYy62bw=
Received: by mail-ed1-f41.google.com with SMTP id f12so8610498edn.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 18:23:50 -0700 (PDT)
X-Gm-Message-State: AGi0PuYqBA/DzRbP2WOb6xCHiRAsa2JldfX4xILQi3kgk+lz95ziaQFj
        JdRAsp8DYVMNkUVKdNPsuYybMTXN6gNhFXixKQ==
X-Google-Smtp-Source: APiQypKfu4S78pn6Hni94rL6h97guVNLRCNyuj3ph+4DeSmaCsksPyugFgEcYB5B3sAmS1GpdvZ7InYPlctsgiiekeE=
X-Received: by 2002:a05:6402:1f6:: with SMTP id i22mr6043564edy.271.1588382628798;
 Fri, 01 May 2020 18:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200501152335.1805790-1-enric.balletbo@collabora.com> <20200501152335.1805790-4-enric.balletbo@collabora.com>
In-Reply-To: <20200501152335.1805790-4-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 2 May 2020 09:23:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY__grEXBPJjYveiEDFZ4-XjGr=sBpciK4zhFXfd=4OBZNA@mail.gmail.com>
Message-ID: <CAAOTY__grEXBPJjYveiEDFZ4-XjGr=sBpciK4zhFXfd=4OBZNA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] drm/mediatek: mtk_dsi: Rename bridge to next_bridge
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
> This is really a cosmetic change just to make a bit more readable the
> code after convert the driver to drm_bridge. The bridge variable name
> will be used by the encoder drm_bridge, and the chained bridge will be
> named next_bridge.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> Changes in v4: None
> Changes in v3:
> - Replace s/bridge/next bridge/ for comment. (Laurent Pinchart)
>
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index cfa45d6abd74..37b8d7ffd835 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -182,7 +182,7 @@ struct mtk_dsi {
>         struct drm_encoder encoder;
>         struct drm_connector conn;
>         struct drm_panel *panel;
> -       struct drm_bridge *bridge;
> +       struct drm_bridge *next_bridge;
>         struct phy *phy;
>
>         void __iomem *regs;
> @@ -902,9 +902,10 @@ static int mtk_dsi_create_conn_enc(struct drm_device=
 *drm, struct mtk_dsi *dsi)
>          */
>         dsi->encoder.possible_crtcs =3D 1;
>
> -       /* If there's a bridge, attach to it and let it create the connec=
tor */
> -       if (dsi->bridge) {
> -               ret =3D drm_bridge_attach(&dsi->encoder, dsi->bridge, NUL=
L, 0);
> +       /* If there's a next bridge, attach to it and let it create the c=
onnector */
> +       if (dsi->next_bridge) {
> +               ret =3D drm_bridge_attach(&dsi->encoder, dsi->next_bridge=
, NULL,
> +                                       0);
>                 if (ret) {
>                         DRM_ERROR("Failed to attach bridge to drm\n");
>                         goto err_encoder_cleanup;
> @@ -1185,7 +1186,7 @@ static int mtk_dsi_probe(struct platform_device *pd=
ev)
>         }
>
>         ret =3D drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> -                                         &dsi->panel, &dsi->bridge);
> +                                         &dsi->panel, &dsi->next_bridge)=
;
>         if (ret)
>                 goto err_unregister_host;
>
> --
> 2.26.2
>
