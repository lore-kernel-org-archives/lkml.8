Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA5C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2997F21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgATPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:05:17 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53830 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgATPFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:05:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A5C71FB02;
        Mon, 20 Jan 2020 16:05:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8znXPdI71quQ; Mon, 20 Jan 2020 16:05:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id ED37240007; Fri, 17 Jan 2020 16:47:26 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:47:26 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v2 13/24] drm/etnaviv: reject timeouts with tv_nsec >=
 NSEC_PER_SEC
Message-ID: <20200117154726.GA328525@bogon.m.sigxcpu.org>
References: <20191213204936.3643476-1-arnd@arndb.de>
 <20191213205417.3871055-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213205417.3871055-4-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Dec 13, 2019 at 09:53:41PM +0100, Arnd Bergmann wrote:
> Most kernel interfaces that take a timespec require normalized
> representation with tv_nsec between 0 and NSEC_PER_SEC.
> 
> Passing values larger than 0x100000000ull further behaves differently
> on 32-bit and 64-bit kernels, and can cause the latter to spend a long
> time counting seconds in timespec64_sub()/set_normalized_timespec64().
> 
> Reject those large values at the user interface to enforce sane and
> portable behavior.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 1f9c01be40d7..95d72dc00280 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -297,6 +297,9 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
>  	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
>  		return -EINVAL;
>  
> +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> +		return -EINVAL;
> +
>  	obj = drm_gem_object_lookup(file, args->handle);
>  	if (!obj)
>  		return -ENOENT;
> @@ -360,6 +363,9 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
>  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
>  		return -EINVAL;
>  
> +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> +		return -EINVAL;
> +
>  	if (args->pipe >= ETNA_MAX_PIPES)
>  		return -EINVAL;
>  
> @@ -411,6 +417,9 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
>  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
>  		return -EINVAL;
>  
> +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> +		return -EINVAL;
> +
>  	if (args->pipe >= ETNA_MAX_PIPES)
>  		return -EINVAL;
>

This breaks rendering here on arm64/gc7000 due to

ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0

This is due to

    get_abs_timeout(&req.timeout, 5000000000);

in etna_bo_cpu_prep which can exceed NSEC_PER_SEC.

Should i send a patch to revert that change since it breaks existing userspace?

Cheers,
 -- Guido

> -- 
> 2.20.0
> 
> _______________________________________________
> etnaviv mailing list
> etnaviv@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/etnaviv
> 
