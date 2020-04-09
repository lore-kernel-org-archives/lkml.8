Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6078C21927
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586448638;
	bh=fVvP6SUlDpMc2d96/92LswakbtL1VsS55y5+h6rpY3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XGCv6M+mz0hWJBkV1oAgUBmnrGGCdbG4CzlekMtYILBsQrj8giQ7VrO4wiKclOooU
	 7MGf+dqH7se1POHVwi1OzA7NjxCGZMO82/PFHWpjgLMsEQClnCaXLPXPc0AEDusbRo
	 7He1vcVyJEkwrCvdbXDujWVZjBdtSREe30NDvgqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgDIQKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgDIQKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:10:36 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8719B21974
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586448635;
        bh=fVvP6SUlDpMc2d96/92LswakbtL1VsS55y5+h6rpY3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPmvECc5MbxkT11rQVdweMo1GgfsCfCfDNCAb+WP6gNKjHVsXFd+wiq5nPbJM9rWR
         oi1Y8TrzMQpsHiTJWSKQNwJn8sKA2SuCvEjBpTUxBVMMbVi3lgg7w7wPBJkyGWuq1j
         1gKHuIJqTuvJ+4FER8B1iIS7N5fmmYGhXzW7f7oU=
Received: by mail-ed1-f49.google.com with SMTP id i7so444933edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:10:35 -0700 (PDT)
X-Gm-Message-State: AGi0PuYPlYCk2Gh/OR0bZXoO5dXk5uzVdJLHDY3CExOS1+Kgn1VL77d1
        UNTr60izZqTze+nD1hYqEkU0oeUkEQMKgj+Y5w==
X-Google-Smtp-Source: APiQypL+qKD7yHrEW+JUzCaJa3ePCbbv5DvvhgZrZM52zY343hHolUioqNBoHQwpr2Z/SpKf/sp3enrttnW+5MQ39NE=
X-Received: by 2002:a05:6402:335:: with SMTP id q21mr720860edw.47.1586448633893;
 Thu, 09 Apr 2020 09:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200409060209.202677-1-hsinyi@chromium.org>
In-Reply-To: <20200409060209.202677-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 10 Apr 2020 00:10:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9hOoW754+sFmr_cCf+kU7H2qv261Me777dcccKv5LFwg@mail.gmail.com>
Message-ID: <CAAOTY_9hOoW754+sFmr_cCf+kU7H2qv261Me777dcccKv5LFwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm: mediatek: fix device passed to cmdq
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B44=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> drm device is now probed from mmsys. We need to use mmsys device to get g=
ce
> nodes. Fix following errors:
>
> [    0.740068] mediatek-drm mediatek-drm.1.auto: error -2 can't parse gce=
-client-reg property (0)
> [    0.748721] mediatek-drm mediatek-drm.1.auto: error -2 can't parse gce=
-client-reg property (0)
> ...
> [    2.659645] mediatek-drm mediatek-drm.1.auto: failed to request channe=
l
> [    2.666270] mediatek-drm mediatek-drm.1.auto: failed to request channe=
l

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 1d367541aded ("soc / drm: mediatek: Fix mediatek-drm device probin=
g")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> The patch is based on
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
> branch v5.6-next/soc
>
> Change log:
> v1->v2:
> align with 60fa8c13ab1a ("drm/mediatek: Move gce event property to mutex =
device node")
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 ++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 615a54e60fe2..7247c6f87f4a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -822,7 +822,8 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         mtk_crtc->cmdq_client =3D
> -                       cmdq_mbox_create(dev, drm_crtc_index(&mtk_crtc->b=
ase),
> +                       cmdq_mbox_create(mtk_crtc->mmsys_dev,
> +                                        drm_crtc_index(&mtk_crtc->base),
>                                          2000);
>         if (IS_ERR(mtk_crtc->cmdq_client)) {
>                 dev_dbg(dev, "mtk_crtc %d failed to create mailbox client=
, writing register by CPU now\n",
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index e2bb0d19ef99..28418e5b83ee 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -517,7 +517,7 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>                                 goto err_node;
>                         }
>
> -                       ret =3D mtk_ddp_comp_init(dev, node, comp, comp_i=
d, NULL);
> +                       ret =3D mtk_ddp_comp_init(dev->parent, node, comp=
, comp_id, NULL);
>                         if (ret) {
>                                 of_node_put(node);
>                                 goto err_node;
> --
> 2.26.0.292.g33ef6b2f38-goog
>
