Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D2C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D797820848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 23:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598571180;
	bh=CxkE/q++Eo2vJZXF0frHIrwwj8Su9GHTDl44/EylMxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K2Mq/dE0b2SLY/KG+qgXZtq6CEBD+EFQW1qvU6nNuRoL2/8LxZGd4ScOUtOrveXqZ
	 NG9BnY1Srz6nybrp0rf4Ah3z2exq3UwrkTaCNX/kbEmEw1k4kvXVzro2ad78ZuNhJf
	 ns3wXyp9fjYuMw4MN/P0p2hA/O8CO2vLDGuE8qPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgH0Xc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0Xc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 19:32:59 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B49320872
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598571178;
        bh=CxkE/q++Eo2vJZXF0frHIrwwj8Su9GHTDl44/EylMxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0INqP1XWALFFZC20VHK8xYB2tSGPjASUk4GIkFKOcvuFubYdz5GfetLVTTTBWPFBU
         PdqSaWjRJGPExZnMjjlZ3Q8OwLC8eMfWLP0qCGJOz8LSo4eWkthsMxP8ZGCF3ZoFsJ
         dZ9gjHsPJ6BSUjnhwXkmUIajxFUVWdeop8pHEDPw=
Received: by mail-ed1-f47.google.com with SMTP id l63so6416476edl.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 16:32:58 -0700 (PDT)
X-Gm-Message-State: AOAM531Sgj5pKNbSxCqmbvYWC0zSaysIJSHN+jbBMLT4mWa4gL38/oMj
        W2JOHMuL2AQLerMgkWlkLOjMh8qpryoO0wsusg==
X-Google-Smtp-Source: ABdhPJwTJAXoXtZdq1zZz3alAlq9lDJ0l2Ct9XsjXhjUW3fXtj711OBC1IZNyN5F5962joWUZrBnuIu2GzAzLaEVIWs=
X-Received: by 2002:a05:6402:17d8:: with SMTP id s24mr21170877edy.61.1598571176689;
 Thu, 27 Aug 2020 16:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200819081752.4805-1-linux@fw-web.de> <20200819081752.4805-3-linux@fw-web.de>
In-Reply-To: <20200819081752.4805-3-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 28 Aug 2020 07:32:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY__SVKF=9CDeyHyKoAZ1fhRK+R0y0S5wMYz+ovqRN8Xtjw@mail.gmail.com>
Message-ID: <CAAOTY__SVKF=9CDeyHyKoAZ1fhRK+R0y0S5wMYz+ovqRN8Xtjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/mediatek: add ddp routing for mt7623
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> on BPi-R2/mt7623 main-path have to be routed to DPI0 (hdmi) instead of DS=
I0
> using compatible "mt7623-mmsys" already defined in dts
>

For this patch, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 040a8f393fe2..2350e3200b59 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -74,6 +74,19 @@ static const enum mtk_ddp_comp_id mt2701_mtk_ddp_ext[]=
 =3D {
>         DDP_COMPONENT_DPI0,
>  };
>
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
>  static const enum mtk_ddp_comp_id mt2712_mtk_ddp_main[] =3D {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_COLOR0,
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
