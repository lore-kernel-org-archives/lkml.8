Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F415C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5069A22525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgATRsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:48:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51595 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:48:04 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1itb9b-0004hc-84; Mon, 20 Jan 2020 18:47:59 +0100
Message-ID: <aaf2f587a61dee42c25805c3fe7916bed4dbd0c3.camel@pengutronix.de>
Subject: Re: [PATCH v2 13/24] drm/etnaviv: reject timeouts with tv_nsec >=
 NSEC_PER_SEC
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, y2038@lists.linaro.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Mon, 20 Jan 2020 18:47:56 +0100
In-Reply-To: <20200117154726.GA328525@bogon.m.sigxcpu.org>
References: <20191213204936.3643476-1-arnd@arndb.de>
         <20191213205417.3871055-4-arnd@arndb.de>
         <20200117154726.GA328525@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2020-01-17 at 16:47 +0100, Guido Günther wrote:
> Hi,
> On Fri, Dec 13, 2019 at 09:53:41PM +0100, Arnd Bergmann wrote:
> > Most kernel interfaces that take a timespec require normalized
> > representation with tv_nsec between 0 and NSEC_PER_SEC.
> > 
> > Passing values larger than 0x100000000ull further behaves differently
> > on 32-bit and 64-bit kernels, and can cause the latter to spend a long
> > time counting seconds in timespec64_sub()/set_normalized_timespec64().
> > 
> > Reject those large values at the user interface to enforce sane and
> > portable behavior.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > index 1f9c01be40d7..95d72dc00280 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -297,6 +297,9 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
> >  	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
> >  		return -EINVAL;
> >  
> > +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> >  	obj = drm_gem_object_lookup(file, args->handle);
> >  	if (!obj)
> >  		return -ENOENT;
> > @@ -360,6 +363,9 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
> >  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
> >  		return -EINVAL;
> >  
> > +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> >  	if (args->pipe >= ETNA_MAX_PIPES)
> >  		return -EINVAL;
> >  
> > @@ -411,6 +417,9 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
> >  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
> >  		return -EINVAL;
> >  
> > +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> > +		return -EINVAL;
> > +
> >  	if (args->pipe >= ETNA_MAX_PIPES)
> >  		return -EINVAL;
> > 
> 
> This breaks rendering here on arm64/gc7000 due to
> 
> ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> 
> This is due to
> 
>     get_abs_timeout(&req.timeout, 5000000000);
> 
> in etna_bo_cpu_prep which can exceed NSEC_PER_SEC.
> 
> Should i send a patch to revert that change since it breaks existing userspace?

No need to revert. This patch has not been applied to the etnaviv tree
yet, I guess it's just in one of Arnds branches feeding into -next.

That part of userspace is pretty dumb, as it misses to renormalize
tv_nsec when it overflows the second boundary. So if what I see is
correct it should be enough to allow 2 * NSEC_PER_SEC, which should
both reject broken large timeout and keep existing userspace working.

Regards,
Lucas

