Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22E720709
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 09:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589620377;
	bh=nImC5Lqhf3m2EzWrtneElBAhRDJ15TlDvFtmSiX6f7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=klx4UBa/BKWkA9UAnAembhjXoyhJYtw2NtARFNb6f+B4uZqhC4kdqEJDW9SdzFIeH
	 vRx2K86vc0Wd824VITSsNm5eWxUIAQvQiZscYxir71JdXr/NwGe9yPZ50OLQLHFQGS
	 3wAVquqTOdFU1raO1Cteg4WsfIxCW/mKOg2naQoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgEPJMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 05:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgEPJMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 05:12:54 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3140207D5
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589620374;
        bh=nImC5Lqhf3m2EzWrtneElBAhRDJ15TlDvFtmSiX6f7A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wbsupaP1ar8iPmoMPYJDWi5irNzvBB6pqH5pcSytYnMSwUsz02TPYvpQQ2/l0nP/E
         /g9o22SpfjLQ3NVmz2589opIlVQ4VhXTv9gIQACgziZ51GuoovNEdiMI3Zu0AQ2R4p
         LPjNZy8Sjy2viK3RRvNBSLVm2qC0nfnN+mtvv5xE=
Received: by mail-ej1-f42.google.com with SMTP id se13so4326375ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 02:12:53 -0700 (PDT)
X-Gm-Message-State: AOAM531DzTU/LysnAXJ530sFHcSHMNWcePSiVflqmJzBj7RFPylWUc/h
        1Ez9/YeGKz7glSALraCeZOk7mVuNQcxXjFVoLQ==
X-Google-Smtp-Source: ABdhPJxqXiBmi+YOlaHROm44eIZV54f3axqEuGxo7+ttRmcSCa8fZsoluwuiSKiAlI4IsRpaXMHAB1+wPGTuO+pbJpk=
X-Received: by 2002:a17:906:924a:: with SMTP id c10mr2519194ejx.360.1589620372129;
 Sat, 16 May 2020 02:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200504141408.60877-1-enric.balletbo@collabora.com> <CAAOTY_8vMG1k86V+qBhs0YH5QHELmgtJ0PNOAzWTHoTy2j=R2Q@mail.gmail.com>
In-Reply-To: <CAAOTY_8vMG1k86V+qBhs0YH5QHELmgtJ0PNOAzWTHoTy2j=R2Q@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 16 May 2020 17:12:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9PdpKTwN46ZwpnRyOw-Ky758oxX11mLer6EksZgfsXSw@mail.gmail.com>
Message-ID: <CAAOTY_9PdpKTwN46ZwpnRyOw-Ky758oxX11mLer6EksZgfsXSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Convert mtk-dpi to drm_bridge API
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:24=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Enric:
>
> Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=
=B9=B45=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:14=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > The mtk-dpi driver still uses the drm_encoder API which is now somehow
> > deprecated. We started to move all the Mediatek drivers to the drm_brid=
ge API,
> > like we did for the mtk-dsi driver [1], this is another small step to b=
e able to
> > fully convert the DRM Mediatek drivers to the drm_bridge API. A dummy
> > drm_encoder is maintained in the mtk-dpi driver but the end goal is mov=
e all the
> > dummy drm_encoder (mtk-dsi, mtk-dpi, etc) to the main mtk_drm_drv drive=
r.
>
> For this series, applied to mediatek-drm-next [1], thanks.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.gi=
t/log/?h=3Dmediatek-drm-next
>

I remove this series from mediatek-drm-next because drm bridge driver
need ack of drm bridge maintainer.

Regards,
Chun-Kuang.

> Regards,
> Chun-Kuang.
>
> >
> > Best regards,
> >  Enric
> >
> > [1] https://lore.kernel.org/patchwork/project/lkml/list/?series=3D44155=
9
> >
> > Enric Balletbo i Serra (3):
> >   drm/mediatek: mtk_dpi: Rename bridge to next_bridge
> >   drm/mediatek: mtk_dpi: Convert to bridge driver
> >   drm/mediatek: mtk_dpi: Use simple encoder
> >
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 84 ++++++++++++++----------------
> >  1 file changed, 39 insertions(+), 45 deletions(-)
> >
> > --
> > 2.26.2
> >
