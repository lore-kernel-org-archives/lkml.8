Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31962C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF9E2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588685188;
	bh=Cg3Aww/DWiRcPHXAAcy63wB+BBaJMxE4W5SjVqI52xM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XlV8cilsABaoe81OPlrxQSsf2TYWJfSsmTaf3TESw85CuPgwsnvtXtYxIf9gv2rMw
	 PmLW29jvxNWp611yjoT+X4MRMg/A4DITyrJrRQ00ikwyIdIRnY+io9915Vbf4u1gLA
	 wQVhOIJu9j1Y9QBlvL7uRDdICN8cnSTXhwdSFpns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgEEN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgEEN0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:26:19 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF83E21775
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588685179;
        bh=Cg3Aww/DWiRcPHXAAcy63wB+BBaJMxE4W5SjVqI52xM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jl6xMq65m2X3WEe5EWx7+ejjvCPFF50UyIRkX3tbpEfiDyIj1915/uLUMrzdtJfaw
         6iqUX04UY73+GzpazFnWSkIkB5sok0LeDe9adoCvV8vdgJ9jAbOWhaT/RPnEuGXDM0
         FaX+THGQl4IkBFpR2xkMR512gckbveC1akdYSSOE=
Received: by mail-ej1-f42.google.com with SMTP id rh22so1621998ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:26:18 -0700 (PDT)
X-Gm-Message-State: AGi0PubsTDV9T/1n6pfzHTw4oXnKtjerOLR8xHjeAOGcs9CIeeU+wrWy
        mRb1ZyDjSa+2Nq222co79XPRNSRx54pYmfPUpA==
X-Google-Smtp-Source: APiQypJhGBe4KM2v2+R7Tdau70M9ldxuxhIcdizZA6GeTupSyTsy4bkN4GwbSWQLG63deM2MBxQgW+u07ypp/LcOr8Q=
X-Received: by 2002:a17:906:2ad4:: with SMTP id m20mr2786571eje.324.1588685177209;
 Tue, 05 May 2020 06:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200504141408.60877-1-enric.balletbo@collabora.com> <20200504141408.60877-4-enric.balletbo@collabora.com>
In-Reply-To: <20200504141408.60877-4-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 5 May 2020 21:26:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9pFfrKjg6qD5fF0gnuj0aLG7DZh1k0htg=YZGaJE9Hww@mail.gmail.com>
Message-ID: <CAAOTY_9pFfrKjg6qD5fF0gnuj0aLG7DZh1k0htg=YZGaJE9Hww@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/mediatek: mtk_dpi: Use simple encoder
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
> The mtk_dpi driver uses an empty implementation for its encoder. Replace
> the code with the generic simple encoder.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index baad198c69eb..80778b2aac2a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -20,6 +20,7 @@
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_simple_kms_helper.h>
>
>  #include "mtk_dpi_regs.h"
>  #include "mtk_drm_ddp_comp.h"
> @@ -510,15 +511,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *=
dpi,
>         return 0;
>  }
>
> -static void mtk_dpi_encoder_destroy(struct drm_encoder *encoder)
> -{
> -       drm_encoder_cleanup(encoder);
> -}
> -
> -static const struct drm_encoder_funcs mtk_dpi_encoder_funcs =3D {
> -       .destroy =3D mtk_dpi_encoder_destroy,
> -};
> -
>  static int mtk_dpi_bridge_attach(struct drm_bridge *bridge,
>                                  enum drm_bridge_attach_flags flags)
>  {
> @@ -591,8 +583,8 @@ static int mtk_dpi_bind(struct device *dev, struct de=
vice *master, void *data)
>                 return ret;
>         }
>
> -       ret =3D drm_encoder_init(drm_dev, &dpi->encoder, &mtk_dpi_encoder=
_funcs,
> -                              DRM_MODE_ENCODER_TMDS, NULL);
> +       ret =3D drm_simple_encoder_init(drm_dev, &dpi->encoder,
> +                                     DRM_MODE_ENCODER_TMDS);
>         if (ret) {
>                 dev_err(dev, "Failed to initialize decoder: %d\n", ret);
>                 goto err_unregister;
> --
> 2.26.2
>
