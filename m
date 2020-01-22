Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E49C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C1A20828
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAVKaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:30:39 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:54384 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgAVKaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:30:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 94D68FB03;
        Wed, 22 Jan 2020 11:30:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T6ubGSDKZvw2; Wed, 22 Jan 2020 11:30:35 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4AA0B404A9; Wed, 22 Jan 2020 11:30:34 +0100 (CET)
Date:   Wed, 22 Jan 2020 11:30:34 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2
 seconds
Message-ID: <20200122103034.GA67385@bogon.m.sigxcpu.org>
References: <20200121114553.2667556-1-arnd@arndb.de>
 <20200121125546.GA71415@bogon.m.sigxcpu.org>
 <1971902c68ff805ee0b4a66f558afe06e6edf0c5.camel@pengutronix.de>
 <CAK8P3a2E__zHPPEL37JwK=uHb_v-=C+-+zGaL3XoW5PZ+BUN5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2E__zHPPEL37JwK=uHb_v-=C+-+zGaL3XoW5PZ+BUN5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Jan 21, 2020 at 08:05:27PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 21, 2020 at 5:10 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> >
> > Hi Guido,
> >
> > On Di, 2020-01-21 at 13:55 +0100, Guido Günther wrote:
> > > Hi,
> > > On Tue, Jan 21, 2020 at 12:45:25PM +0100, Arnd Bergmann wrote:
> > > > As Guido Günther reported, get_abs_timeout() in the etnaviv user space
> > > > sometimes passes timeouts with nanosecond values larger than 1000000000,
> > > > which gets rejected after my first patch.
> > > >
> > > > To avoid breaking this, while also not allowing completely arbitrary
> > > > values, set the limit to 1999999999 and use set_normalized_timespec64()
> > > > to get the correct format before comparing it.
> > >
> > > I'm seeing values up to 5 seconds so I need
> > >
> > >      if (args->timeout.tv_nsec > (5 * NSEC_PER_SEC))
> > >
> > > to unbreak rendering. Which seems to match what mesa's get_abs_timeout()
> > > does and how it's invoked.
> >
> > I have not tested this myself yet, only looked at the code. From the
> > code I quoted earlier, I don't see how we end up with 5 * NSEC_PER_SEC
> > in the tv_nsec member, even if the timeout passed to get_abs_timeout()
> > is 5 seconds.
> 
> I can think of two different ways you'd end up with around five seconds here:
> 
> a) you have a completely arbitrary 32-bit number through truncation,
>     which is up to 4.2 seconds
> b) you have the same kind of 32-bit number, but add up to another 999999999
>     nanoseconds, so you get up to 5.2 seconds in the 64-bit field.

I've dumped out some values tv_nsec values with current mesa git on arm64:

[   33.699652] etnaviv_ioctl_gem_cpu_prep: 4990449401
[   33.813081] etnaviv_ioctl_gem_cpu_prep: 5103872445
[   33.822936] etnaviv_ioctl_gem_cpu_prep: 5113731286
[   33.840963] etnaviv_ioctl_gem_cpu_prep: 5131762726
[   33.854120] etnaviv_ioctl_gem_cpu_prep: 5144920127
[   33.861426] etnaviv_ioctl_gem_cpu_prep: 5152227527
[   33.872666] etnaviv_ioctl_gem_cpu_prep: 5163466968
[   33.879485] etnaviv_ioctl_gem_cpu_prep: 5170286808

The problem is that in mesa/libdrm

static inline void get_abs_timeout(struct drm_etnaviv_timespec *tv, uint64_t ns)
{
        struct timespec t;
        uint32_t s = ns / 1000000000;
        clock_gettime(CLOCK_MONOTONIC, &t);
        tv->tv_sec = t.tv_sec + s;
        tv->tv_nsec = t.tv_nsec + ns - (s * 1000000000);
                                        ^^^^^^^^^^^^^^^
   this overflows (since `s` is `uint_32t` and hence we substract a way
   too small value with ns = 5000000000 which mesa uses in
   etna_bo_cpu_prep.
}

So with current mesa/libdrm (which needs to be fixed) we'd have a maximum

      t.tv_nsec + ns         - (s_max * 1000000000)

      999999999 + 5000000000 - 705032704            = 5294967295

Does that make sense? If so that'd be the possible upper bound for the
kernel. Note that this only applies to etnaviv_ioctl_gem_cpu_prep. While
etnaviv_ioctl_wait_fence and etnaviv_ioctl_gem_wait are affected too
i've not yet seen user space passing in larger values.

Cheers,
 -- Guido

> 
> It could of course be something completely different. If this works correctly
> today, we may need to allow any 64-bit input for the nanoseconds and do
> an expensive 64-bit div/mod in the kernel for normalization rather than the
> cheaper set_normalized_timespec64() from my patch.
> 
>         Arnd
> 
