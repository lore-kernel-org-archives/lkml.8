Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E1CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B9120882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgAULqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:46:21 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:35923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:46:20 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MV2Sk-1j0ukv0vQs-00S3nR for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 12:46:19 +0100
Received: by mail-qv1-f42.google.com with SMTP id y8so1259460qvk.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:46:19 -0800 (PST)
X-Gm-Message-State: APjAAAVttoVmBLTrUHTVAfYnoIEDiVPAdj9bHUjGnSsfwcMzHUUaTAW0
        1s8WowqXMqipFWg0W2hOFrT5kJTEJxPCFAJjIK8=
X-Google-Smtp-Source: APXvYqyxZGlIFCBF780+KS/2bkfvq0hP+a0/hThj2asG4RwHxIFlbrU9wtbrUp8O1361oVkawD1TQHBg3rBp7/M4I3g=
X-Received: by 2002:a0c:e7c7:: with SMTP id c7mr4350634qvo.222.1579607178086;
 Tue, 21 Jan 2020 03:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20191213204936.3643476-1-arnd@arndb.de> <20191213205417.3871055-4-arnd@arndb.de>
 <20200117154726.GA328525@bogon.m.sigxcpu.org> <aaf2f587a61dee42c25805c3fe7916bed4dbd0c3.camel@pengutronix.de>
 <CAK8P3a3hyDeskg0ix=1+yNihqacZ5rqsXaHbRsBfPt7zFr8EOw@mail.gmail.com> <8d86fcb526ee14c7e6c80a787db645192c2c7c33.camel@pengutronix.de>
In-Reply-To: <8d86fcb526ee14c7e6c80a787db645192c2c7c33.camel@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 12:46:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0tKt_ZfAPnPKbaOQ9j3A+kS0LypeGA46epdyQw-knitA@mail.gmail.com>
Message-ID: <CAK8P3a0tKt_ZfAPnPKbaOQ9j3A+kS0LypeGA46epdyQw-knitA@mail.gmail.com>
Subject: Re: [PATCH v2 13/24] drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:KBPpsYpnrBSGOdCwCE4yT4gNfvFTP/DIyrZDD00LB+G6/iaNwQs
 ntl1BvH3NIoSTPYU5TmFoGHnj3D3EUg8Wcy9CmWlumLul798VkaHzl8Re+vcJz/Tq1bec7P
 SE80JdS3fXvgaeJKRnG057tOQNr76wN8/Je/3/nKn/0MjaU7zPOxKt1EWwvCLwfMIN9Nyzi
 Uy/Uj+nwj/K+1z1mpY8Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cBEZqDmt+Mo=:vedcsuiFNF4ab6FJwf4/q7
 5WJJ9HMFXCkH4zHL26l3/gq/SUdzGZ1Tb320w1ejIBTupd09skVK3UPDmaylLWeoHrQ8KxdfF
 hbYQLhvDQujxWZcknq4LzkzBprqLeWVp9Xcq54R3E/WRhofe9+Gotkq2VYDdRm7B1LIF8vWb4
 2KjS4D1a2dElMln6qsgEaQVBqMvG9NViPVnEQkjhMnX7T57V1iY9ohErBS8l0JyHylVbtk3O0
 2d6214LMWcjCGR5n/oc9kIVrblhZjmddZnK6XedqbjkXz+KBkAL5Jz6XPyWNxiANAdYvffaYv
 wFBbU8iQsKKscbU4KG21BvkKP+jtyEQYSx+VSfwK5TMpGYSjnaAZmpEaPFdTvm1HmUD+DIJ2u
 mmiYG38SKfRB1xSOabTYkK5M6J2eS/oGcOeNfR7Mn8IOcOy8FBQ6QNfRs2HIEcrL9wdq34g67
 v/Wlri3thoSp6exZHRQpoXUq1M8IVoSH1lj4/DZBOKkflL2ZnvyR7C2lumELvyK6JaeoqIlps
 huUIRn/Tn2CD4eooXorACvYg8GOIYqrXTPwpanlWJBT05Wo6emfp/A+EaFVECoPGXRfx0dKL3
 kTy1wTXyILLKAVLJuIbNFDE1Unh3koDag+pEZ8e5+nnA5Z1hzub4BMCxecwlp5RZiGZlcLCnq
 CnDTlUp9rVlTkQwHG+pq9HEI5i9hy1WLc+vibNQ9ePegBaoc8KymZS/9kFCTs2ChUhXgoVCjn
 YGqiW6AQZmD1zSoGageZuRQIpHtaWJ7YZmaP8LwSrdlgXyL/tOIdnUnQmZiOjS8WV0ZBhNjMF
 DfKLMxlhkZV/DHvVrJljq+6j/Y5fAVraEZmviUbnuH/s6YFHXx3lvjXomynbJQaA9ONxrzilc
 +VZ4Zu1vTpvA0c6kupOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:22 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> On Mo, 2020-01-20 at 19:47 +0100, Arnd Bergmann wrote:
> > On Mon, Jan 20, 2020 at 6:48 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > On Fr, 2020-01-17 at 16:47 +0100, Guido Günther wrote:
> > > > This breaks rendering here on arm64/gc7000 due to
> > > >
> > > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_PREP or DRM_IOCTL_MSM_GEM_CPU_PREP, 0xfffff7888680) = -1 EINVAL (Invalid argument)
> > > > ioctl(6, DRM_IOCTL_ETNAVIV_GEM_CPU_FINI or DRM_IOCTL_QXL_CLIENTCAP, 0xfffff78885e0) = 0
> > > >
> > > > This is due to
> > > >
> > > >     get_abs_timeout(&req.timeout, 5000000000);
> > > >
> > > > in etna_bo_cpu_prep which can exceed NSEC_PER_SEC.
> > > >
> > > > Should i send a patch to revert that change since it breaks existing userspace?
> > >
> > > No need to revert. This patch has not been applied to the etnaviv tree
> > > yet, I guess it's just in one of Arnds branches feeding into -next.
> > >
> > > That part of userspace is pretty dumb, as it misses to renormalize
> > > tv_nsec when it overflows the second boundary. So if what I see is
> > > correct it should be enough to allow 2 * NSEC_PER_SEC, which should
> > > both reject broken large timeout and keep existing userspace working.
> >
> > Ah, so it's never more than 2 billion nanoseconds in known user space?
> > I can definitely change my patch (actually add one on top) to allow that
> > and handle it as before, or alternatively accept any 64-bit nanosecond value
> > as arm64 already did, but make it less inefficient to handle.
>
> So the broken userspace code looks like this:
>
> static inline void get_abs_timeout(struct drm_etnaviv_timespec *tv, uint64_t ns)
> {
>         struct timespec t;
>         uint32_t s = ns / 1000000000;
>         clock_gettime(CLOCK_MONOTONIC, &t);
>         tv->tv_sec = t.tv_sec + s;
>         tv->tv_nsec = t.tv_nsec + ns - (s * 1000000000);
> }
>
> Which means it _tries_ to do the right thing by putting the billion
> part into the tv_sec member and only the remaining ns part is added to
> tv_nsec, but then it fails to propagate a tv_nsec overflow over
> NSEC_PER_SEC into tv_sec.
>
> Which means the tv_nsec should never be more than 2 * NSEC_PER_SEC in
> known userspace. I would prefer if we could make the interface as
> strict as possible (i.e. no arbitrary large numbers in tv_nsec), while
> keeping this specific corner case working.

I've added a patch on top of my 2038 branch, please have a look at that.

      Arnd
