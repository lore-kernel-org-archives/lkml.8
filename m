Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E12C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126D20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPLoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:44:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAPLoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:44:18 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is3ZI-0005bg-09; Thu, 16 Jan 2020 12:44:08 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A4864101B66; Thu, 16 Jan 2020 12:44:07 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
In-Reply-To: <87sgkgw3xq.fsf@nanos.tec.linutronix.de>
References: <20200103151032.19590-1-longman@redhat.com> <87sgkgw3xq.fsf@nanos.tec.linutronix.de>
Date:   Thu, 16 Jan 2020 12:44:07 +0100
Message-ID: <87blr3wrqw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

Added ARM64 and ThunderX folks 

> Waiman Long <longman@redhat.com> writes:
>> By adding some instrumentation code, it was found that for cpu 14,
>> watchdog_enable() was called early with a timestamp of 1. That activates
>> the watchdog time checking logic. It was also found that the monotonic
>> time measured during the smp_init() phase runs much slower than the
>> real elapsed time as shown by the below debug printf output:
>>
>>   [    1.138522] run_queues, watchdog_timer_fn: now =  170000000
>>   [   25.519391] run_queues, watchdog_timer_fn: now = 4170000000
>>
>> In this particular case, it took about 24.4s of elapsed time for the
>> clock to advance 4s which is the soft expiration time that is required
>> to trigger the calling of watchdog_timer_fn(). That clock slowdown
>> stopped once the smp_init() call was done and the clock time ran at
>> the same rate as the elapsed time afterward.

And looking at this with a more awake brain, the root cause is pretty
obvious.

sched_clock() advances by 24 seconds, but clock MONOTONIC on which the
watchdog timer is based does not. As the timestamps you printed have 7
trailing zeros, it's pretty clear that timekeeping is still jiffies
based at this point and HZ is set to 100.

So while bringing up the non-boot CPUs the boot CPU loses ~2000 timer
interrupts. That needs to be fixed and not papered over.

Thanks,

        tglx
