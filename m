Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D1C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F083F249B0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586192226;
	bh=d5WwVLVFEz/qBX2k9G3pvY8aj9ZG4dDXgjdXesFl72Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XQ100UcCuhSb/PN7uyUfMYMhEWD486c8JcVJsxVcIIncUoTZN+/zsMOr8J/ZKYM3Y
	 +U9eZ4RMcHmHYsXZEgN/gtKr3w0wou7IGF2zksBBaxpIERqeFULkMegPu0wT+hZP1G
	 8ddBHjgxEzk5dMZtx+/QXkVDoxrb/3xd0XJzqvos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgDFQ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgDFQ5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:57:04 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA6CB249B0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Apr 2020 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586192224;
        bh=d5WwVLVFEz/qBX2k9G3pvY8aj9ZG4dDXgjdXesFl72Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2b11M1QLOY7iK7uifO5nBAZ8bvKGbtsHtmiUXVepu4nMWJ0lllOwDjh4fNH5CYNy4
         vTkOZImNQDJ1CeOeKd3mhstdA7JBPeI9Urm+N6WZdTlN5YpCWrl59BsDqKRB5mTpmF
         QPESExpSgygqg6+fcOb//HQ/dAxJr5jzbnaJ5orw=
Received: by mail-ed1-f46.google.com with SMTP id cw6so333692edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:57:03 -0700 (PDT)
X-Gm-Message-State: AGi0PubauVRZbAK6Gna+N5rAcE4WqA+Ycka7c33gxakoKTFc4688K3g/
        6x3dfssnC/twuCKs67lYaiWRT2WIjHnjutxg9Q==
X-Google-Smtp-Source: APiQypJ/iPGF+cvIgkUgfRfcgINI0hY5iZiKWnX6gcKA9lAMAGbU4+kz269vsFd53VBSCqsVJta4Qo1yoqmPd7O1bkg=
X-Received: by 2002:a05:6402:b70:: with SMTP id cb16mr19702151edb.48.1586192222144;
 Mon, 06 Apr 2020 09:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200406051131.225748-1-hsinyi@chromium.org>
In-Reply-To: <20200406051131.225748-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 7 Apr 2020 00:56:49 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9zKbSsYmq7BrQdu3h1zTNYcX3WiFjGaiB1=x8eUA4ogg@mail.gmail.com>
Message-ID: <CAAOTY_9zKbSsYmq7BrQdu3h1zTNYcX3WiFjGaiB1=x8eUA4ogg@mail.gmail.com>
Subject: Re: [PATCH] drm: mediatek: fix device passed to cmdq
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B44=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:12=E5=AF=AB=E9=81=93=EF=BC=9A
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
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 6 ++++--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 3 ++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index 615a54e60fe2..8621f0289399 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -822,14 +822,16 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
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
>                         drm_crtc_index(&mtk_crtc->base));
>                 mtk_crtc->cmdq_client =3D NULL;
>         }
> -       ret =3D of_property_read_u32_index(dev->of_node, "mediatek,gce-ev=
ents",
> +       ret =3D of_property_read_u32_index(mtk_crtc->mmsys_dev->of_node,
> +                                        "mediatek,gce-events",
>                                          drm_crtc_index(&mtk_crtc->base),
>                                          &mtk_crtc->cmdq_event);
>         if (ret)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index e2bb0d19ef99..dc78e86bccc0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -517,7 +517,8 @@ static int mtk_drm_probe(struct platform_device *pdev=
)
>                                 goto err_node;
>                         }
>
> -                       ret =3D mtk_ddp_comp_init(dev, node, comp, comp_i=
d, NULL);
> +                       ret =3D mtk_ddp_comp_init(dev->parent, node, comp=
,
> +                                               comp_id, NULL);
>                         if (ret) {
>                                 of_node_put(node);
>                                 goto err_node;
> --
> 2.26.0.292.g33ef6b2f38-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
