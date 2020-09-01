Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B9EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F77206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599004704;
	bh=a6KF+jC9KD876VJklSle5wWAxx/4vlgNqBPMgZM9Tyo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=b6eG5q5zJ6VrFHZy14x9qTwZrlzzkwKXx3ceLscuLWC8xgJOICjQ6wWX2W0BdtPJn
	 GYtg8iAW09BJJH0fmh8mAD17QLC9/Ezy7wPmqv5IMX1pRJqNff7sUX1fpcoOsEtAvj
	 Ux1uj0B5CuaFTO3WDkN8JAcH3h87Ih+i2qgkGrZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIAX6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAX6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:58:22 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC16C206DD;
        Tue,  1 Sep 2020 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599004701;
        bh=a6KF+jC9KD876VJklSle5wWAxx/4vlgNqBPMgZM9Tyo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b3eA0njPcmHb2m/O2NUcZFZtQg1eCjLTy/A8P91KU7GpLFYwoYn5IrPyBjBfAq9Dc
         pDRkeACXdBWabiDAQ5wBrFpFPJ95xYgvltdhJhQoTHciRZErlx5eJEbH/gZ7czCyV8
         LnGkGLK3UtHpZENOqdxHmr2DYCzFsUDnQBd2Z+9s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 519DD3523091; Tue,  1 Sep 2020 16:58:21 -0700 (PDT)
Date:   Tue, 1 Sep 2020 16:58:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200901235821.GA8516@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901174938.GA8158@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 10:49:38AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 31, 2020 at 04:21:30PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 31, 2020 at 03:49:11PM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > The task_blocks_on_rt_mutex() function uses rt_mutex_owner() to
> > > take a snapshot of the lock owner right up front.  At this point,
> > > the ->wait_lock is held, which at first glance prevents the owner
> > > from leaving.  Except that if there are not yet any waiters (that is,
> > > the low-order bit of ->owner is zero), rt_mutex_fastunlock() might
> > > locklessly clear the ->owner field.  And in that case, it looks like
> > > task_blocks_on_rt_mutex() will blithely continue using the ex-owner's
> > > task_struct structure, without anything that I can see that prevents
> > > the ex-owner from exiting.
> > > 
> > > What am I missing here?
> > 
> > One thing I missed is that the low-order bit of ->owner would already
> > be set by this point.
> > 
> > > The reason that I am looking into this is that locktorture scenario LOCK05
> > > hangs, and does so leaving the torture_rtmutex.waiters field equal to 0x1.
> > > This is of course a legal transitional state, but I would not expect it
> > > to persist for more than three minutes.  Yet it often does.
> > > 
> > > This leads me to believe that there is a way for an unlock to fail to wake
> > > up a task concurrently acquiring the lock.  This seems to be repaired
> > > by later lock acquisitions, and in fact setting the locktorture.stutter
> > > module parameter to zero avoids the hang.  Except that I first found the
> > > above apparently unprotected access to what was recently the owner task.
> > > 
> > > Thoughts?
> > 
> > Some breakage elsewhere, presumably...
> 
> And it might be a lost wakeup, given that ->locktorture_wake_up is equal
> to 1 for one of the locktorture writer tasks given the patch below.
> Yes, this is a virtual environment.  Except that none of the other
> locktorture scenarios make this happen, nor the rcutorture scenario,
> nor the scftorture scenarios.  Maybe just the wrong timing?  Who knows,
> looking further.

And it appears that a default-niced CPU-bound SCHED_OTHER process is
not preempted by a newly awakened MAX_NICE SCHED_OTHER process.  OK,
OK, I never waited for more than 10 minutes, but on my 2.2GHz that is
close enough to a hang for most people.

Which means that the patch below prevents the hangs.  And maybe does
other things as well, firing rcutorture up on it to check.

But is this indefinite delay expected behavior?

This reproduces for me on current mainline as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05

This hangs within a minute of boot on my setup.  Here "hangs" is defined
as stopping the per-15-second console output of:
	Writes:  Total: 569906696 Max/Min: 81495031/63736508   Fail: 0

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492..9310c1d 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -602,6 +602,7 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
+	unsigned i = 0;
 	int spt;
 	bool ret = false;
 
@@ -612,8 +613,13 @@ bool stutter_wait(const char *title)
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test))
+			while (READ_ONCE(stutter_pause_test)) {
+				if (!(++i & 0xffff))
+					schedule_timeout_interruptible(1);
+				else if (!(i & 0xfff))
+					udelay(1);
 				cond_resched();
+			}
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
