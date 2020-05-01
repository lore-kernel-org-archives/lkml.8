Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 449AD20836
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588343215;
	bh=GWJwkvt0+8TQNxyG05ofo9WUCas5EChknR0I2IxYgog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JD4O3PJbL0TVEQqy5Hsn0dnhwbczIEQQF5nrETSlNRj4ghoyzS2h9pGToIdRVrNnQ
	 U/iGz2YGb3W2SJ7zNH0zA4q/n5D0TVQv6wb2mNKEWxoYnqG2hUturEKGekk+iZYDbg
	 uBvWY6Hk5Zwh5d1wNSLgmdzjeRVW7JGy4yssn6HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEAO0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgEAO0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:26:53 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE0DE2137B
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588343213;
        bh=GWJwkvt0+8TQNxyG05ofo9WUCas5EChknR0I2IxYgog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J6GWbaettKOvk+oK9TnS51EkolS6QgEhWLhlRy8UMkMDxWBHVuBv0+IIaYp3/dbh3
         HltRsMIZPGLN1o4ykQmmop96R4hv/4qpB/f5wZtLIdF6am4OujLdcpaQk45OAm3HnP
         29dXCjiaGEX2RTL6bdKguIrkBNsgDAXISfnoZx/o=
Received: by mail-ed1-f47.google.com with SMTP id t12so7377047edw.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:26:52 -0700 (PDT)
X-Gm-Message-State: AGi0PuarYxnJjkDnS/SUIMktf+u1WclrG3xLmT33NtisZ07fxj60Iiu/
        FYUTIQdvSXgo7zd9l3rBz2xlVts/MuS1qNtYfA==
X-Google-Smtp-Source: APiQypJN7wZ4G/nD2HBUrq+csPQL5onomudMxtaCzeqVlUIAwpqC80OOjadus0NF19FGaH+HaaWVunxmRN799sICD4s=
X-Received: by 2002:aa7:dcd7:: with SMTP id w23mr3810850edu.300.1588343211141;
 Fri, 01 May 2020 07:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200417150614.2631786-1-enric.balletbo@collabora.com> <20200417150614.2631786-8-enric.balletbo@collabora.com>
In-Reply-To: <20200417150614.2631786-8-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 1 May 2020 22:26:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8uWP80ZMO5ZQGLJ5YLFZcmGjZwc33Hi_oXsCPj5Yr89A@mail.gmail.com>
Message-ID: <CAAOTY_8uWP80ZMO5ZQGLJ5YLFZcmGjZwc33Hi_oXsCPj5Yr89A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] drm/mediatek: mtk_dsi: Create connector for bridges
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
> Use the drm_bridge_connector helper to create a connector for pipelines
> that use drm_bridge. This allows splitting connector operations across
> multiple bridges when necessary, instead of having the last bridge in
> the chain creating the connector and handling all connector operations
> internally.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
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
> index 157097c63b23..85f76b01ae4d 100644
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

I'm not very clear about how brige-connector works, but why connector
does not attach to panel?

Regards,
Chun-Kuang.

>         return 0;
>
>  err_cleanup_encoder:
> --
> 2.25.1
>
