Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657E32072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgESUls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:41:48 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:59274 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:41:47 -0400
Date:   Tue, 19 May 2020 16:41:44 -0400
From:   Rich Felker <dalias@libc.org>
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: clock_gettime64 vdso bug on 32-bit arm, rpi-4
Message-ID: <20200519204143.GG1079@brightrain.aerifal.cx>
References: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
 <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 05:24:18PM -0300, Adhemerval Zanella wrote:
> 
> 
> On 19/05/2020 16:54, Arnd Bergmann wrote:
> > Jack Schmidt reported a bug for the arm32 clock_gettimeofday64 vdso call last
> > month: https://github.com/richfelker/musl-cross-make/issues/96 and
> > https://github.com/raspberrypi/linux/issues/3579
> > 
> > As Will Deacon pointed out, this was never reported on the mailing list,
> > so I'll try to summarize what we know, so this can hopefully be resolved soon.
> > 
> > - This happened reproducibly on Linux-5.6 on a 32-bit Raspberry Pi patched
> >    kernel running on a 64-bit Raspberry Pi 4b (bcm2711) when calling
> >    clock_gettime64(CLOCK_REALTIME)
> 
> Does it happen with other clocks as well?
> 
> > 
> > - The kernel tree is at https://github.com/raspberrypi/linux/, but I could
> >   see no relevant changes compared to a mainline kernel.
> 
> Is this bug reproducible with mainline kernel or mainline kernel can't be
> booted on bcm2711?
> 
> > 
> > - From the report, I see that the returned time value is larger than the
> >   expected time, by 3.4 to 14.5 million seconds in four samples, my
> >   guess is that a random number gets added in at some point.
> 
> What kind code are you using to reproduce it? It is threaded or issue
> clock_gettime from signal handlers?

Original report thread is here:

https://github.com/richfelker/musl-cross-make/issues/96

The reporter originally misunderstood the issue and wrongly attributed
it to difference between gettimeofday and clock_gettime but it was
just big jumps between successive vdso clock_gettime64 calls.

No transformation was being done on the output of the vdso function;
as long as it succeeds musl just returns directly with the value it
stored in the timespec. No threads or anything fancy were involved.

Current musl will no longer call it but you should be able to
dlopen("linux-gate.so.1", RTLD_NOW|RTLD_LOCAL) then use dlsym to get
its address and call it (not tested; I've never used it this way).

> > - The current musl git tree has been patched to not call clock_gettime64
> >    on ARM because of this problem, so it cannot be used for reproducing it.
> 
> So should glibc follow musl and remove arm clock_gettime6y4 vDSO support
> or this bug is localized to an specific kernel version running on an
> specific hardware?

For musl it was important to disable it asap pending a fix, because
users are expected to generate static binaries, and these could make
it into the wild without anyone realizing they're broken until much
later when run on an affected kernel (especially since pre-5.6 kernels
would hide the issue entirely due to lacking vdso). Ideally a fix will
be something we can detect (e.g. new symbol version) so as not to risk
calling the broken one, but whether that's necessary may depend on
what's affected.

I'm not sure if glibc should do the same; it's not often used in
static linking, and replacing libc (shared lib, or re-static-linking
which LGPL requires you to facilitate to distribute static binaries)
could solve the issue on affected systems.

Rich
