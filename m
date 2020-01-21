Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CEC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144BF217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgAUQKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:10:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50579 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:10:11 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1itw6K-00023c-2Z; Tue, 21 Jan 2020 17:10:00 +0100
Message-ID: <1971902c68ff805ee0b4a66f558afe06e6edf0c5.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2
 seconds
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 Jan 2020 17:09:56 +0100
In-Reply-To: <20200121125546.GA71415@bogon.m.sigxcpu.org>
References: <20200121114553.2667556-1-arnd@arndb.de>
         <20200121125546.GA71415@bogon.m.sigxcpu.org>
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

Hi Guido,

On Di, 2020-01-21 at 13:55 +0100, Guido Günther wrote:
> Hi,
> On Tue, Jan 21, 2020 at 12:45:25PM +0100, Arnd Bergmann wrote:
> > As Guido Günther reported, get_abs_timeout() in the etnaviv user space
> > sometimes passes timeouts with nanosecond values larger than 1000000000,
> > which gets rejected after my first patch.
> > 
> > To avoid breaking this, while also not allowing completely arbitrary
> > values, set the limit to 1999999999 and use set_normalized_timespec64()
> > to get the correct format before comparing it.
> 
> I'm seeing values up to 5 seconds so I need
> 
>      if (args->timeout.tv_nsec > (5 * NSEC_PER_SEC))
> 
> to unbreak rendering. Which seems to match what mesa's get_abs_timeout()
> does and how it's invoked.

I have not tested this myself yet, only looked at the code. From the
code I quoted earlier, I don't see how we end up with 5 * NSEC_PER_SEC
in the tv_nsec member, even if the timeout passed to get_abs_timeout()
is 5 seconds.

Regards,
Lucas

>    with that:
> 
> Tested-by: Guido Günther <agx@sigxcpu.org>
> 
> Cheers,
>  -- Guido
> 
> > This also addresses the off-by-1 glitch reported by Ben Hutchings.
> > 
> > Fixes: 172a216ff334 ("drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC")
> > Cc: Guido Günther <agx@sigxcpu.org>
> > Link: https://patchwork.kernel.org/patch/11291089/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.h |  6 ++----
> >  2 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > index 3eb0f9223bea..d94740c123d3 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -292,7 +292,11 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
> >  	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
> >  		return -EINVAL;
> >  
> > -	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> > +	/*
> > +	 * existing user space passes non-normalized timespecs, but never
> > +	 * more than 2 seconds worth of nanoseconds
> > +	 */
> > +	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
> >  		return -EINVAL;
> >  
> >  	obj = drm_gem_object_lookup(file, args->handle);
> > @@ -358,7 +362,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
> >  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
> >  		return -EINVAL;
> >  
> > -	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> > +	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
> >  		return -EINVAL;
> >  
> >  	if (args->pipe >= ETNA_MAX_PIPES)
> > @@ -412,7 +416,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
> >  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
> >  		return -EINVAL;
> >  
> > -	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> > +	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
> >  		return -EINVAL;
> >  
> >  	if (args->pipe >= ETNA_MAX_PIPES)
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > index efc656efeb0f..3e47050af706 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> > @@ -109,12 +109,10 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
> >  static inline unsigned long etnaviv_timeout_to_jiffies(
> >  	const struct drm_etnaviv_timespec *timeout)
> >  {
> > -	struct timespec64 ts, to = {
> > -		.tv_sec = timeout->tv_sec,
> > -		.tv_nsec = timeout->tv_nsec,
> > -	};
> > +	struct timespec64 ts, to;
> >  
> >  	ktime_get_ts64(&ts);
> > +	set_normalized_timespec64(&to, timeout->tv_sec, timeout->tv_nsec);
> >  
> >  	/* timeouts before "now" have already expired */
> >  	if (timespec64_compare(&to, &ts) <= 0)
> > -- 
> > 2.25.0
> > 

