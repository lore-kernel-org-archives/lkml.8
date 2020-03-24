Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53852076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056618;
	bh=75riC9xW+rrb7ix7MFZHbQp7waeSm9QImhRtNFJBo+g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YIv/xrXcW7JE4WBHLQQNp0ljZwnmS++z9kpFgGWdQGs06k6ivMzYN3CaY1ZTl8/ic
	 Zey0LC6z1dK9cHzPccRyVKelTWMRZv1tcx51rvqgpZStMuuYEkPoQU4mP+do2Zh+xV
	 qHCPgE8KzEbrl0JXugb8vxfu/vdDECczOWAT3rzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgCXNaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgCXNaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:30:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA4F2073E;
        Tue, 24 Mar 2020 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056613;
        bh=75riC9xW+rrb7ix7MFZHbQp7waeSm9QImhRtNFJBo+g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YkbwyQncfa/qMF5eysEjpYMFxIZhnKObARpSHUSF/m5Lic2ylukdCh5ZrzxCUr5/s
         INcmdLr/PdxMeR+nff/Mq/E4DOLkH+KcymNdsLafLnMlnBnI6tIy2vQLFt9MRyVzGr
         l2tFdZV0UBaPHc1MouqYTBbO39ye3rRUSdtID1vA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E53D93522760; Tue, 24 Mar 2020 06:30:12 -0700 (PDT)
Date:   Tue, 24 Mar 2020 06:30:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, vpillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, peterz@infradead.org,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
Message-ID: <20200324133012.GW3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200313232918.62303-1-joel@joelfernandes.org>
 <20200314003004.GI3199@paulmck-ThinkPad-P72>
 <f77b9432-933c-a9fe-5541-437cf0094a65@linux.intel.com>
 <20200323152126.GA141027@google.com>
 <6d933ce2-75e3-6469-4bb0-08ce9df29139@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d933ce2-75e3-6469-4bb0-08ce9df29139@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:01:27AM +0800, Li, Aubrey wrote:
> On 2020/3/23 23:21, Joel Fernandes wrote:
> > On Mon, Mar 23, 2020 at 02:58:18PM +0800, Li, Aubrey wrote:
> >> On 2020/3/14 8:30, Paul E. McKenney wrote:
> >>> On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
> >>>> rcu_read_unlock() can incur an infrequent deadlock in
> >>>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> >>>>
> >>>> This fixes the following spinlock recursion observed when testing the
> >>>> core scheduling patches on PREEMPT=y kernel on ChromeOS:
> >>>>
> >>>> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> >>>>
> >>>
> >>> The original could indeed deadlock, and this would avoid that deadlock.
> >>> (The commit to solve this deadlock is sadly not yet in mainline.)
> >>>
> >>> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> >>
> >> I saw this in dmesg with this patch, is it expected?
> >>
> >> [  117.000905] =============================
> >> [  117.000907] WARNING: suspicious RCU usage
> >> [  117.000911] 5.5.7+ #160 Not tainted
> >> [  117.000913] -----------------------------
> >> [  117.000916] kernel/sched/core.c:4747 suspicious rcu_dereference_check() usage!
> >> [  117.000918] 
> >>                other info that might help us debug this:
> > 
> > Sigh, this is because for_each_domain() expects rcu_read_lock(). From an RCU
> > PoV, the code is correct (warning doesn't cause any issue).
> > 
> > To silence warning, we could replace the rcu_read_lock_sched() in my patch with:
> > preempt_disable();
> > rcu_read_lock();
> > 
> > and replace the unlock with:
> > 
> > rcu_read_unlock();
> > preempt_enable();
> > 
> > That should both take care of both the warning and the scheduler-related
> > deadlock. Thoughts?
> > 
> 
> How about this?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a01df3e..7ff694e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4743,7 +4743,6 @@ static void sched_core_balance(struct rq *rq)
>  	int cpu = cpu_of(rq);
>  
>  	rcu_read_lock();
> -	raw_spin_unlock_irq(rq_lockp(rq));
>  	for_each_domain(cpu, sd) {
>  		if (!(sd->flags & SD_LOAD_BALANCE))
>  			break;
> @@ -4754,7 +4753,6 @@ static void sched_core_balance(struct rq *rq)
>  		if (steal_cookie_task(cpu, sd))
>  			break;
>  	}
> -	raw_spin_lock_irq(rq_lockp(rq));
>  	rcu_read_unlock();
>  }

As an alternative, I am backporting the -rcu commit 2b5e19e20fc2 ("rcu:
Make rcu_read_unlock_special() safe for rq/pi locks") to v5.6-rc6 and
testing it.  The other support for this is already in mainline.  I just
now started testing it, and will let you know how it goes.

If that works for you, and if the bug you are looking to fix is also
in v5.5 or earlier, please let me know so that we can work out how to
deal with the older releases.

							Thanx, Paul
