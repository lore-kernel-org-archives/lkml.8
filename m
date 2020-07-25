Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A505B206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 15:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GcEseSQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGYPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 11:54:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95AC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 08:54:17 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so10703876oik.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BjkiE1GN+mh3yOkUNEJsHhkZ6KsGJ1P6f7ZdAty3Jc=;
        b=GcEseSQX/ZY/yzXt4/evGDbqxoqUKrU1b7V6U1nn0kb9tbsrUu8sxbo0i1s4VGmQMY
         Z8aEue4FMAqkmS5v4Ai5Mgs4tJNYPLdnG1qzuiuCHCiabR4f1YTUb10eBP4eLChx60jD
         QJALmHTm+Oir2mxrR6e1sMTU1KxAjgf2jXVc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BjkiE1GN+mh3yOkUNEJsHhkZ6KsGJ1P6f7ZdAty3Jc=;
        b=iAnu3Fs8Rb0MORLsrp+zpzSZGMelMb6bIGNCdnHUmTjCNTXoF7XYy18M9k+9tTdsSF
         Btn8TtKETFEjxEDF+OJwVM9bdv3hNSTLbbsa6D/m8VPSglZoQZRSwJB0V6xE8MuXriEt
         P2e/Yh5i/Mp4vRhtdIc2fdhjswfcsXMqmfQnncDG3MfT7LThec4ychzrgfl8nzOP2haY
         tqyDC8O/O5n9elVmJI95oWE7Z49SKHJZe66GQKQWL581B6fIaI+1oPpN2SzchFNfMDDV
         Y0BZWAEwFe94tbFgRg4hbSP7THl3DgrDXjkRV16eDuFSx0QV7qEE/KLiRF/MxwWc4cyl
         gyTQ==
X-Gm-Message-State: AOAM533XEfRMrfb5KhFYlf0EY8aXBTJ/Kk8efXpLu9KqclKYdYmIDxo3
        5fMJhMG91KtBikrw3PEA8Vycwx4lDsq0jEZrB/wdwQPN
X-Google-Smtp-Source: ABdhPJzcQZJr/JigGR3ib8O5dLHrOjcSyBbnZtVsiMK4UbfLwAhTGKnd06RjYBUpOMABOphSdi7YP78Z440PXU0V45M=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr11568435oic.101.1595692457203;
 Sat, 25 Jul 2020 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200722181332.26995-1-knaerzche@gmail.com> <CAKMK7uGKyYea_9MamAQw2=ebjW=raYCDeFCf_5jyyJPHL9AZWA@mail.gmail.com>
 <47599ce1-2a3b-87eb-c46e-8f7f79ca945e@gmail.com>
In-Reply-To: <47599ce1-2a3b-87eb-c46e-8f7f79ca945e@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 25 Jul 2020 17:54:06 +0200
Message-ID: <CAKMK7uEn0552JuTuwpL-XdYSVk7OA=fEsphpivS8ouE-10--Zg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] drm: rockchip: various ports for older VOPs
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 3:52 PM Alex Bee <knaerzche@gmail.com> wrote:
>
>
> Am 22.07.20 um 23:43 schrieb Daniel Vetter:
> > On Wed, Jul 22, 2020 at 8:13 PM Alex Bee <knaerzche@gmail.com> wrote:
> >> Hi,
> >>
> >> this series mainly ports existining functionality to older SoCs - most
> >> importantly enables alpha blending for RK3036, RK3066, RK3126 and
> >> RK3188.
> >> Besides that, it also changes the window type from DRM_PLANE_TYPE_CURSOR
> >> to DRM_PLANE_TYPE_OVERLAY for VOPs that have only one (1) overlay window.
> > This doesn't make much sense, the cursor overlay is really just a hint
> > for legacy ioctls that this is the overlay that should be used for
> > cursors. Compositors should try to use such planes as full overlays
> > (if they don't want to use them as a cursor). So sounds like a case of
> > "fix your compositor".
> I agree here - but: If HWC windows would have been implemented in this
> particular driver, their max size would be 128x128 on some SoCs - so
> they woudn't be really suitable to create an OSD overlay at 4K, for
> example. I don't know, but I guess other vendors implement their HWC
> windows on this reduced HW resources as well. I guess that is one of the
> reasons, why userspace, which aims to be cross-plattfrom, avoids
> DRM_PLANE_TYPE_CURSOR when its looking for an usable overlay plane. (a
> heuristic, indeed)

Which userspace does that? We should fix that, not try to work around
that in all the drivers in upstream, that wont work.
-Daniel

> > For atomic there's 0 difference between a overlay or a cursor (primary
> > plane is still treated somewhat special in the RMFB ioctl, but again
> > that's for backwards compat reasons with existing uapi, not because
> > the primary plane is different).
> >
> > What does happen though is that this breaks cursor for legacy
> > userspace, which is probably not really what you want.
>
> Indeed not.
>
> Beforhand I was submiiting this, I looked arround and couldn't find
> anything which relies or even depends of a cursor window to be
> available. Even if: as per spec only one DRM_PLANE_TYPE_PRIMARY is
> mandatory, everything else is optional.
>
> > -Daniel
> >
> >
> >> Regards,
> >> Alex
> >>
> >> Changes in v2:
> >> - drop not yet upstreamed dsp_data_swap from RK3188 regs
> >> - rephrase most commit messages
> >>
> >> Alex Bee (5):
> >>    drm: rockchip: add scaling for RK3036 win1
> >>    drm: rockchip: add missing registers for RK3188
> >>    drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
> >>    drm: rockchip: set alpha_en to 0 if it is not used
> >>    drm: rockchip: use overlay windows as such
> >>
> >>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  1 +
> >>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++---
> >>   drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
> >>   3 files changed, 38 insertions(+), 6 deletions(-)
> >>
> >> --
> >> 2.17.1
> >>
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
> Best Regards
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
