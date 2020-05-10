Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B840C47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59090208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589073881;
	bh=VDbINtk/hHh41cZphTvVQ8Ky+q+Za8dszq3rcDCuDgg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=19HhXUwUit0Wtbbn7qAy2Qu6crwqKcG2NB2jPtRgOF03L9P0omyjH6j3AVmqb7xdv
	 difdTFGFAvgfNZCg88dsw7765Ns80Lg0XqO8IhMZ69cDDdsZRuzy3FnI5oGq0xHbyB
	 4/aYxN9vd/sEyjPJj8nemZLF83IiCQkv75G81cAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgEJBYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgEJBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:24:40 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 379C62495E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589073879;
        bh=VDbINtk/hHh41cZphTvVQ8Ky+q+Za8dszq3rcDCuDgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2s5RwkcCgY+7iBY9+BSxiC+PdZ3wCBfzORu1ikUu7+4VooqNCZ3Tp2S4MfpDzYqxD
         /Aiv27Fw5wwj6oC2C5Q0YbYIiWsI04Mf0rUOHlM+gZOIGafmPPxIGvmo/ldBlY9SzS
         bmWdTDX7rnr0Tn4kc9+cT7MdRhvcIb9g4jkIxy7M=
Received: by mail-ej1-f51.google.com with SMTP id n17so4779106ejh.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 18:24:39 -0700 (PDT)
X-Gm-Message-State: AGi0PuYEcpL/lwjE2cc+tylixmHaFR02Xk58LiSOzG8SPNVazUoCKPKl
        CKviAwPtTT1lRJE3b8SBtGGECtX1KxzhMo/vGQ==
X-Google-Smtp-Source: APiQypJQq9WhDnA9jUZbUiITcFvF3ELgL4vCwkLG+ADbvWTfS2qBr5SHAnlXV3hHEHN/KVbA4TLWtj15E1RhlIcsNFA=
X-Received: by 2002:a17:906:7717:: with SMTP id q23mr7983742ejm.38.1589073877528;
 Sat, 09 May 2020 18:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200504141408.60877-1-enric.balletbo@collabora.com>
In-Reply-To: <20200504141408.60877-1-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 10 May 2020 09:24:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8vMG1k86V+qBhs0YH5QHELmgtJ0PNOAzWTHoTy2j=R2Q@mail.gmail.com>
Message-ID: <CAAOTY_8vMG1k86V+qBhs0YH5QHELmgtJ0PNOAzWTHoTy2j=R2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Convert mtk-dpi to drm_bridge API
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
> The mtk-dpi driver still uses the drm_encoder API which is now somehow
> deprecated. We started to move all the Mediatek drivers to the drm_bridge=
 API,
> like we did for the mtk-dsi driver [1], this is another small step to be =
able to
> fully convert the DRM Mediatek drivers to the drm_bridge API. A dummy
> drm_encoder is maintained in the mtk-dpi driver but the end goal is move =
all the
> dummy drm_encoder (mtk-dsi, mtk-dpi, etc) to the main mtk_drm_drv driver.

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Best regards,
>  Enric
>
> [1] https://lore.kernel.org/patchwork/project/lkml/list/?series=3D441559
>
> Enric Balletbo i Serra (3):
>   drm/mediatek: mtk_dpi: Rename bridge to next_bridge
>   drm/mediatek: mtk_dpi: Convert to bridge driver
>   drm/mediatek: mtk_dpi: Use simple encoder
>
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 84 ++++++++++++++----------------
>  1 file changed, 39 insertions(+), 45 deletions(-)
>
> --
> 2.26.2
>
