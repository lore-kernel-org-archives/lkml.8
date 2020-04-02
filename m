Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C4EC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DD320787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585842849;
	bh=4Eu298RZ2IWYgmD/vOfOB6+9cpJ48Q2EoWqLKqCJRtc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HJGk5dOQnDloOrmCrZK7/dFYj5WHSy8etvgJ9U5eFmXjN0gCURnop/GjQOlQ6uuVD
	 wgJQ/l8SDMc+MHn4svoUB5OnrgqddxOPjJQHybFhpZNuigkhJpNr3N0I1gQbpUt2Mu
	 KxAbaEspmsrfrIj9EkHZeYR8kovB63i/cBa6tTK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389560AbgDBPyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388677AbgDBPyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:54:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793FD2063A;
        Thu,  2 Apr 2020 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585842846;
        bh=4Eu298RZ2IWYgmD/vOfOB6+9cpJ48Q2EoWqLKqCJRtc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ay8L+idr6K8LOgJLPqEPdE0Z1gVQT47uLiObP4g66rkbmMb/PXuVhVjBucd7eTcWf
         n5UA5MbyZBE13CQCInce1Kv4ohKzrPFNYQRND3IQale4O5OWn525djNEuult6w5bUo
         1aUY8NBcEBqpe5tiEL6fORJCFENwC9AaI5f/mnkQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 499613521885; Thu,  2 Apr 2020 08:54:06 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:54:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>, deller@gmx.de,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Message-ID: <20200402155406.GP19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200401214033.8448-1-cai@lca.pw>
 <87369mt9kf.fsf@mpe.ellerman.id.au>
 <C0F26F4C-77A0-41DF-856A-B7E29C56A4B6@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C0F26F4C-77A0-41DF-856A-B7E29C56A4B6@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:00:16AM -0400, Qian Cai wrote:
> 
> 
> > On Apr 2, 2020, at 7:24 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > 
> > Qian Cai <cai@lca.pw> writes:
> >> From: Peter Zijlstra <peterz@infradead.org>
> >> 
> >> In the CPU-offline process, it calls mmdrop() after idle entry and the
> >> subsequent call to cpuhp_report_idle_dead(). Once execution passes the
> >> call to rcu_report_dead(), RCU is ignoring the CPU, which results in
> >> lockdep complaining when mmdrop() uses RCU from either memcg or
> >> debugobjects below.
> >> 
> >> Fix it by cleaning up the active_mm state from BP instead. Every arch
> >> which has CONFIG_HOTPLUG_CPU should have already called idle_task_exit()
> >> from AP. The only exception is parisc because it switches them to
> >> &init_mm unconditionally (see smp_boot_one_cpu() and smp_cpu_init()),
> >> but the patch will still work there because it calls mmgrab(&init_mm) in
> >> smp_cpu_init() and then should call mmdrop(&init_mm) in finish_cpu().
> > 
> > Thanks for debugging this. How did you hit it in the first place?
> 
> Just repeatedly offline/online CPUs which will eventually cause an idle thread
> refcount goes to 0 and trigger __mmdrop() and of course it needs to enable
> lockdep (PROVE_RCU?) as well as having luck to hit the cgroup, workqueue
> or debugobject code paths to call RCU.
> 
> > 
> > A link to the original thread would have helped me:
> > 
> >  https://lore.kernel.org/lkml/20200113190331.12788-1-cai@lca.pw/
> > 
> >> WARNING: suspicious RCU usage
> >> -----------------------------
> >> kernel/workqueue.c:710 RCU or wq_pool_mutex should be held!
> >> 
> >> other info that might help us debug this:
> >> 
> >> RCU used illegally from offline CPU!
> >> Call Trace:
> >> dump_stack+0xf4/0x164 (unreliable)
> >> lockdep_rcu_suspicious+0x140/0x164
> >> get_work_pool+0x110/0x150
> >> __queue_work+0x1bc/0xca0
> >> queue_work_on+0x114/0x120
> >> css_release+0x9c/0xc0
> >> percpu_ref_put_many+0x204/0x230
> >> free_pcp_prepare+0x264/0x570
> >> free_unref_page+0x38/0xf0
> >> __mmdrop+0x21c/0x2c0
> >> idle_task_exit+0x170/0x1b0
> >> pnv_smp_cpu_kill_self+0x38/0x2e0
> >> cpu_die+0x48/0x64
> >> arch_cpu_idle_dead+0x30/0x50
> >> do_idle+0x2f4/0x470
> >> cpu_startup_entry+0x38/0x40
> >> start_secondary+0x7a8/0xa80
> >> start_secondary_resume+0x10/0x14
> > 
> > Do we know when this started happening? ie. can we determine a Fixes
> > tag?
> 
> I don’t know. I looked at some commits that it seems the code was like that
> even 10-year ago. It must be nobody who cares to run lockdep (PROVE_RCU?)
> with CPU hotplug very regularly.

I do run this combination quite frequently, but only as part of
rcutorture, which might not be a representative workload.  For one thing,
it has a minimal userspace consisting only of a trivial init program.
I don't recall having ever seen this.  (I have seen one recent complaint
about an IPI being sent to an offline CPU, but I cannot prove that this
was not due to RCU bugs that I was chasing at the time.)

							Thanx, Paul

> >> <Peter to sign off here>
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >> ---
> >> arch/powerpc/platforms/powernv/smp.c |  1 -
> >> include/linux/sched/mm.h             |  2 ++
> >> kernel/cpu.c                         | 18 +++++++++++++++++-
> >> kernel/sched/core.c                  |  5 +++--
> >> 4 files changed, 22 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> >> index 13e251699346..b2ba3e95bda7 100644
> >> --- a/arch/powerpc/platforms/powernv/smp.c
> >> +++ b/arch/powerpc/platforms/powernv/smp.c
> >> @@ -167,7 +167,6 @@ static void pnv_smp_cpu_kill_self(void)
> >> 	/* Standard hot unplug procedure */
> >> 
> >> 	idle_task_exit();
> >> -	current->active_mm = NULL; /* for sanity */
> > 
> > If I'm reading it right, we'll now be running with active_mm == init_mm
> > in the offline loop.
> > 
> > I guess that's fine, I can't think of any reason it would matter, and it
> > seems like we were NULL'ing it out just for paranoia's sake not because
> > of any actual problem.
> > 
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> > 
> > 
> > cheers
> > 
> >> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> >> index c49257a3b510..a132d875d351 100644
> >> --- a/include/linux/sched/mm.h
> >> +++ b/include/linux/sched/mm.h
> >> @@ -49,6 +49,8 @@ static inline void mmdrop(struct mm_struct *mm)
> >> 		__mmdrop(mm);
> >> }
> >> 
> >> +void mmdrop(struct mm_struct *mm);
> >> +
> >> /*
> >>  * This has to be called after a get_task_mm()/mmget_not_zero()
> >>  * followed by taking the mmap_sem for writing before modifying the
> >> diff --git a/kernel/cpu.c b/kernel/cpu.c
> >> index 2371292f30b0..244d30544377 100644
> >> --- a/kernel/cpu.c
> >> +++ b/kernel/cpu.c
> >> @@ -3,6 +3,7 @@
> >>  *
> >>  * This code is licenced under the GPL.
> >>  */
> >> +#include <linux/sched/mm.h>
> >> #include <linux/proc_fs.h>
> >> #include <linux/smp.h>
> >> #include <linux/init.h>
> >> @@ -564,6 +565,21 @@ static int bringup_cpu(unsigned int cpu)
> >> 	return bringup_wait_for_ap(cpu);
> >> }
> >> 
> >> +static int finish_cpu(unsigned int cpu)
> >> +{
> >> +	struct task_struct *idle = idle_thread_get(cpu);
> >> +	struct mm_struct *mm = idle->active_mm;
> >> +
> >> +	/*
> >> +	 * idle_task_exit() will have switched to &init_mm, now
> >> +	 * clean up any remaining active_mm state.
> >> +	 */
> >> +	if (mm != &init_mm)
> >> +		idle->active_mm = &init_mm;
> >> +	mmdrop(mm);
> >> +	return 0;
> >> +}
> >> +
> >> /*
> >>  * Hotplug state machine related functions
> >>  */
> >> @@ -1549,7 +1565,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
> >> 	[CPUHP_BRINGUP_CPU] = {
> >> 		.name			= "cpu:bringup",
> >> 		.startup.single		= bringup_cpu,
> >> -		.teardown.single	= NULL,
> >> +		.teardown.single	= finish_cpu,
> >> 		.cant_stop		= true,
> >> 	},
> >> 	/* Final state before CPU kills itself */
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index a2694ba82874..8787958339d5 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -6200,13 +6200,14 @@ void idle_task_exit(void)
> >> 	struct mm_struct *mm = current->active_mm;
> >> 
> >> 	BUG_ON(cpu_online(smp_processor_id()));
> >> +	BUG_ON(current != this_rq()->idle);
> >> 
> >> 	if (mm != &init_mm) {
> >> 		switch_mm(mm, &init_mm, current);
> >> -		current->active_mm = &init_mm;
> >> 		finish_arch_post_lock_switch();
> >> 	}
> >> -	mmdrop(mm);
> >> +
> >> +	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
> >> }
> >> 
> >> /*
> >> -- 
> >> 2.21.0 (Apple Git-122.2)
> 
