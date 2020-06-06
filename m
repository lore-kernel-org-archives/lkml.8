Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A9EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 17:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210B62077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591464586;
	bh=InFdTWf+AQ3EEuNVLEAMS/IifpeSAsaN4CaqB7gUAzk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ivB+xpMkXX8VJdtR/JrVA6Rqc25EqRVCsBYb53phXFHCoP03WnQn9pBn6Ws/kUmcB
	 edE9VJvANYgxDwmjyMWZnhbcmxaEb9fGVsIBy6rOvJus1LdcLv1qQuHBShGuHQK9zO
	 hKRax7gaXgUZFc6T5Di5nI2E9gvOGPx/i+YWYzWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgFFR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 13:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgFFR3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 13:29:42 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA632073E;
        Sat,  6 Jun 2020 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591464582;
        bh=InFdTWf+AQ3EEuNVLEAMS/IifpeSAsaN4CaqB7gUAzk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GiJAvw09oFkrMoCXInmQ6jKjBSjNEMyqu4+3zWeDhgsq3R8kVbSyprV8OaKxR3kQ9
         cUmhveo68DnzuNxdNGDFO08Sr+8GtjwglGcYaQQNqKGTM7uMX3Rpgc+pXN8R/DPTuj
         V64CNmVgW1ulp4BEKFkczum3vkH5XCCcW8NNXGQQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1A0A935209C2; Sat,  6 Jun 2020 10:29:42 -0700 (PDT)
Date:   Sat, 6 Jun 2020 10:29:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200606172942.GA30594@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605131451.GE2750@hirez.programming.kicks-ass.net>
 <20200605141607.GB4455@paulmck-ThinkPad-P72>
 <20200605184159.GA4062@paulmck-ThinkPad-P72>
 <20200606005126.GA21507@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606005126.GA21507@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:51:26PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 05, 2020 at 11:41:59AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 05, 2020 at 07:16:07AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jun 05, 2020 at 03:14:51PM +0200, Peter Zijlstra wrote:
> > > 
> > > No KCSAN.  GCC 8.2.1.  No cgroups unless the kernel creates some.
> > > No userspace other than a C-language binary named "init" that
> > > sleeps in an infinite loop.
> > > 
> > > .config attached.
> > 
> > And in case it is helpful, here is the output of "git bisect view",
> > which lists rather more commits than "git bisect run" claims, but there
> > are only a few scheduler commits below.  I don't see anything that
> > I can prove can cause this problem, but there are some that are at
> > least related to this code path.
> > 
> > Is there anything that is actually relevant?
> 
> And the run with the WARN and tracing did hit two failures, and the
> corresponding console logs are in the attached tarball.  Both of them
> triggered a warning as well as the failure.

And the current state of the bisection, for whatever it is worth.

							Thanx, Paul

------------------------------------------------------------------------

dbe9337109c2 sched/cpuacct: Fix charge cpuacct.usage_sys
04f5c362ec6d sched/fair: Replace zero-length array with flexible-array
95d685935a2e sched/pelt: Sync util/runnable_sum with PELT window when propagating
12aa2587388d sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()
7d148be69e3a sched/fair: Optimize enqueue_task_fair()
9013196a467e Merge branch 'sched/urgent'
2a0a24ebb499 sched: Make scheduler_ipi inline
90b5363acd47 sched: Clean up scheduler_ipi()
b1d1779e5ef7 sched/core: Simplify sched_init()
12ac6782a40a sched/swait: Reword some of the main description
17c891ab3491 sched/fair: Use __this_cpu_read() in wake_wide()
bf2c59fce407 sched/core: Fix illegal RCU from offline CPUs
f38f12d1e081 sched/fair: Mark sched_init_granularity __init
5a6d6a6ccb5f sched/fair: Refill bandwidth before scaling
457d1f465778 sched: Extract the task putting code from pick_next_task()
d91cecc15662 sched: Make newidle_balance() static again
36c5bdc43870 sched/topology: Kill SD_LOAD_BALANCE
e669ac8ab952 sched: Remove checks against SD_LOAD_BALANCE
9818427c6270 sched/debug: Make sd->flags sysctl read-only
45da27732b0b sched/fair: find_idlest_group(): Remove unused sd_flag parameter
586b58cac8b4 exit: Move preemption fixup up, move blocking operations down
64297f2b03cc sched/fair: Simplify the code of should_we_balance()
ab93a4bc955b sched/fair: Remove distribute_running from CFS bandwidth
e98fa02c4f2e sched/fair: Eliminate bandwidth race between throttling and distribution
f080d93e1d41 sched/debug: Fix trival print_task() format
