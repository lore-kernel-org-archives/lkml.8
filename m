Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CAAC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBBF2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKsYAW9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgIHKDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:03:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58063 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729094AbgIHKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599559380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Al+jB21s8k4aRrKK14DGG1BWv7CsWudzcU2+kAwpAVw=;
        b=GKsYAW9sCH8vs23An5AC3MGF/99uxsMlmOcc2JGUp0M8vUokYYtTjz+omsnbYtVOJf+99A
        sNJoR+6K7Lo82SV2cGeAL/p8jq1Zse344iPblh9PGvjWSmvOBIUHLmt+DExCAS7jTQUSV9
        o3sLmmy8tGzXbbbrVAP1m1+QidT28yU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-22mgQBftORuwdHZCpB_IfA-1; Tue, 08 Sep 2020 06:02:59 -0400
X-MC-Unique: 22mgQBftORuwdHZCpB_IfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3531091060;
        Tue,  8 Sep 2020 10:02:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C75B1002388;
        Tue,  8 Sep 2020 10:02:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id ACCE89D78; Tue,  8 Sep 2020 12:02:53 +0200 (CEST)
Date:   Tue, 8 Sep 2020 12:02:53 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
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
Message-ID: <20200908100253.b22sff23737l77bo@sirius.home.kraxel.org>
References: <20200907112425.15610-1-kraxel@redhat.com>
 <20200907112425.15610-2-kraxel@redhat.com>
 <CAKMK7uGjT73rh=9iuCKAXvC_CaOuygm8PgOQgofkTgH7wRysFw@mail.gmail.com>
 <20200908054858.um34wojjv6uhi7d3@sirius.home.kraxel.org>
 <20200908085544.GI2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908085544.GI2352366@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The comments I've found suggest very much not ... Or is that all very
> > > old stuff only that no one cares about anymore?
> > 
> > I think these days it is possible to override dma_ops per device, which
> > in turn allows virtio to deal with the quirks without the rest of the
> > kernel knowing about these details.
> > 
> > I also think virtio-gpu can drop the virtio_has_dma_quirk() checks, just
> > use the dma api path unconditionally and depend on virtio core having
> > setup dma_ops in a way that it JustWorks[tm].  I'll look into that next.
> 
> The comment above vring_use_dma_api() suggests that this has not yet
> happened, that's why I'm asking.

Hmm, wading through the code, seems it indeed happen yet, even though my
testing didn't show any issues.  Probably pure luck because devices and
cpus have the same memory view on x86.  Guess I need to try this on
ppc64 to see it actually failing ...

So dropping the virtio_has_dma_quirk() checks isn't going to fly.

Using dma_max_mapping_size() should be fine though.  It might use a
lower limit than needed for virtio, but it should not break things.

take care,
  Gerd

