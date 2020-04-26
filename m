Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0EC55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D358C2078E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 03:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587870662;
	bh=5ufY2WNf1d+9zTXd2f3aMGdsxjO3ggnK7WB1Ct27mWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DBiL+qzJKqx1pOldQ4JUbynoToOheASaiW494e/A7EXHisXRMftBwURkLhJTsC1f/
	 AA61IF+Y0zp6x2QhpFSCU7froGIf9PYSdf6FleglePHK9odbZtfaY96NZ8a3r5iMWW
	 ky4Z3sPkUjTBc4Do6rfVSYeWDxj7VE//l/U0pcKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDZDLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 23:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgDZDLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 23:11:01 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E206E215A4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 03:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587870661;
        bh=5ufY2WNf1d+9zTXd2f3aMGdsxjO3ggnK7WB1Ct27mWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AoOgEJ/PCHpNCNceEnPC+l4jFraujO8GwZ54QALOYlUi1eslUYlJQgZFhAtDYYnI0
         bCvLruNMB2ngmXYg3t5f5++qHEQG0q1JS7kqvHCkKNSF2AF2Vnr8A183mi/bzybxgf
         /DcO8p2mpk5dVMyUGCfO9UZ3/lOPIOwXq7BD7iNk=
Received: by mail-ed1-f50.google.com with SMTP id l3so10772404edq.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 20:11:00 -0700 (PDT)
X-Gm-Message-State: AGi0PubQ9+GA/2ungjJl6/iI5b6VYf858Ll0TruHz3Q4CU1DA1PxQFzm
        09CBNDvyWqMPTVhxa7cpyYKIA9HkhFZH4Opn1Q==
X-Google-Smtp-Source: APiQypKzGcK+rktzR+tfPW/JO9EwaomlqVHqX5FQ7TR3YoCZvSXlsx8Rq/Mgm42CxzCH2NCu/qfo70XhLlXeJ46XxG8=
X-Received: by 2002:aa7:c649:: with SMTP id z9mr14002618edr.288.1587870659255;
 Sat, 25 Apr 2020 20:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200226112723.649954-1-enric.balletbo@collabora.com>
In-Reply-To: <20200226112723.649954-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 26 Apr 2020 11:10:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9tfwd-cqxkwUWXM-B7vuLZoKjF6DhFgZZM3QZp1pmCAg@mail.gmail.com>
Message-ID: <CAAOTY_9tfwd-cqxkwUWXM-B7vuLZoKjF6DhFgZZM3QZp1pmCAg@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Remove debug messages for function calls
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B42=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:27=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Equivalent information can be nowadays obtained using function tracer.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 5 -----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 2 --
>  2 files changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index a236499123aa..882c690d3f13 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -192,7 +192,6 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crt=
c *mtk_crtc)
>         int ret;
>         int i;
>
> -       DRM_DEBUG_DRIVER("%s\n", __func__);
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 ret =3D clk_prepare_enable(mtk_crtc->ddp_comp[i]->clk);
>                 if (ret) {
> @@ -212,7 +211,6 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_drm_c=
rtc *mtk_crtc)
>  {
>         int i;
>
> -       DRM_DEBUG_DRIVER("%s\n", __func__);
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++)
>                 clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
>  }
> @@ -257,7 +255,6 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *=
mtk_crtc)
>         int ret;
>         int i;
>
> -       DRM_DEBUG_DRIVER("%s\n", __func__);
>         if (WARN_ON(!crtc->state))
>                 return -EINVAL;
>
> @@ -298,7 +295,6 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *=
mtk_crtc)
>                 goto err_mutex_unprepare;
>         }
>
> -       DRM_DEBUG_DRIVER("mediatek_ddp_ddp_path_setup\n");
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
>                 mtk_ddp_add_comp_to_path(mtk_crtc->config_regs,
>                                          mtk_crtc->ddp_comp[i]->id,
> @@ -348,7 +344,6 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc =
*mtk_crtc)
>         struct drm_crtc *crtc =3D &mtk_crtc->base;
>         int i;
>
> -       DRM_DEBUG_DRIVER("%s\n", __func__);
>         for (i =3D 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 mtk_ddp_comp_stop(mtk_crtc->ddp_comp[i]);
>                 if (i =3D=3D 1)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 17f118ee0e57..4934834977b3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -570,7 +570,6 @@ static int mtk_drm_sys_suspend(struct device *dev)
>         int ret;
>
>         ret =3D drm_mode_config_helper_suspend(drm);
> -       DRM_DEBUG_DRIVER("mtk_drm_sys_suspend\n");
>
>         return ret;
>  }
> @@ -582,7 +581,6 @@ static int mtk_drm_sys_resume(struct device *dev)
>         int ret;
>
>         ret =3D drm_mode_config_helper_resume(drm);
> -       DRM_DEBUG_DRIVER("mtk_drm_sys_resume\n");
>
>         return ret;
>  }
> --
> 2.25.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
