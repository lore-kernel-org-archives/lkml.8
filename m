Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1361622B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596582122;
	bh=G0QXhj8uvE6uFG6LEZRUpWEjC9R2zkgt7jzZ8pwDd9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oMt7mpRJDw+a0w+eM1ZKCBFGcuLDorK8AxhMeqzWc+lJexdDLZ3BNGyPTvNF6egso
	 N9tyfy6J3HwxW+Aop/HBYfSSwuBOdWJZcSzjS/OOF93n3qGHl5ugnsArcFhfUXhO7Z
	 Nqb96xA9uMO5E0O3s+QiWNPWY2ZrGm+PengZ+KAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHDXCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgHDXB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:01:59 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8BC622B45
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 23:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596582119;
        bh=G0QXhj8uvE6uFG6LEZRUpWEjC9R2zkgt7jzZ8pwDd9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CAEtWlpJUCItzCh0R85X2nUmruZ3t3Ig3+reCj6xaQeikD1+DGcFEWHZb85MDCrIX
         7/xVZw/mxS+fQsvaHRl8suTRwNYGM85ckttn036gSG26IjnYeI/kBXaOW9BIzkcYH5
         EVFouvvLMRXFZF241KforHyr19RuJfcTkEsiQVhY=
Received: by mail-ed1-f50.google.com with SMTP id c15so21426365edj.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:01:58 -0700 (PDT)
X-Gm-Message-State: AOAM530nE86r41eFE7CaKrBz9Tur3QdmcuWJ8z9lZqJWfEYA2hS2fyaz
        r7FBJWbeCV2FTtRdZnBKCIsPrcghP00udY7NaA==
X-Google-Smtp-Source: ABdhPJyiqhWgjKSgZozGPp1jl9K0B7+yb2PKS2guwR3ob296qpnBATjzZoDka004lYrqOD1qk897url6EerXEvu419k=
X-Received: by 2002:a50:e109:: with SMTP id h9mr207114edl.47.1596582117170;
 Tue, 04 Aug 2020 16:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200804165555.75159-1-linux@fw-web.de> <20200804165555.75159-4-linux@fw-web.de>
In-Reply-To: <20200804165555.75159-4-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 5 Aug 2020 07:01:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8VB6wkKLCAcJtwbhzOxN8R3=FzdJhab5NzmpOxyLEmeg@mail.gmail.com>
Message-ID: <CAAOTY_8VB6wkKLCAcJtwbhzOxN8R3=FzdJhab5NzmpOxyLEmeg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] drm/mediatek: add ddp routing for mt7623
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <linux@fw-web.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> on BPi-R2/mt7623 main-path have to be routed to DPI0 (hdmi) instead of DS=
I0
> using compatible "mt7623-mmsys" already defined in dts

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 6bd369434d9d..11e3752c670d 100644
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
