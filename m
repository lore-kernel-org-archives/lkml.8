Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A46AC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259292467D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgAPCGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:06:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgAPCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:06:16 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iruXy-0005Iv-BX; Thu, 16 Jan 2020 03:06:10 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CFB4910121C; Thu, 16 Jan 2020 03:06:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
In-Reply-To: <20200103151032.19590-1-longman@redhat.com>
References: <20200103151032.19590-1-longman@redhat.com>
Date:   Thu, 16 Jan 2020 03:06:09 +0100
Message-ID: <87sgkgw3xq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

>  [   25.496379] watchdog: BUG: soft lockup - CPU#14 stuck for 22s!  [swapper/14:0]
>
> Further analysis of the situation revealed that the smp_init() call
> itself took more than 20s for that 2-socket 56-core and 224-thread
> server.
>
>  [    0.115632] CPU1: Booted secondary processor 0x0000000100 [0x431f0af1]
>    :
>  [   27.177282] CPU223: Booted secondary processor 0x0000011b03 [0x431f0af1]

So what?

> By adding some instrumentation code, it was found that for cpu 14,
> watchdog_enable() was called early with a timestamp of 1. That activates
> the watchdog time checking logic. It was also found that the monotonic
> time measured during the smp_init() phase runs much slower than the
> real elapsed time as shown by the below debug printf output:
>
>   [    1.138522] run_queues, watchdog_timer_fn: now = 170000000
>   [   25.519391] run_queues, watchdog_timer_fn: now = 4170000000
>
> In this particular case, it took about 24.4s of elapsed time for the
> clock to advance 4s which is the soft expiration time that is required
> to trigger the calling of watchdog_timer_fn(). That clock slowdown
> stopped once the smp_init() call was done and the clock time ran at
> the same rate as the elapsed time afterward.

So the consequence is that you defer the soft lockup detector
initialization instead of figuring out WHY this time difference
happens. There is no clock slowdown. The clock keeps ticking at the same
frequency so there must be something else which causes this deviation.

> On a comparable CN9980 system from HPE, there was also a bit of clock
> slowdown but not as much as the Cavium system:
>
>   [    1.177068] run_queues, watchdog_timer_fn: now = 1010000000
>   [    5.577925] run_queues, watchdog_timer_fn: now = 5010000000
>
> Similar clock slowdown was not obseved on x86-64 systems.
>
> The clock slowdown in arm64 systems seems to be hardware specific.

Maybe, but that's not a reasonable explanation. 

> Given the fact that the clock is less reliable during the smp_init()

Which fact? An observation is not a fact.

> call and that call can take a rather long time, one simple workaround
> to avoid this soft lockup problem is to move lockup_detector_init()
> call after smp_init() when the clock is reliable. This does fix the
> soft lockup problem for that Cavium system and does not seem to affect
> the operation of the watchdog. This is much easier than trying to fix
> the clock slowdown problem in smp_init() as the watchdog timer is the
> only timer function that can be active at such early boot stage anyway.

Sure, it's much easier to weaken debug features instead of actually
analyzing why there is a deviation between clocks which should not have
any deviation in the first place. Root cause analysis is overrrated and
just a pet pieve of grumpy old greybeards, right?

Andrew, please drop this hackery.

Thanks,

        tglx
