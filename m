Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D0C7C820
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAFF206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587987148;
	bh=HyZEmG6wmcdniR2Viwm5NPHIbC+E2pVAsWUXqBU5HWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bS6m4o0RmkCiU0kyQeeDmIjAOgY+ppy7MATcxutVbvIoQkQo51R7siCCVMb6v9s4i
	 lDSpE7fCbdCbxe50pcEeyGNhDLmUbNtgdBJtl0zVMiA4sazl/5V+5XZDJlZypqUcy9
	 kiqYOSlLsZHX1lP37/DiHBmX6f7kA1oj0eHFjspI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgD0Lc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgD0LcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:32:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0128E206A4;
        Mon, 27 Apr 2020 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587987142;
        bh=HyZEmG6wmcdniR2Viwm5NPHIbC+E2pVAsWUXqBU5HWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJfkm9oiIt/XWlTLQ0TOgPbLC3asB2J0JzUMyvTUz9w8/BsLgMnd/hm0lF+RZhRKl
         5CTU+CitEMpThKsklh5bwutbGd0kBFxqV+4UfKTtbmnmE00Vzy6vGQcsrqxCQVpIxv
         j6Qc4YCqMSfXRpIdePLZGmxtAa1S0y3RRIyBamSU=
Date:   Mon, 27 Apr 2020 14:32:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200427113218.GB134660@unreal>
References: <20200407170925.1775019-1-leon@kernel.org>
 <20200414054836.GA956407@unreal>
 <20200414062454.GA84326@gmail.com>
 <87tv15qj5u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv15qj5u.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 01:09:49PM +0200, Thomas Gleixner wrote:
> Ingo Molnar <mingo@kernel.org> writes:
> > * Leon Romanovsky <leon@kernel.org> wrote:
> > The fix definitely looks legit, lockdep is right that we shouldn't take
> > the console_sem.lock even under trylock.
> >
> > It's only a printk_once(), yet I'm wondering why in the last ~8 years
> > this never triggered. Nobody ever ran lockdep and debug console level
> > enabled on such hardware, or did something else change?
> >
> > One possibility would be that apic_check_deadline_errata() marked almost
> > all Intel systems as broken and the TSC-deadline hardware never actually
> > got activated. In that case you have triggered rarely tested code and
> > might see other weirdnesses. Just saying. :-)
> >
> > Or a bootup with "debug" specified is much more rare in production
> > systems, hence the 8 years old bug.
>
> None of this makes any sense at all.
>
> The local APIC timer (in this case the TSC deadline timer) is set up
> during early boot on the boot CPU (before SMP setup) with this call
> chain:
>
> smp_prepare_cpus()
>  native_smp_prepare_cpus()
>    x86_init.timers.setup_percpu_clockev()
>      setup_boot_APIC_clock()
>        setup_APIC_timer()
>          clockevents_config_and_register()
>            tick_check_new_device()
>              tick_setup_device()
>                tick_setup_oneshot()
>                  clockevents_switch_state()
>                    lapic_timer_set_oneshot()
>                      __setup_APIC_LVTT()
>                        printk_once(...)
>
> Nothing holds hrtimer.base_lock in this call chain.

Can't printk hold that lock through console/netconsole?

>
> But the lockdep splat clearly says:
>
>  [  735.324357] stack backtrace:
>  [  735.324360] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1
>
> ...
>
> So how can that be the first invocation of that printk_once()?
>
> While the patch looks innocent, it papers over the underlying problem
> and wild theories are not really helping here.
>
> Here is a boot log excerpt with lockdep enabled and 'debug' on the
> command line:
>
> [    0.000000] Linux version 5.7.0-rc3 ...
> ...
> [    3.992125] TSC deadline timer enabled
> [    3.995820] smpboot: CPU0: Intel(R) ....
> ...
> [    4.050766] smp: Bringing up secondary CPUs ...
>
> No splat nothing. The real question is WHY this triggers on Leons
> machine 735 seconds after boot and on CPU3.

I want to believe that the timestamp are not correct, have no clue if it
is even possible.

But let's talk about facts:
1. It is started after -rc1 (we don't test linux-next).
2. This workaround helped to eliminate the splat.
3. My machine experiences the extra splat all the time
https://lore.kernel.org/lkml/20200414070502.GR334007@unreal/

Unfortunately, I can't bisect because the failure mentioned in the
commit message because it  doesn't happen on one machine all the time,
but when we are talking about night run regression, at least one of the
runners hits such lockdep prints.

I can add to our regression any debug patch and get results day after,
if it helps.

Thanks

>
> Thanks,
>
>         tglx
