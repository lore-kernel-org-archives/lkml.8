Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F84C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA33207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589815406;
	bh=yxtbYhqiBpX0vaCKJ8nincWDlOttWPQGQYeL0KqTH88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vZCDnPs17SluHaKTbNT6/Afu+pp393pdE3D4gNJJPugdS/vAOGsO1IMq2QuLOnjtr
	 p/obIgF+cmvUe1XyoYVBbrVk1I564CD/4UCxrVJnS41im+pSooJfXCjJafTzKeKQKf
	 8DoTHiNOmOoyasmG6O2hONTuiDsp+ic0OGPodYHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgERPXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgERPXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:23:25 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AFF3207D8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589815404;
        bh=yxtbYhqiBpX0vaCKJ8nincWDlOttWPQGQYeL0KqTH88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rejD3Cq3JkMBTzUozSEQ/NMDN4wNabDl16h10hnxRO/FeHWgmHuBR1gpptZvSLEmk
         MerhXjFPxqumyVcS4pDPVo779TNtQyQiVWYUsMSyf/WgUSilWfXZfG2UVY6cyEzsRH
         qEihdwS5ax4XJoPtGyu0LU44g3M2x4HNHH/cZuEo=
Received: by mail-ej1-f47.google.com with SMTP id n24so1148652ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:23:24 -0700 (PDT)
X-Gm-Message-State: AOAM532zXe9t0Si6vOa+QDwY02AGFjec2WbCeTS1FoHZ/qumgufp+13g
        hkfXWzqAskpu94aIJ+srOn6AZvi9igBGsL2iyg==
X-Google-Smtp-Source: ABdhPJx1xmRv1Gbqt6X2HaH4typf9wcXv81hsB28v44g5GQNU5bFmryX50AtKCXktDvePVh8ZZJSpwAS+KTHOyiTrIE=
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr10734314ejx.360.1589815402680;
 Mon, 18 May 2020 08:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200518112254.23692-1-matthias.bgg@kernel.org>
In-Reply-To: <20200518112254.23692-1-matthias.bgg@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 18 May 2020 23:23:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-kBsnBk3RRUb_ks96c1Cf6hJ+SeSE4T52Djoqjzxk3jA@mail.gmail.com>
Message-ID: <CAAOTY_-kBsnBk3RRUb_ks96c1Cf6hJ+SeSE4T52Djoqjzxk3jA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Delete not used of_device_get_match_data
To:     matthias.bgg@kernel.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

<matthias.bgg@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=E6=97=A5 =E9=
=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> The driver will be loaded by via a platform device. So we
> will need to get the device_node from the parent device.
> Depending on this we will set the driver data.
> As all this is done later already, just delete the call to
> of_device_get_match_data.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index e2bb0d19ef99..63ec92ba0e92 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -447,7 +447,6 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>         if (!private)
>                 return -ENOMEM;
>
> -       private->data =3D of_device_get_match_data(dev);
>         private->mmsys_dev =3D dev->parent;
>         if (!private->mmsys_dev) {
>                 dev_err(dev, "Failed to get MMSYS device\n");
> --
> 2.26.2
>
