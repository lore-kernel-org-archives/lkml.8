Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E49C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094AD2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596552114;
	bh=49+4jaBGejOQEj2mBMoA+n/qjCxSINfX1ZlDTF4RB9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zi5xs/VVdeFSjMN0JeJMj9VmkLEsv79SruciDfKrvcNVazay6Czk+Xe28ZEynH2zb
	 +CPwC26ETWWIo+jLRUVm1lD9PoX8C08zbCCf2sd/19pwRWwBvca/hhxclLflMHpPmk
	 KOPa/fDSF5Y2LabhHMqL/TCcNzq1fww3AryfVKww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgHDOlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHDOla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:41:30 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F0522CE3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596552089;
        bh=49+4jaBGejOQEj2mBMoA+n/qjCxSINfX1ZlDTF4RB9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SIo20VzQD1hcKkTqZ3z6GBe+Nk04OJx3rnyojyF0dO0yfKTibSzFTxzo9XexiAGpL
         7kift6qM8OTaCC660NCKLt6bJH6Yq6r+KkBvLatUZlR7pHxBD1y4RuGzEjCe+xwcIQ
         /sG0jMIKiPHNmA+iSLJKMuPh+iI8pcYgGIjtOg34=
Received: by mail-ej1-f48.google.com with SMTP id qc22so27910076ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 07:41:29 -0700 (PDT)
X-Gm-Message-State: AOAM530cwXBizKcMlLCJoOnkVjoMStT7/uBkQco6d2PLaN+eYWIp1r8b
        eO4TSeJMUWReNI2145k6a+E1fz8jeu4GTonC2w==
X-Google-Smtp-Source: ABdhPJxZ0G5jQrTt8tCKNFsHW0hKmhaebXxOjBoQebMkyIg/uoMGnJRW5xIni95vs+vqhJWTPzUYNN6/fLd4aQtB8v8=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr21013338ejb.187.1596552088025;
 Tue, 04 Aug 2020 07:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200804105849.70876-1-linux@fw-web.de> <20200804105849.70876-5-linux@fw-web.de>
In-Reply-To: <20200804105849.70876-5-linux@fw-web.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 22:41:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Nd9jTiSZPZDUj3YtuqJTWCJTR91y2xjNT6y9f4v1+aQ@mail.gmail.com>
Message-ID: <CAAOTY_-Nd9jTiSZPZDUj3YtuqJTWCJTR91y2xjNT6y9f4v1+aQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] drm/mediatek: dpi/dsi: change the getting
 possible_crtc way
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
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
> From: Jitao Shi <jitao.shi@mediatek.com>
>
> For current mediatek dsi encoder, its possible crtc is fixed in crtc
> 0, and mediatek dpi encoder's possible crtc is fixed in crtc 1. In
> some SoC the possible crtc is not fixed in this case, so call
> mtk_drm_find_possible_crtc_by_comp() to find out the correct possible
> crtc.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index d4f0fb7ad312..e43977015843 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -608,7 +608,8 @@ static int mtk_dpi_bind(struct device *dev, struct de=
vice *master, void *data)
>         drm_encoder_helper_add(&dpi->encoder, &mtk_dpi_encoder_helper_fun=
cs);
>
>         /* Currently DPI0 is fixed to be driven by OVL1 */
> -       dpi->encoder.possible_crtcs =3D BIT(1);
> +       dpi->encoder.possible_crtcs =3D
> +               mtk_drm_find_possible_crtc_by_comp(drm_dev, dpi->ddp_comp=
);
>
>         ret =3D drm_bridge_attach(&dpi->encoder, dpi->bridge, NULL, 0);
>         if (ret) {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 270bf22c98fe..c31d9c12d4a9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -892,7 +892,8 @@ static int mtk_dsi_create_conn_enc(struct drm_device =
*drm, struct mtk_dsi *dsi)
>          * Currently display data paths are statically assigned to a crtc=
 each.
>          * crtc 0 is OVL0 -> COLOR0 -> AAL -> OD -> RDMA0 -> UFOE -> DSI0
>          */
> -       dsi->encoder.possible_crtcs =3D 1;
> +       dsi->encoder.possible_crtcs =3D
> +               mtk_drm_find_possible_crtc_by_comp(drm, dsi->ddp_comp);
>
>         /* If there's a bridge, attach to it and let it create the connec=
tor */
>         if (dsi->bridge) {
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
