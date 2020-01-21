Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5C724125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgAUKWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:22:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47001 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgAUKWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:22:05 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1itqfZ-0004jX-IB; Tue, 21 Jan 2020 11:22:01 +0100
Message-ID: <8d86fcb526ee14c7e6c80a787db645192c2c7c33.camel@pengutronix.de>
Subject: Re: [PATCH v2 13/24] drm/etnaviv: reject timeouts with tv_nsec >=
 NSEC_PER_SEC
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Emil Velikov <emil.velikov@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Tue, 21 Jan 2020 11:21:56 +0100
In-Reply-To: <CAK8P3a3hyDeskg0ix=1+yNihqacZ5rqsXaHbRsBfPt7zFr8EOw@mail.gmail.com>
References: <20191213204936.3643476-1-arnd@arndb.de>
         <20191213205417.3871055-4-arnd@arndb.de>
         <20200117154726.GA328525@bogon.m.sigxcpu.org>
         <aaf2f587a61dee42c25805c3fe7916bed4dbd0c3.camel@pengutronix.de>
         <CAK8P3a3hyDeskg0ix=1+yNihqacZ5rqsXaHbRsBfPt7zFr8EOw@mail.gmail.com>
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

On Mo, 2020-01-20 at 19:47 +0100, Arnd Bergmann wrote:
> On Mon, Jan 20, 2020 at 6:48 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > On Fr, 2020-01-17 at 16:47 +0100, Guido Günther wrote:
> > > This breaks rendering here on arm64/gc7000 due to
> > > 
> > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > > 
> > > This is due to
> > > 
> > >     get_abs_timeout(&req.timeout, 5000000000);
> > > 
> > > in etna_bo_cpu_prep which can exceed NSEC_PER_SEC.
> > > 
> > > Should i send a patch to revert that change since it breaks existing userspace?
> > 
> > No need to revert. This patch has not been applied to the etnaviv tree
> > yet, I guess it's just in one of Arnds branches feeding into -next.
> > 
> > That part of userspace is pretty dumb, as it misses to renormalize
> > tv_nsec when it overflows the second boundary. So if what I see is
> > correct it should be enough to allow 2 * NSEC_PER_SEC, which should
> > both reject broken large timeout and keep existing userspace working.
> 
> Ah, so it's never more than 2 billion nanoseconds in known user space?
> I can definitely change my patch (actually add one on top) to allow that
> and handle it as before, or alternatively accept any 64-bit nanosecond value
> as arm64 already did, but make it less inefficient to handle.

So the broken userspace code looks like this:

static inline void get_abs_timeout(struct drm_etnaviv_timespec *tv, uint64_t ns)
{
        struct timespec t;
        uint32_t s = ns / 1000000000;
        clock_gettime(CLOCK_MONOTONIC, &t);
        tv->tv_sec = t.tv_sec + s;
        tv->tv_nsec = t.tv_nsec + ns - (s * 1000000000);
}

Which means it _tries_ to do the right thing by putting the billion
part into the tv_sec member and only the remaining ns part is added to
tv_nsec, but then it fails to propagate a tv_nsec overflow over
NSEC_PER_SEC into tv_sec.

Which means the tv_nsec should never be more than 2 * NSEC_PER_SEC in
known userspace. I would prefer if we could make the interface as
strict as possible (i.e. no arbitrary large numbers in tv_nsec), while
keeping this specific corner case working.

Regards,
Lucas

