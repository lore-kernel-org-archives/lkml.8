Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C621FC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7034D2072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kB4q6y/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgIEVYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgIEVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 17:24:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842BC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 14:24:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so7418582qtj.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FhzlJkPzHqdJW6hiIGP2F4ys6NOEOMZPpGIygDRYmm8=;
        b=kB4q6y/Vat29F1JzO25XSFDi+aDV1u6qDVS5b3rXpFY+XoCa8PIS4IqIAl5ONKQGO6
         Ktj477ZSTfLnQoiFdnoB+6n3VyasVS03yru6R2pIA/e4SuMXx9TUkBjYFIhtEZjo10qP
         cXlrrQAuKTmv9PgZd4FLYuSxcQPV8N9UhuyVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FhzlJkPzHqdJW6hiIGP2F4ys6NOEOMZPpGIygDRYmm8=;
        b=szbx/BkNXuXiASrBLgmQ8bTSIxSgrvQ9XZ8Qja/ioah2OEkAUIxoPR98iv/fKsjdK+
         GXkfhTJA3OPV1dq2xw6BArlBx4qHh2Xt2Y0ApRjFH4vQ8Vq8tmNzgfPcniBNObzmUZw8
         2ey1it5ABOmzF6otJNTnCJ93SzsRFYCLSR+8eTzHUofvFalxpE4uGVOgNJPlF28m23L9
         FT/3hXuSkZCvXckYjPa5RhfFvetQT3d/n2YBuP6fRxFB86PVHZ6KwdoZe0+mBsSLCYCT
         xyj/yRLVMovzPM/Y6MRs6wFDeXFC0jhks03eeP/qWotpDJRfHwhVd06/10CLCfqVrRNy
         Idcw==
X-Gm-Message-State: AOAM533zy5lsRqL3lCAsm3POJR+SpTB1sjRpyxbNszGoXt0QWWq26dOF
        hYCc78o8GCEhCqM+xenIgwTKWA==
X-Google-Smtp-Source: ABdhPJy9ggnCVCKeGcPsRQZarGCCeJla40jLt5OiFx+WwnRumMh6jU4XcZcs22ao17O10D314cYPog==
X-Received: by 2002:ac8:acd:: with SMTP id g13mr11682372qti.196.1599341047575;
        Sat, 05 Sep 2020 14:24:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id e1sm7749393qtb.0.2020.09.05.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 14:24:07 -0700 (PDT)
Date:   Sat, 5 Sep 2020 17:24:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200905212406.GA2074270@google.com>
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
 <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
 <20200902155410.GH29330@paulmck-ThinkPad-P72>
 <20200903200639.GA8956@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903200639.GA8956@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Sep 03, 2020 at 01:06:39PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 02, 2020 at 08:54:10AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 01, 2020 at 06:51:28PM -0700, Davidlohr Bueso wrote:
> > > On Tue, 01 Sep 2020, Paul E. McKenney wrote:
> > > 
> > > > And it appears that a default-niced CPU-bound SCHED_OTHER process is
> > > > not preempted by a newly awakened MAX_NICE SCHED_OTHER process.  OK,
> > > > OK, I never waited for more than 10 minutes, but on my 2.2GHz that is
> > > > close enough to a hang for most people.
> > > > 
> > > > Which means that the patch below prevents the hangs.  And maybe does
> > > > other things as well, firing rcutorture up on it to check.
> > > > 
> > > > But is this indefinite delay expected behavior?
> > > > 
> > > > This reproduces for me on current mainline as follows:
> > > > 
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
> > > > 
> > > > This hangs within a minute of boot on my setup.  Here "hangs" is defined
> > > > as stopping the per-15-second console output of:
> > > > 	Writes:  Total: 569906696 Max/Min: 81495031/63736508   Fail: 0
> > > 
> > > Ok this doesn't seem to be related to lockless wake_qs then. fyi there have
> > > been missed wakeups in the past where wake_q_add() fails the cmpxchg because
> > > the task is already pending a wakeup leading to the actual wakeup ocurring
> > > before its corresponding wake_up_q(). This is why we have wake_q_add_safe().
> > > But for rtmutexes, because there is no lock stealing only top-waiter is awoken
> > > as well as try_to_take_rt_mutex() is done under the lock->wait_lock I was not
> > > seeing an actual race here.
> > 
> > This problem is avoided if stutter_wait() does the occasional sleep.
> > I would have expected preemption to take effect, but even setting the
> > kthreads in stutter_wait() to MAX_NICE doesn't help.  The current fix
> > destroys intended instant-on nature of stutter_wait(), so the eventual
> > fix will need to use hrtimer-based sleeps or some such.
> 
> And here is my current best shot at a workaround/fix/whatever.  Thoughts?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit d93a64389f4d544ded241d0ba30b2586497f5dc0
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Sep 1 16:58:41 2020 -0700
> 
>     torture: Periodically pause in stutter_wait()
>     
>     Running locktorture scenario LOCK05 results in hangs:
>     
>     tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
>     
>     The lock_torture_writer() kthreads set themselves to MAX_NICE while
>     running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
>     also SCHED_OTHER.  This results in these other locktorture kthreads
>     indefinitely preempting the lock_torture_writer() kthreads.  Note that

In the past I have seen issues with niceness and CFS. Those issues were
related to tick granularity, if the scheduler tick is too coarse, then
scheduler may allow a low priority task to run for a bit longer. But this
also means that higher priority tasks will take even longer to catch up to
the vruntime of the lower priority ones. IIRC, this can run into several
seconds.

Not fully sure if that's what you're seeing. If you drop the niceness by some
amount, does the issue go away or get better?

>     the cond_resched() in the stutter_wait() function's loop is ineffective
>     because this scenario is built with CONFIG_PREEMPT=y.
>     
>     It is not clear that such indefinite preemption is supposed to happen, but
>     in the meantime this commit prevents kthreads running in stutter_wait()
>     from being completely CPU-bound, thus allowing the other threads to get
>     some CPU in a timely fashion.  This commit also uses hrtimers to provide
>     very short sleeps to avoid degrading the sudden-on testing that stutter
>     is supposed to provide.

There is a CFS tracepoint called sched:sched_stat_runtime. That could be
enabled to see what happens to the vruntime values on the wakeup of the lower
prio task.

I'm also seeing the LOCK05 failure, I see that some writer threads are in
TASK_UNINTERRUPTIBLE state shown by hung task detector on LOCK05. So these
writers didn't wake up for over 2 minutes to begin with:

[  246.797326] task:lock_torture_wr state:D stack:14696 pid:   72 ppid:     2 flags:0x00004000
[  246.798826] Call Trace:
[  246.799282]  __schedule+0x414/0x6a0
[  246.799917]  schedule+0x41/0xe0
[  246.800510]  __rt_mutex_slowlock+0x49/0xd0
[  246.801259]  rt_mutex_slowlock+0xca/0x1e0
[  246.801994]  ? lock_torture_reader+0x110/0x110
[  246.802799]  torture_rtmutex_lock+0xc/0x10
[  246.803545]  lock_torture_writer+0x72/0x150
[  246.804322]  kthread+0x120/0x160
[  246.804911]  ? kthread_park+0x80/0x80
[  246.805581]  ret_from_fork+0x22/0x30
[  246.806237] INFO: task lock_torture_wr:73 blocked for more than 122 seconds.
[  246.807505]       Not tainted 5.9.0-rc1+ #26
[  246.808287] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.809690] task:lock_torture_wr state:D stack:14696 pid:   73 ppid:     2 flags:0x00004000
[  246.811208] Call Trace:
[  246.811657]  __schedule+0x414/0x6a0
[  246.812306]  schedule+0x41/0xe0
[  246.812881]  __rt_mutex_slowlock+0x49/0xd0
[  246.813636]  rt_mutex_slowlock+0xca/0x1e0
[  246.814371]  ? lock_torture_reader+0x110/0x110
[  246.815182]  torture_rtmutex_lock+0xc/0x10
[  246.815923]  lock_torture_writer+0x72/0x150
[  246.816692]  kthread+0x120/0x160
[  246.817287]  ? kthread_park+0x80/0x80
[  246.817952]  ret_from_fork+0x22/0x30

Could this just be a side effect of the issue you are seeing?  (A writer
acquired a lock but never got CPU to release it, which inturn caused lock
acquirers to block in D-state indefinitely).

thanks,

 - Joel

