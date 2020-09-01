Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE276C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B2E207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598982581;
	bh=EQLNAMxkmTDyb5sNsTlYm1ZYeU+slvP9jlY01JuWhxE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HrAuzLMH7TKhdISJAKLIe9V9eVXcOgZSJ08oAHhWQE2Kouq0pgmkUJs71A9u8zVya
	 ctgCx2UT2/VTA4iRuOg3gj7OtvrvZ4PGOFEnyq2CbofE8rzsyoxSTJ7vGyniJwDM1u
	 Lp18j3Iqf1AGntlsi6q2fMu97Y5Kw/wNx4S7T4bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgIARtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgIARtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:49:39 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF45F207D3;
        Tue,  1 Sep 2020 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598982578;
        bh=EQLNAMxkmTDyb5sNsTlYm1ZYeU+slvP9jlY01JuWhxE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CPjMH1spEHC/EXgkSnX/sTmsb1QFWaxN618Ysa6Es7zmc7gHFLbijarh3EehqAsDa
         sm3iQsk0HTNdqAUwdNZx/w4X2MZ2EptSvFq0BKPPmTZJ4P1e1DmI/zPwP1fddox6+Y
         6TMScjdZvKLsB6IAgkvpj/u5Idy7DAN0xmbMwJow=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF1F73523091; Tue,  1 Sep 2020 10:49:38 -0700 (PDT)
Date:   Tue, 1 Sep 2020 10:49:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200901174938.GA8158@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831232130.GA28456@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 04:21:30PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 31, 2020 at 03:49:11PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > The task_blocks_on_rt_mutex() function uses rt_mutex_owner() to
> > take a snapshot of the lock owner right up front.  At this point,
> > the ->wait_lock is held, which at first glance prevents the owner
> > from leaving.  Except that if there are not yet any waiters (that is,
> > the low-order bit of ->owner is zero), rt_mutex_fastunlock() might
> > locklessly clear the ->owner field.  And in that case, it looks like
> > task_blocks_on_rt_mutex() will blithely continue using the ex-owner's
> > task_struct structure, without anything that I can see that prevents
> > the ex-owner from exiting.
> > 
> > What am I missing here?
> 
> One thing I missed is that the low-order bit of ->owner would already
> be set by this point.
> 
> > The reason that I am looking into this is that locktorture scenario LOCK05
> > hangs, and does so leaving the torture_rtmutex.waiters field equal to 0x1.
> > This is of course a legal transitional state, but I would not expect it
> > to persist for more than three minutes.  Yet it often does.
> > 
> > This leads me to believe that there is a way for an unlock to fail to wake
> > up a task concurrently acquiring the lock.  This seems to be repaired
> > by later lock acquisitions, and in fact setting the locktorture.stutter
> > module parameter to zero avoids the hang.  Except that I first found the
> > above apparently unprotected access to what was recently the owner task.
> > 
> > Thoughts?
> 
> Some breakage elsewhere, presumably...

And it might be a lost wakeup, given that ->locktorture_wake_up is equal
to 1 for one of the locktorture writer tasks given the patch below.
Yes, this is a virtual environment.  Except that none of the other
locktorture scenarios make this happen, nor the rcutorture scenario,
nor the scftorture scenarios.  Maybe just the wrong timing?  Who knows,
looking further.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd93..054b6f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -720,6 +720,7 @@ struct task_struct {
 	struct list_head		rcu_node_entry;
 	struct rcu_node			*rcu_blocked_node;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
+	u8				locktorture_wake_up;
 
 #ifdef CONFIG_TASKS_RCU
 	unsigned long			rcu_tasks_nvcsw;
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 316531d..7f183be 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -617,6 +617,7 @@ static int lock_torture_writer(void *arg)
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	set_user_nice(current, MAX_NICE);
+	current->locktorture_wake_up = 0;
 
 	do {
 		if ((torture_random(&rand) & 0xfffff) == 0)
@@ -635,6 +636,7 @@ static int lock_torture_writer(void *arg)
 		lock_is_write_held = false;
 		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock();
+		current->locktorture_wake_up = 0;
 
 		stutter_wait("lock_torture_writer");
 	} while (!torture_must_stop());
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cfdd5b9..4a0b046 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1053,6 +1053,7 @@ static void mark_wakeup_next_waiter(struct wake_q_head *wake_q,
 	 */
 	preempt_disable();
 	wake_q_add(wake_q, waiter->task);
+	waiter->task->locktorture_wake_up = 1;
 	raw_spin_unlock(&current->pi_lock);
 }
 
