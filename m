Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D935AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B46082065C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596551813;
	bh=msyy9aG35H4DSGIygANUzGiwZ9bmaHBVupY0hOPK2nA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MRfCPHkeUviam606ol+7sbACBLgosKfV1fxZTIXLMZe1bMhzJq+DLtB9jSwhJC1Im
	 8oOPymq/QRCiZ5f0P9LTk2ww8roY85nenxcWiPnpsyYK2Vy4D3O5FkRkragqo8ubFZ
	 GT8wTl+4zT+kkqJV/yV1CHSouOlnF8R1SICpahr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHDOgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHDOfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:35:04 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57BF322D0B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596551703;
        bh=msyy9aG35H4DSGIygANUzGiwZ9bmaHBVupY0hOPK2nA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=INn72nCnUGfrwDf/6D76PRUMF4gh/ThIG+NjSmuyJEdM2wunn48TfTl7XUWx5gt4/
         G12DNFSI9KhHI6U2jb50EL35hvUSFb9I+5ZtGF7XWjcPOgvVR0rhI0QOE0Ic0RsVuW
         6zf43KDoWpiNSUXYFszZaAyXWhVUfEgU2maMm2pY=
Received: by mail-ed1-f50.google.com with SMTP id i26so26721236edv.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:35:03 -0700 (PDT)
X-Gm-Message-State: AOAM531LvisKj/PrauXDO1YoONcxH9TFfSSGmMIt8vzrrhFU5YsqVmp9
        zKrRX14IH4Mc7NiL+UvNjGtNXF9iIquHw2Mt3g==
X-Google-Smtp-Source: ABdhPJxtAkBWkUbp57xqa5KFEP+7l8fLYyFpHi+fJGBL3okYbOQpXuKQ7hFcornheF7wFTIcTsqN1xDf/iN0Ar3JdVQ=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr21504828edv.271.1596551701677;
 Tue, 04 Aug 2020 07:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200804105849.70876-1-linux@fw-web.de> <20200804105849.70876-2-linux@fw-web.de>
In-Reply-To: <20200804105849.70876-2-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 22:34:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_94Kt3Z4FhB+1Chca-tanzY1Xwun8D2ZQ09Y7p7+Jw40Q@mail.gmail.com>
Message-ID: <CAAOTY_94Kt3Z4FhB+1Chca-tanzY1Xwun8D2ZQ09Y7p7+Jw40Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] drm: mediatek: add ddp routing for mt7623
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> on BPi-R2/mt7623 main-path have to be routed to DPI0 (hdmi) instead of DS=
I0
> using compatible "mt7623-mmsys" already defined in dts
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 6bd369434d9d..9e418b83be48 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -74,7 +74,20 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[]=
 =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
> -static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
> +static const enum mtk_ddp_comp_id mt7623_mtk_ddp_main[] =3D {
> +       DDP_COMPONENT_OVL0,
> +       DDP_COMPONENT_RDMA0,
> +       DDP_COMPONENT_COLOR0,
> +       DDP_COMPONENT_BLS,
> +       DDP_COMPONENT_DPI0,
> +};
> +
> +static const enum mtk_ddp_comp_id mt7623_mtk_ddp_ext[] =3D {
> +       DDP_COMPONENT_RDMA1,
> +       DDP_COMPONENT_DSI0,
> +};
> +
> +static enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {

Why do you remove 'const'?

>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_COLOR0,
>         DDP_COMPONENT_AAL0,
> @@ -127,6 +140,14 @@ static const struct mtk_mmsys_driver_data mt2701_mms=
ys_driver_data =3D {
>         .shadow_register =3D true,
>  };
>
> +static const struct mtk_mmsys_driver_data mt7623_mmsys_driver_data =3D {
> +       .main_path =3D mt7623_mtk_ddp_main,
> +       .main_len =3D ARRAY_SIZE(mt7623_mtk_ddp_main),
> +       .ext_path =3D mt7623_mtk_ddp_ext,
> +       .ext_len =3D ARRAY_SIZE(mt7623_mtk_ddp_ext),
> +       .shadow_register =3D true,
> +};
> +
>  static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data =3D {
>         .main_path =3D mt2712_mtk_ddp_main,
>         .main_len =3D ARRAY_SIZE(mt2712_mtk_ddp_main),
> @@ -422,6 +443,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[=
] =3D {
>  static const struct of_device_id mtk_drm_of_ids[] =3D {
>         { .compatible =3D "mediatek,mt2701-mmsys",
>           .data =3D &mt2701_mmsys_driver_data},
> +       { .compatible =3D "mediatek,mt7623-mmsys",
> +         .data =3D &mt7623_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt2712-mmsys",
>           .data =3D &mt2712_mmsys_driver_data},
>         { .compatible =3D "mediatek,mt8173-mmsys",
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
