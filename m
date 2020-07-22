Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5124BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019102086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lqELnH6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbgGVVnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgGVVnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:43:16 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C81DC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:43:16 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id d125so728313oob.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1t7HIxSpiPGVW8HIfsz8uFGun9cV3Lrnc1zjHDooMI=;
        b=lqELnH6haUXcDzCle4zBg4k9gYJ4kbFDCMVzzBCAbdY4yNoOnmUv00/yYP8npCFb6J
         f/7877AGDD3uB3UGQHTMGN18cYu1HyBrNoRB+9q7wqJa86XCzpFc3D5fvRJrhnDRB3ou
         lhT6TOYzeIYVJl3pRGIunfRB9Ah5D7XRQcq8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1t7HIxSpiPGVW8HIfsz8uFGun9cV3Lrnc1zjHDooMI=;
        b=SfUScKxtXJTjOq5qZ9ACIPnnlwl7lu6b5jRVmw2grSLfksLxIay9GmTQ54SojD1beK
         q839+2Qdjn5KnrYOEyYdEt5pyUVAMESKQ1UnSd3fTmXIAdXhmJ00ZcdMM6EWRuqJseGv
         25O7e4zeKhj+OYZ6nWhDMT0+D5Oro1lnw5cSVv90UqMOElhTqzSfc315Ls41FtEXh5rQ
         6sHUGOWdtQo1rnvohViiArF0/Dwc9yLic97JONsK2eXrD0JCoWtEV/lvV17sUdJEF5ND
         JlbnnKzjCY/oIsEeDC/JhXVRZnL5YDmTJK7NyhQUVzl5Po+S4faRA1ybAL22dKu6brFn
         uhOg==
X-Gm-Message-State: AOAM533777WCLbFAbBhGxS0dDL9OKAJQ6OdC+KD0EMAtA26yvT7K39mX
        wTyYTkVdxV3GlOAblDVACKe6lsyDzG8d/p6RdeOCu+1q
X-Google-Smtp-Source: ABdhPJwjGGPeDONT2CFs/OlUi7TXL081AoFouDVflV6BT6q3DATGHn0IPyzh2/J5KJpEfVEBMr7X4irba2fq0ljn80s=
X-Received: by 2002:a4a:b6c5:: with SMTP id w5mr1809420ooo.89.1595454195461;
 Wed, 22 Jul 2020 14:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200722181332.26995-1-knaerzche@gmail.com>
In-Reply-To: <20200722181332.26995-1-knaerzche@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 22 Jul 2020 23:43:04 +0200
Message-ID: <CAKMK7uGKyYea_9MamAQw2=ebjW=raYCDeFCf_5jyyJPHL9AZWA@mail.gmail.com>
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

On Wed, Jul 22, 2020 at 8:13 PM Alex Bee <knaerzche@gmail.com> wrote:
>
> Hi,
>
> this series mainly ports existining functionality to older SoCs - most
> importantly enables alpha blending for RK3036, RK3066, RK3126 and
> RK3188.
> Besides that, it also changes the window type from DRM_PLANE_TYPE_CURSOR
> to DRM_PLANE_TYPE_OVERLAY for VOPs that have only one (1) overlay window.

This doesn't make much sense, the cursor overlay is really just a hint
for legacy ioctls that this is the overlay that should be used for
cursors. Compositors should try to use such planes as full overlays
(if they don't want to use them as a cursor). So sounds like a case of
"fix your compositor".

For atomic there's 0 difference between a overlay or a cursor (primary
plane is still treated somewhat special in the RMFB ioctl, but again
that's for backwards compat reasons with existing uapi, not because
the primary plane is different).

What does happen though is that this breaks cursor for legacy
userspace, which is probably not really what you want.
-Daniel


>
> Regards,
> Alex
>
> Changes in v2:
> - drop not yet upstreamed dsp_data_swap from RK3188 regs
> - rephrase most commit messages
>
> Alex Bee (5):
>   drm: rockchip: add scaling for RK3036 win1
>   drm: rockchip: add missing registers for RK3188
>   drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
>   drm: rockchip: set alpha_en to 0 if it is not used
>   drm: rockchip: use overlay windows as such
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  1 +
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++---
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
>  3 files changed, 38 insertions(+), 6 deletions(-)
>
> --
> 2.17.1
>


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
