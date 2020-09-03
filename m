Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD4AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97519208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599163603;
	bh=BPQE+aY4Awl+whFKcdM9mAjsuebPu1tzmnWJLS/BxAw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=whEQ7CI32SepBmDl4LGP5xzt8npja9fuHswBu95pbqOu3VK9wce7BJjSqOGSMSvyr
	 K5l+2bFAU4Kcc+c7NVtbJ410oRHBYculHBUHi/RTPIzPMS95KR4tCqaoEyz2oJUPS4
	 kImoK4Iqc2gk0fbAFa1ra42b+BnALhyINmFqj5kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgICUGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgICUGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:06:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C322071B;
        Thu,  3 Sep 2020 20:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599163600;
        bh=BPQE+aY4Awl+whFKcdM9mAjsuebPu1tzmnWJLS/BxAw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G8YpLGTc4qtFZmhkWNC5+PSkVkMdAnAb5bUUsHWy3sco0KTU+PywAoJc3HRJ7jhnu
         02I0TeSbbFYzR2wGM4MbBAQtzDRIVz6x/q7DGXq6sXT3ekArdiuVwM887GcP5hapm8
         qMyXtzmTdgLiA2KA6bctk0aWx/pN6eQv02TZZouw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CEE813522636; Thu,  3 Sep 2020 13:06:39 -0700 (PDT)
Date:   Thu, 3 Sep 2020 13:06:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200903200639.GA8956@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
 <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
 <20200902155410.GH29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902155410.GH29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:54:10AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 01, 2020 at 06:51:28PM -0700, Davidlohr Bueso wrote:
> > On Tue, 01 Sep 2020, Paul E. McKenney wrote:
> > 
> > > And it appears that a default-niced CPU-bound SCHED_OTHER process is
> > > not preempted by a newly awakened MAX_NICE SCHED_OTHER process.  OK,
> > > OK, I never waited for more than 10 minutes, but on my 2.2GHz that is
> > > close enough to a hang for most people.
> > > 
> > > Which means that the patch below prevents the hangs.  And maybe does
> > > other things as well, firing rcutorture up on it to check.
> > > 
> > > But is this indefinite delay expected behavior?
> > > 
> > > This reproduces for me on current mainline as follows:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
> > > 
> > > This hangs within a minute of boot on my setup.  Here "hangs" is defined
> > > as stopping the per-15-second console output of:
> > > 	Writes:  Total: 569906696 Max/Min: 81495031/63736508   Fail: 0
> > 
> > Ok this doesn't seem to be related to lockless wake_qs then. fyi there have
> > been missed wakeups in the past where wake_q_add() fails the cmpxchg because
> > the task is already pending a wakeup leading to the actual wakeup ocurring
> > before its corresponding wake_up_q(). This is why we have wake_q_add_safe().
> > But for rtmutexes, because there is no lock stealing only top-waiter is awoken
> > as well as try_to_take_rt_mutex() is done under the lock->wait_lock I was not
> > seeing an actual race here.
> 
> This problem is avoided if stutter_wait() does the occasional sleep.
> I would have expected preemption to take effect, but even setting the
> kthreads in stutter_wait() to MAX_NICE doesn't help.  The current fix
> destroys intended instant-on nature of stutter_wait(), so the eventual
> fix will need to use hrtimer-based sleeps or some such.

And here is my current best shot at a workaround/fix/whatever.  Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit d93a64389f4d544ded241d0ba30b2586497f5dc0
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Sep 1 16:58:41 2020 -0700

    torture: Periodically pause in stutter_wait()
    
    Running locktorture scenario LOCK05 results in hangs:
    
    tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
    
    The lock_torture_writer() kthreads set themselves to MAX_NICE while
    running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
    also SCHED_OTHER.  This results in these other locktorture kthreads
    indefinitely preempting the lock_torture_writer() kthreads.  Note that
    the cond_resched() in the stutter_wait() function's loop is ineffective
    because this scenario is built with CONFIG_PREEMPT=y.
    
    It is not clear that such indefinite preemption is supposed to happen, but
    in the meantime this commit prevents kthreads running in stutter_wait()
    from being completely CPU-bound, thus allowing the other threads to get
    some CPU in a timely fashion.  This commit also uses hrtimers to provide
    very short sleeps to avoid degrading the sudden-on testing that stutter
    is supposed to provide.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492..5488ad2 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -602,8 +602,11 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	int spt;
+	ktime_t delay;
+	unsigned i = 0;
+	int oldnice;
 	bool ret = false;
+	int spt;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
@@ -612,8 +615,17 @@ bool stutter_wait(const char *title)
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test))
+			oldnice = task_nice(current);
+			set_user_nice(current, MAX_NICE);
+			while (READ_ONCE(stutter_pause_test)) {
+				if (!(i++ & 0xffff)) {
+					set_current_state(TASK_INTERRUPTIBLE);
+					delay = 10 * NSEC_PER_USEC;
+					schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				}
 				cond_resched();
+			}
+			set_user_nice(current, oldnice);
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
