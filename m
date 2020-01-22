Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AB9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFF124655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jv2YkmeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgAVKgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:36:24 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37994 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgAVKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qV0nPj5tEVoFXSxisYrwpsdGo4tcFtq0OnTwiKfamQ0=; b=Jv2YkmeB9uF1EaComQ4haMGNK
        e8aqhElhaSEvbl/SpMYwdeF81r3tuwpyZBiSL5Zr2VV9gUB6me6afaJs7SyDSJNxDUxXNs553q2WE
        f+qrqarjg49fIIFAPJ1XO1of1VdOvlq+QfbqP4mqgcm+JrOcJoqd1hutQ3Ev0npvuVP5eHhQXrRk9
        LJU/k6FU7mWBxJFLzFg455xzOFjE9Cbr4b0eDm9jD/LrTltZ6TlS0LLlQ+/51rMIurF8XHNhy5oeH
        ztr1i7j0NOHjHI7NEk/l3C7sYhkUaKIeYTKf2hnK1llgI4uxGlrgOavs5COWjWqkx0xKPh6t0W2ud
        B8ELuE/zQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37606)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iuDMc-0002KF-MP; Wed, 22 Jan 2020 10:35:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iuDMX-0004l8-9Y; Wed, 22 Jan 2020 10:35:53 +0000
Date:   Wed, 22 Jan 2020 10:35:53 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lucas Stach <l.stach@pengutronix.de>,
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
Message-ID: <20200122103553.GN25745@shell.armlinux.org.uk>
References: <20200121114553.2667556-1-arnd@arndb.de>
 <20200121125546.GA71415@bogon.m.sigxcpu.org>
 <1971902c68ff805ee0b4a66f558afe06e6edf0c5.camel@pengutronix.de>
 <CAK8P3a2E__zHPPEL37JwK=uHb_v-=C+-+zGaL3XoW5PZ+BUN5g@mail.gmail.com>
 <20200122103034.GA67385@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122103034.GA67385@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:30:34AM +0100, Guido Günther wrote:
> Hi,
> On Tue, Jan 21, 2020 at 08:05:27PM +0100, Arnd Bergmann wrote:
> > On Tue, Jan 21, 2020 at 5:10 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Hi Guido,
> > >
> > > On Di, 2020-01-21 at 13:55 +0100, Guido Günther wrote:
> > > > Hi,
> > > > On Tue, Jan 21, 2020 at 12:45:25PM +0100, Arnd Bergmann wrote:
> > > > > As Guido Günther reported, get_abs_timeout() in the etnaviv user space
> > > > > sometimes passes timeouts with nanosecond values larger than 1000000000,
> > > > > which gets rejected after my first patch.
> > > > >
> > > > > To avoid breaking this, while also not allowing completely arbitrary
> > > > > values, set the limit to 1999999999 and use set_normalized_timespec64()
> > > > > to get the correct format before comparing it.
> > > >
> > > > I'm seeing values up to 5 seconds so I need
> > > >
> > > >      if (args->timeout.tv_nsec > (5 * NSEC_PER_SEC))
> > > >
> > > > to unbreak rendering. Which seems to match what mesa's get_abs_timeout()
> > > > does and how it's invoked.
> > >
> > > I have not tested this myself yet, only looked at the code. From the
> > > code I quoted earlier, I don't see how we end up with 5 * NSEC_PER_SEC
> > > in the tv_nsec member, even if the timeout passed to get_abs_timeout()
> > > is 5 seconds.
> > 
> > I can think of two different ways you'd end up with around five seconds here:
> > 
> > a) you have a completely arbitrary 32-bit number through truncation,
> >     which is up to 4.2 seconds
> > b) you have the same kind of 32-bit number, but add up to another 999999999
> >     nanoseconds, so you get up to 5.2 seconds in the 64-bit field.
> 
> I've dumped out some values tv_nsec values with current mesa git on arm64:
> 
> [   33.699652] etnaviv_ioctl_gem_cpu_prep: 4990449401
> [   33.813081] etnaviv_ioctl_gem_cpu_prep: 5103872445
> [   33.822936] etnaviv_ioctl_gem_cpu_prep: 5113731286
> [   33.840963] etnaviv_ioctl_gem_cpu_prep: 5131762726
> [   33.854120] etnaviv_ioctl_gem_cpu_prep: 5144920127
> [   33.861426] etnaviv_ioctl_gem_cpu_prep: 5152227527
> [   33.872666] etnaviv_ioctl_gem_cpu_prep: 5163466968
> [   33.879485] etnaviv_ioctl_gem_cpu_prep: 5170286808
> 
> The problem is that in mesa/libdrm
> 
> static inline void get_abs_timeout(struct drm_etnaviv_timespec *tv, uint64_t ns)
> {
>         struct timespec t;
>         uint32_t s = ns / 1000000000;
>         clock_gettime(CLOCK_MONOTONIC, &t);
>         tv->tv_sec = t.tv_sec + s;
>         tv->tv_nsec = t.tv_nsec + ns - (s * 1000000000);
>                                         ^^^^^^^^^^^^^^^
>    this overflows (since `s` is `uint_32t` and hence we substract a way
>    too small value with ns = 5000000000 which mesa uses in
>    etna_bo_cpu_prep.
> }
> 
> So with current mesa/libdrm (which needs to be fixed) we'd have a maximum
> 
>       t.tv_nsec + ns         - (s_max * 1000000000)
> 
>       999999999 + 5000000000 - 705032704            = 5294967295
> 
> Does that make sense? If so that'd be the possible upper bound for the
> kernel. Note that this only applies to etnaviv_ioctl_gem_cpu_prep. While
> etnaviv_ioctl_wait_fence and etnaviv_ioctl_gem_wait are affected too
> i've not yet seen user space passing in larger values.

Except the fact that the calculation being done above is buggy.
Not only do we end up with tv_sec incremented by 5 seconds, but
we also end up with tv_nsec containing around 5 seconds in
nanoseconds, which means we end up with about a 10 second timeout.

I think it would probably be better for the kernel to print a
warning once when noticing over-large nsec values, suggesting a
userspace upgrade is in order, but continue the existing behaviour.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
