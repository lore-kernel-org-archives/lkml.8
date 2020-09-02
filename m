Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029DAC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E3A207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599062057;
	bh=T9iTGJwk3MutXitltZ85MC5KJh0naTlHQ9Yv1BlJG2A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=myJWXU7hjKSooCdpU/s31WV5hidjkH/EpK4jiCOpQpQveTk/q/04WpLCU4A+7RGUc
	 BbOqdNnm37mzjexxMcxtbQnfun1XSxG6GXLGzFk5LMEIVIws+MYdCgW4gCJDvZDXqV
	 DjFlAHv0WbdTStaMRxKjdXmsdashszbxSVdRcEaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIBPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgIBPyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:54:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9DC2072A;
        Wed,  2 Sep 2020 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599062051;
        bh=T9iTGJwk3MutXitltZ85MC5KJh0naTlHQ9Yv1BlJG2A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QanVEyu0Y8fvXfxzCKQ7+7u25VxbaSQXAFUO6scvERn5gpnqEsKJGv4lwONrQGCu3
         CZKS4fSd5rDP2lfP5Q0xrEJbGIcWDuMNYGqHjLO3wasWZqLcWZPRGR8cz1phTykO0o
         fdgmW/YejKomoK4ix6fO/RUO5XzGP/UDUoqFU2kw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 64F07352157A; Wed,  2 Sep 2020 08:54:10 -0700 (PDT)
Date:   Wed, 2 Sep 2020 08:54:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200902155410.GH29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
 <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 06:51:28PM -0700, Davidlohr Bueso wrote:
> On Tue, 01 Sep 2020, Paul E. McKenney wrote:
> 
> > And it appears that a default-niced CPU-bound SCHED_OTHER process is
> > not preempted by a newly awakened MAX_NICE SCHED_OTHER process.  OK,
> > OK, I never waited for more than 10 minutes, but on my 2.2GHz that is
> > close enough to a hang for most people.
> > 
> > Which means that the patch below prevents the hangs.  And maybe does
> > other things as well, firing rcutorture up on it to check.
> > 
> > But is this indefinite delay expected behavior?
> > 
> > This reproduces for me on current mainline as follows:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
> > 
> > This hangs within a minute of boot on my setup.  Here "hangs" is defined
> > as stopping the per-15-second console output of:
> > 	Writes:  Total: 569906696 Max/Min: 81495031/63736508   Fail: 0
> 
> Ok this doesn't seem to be related to lockless wake_qs then. fyi there have
> been missed wakeups in the past where wake_q_add() fails the cmpxchg because
> the task is already pending a wakeup leading to the actual wakeup ocurring
> before its corresponding wake_up_q(). This is why we have wake_q_add_safe().
> But for rtmutexes, because there is no lock stealing only top-waiter is awoken
> as well as try_to_take_rt_mutex() is done under the lock->wait_lock I was not
> seeing an actual race here.

This problem is avoided if stutter_wait() does the occasional sleep.
I would have expected preemption to take effect, but even setting the
kthreads in stutter_wait() to MAX_NICE doesn't help.  The current fix
destroys intended instant-on nature of stutter_wait(), so the eventual
fix will need to use hrtimer-based sleeps or some such.

							Thanx, Paul
