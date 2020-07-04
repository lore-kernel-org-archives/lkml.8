Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A319C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8F20826
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593905179;
	bh=jjLI1NVY4paYHUmIojobSDVFBbLlkvJZnfkgPCCD+YU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jXclLENg8mGXeH4+BAZeXl9at2Q8HrQjCQ1jlWTUzI8QSTzh79IAADG/brwaG1bO3
	 4bUjCmyp8sb/W15GduLD90AI/w0sQsg8MyHBMWxAp7DC0zyFXdThXVo+skKCCAfVdj
	 Ne2BMj552/R0NYQescRTaWkgb7Qub8hvb0eE1IRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgGDXVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgGDXVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:21:13 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258B4208E4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593904872;
        bh=jjLI1NVY4paYHUmIojobSDVFBbLlkvJZnfkgPCCD+YU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yobnRxgPmq/BD478RO0cvpD+xb/0uvejoPSdBkq3UdFeQZXlXNWCbRavLRi7G5jXN
         sQzEMSW1ZjA5FGsVKMmotrnmqQjs3veB0rUTXS3WX/0QqQ3GXePLVhnFNp/qvg6VcM
         F6HZF0bXrQC8k6Ip8al9F+afQl6w//5t6MLwFunM=
Received: by mail-ej1-f44.google.com with SMTP id n26so24598719ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:21:12 -0700 (PDT)
X-Gm-Message-State: AOAM533aE1heT7Xk+VuiKGBnrPJUNZFMb8DWXdYicgfaHXHvDcGjw19O
        uCQ4bjaDlTlVngYxWPlDTQ62CTUvFavUqMkZsA==
X-Google-Smtp-Source: ABdhPJzSJ1ZWbwUWJLnVTcfoYRxGdqUMKJzrzedJHWFE7nqUV7raFr7/mAlCkHNtCxHv7UjgUk/yH0v2MF8C9pKav+U=
X-Received: by 2002:a17:906:1e83:: with SMTP id e3mr23006232ejj.7.1593904870633;
 Sat, 04 Jul 2020 16:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com> <20200615203108.786083-4-enric.balletbo@collabora.com>
In-Reply-To: <20200615203108.786083-4-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 07:20:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_89jeRvdv01batww9+bY0XWabvQ8xnEOEVCgsPimJ6WWg@mail.gmail.com>
Message-ID: <CAAOTY_89jeRvdv01batww9+bY0XWabvQ8xnEOEVCgsPimJ6WWg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 3/7] drm/mediatek: mtk_dsi: Rename bridge to next_bridge
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
> This is really a cosmetic change just to make a bit more readable the
> code after convert the driver to drm_bridge. The bridge variable name
> will be used by the encoder drm_bridge, and the chained bridge will be
> named next_bridge.
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
> - Replace s/bridge/next bridge/ for comment. (Laurent Pinchart)
>
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 270bf22c98feb..208f49bf14a01 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -183,7 +183,7 @@ struct mtk_dsi {
>         struct drm_encoder encoder;
>         struct drm_connector conn;
>         struct drm_panel *panel;
> -       struct drm_bridge *bridge;
> +       struct drm_bridge *next_bridge;
>         struct phy *phy;
>
>         void __iomem *regs;
> @@ -894,9 +894,10 @@ static int mtk_dsi_create_conn_enc(struct drm_device=
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
> @@ -1177,7 +1178,7 @@ static int mtk_dsi_probe(struct platform_device *pd=
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
> 2.27.0
>
