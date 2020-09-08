Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC5C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638AB20678
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PGlAHISs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgIHIz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgIHIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:55:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A141C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:55:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so16439929wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lPf7+5yaWPR4Bsu29CBYqFns/59BDsvYdpze1XOObUQ=;
        b=PGlAHISsJbb/iYgixfJKVAK0d3OOuP3SlP2TjTpoK/oyd/DkyWjQ7j9CtU74WPEw0A
         NkxDuWQKM4W+M6eiE0fRmROTwl4OHi/jQ6z3R8Ikhb+ljBKxuSnOMNBFuSVwV7AkQa34
         kBB3vAMyk0pYZpn9c7JUOZ/xI0bfjYSUvtffY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lPf7+5yaWPR4Bsu29CBYqFns/59BDsvYdpze1XOObUQ=;
        b=O7DVOI/7QkG0mCdhBcie3FOMZ0SmphX8Ah4KAfYidc7SjVMIjcdrklM3ZvpUQCo2ke
         IHf2LsRqv7UAC8qU5jPeD1Za4HpEwe5cFaZqkv+Vqo84iRo9uOA7YHcAFp1Y0P/+cx1a
         YruUKKJIvATCf0FH6nV2vEpCHA+NVHlNKAlkrkdBCcrw/F/aqFbTtUgpYmJbdI2d5vm8
         M0Ag5kU02Nn/s2hdUHlQk5jCkCvQ+0uL1/FJXdPCMT7zI+72nECMiNRiKkU5N28/7Vpt
         Jw53rzi6yYZl+SEzfD7/ZZ/nPqBYgTP+y1j6KrkjdXz5F6o1UQECVrxvpLQSuCyQPWaV
         tj5g==
X-Gm-Message-State: AOAM5326rheC13QuPS478VP5Dv7y9stSGEVcITdmzF99KN2qA8LCeTR4
        ZDDTMVaPmf7MQnAa3X8GFEJvow==
X-Google-Smtp-Source: ABdhPJzRIgnrsr1zISzj3JMMO+qHmnUUaLRMb8phFavthqU3M8id+c7krZN538k/E4IFJZLkveZLYQ==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr3369682wmg.33.1599555347784;
        Tue, 08 Sep 2020 01:55:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l10sm30834268wru.59.2020.09.08.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:55:47 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:55:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v4 1/1] drm: allow limiting the scatter list size.
Message-ID: <20200908085544.GI2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Ben Skeggs <bskeggs@redhat.com>, Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>
References: <20200907112425.15610-1-kraxel@redhat.com>
 <20200907112425.15610-2-kraxel@redhat.com>
 <CAKMK7uGjT73rh=9iuCKAXvC_CaOuygm8PgOQgofkTgH7wRysFw@mail.gmail.com>
 <20200908054858.um34wojjv6uhi7d3@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908054858.um34wojjv6uhi7d3@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:48:58AM +0200, Gerd Hoffmann wrote:
> On Mon, Sep 07, 2020 at 03:53:02PM +0200, Daniel Vetter wrote:
> > On Mon, Sep 7, 2020 at 1:24 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Add drm_device argument to drm_prime_pages_to_sg(), so we can
> > > call dma_max_mapping_size() to figure the segment size limit
> > > and call into __sg_alloc_table_from_pages() with the correct
> > > limit.
> > >
> > > This fixes virtio-gpu with sev.  Possibly it'll fix other bugs
> > > too given that drm seems to totaly ignore segment size limits
> > > so far ...
> > >
> > > v2: place max_segment in drm driver not gem object.
> > > v3: move max_segment next to the other gem fields.
> > > v4: just use dma_max_mapping_size().
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Uh, are you sure this works in all cases for virtio?
> 
> Sure, I've tested it ;)
> 
> > The comments I've found suggest very much not ... Or is that all very
> > old stuff only that no one cares about anymore?
> 
> I think these days it is possible to override dma_ops per device, which
> in turn allows virtio to deal with the quirks without the rest of the
> kernel knowing about these details.
> 
> I also think virtio-gpu can drop the virtio_has_dma_quirk() checks, just
> use the dma api path unconditionally and depend on virtio core having
> setup dma_ops in a way that it JustWorks[tm].  I'll look into that next.

The comment above vring_use_dma_api() suggests that this has not yet
happened, that's why I'm asking. If this has happened then I think it'd be
best if you remove that todo entry and update it, as part of the overall
series to add dma_max_mapping_size and remove the quirks.

Otherwise this all is a bit wtf material :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
