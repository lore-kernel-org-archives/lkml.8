Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A2EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F50020870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593908166;
	bh=iH3aDb4sdbfsSHuXjwPQYPJDHIzy2wXOVaJjcjHJR7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IdoXO8Vj3Jqkb7VyalCA5mmIx35fJPFssrYjiw0salAeU4KopHGTsDrQ34qZgK7cU
	 HE0DLn4frNvlkofXMMECmITO1npd/SVwQV0sgKsRva8HHf6Be2JedX6dq3R5Czb4xS
	 bkG0tvUrRLoHTsZuREVm4hAQyY4UFSsg3hmZhxEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGEAPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgGEAPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:15:35 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4327A208D5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 00:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593908134;
        bh=iH3aDb4sdbfsSHuXjwPQYPJDHIzy2wXOVaJjcjHJR7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fo/T8nV8UTUf3nPFZcibQZ67/VzukqzyFnAcDMStbL5s7VdtB5HV5cZ6Qj6U4Wbrx
         0PXAfaa611CB5ksiokKPx83nI5/emE1xVDTgqmmY76bzRtjyclvLJdLq6axogE0qmN
         8Dl5YoLtQStEYxfv2PWmvSgHsQ/ii7Mta8rH98EI=
Received: by mail-ej1-f53.google.com with SMTP id n26so24788042ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 17:15:34 -0700 (PDT)
X-Gm-Message-State: AOAM5307gokFCyXVbyzuohq4kYolpld/4M5bs11bGAMtB6p2Q3tBjB47
        bmaXNlUDs+2bq7TnFduvRWX7nODz4r5oECCKgg==
X-Google-Smtp-Source: ABdhPJxQ+wC/XJRg4BJi7j8MwPEO2LRrUvPEFsb+AncSiOFdIMEvNbByzzgnJE/FF0ztSDbqe10F4PqIjLWZrCH2az8=
X-Received: by 2002:a17:906:1e83:: with SMTP id e3mr23125845ejj.7.1593908132783;
 Sat, 04 Jul 2020 17:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200615203108.786083-1-enric.balletbo@collabora.com> <20200615203108.786083-8-enric.balletbo@collabora.com>
In-Reply-To: <20200615203108.786083-8-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 08:15:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9i-ForE-kWfdi5A9QNRT2JjrFwAPYk25KupQeWwFDVSg@mail.gmail.com>
Message-ID: <CAAOTY_9i-ForE-kWfdi5A9QNRT2JjrFwAPYk25KupQeWwFDVSg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
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
> Use the drm_bridge_connector helper to create a connector for pipelines
> that use drm_bridge. This allows splitting connector operations across
> multiple bridges when necessary, instead of having the last bridge in
> the chain creating the connector and handling all connector operations
> internally.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>
> Changes in v4: None
> Changes in v3:
> - Move the bridge.type line to the patch that adds drm_bridge support. (L=
aurent Pinchart)
>
> Changes in v2: None
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 4f3bd095c1eee..471fcafdf3488 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -17,6 +17,7 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
> @@ -183,6 +184,7 @@ struct mtk_dsi {
>         struct drm_encoder encoder;
>         struct drm_bridge bridge;
>         struct drm_bridge *next_bridge;
> +       struct drm_connector *connector;
>         struct phy *phy;
>
>         void __iomem *regs;
> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_device *=
drm, struct mtk_dsi *dsi)
>          */
>         dsi->encoder.possible_crtcs =3D 1;
>
> -       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
> +       ret =3D drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>         if (ret)
>                 goto err_cleanup_encoder;
>
> +       dsi->connector =3D drm_bridge_connector_init(drm, &dsi->encoder);
> +       if (IS_ERR(dsi->connector)) {
> +               DRM_ERROR("Unable to create bridge connector\n");
> +               ret =3D PTR_ERR(dsi->connector);
> +               goto err_cleanup_encoder;
> +       }
> +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> +
>         return 0;
>
>  err_cleanup_encoder:
> --
> 2.27.0
>
