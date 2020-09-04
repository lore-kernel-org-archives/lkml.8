Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC74EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB882098B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599252464;
	bh=hVFUHbOH+8zE59ih8ktaaz1jpEK/tLIIBwpTEYiLDLc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=EWHNVVEhmi8zvNQd6cEEqJOiIhl6Qg6wGmDDS+9uYeO3J5q9A65SXhKQm9pEzFvDO
	 dJy4Yqahvfbq+U05ng7nMdcSBMGLwSnOIEnEW7pWOSyVo1NMHLlY0sAgqbIYJLNBu/
	 qzHVj7SRjx9KxfGx73PHB5tnCvsi4n0vaprRE5Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgIDUrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDUrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:47:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FB7208C7;
        Fri,  4 Sep 2020 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252460;
        bh=hVFUHbOH+8zE59ih8ktaaz1jpEK/tLIIBwpTEYiLDLc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2BgRlMY7SjqSUURjyXPeuTiXU4OmlwsfMKOt1Cm40f+dOjL+vHFq8rBV8w3zuctbW
         oiqlmfhNDKH/Mk2PCk86eXLv2jZaZGfWAjhaQWdm5AM0bXVZON0vWpZNi/Vnpnl2Vr
         JazUkua1TC+jxXCm0snXxnLRGOktpOmZIb2M77ss=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A45F4352162B; Fri,  4 Sep 2020 13:47:40 -0700 (PDT)
Date:   Fri, 4 Sep 2020 13:47:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200904204740.GP29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200901104640.GA13814@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901104640.GA13814@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:46:41PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> I'm currently working on making nohz_full/nohz_idle runtime toggable
> and some other people seem to be interested as well. So I've dumped
> a few thoughts about some pre-requirements to achieve that for those
> interested.
> 
> As you can see, there is a bit of hard work in the way. I'm iterating
> that in https://pad.kernel.org/p/isolation, feel free to edit:
> 
> 
> == RCU nocb ==
> 
> Currently controllable with "rcu_nocbs=" boot parameter and/or through nohz_full=/isolcpus=nohz
> We need to make it toggeable at runtime. Currently handling that:
> v1: https://lwn.net/Articles/820544/
> v2: coming soon

Looking forward to seeing it!

> == TIF_NOHZ ==
> 
> Need to get rid of that in order not to trigger syscall slowpath on CPUs that don't want nohz_full.
> Also we don't want to iterate all threads and clear the flag when the last nohz_full CPU exits nohz_full
> mode. Prefer static keys to call context tracking on archs. x86 does that well.

Would it help if RCU was able to, on a per-CPU basis, distinguish between
nohz_full userspace execution on the one hand and idle-loop execution
on the other?  Or do you have some other trick in mind?

							Thanx, Paul

> == Proper entry code ==
> 
> We must make sure that a given arch never calls exception_enter() / exception_exit().
> This saves the previous state of context tracking and switch to kernel mode (from context tracking POV)
> temporarily. Since this state is saved on the stack, this prevents us from turning off context tracking
> entirely on a CPU: The tracking must be done on all CPUs and that takes some cycles.
> 
> This means that, considering early entry code (before the call to context tracking upon kernel entry,
> and after the call to context tracking upon kernel exit), we must take care of few things:
> 
> 1) Make sure early entry code can't trigger exceptions. Or if it does, the given exception can't schedule
> or use RCU (unless it calls rcu_nmi_enter()). Otherwise the exception must call exception_enter()/exception_exit()
> which we don't want.
> 
> 2) No call to schedule_user().
> 
> 3) Make sure early entry code is not interruptible or preempt_schedule_irq() would rely on
> exception_entry()/exception_exit()
> 
> 4) Make sure early entry code can't be traced (no call to preempt_schedule_notrace()), or if it does it
> can't schedule
> 
> I believe x86 does most of that well. In the end we should remove exception_enter()/exit implementations
> in x86 and replace it with a check that makes sure context_tracking state is not in USER. An arch meeting
> all the above conditions would earn a CONFIG_ARCH_HAS_SANE_CONTEXT_TRACKING. Being able to toggle nohz_full
> at runtime would depend on that.
> 
> 
> == Cputime accounting ==
> 
> Both write and read side must switch to tick based accounting and drop the use of seqlock in task_cputime(),
> task_gtime(), kcpustat_field(), kcpustat_cpu_fetch(). Special ordering/state machine is required to make that without races.
> 
> == Nohz ==
> 
> Switch from nohz_full to nohz_idle. Mind a few details:
>     
>     1) Turn off 1Hz offlined tick handled in housekeeping
>     2) Handle tick dependencies, take care of racing CPUs setting/clearing tick dependency. It's much trickier when
>     we switch from nohz_idle to nohz_full
>     
> == Unbound affinity ==
> 
> Restore kernel threads, workqueue, timers, etc... wide affinity. But take care of cpumasks that have been set through other
> interfaces: sysfs, procfs, etc...
