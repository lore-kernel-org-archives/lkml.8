Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEAC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1319620885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593901164;
	bh=9v1dX1d5CT4OlZG432LBpmp+z8QjBxiwBh7CgA1A544=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s8ZrHUQtFZRevLneqwlCTWMlzwUJ/0CcZYaeyRVXuEwRyBaV4gm5p7/vSp4BskYg4
	 Kg/2Di5hU/MMbIh6wkkJk/V0PnDX9VBAv6kfgZNxhMB8vISb3YB0UQ8/Bw1/PGLCze
	 XQT0Kb9rdkqU52jgC7aBfRPWq31Z8W+ynztwxFiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGDWTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 18:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgGDWTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 18:19:21 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28AF620826
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593901161;
        bh=9v1dX1d5CT4OlZG432LBpmp+z8QjBxiwBh7CgA1A544=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=se3OQJClKKjKhYoH9WhQiUxEFZX2L1NvaCCUMqtw7TdurqgGX58PSFP4Skgh6Vvju
         vh4aaV/eWxRDjkmOCifgaTNdIJMHSYciq6XCi2nR+4YsxXKzZYgzkWkdfIIR/oAscc
         tkMswjD4s1D410+EJomp69qFD7gFMMT8MZv//3+w=
Received: by mail-ej1-f43.google.com with SMTP id w6so38400097ejq.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 15:19:21 -0700 (PDT)
X-Gm-Message-State: AOAM531jAZztFQacgBf+iZEBL7DMXMHiQS+i+MMbRwbXCxCLsTOxQHyM
        0VrZoXyXsPD0FRU4E0crFUb12YEMk6uOQIkYIw==
X-Google-Smtp-Source: ABdhPJzpbnPFMQGBtbgHPK/mpFFqynZ8/TPSZmE0VOmdWVSRLcQBDhVy6aNOzos4UlWBPw4oa0qmR7WsUfFu23y1s4M=
X-Received: by 2002:a17:906:856:: with SMTP id f22mr36036089ejd.245.1593901159756;
 Sat, 04 Jul 2020 15:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200518112254.23692-1-matthias.bgg@kernel.org>
In-Reply-To: <20200518112254.23692-1-matthias.bgg@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 5 Jul 2020 06:19:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9gcFvNv26FgKHwN7cxha57sDJ8dzvmBKf-vtUx82YcoA@mail.gmail.com>
Message-ID: <CAAOTY_9gcFvNv26FgKHwN7cxha57sDJ8dzvmBKf-vtUx82YcoA@mail.gmail.com>
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

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
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
