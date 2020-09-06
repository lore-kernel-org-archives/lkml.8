Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B5C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33072076A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 04:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599365645;
	bh=K0EAUweFqpBW8pS8h0uKR7o/P0fEwFWd9EWzBgmkepg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ujKN3q/G0i1sZh4tMVSZH42Ze1XmqXwS4nIhbxgy5Wg2GfAYkUzGLhZBl2JSrF2iT
	 OezR6+FzDcXWwgNoEMSJDq0gmRlcFmYmN9j3jAN6djCKtDVQ4Ih3IEDV8dvx49JFy/
	 5gxx+xhsjsAtunQf3fCS/e4PQM85RWZQAn+rlQls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIFEOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 00:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgIFEOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 00:14:03 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D5E20757;
        Sun,  6 Sep 2020 04:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599365643;
        bh=K0EAUweFqpBW8pS8h0uKR7o/P0fEwFWd9EWzBgmkepg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GL/PrIuFgI6/eG4KG55EUk2JnWNZMYK9yEbaOoiWWDbBWhzIGDb6GFh7WWT+TP4ah
         EPLQ98eNOHR7KZ9ln+1eN/tKOfzTUVSwBEKwg4ktBNGbyTdiXoUKZFdkQP4Zj7e8C3
         olJpHwmjuHBfdFX6XqewyMslup02Cvs6kKPXRoqs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 24B3835229E2; Sat,  5 Sep 2020 21:14:03 -0700 (PDT)
Date:   Sat, 5 Sep 2020 21:14:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200906041403.GS29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
 <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
 <20200902155410.GH29330@paulmck-ThinkPad-P72>
 <20200903200639.GA8956@paulmck-ThinkPad-P72>
 <20200905212406.GA2074270@google.com>
 <20200905214502.GA2631534@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905214502.GA2631534@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 05:45:02PM -0400, Joel Fernandes wrote:
> On Sat, Sep 05, 2020 at 05:24:06PM -0400, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Thu, Sep 03, 2020 at 01:06:39PM -0700, Paul E. McKenney wrote:
> > > On Wed, Sep 02, 2020 at 08:54:10AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Sep 01, 2020 at 06:51:28PM -0700, Davidlohr Bueso wrote:
> > > > > On Tue, 01 Sep 2020, Paul E. McKenney wrote:
> > > > > 
> > > > > > And it appears that a default-niced CPU-bound SCHED_OTHER process is
> > > > > > not preempted by a newly awakened MAX_NICE SCHED_OTHER process.  OK,
> > > > > > OK, I never waited for more than 10 minutes, but on my 2.2GHz that is
> > > > > > close enough to a hang for most people.
> > > > > > 
> > > > > > Which means that the patch below prevents the hangs.  And maybe does
> > > > > > other things as well, firing rcutorture up on it to check.
> > > > > > 
> > > > > > But is this indefinite delay expected behavior?
> > > > > > 
> > > > > > This reproduces for me on current mainline as follows:
> > > > > > 
> > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
> > > > > > 
> > > > > > This hangs within a minute of boot on my setup.  Here "hangs" is defined
> > > > > > as stopping the per-15-second console output of:
> > > > > > 	Writes:  Total: 569906696 Max/Min: 81495031/63736508   Fail: 0
> [...]
> > > ------------------------------------------------------------------------
> > > 
> > > commit d93a64389f4d544ded241d0ba30b2586497f5dc0
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Tue Sep 1 16:58:41 2020 -0700
> > > 
> > >     torture: Periodically pause in stutter_wait()
> > >     
> > >     Running locktorture scenario LOCK05 results in hangs:
> > >     
> > >     tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
> > >     
> > >     The lock_torture_writer() kthreads set themselves to MAX_NICE while
> > >     running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
> > >     also SCHED_OTHER.  This results in these other locktorture kthreads
> > >     indefinitely preempting the lock_torture_writer() kthreads.  Note that
> > 
> > In the past I have seen issues with niceness and CFS. Those issues were
> > related to tick granularity, if the scheduler tick is too coarse, then
> > scheduler may allow a low priority task to run for a bit longer. But this
> > also means that higher priority tasks will take even longer to catch up to
> > the vruntime of the lower priority ones. IIRC, this can run into several
> > seconds.
> > 
> > Not fully sure if that's what you're seeing. If you drop the niceness by some
> > amount, does the issue go away or get better?
> > 
> > >     the cond_resched() in the stutter_wait() function's loop is ineffective
> > >     because this scenario is built with CONFIG_PREEMPT=y.
> > >     
> > >     It is not clear that such indefinite preemption is supposed to happen, but
> > >     in the meantime this commit prevents kthreads running in stutter_wait()
> > >     from being completely CPU-bound, thus allowing the other threads to get
> > >     some CPU in a timely fashion.  This commit also uses hrtimers to provide
> > >     very short sleeps to avoid degrading the sudden-on testing that stutter
> > >     is supposed to provide.
> > 
> > There is a CFS tracepoint called sched:sched_stat_runtime. That could be
> > enabled to see what happens to the vruntime values on the wakeup of the lower
> > prio task.
> > 
> > I'm also seeing the LOCK05 failure, I see that some writer threads are in
> > TASK_UNINTERRUPTIBLE state shown by hung task detector on LOCK05. So these
> > writers didn't wake up for over 2 minutes to begin with:
> > 
> > [  246.797326] task:lock_torture_wr state:D stack:14696 pid:   72 ppid:     2 flags:0x00004000
> > [  246.798826] Call Trace:
> > [  246.799282]  __schedule+0x414/0x6a0
> > [  246.799917]  schedule+0x41/0xe0
> > [  246.800510]  __rt_mutex_slowlock+0x49/0xd0
> > [  246.801259]  rt_mutex_slowlock+0xca/0x1e0
> > [  246.801994]  ? lock_torture_reader+0x110/0x110
> > [  246.802799]  torture_rtmutex_lock+0xc/0x10
> > [  246.803545]  lock_torture_writer+0x72/0x150
> > [  246.804322]  kthread+0x120/0x160
> > [  246.804911]  ? kthread_park+0x80/0x80
> > [  246.805581]  ret_from_fork+0x22/0x30
> > [  246.806237] INFO: task lock_torture_wr:73 blocked for more than 122 seconds.
> > [  246.807505]       Not tainted 5.9.0-rc1+ #26
> > [  246.808287] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  246.809690] task:lock_torture_wr state:D stack:14696 pid:   73 ppid:     2 flags:0x00004000
> > [  246.811208] Call Trace:
> > [  246.811657]  __schedule+0x414/0x6a0
> > [  246.812306]  schedule+0x41/0xe0
> > [  246.812881]  __rt_mutex_slowlock+0x49/0xd0
> > [  246.813636]  rt_mutex_slowlock+0xca/0x1e0
> > [  246.814371]  ? lock_torture_reader+0x110/0x110
> > [  246.815182]  torture_rtmutex_lock+0xc/0x10
> > [  246.815923]  lock_torture_writer+0x72/0x150
> > [  246.816692]  kthread+0x120/0x160
> > [  246.817287]  ? kthread_park+0x80/0x80
> > [  246.817952]  ret_from_fork+0x22/0x30
> > 
> > Could this just be a side effect of the issue you are seeing?  (A writer
> > acquired a lock but never got CPU to release it, which inturn caused lock
> > acquirers to block in D-state indefinitely).
> 
> It appears to me the reason could be because the higher priority task is RT:
> 
> sched_switch: prev_comm=lock_torture_wr prev_pid=74 prev_prio=139 prev_state=R+ ==> next_comm=lock_torture_wr next_pid=70 next_prio=49
> 
> After this, only pid=70 runs till the hungtasks detector screams.
> 
> Could this because the writer calls cur_ops->task_boost(); which sets pid=70
> to RT?  As long as RT task runs, it will block the CFS task without giving it CPU.

Thank you for looking into this!  Sounds like something I would do...
And unlike rcutorture, the timeframes are too short for throttling
to kick in.  Seems like the fix is instead to set to everything to
SCHED_OTHER while it is in torture_stutter().  I will give that a try.
Though perhaps the hrtimer sleep is better?

							Thanx, Paul
