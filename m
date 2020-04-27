Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38604206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD0M7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0M7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:59:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF61AC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 05:59:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT3Lh-0002iK-Oe; Mon, 27 Apr 2020 14:59:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B23FF100606; Mon, 27 Apr 2020 14:59:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between console and hrtimer locks
In-Reply-To: <20200427113218.GB134660@unreal>
References: <20200407170925.1775019-1-leon@kernel.org> <20200414054836.GA956407@unreal> <20200414062454.GA84326@gmail.com> <87tv15qj5u.fsf@nanos.tec.linutronix.de> <20200427113218.GB134660@unreal>
Date:   Mon, 27 Apr 2020 14:59:00 +0200
Message-ID: <87h7x5qe3v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky <leon@kernel.org> writes:
> On Mon, Apr 27, 2020 at 01:09:49PM +0200, Thomas Gleixner wrote:
>> The local APIC timer (in this case the TSC deadline timer) is set up
>> during early boot on the boot CPU (before SMP setup) with this call
>> chain:
>>
>> smp_prepare_cpus()
>>  native_smp_prepare_cpus()
>>    x86_init.timers.setup_percpu_clockev()
>>      setup_boot_APIC_clock()
>>        setup_APIC_timer()
>>          clockevents_config_and_register()
>>            tick_check_new_device()
>>              tick_setup_device()
>>                tick_setup_oneshot()
>>                  clockevents_switch_state()
>>                    lapic_timer_set_oneshot()
>>                      __setup_APIC_LVTT()
>>                        printk_once(...)
>>
>> Nothing holds hrtimer.base_lock in this call chain.
>
> Can't printk hold that lock through console/netconsole?

How so?

The lockdep splat is about this:

 [  735.324154] swapper/3/0 is trying to acquire lock:
 [  735.324155] ffffffff8442c858 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x13/0x70
 [  735.324162]
 [  735.324164] but task is already holding lock:
 [  735.324165] ffff88842dfb9958 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base+0x71/0x120

and the call chain is:

 [  735.324283]        __lock_acquire+0x374a/0x5210
 [  735.324284]        lock_acquire+0x1b9/0x920
 [  735.324286]        _raw_spin_lock_irqsave+0x3c/0x4b
 [  735.324288]        down_trylock+0x13/0x70
 [  735.324289]        __down_trylock_console_sem+0x33/0xa0
 [  735.324291]        console_trylock+0x13/0x60
 [  735.324292]        vprintk_emit+0xec/0x370
 [  735.324294]        printk+0x9c/0xc3
 [  735.324296]        lapic_timer_set_oneshot+0x4e/0x60
 [  735.324297]        clockevents_switch_state+0x1e1/0x360
 [  735.324299]        tick_program_event+0xae/0xc0
 [  735.324301]        hrtimer_start_range_ns+0x4b6/0xaa0
 [  735.324302]        tick_nohz_idle_stop_tick+0x67c/0xa90
 [  735.324304]        do_idle+0x326/0x530
 [  735.324305]        cpu_startup_entry+0x19/0x20
 [  735.324307]        start_secondary+0x2ee/0x3e0
 [  735.324309]        secondary_startup_64+0xa4/0xb0

hrtimer_start_range_ns() clearly holds htimer_base::lock

>> But the lockdep splat clearly says:
>>
>>  [  735.324357] stack backtrace:
>>  [  735.324360] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1
>>
>> ...
>>
>> So how can that be the first invocation of that printk_once()?
>>
>> While the patch looks innocent, it papers over the underlying problem
>> and wild theories are not really helping here.
>>
>> Here is a boot log excerpt with lockdep enabled and 'debug' on the
>> command line:
>>
>> [    0.000000] Linux version 5.7.0-rc3 ...
>> ...
>> [    3.992125] TSC deadline timer enabled
>> [    3.995820] smpboot: CPU0: Intel(R) ....
>> ...
>> [    4.050766] smp: Bringing up secondary CPUs ...
>>
>> No splat nothing. The real question is WHY this triggers on Leons
>> machine 735 seconds after boot and on CPU3.
>
> I want to believe that the timestamp are not correct, have no clue if it
> is even possible.

It does not matter whether the timestamps are correct or not. Even if
they are not, then this does not change the fact that this happens on
CPU3 way after the first invocation of __setup_APIC_LVTT() on CPU0 which
simply cannot trigger this splat.

Can you please provide the full dmesg with the splat?

> But let's talk about facts:
> 1. It is started after -rc1 (we don't test linux-next).

Is that a plain kernel from Linus tree or do you have other patches
applied?

A .config file would be appreciated as well along with information about
the hardware or whatever this runs on.

> 2. This workaround helped to eliminate the splat.

It's eliminating the symptom, but this does not make the root cause go
away nor does it explain anything.

> 3. My machine experiences the extra splat all the time
> https://lore.kernel.org/lkml/20200414070502.GR334007@unreal/

which is completely unrelated.

Thanks,

        tglx
