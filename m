Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D00FC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D3A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eosy6C2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgG0JvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0JvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:51:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ihvO11c4A7HDZBsnXsfduw40zWWsH3cGYC5mZh7Xo3E=; b=eosy6C2TGYyv4BatIBsYEeUcHZ
        XjVCUNqVAxTqU2cB5hHSFHgt612zTXEQ1WeVyiZnCCnDCwgvX43WRKr1Jo/UhRUOWvRZXHR5CMAnU
        QR7/UhlNLwGH5a8m5hPhHrJnSQgdzC3bY35+DhwKvTp/CrPnKS9C8RQghxgtm3dlNGh1kvrL+5W5i
        qqEfjM9i2d0AA+vwzmJvlQuMbfG9nYrx7XDMZATnZQngWF631afWWewD8CdxVVgo1ZPFPFEUifHsG
        M3SMoF0vuSI60wNX26vh2QMeHNUAnblo32hUkYrtD8ydgCqWtyq4Y9ISokRU/J+0LIJRQe4x1t4KU
        Fll+7Peg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzzmq-0007LA-AL; Mon, 27 Jul 2020 09:51:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B70C430477A;
        Mon, 27 Jul 2020 11:51:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A58772143798C; Mon, 27 Jul 2020 11:51:10 +0200 (CEST)
Date:   Mon, 27 Jul 2020 11:51:10 +0200
From:   peterz@infradead.org
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH for 5.9 1/3] futex: introduce FUTEX_SWAP operation
Message-ID: <20200727095110.GG119549@hirez.programming.kicks-ass.net>
References: <20200722234538.166697-1-posk@posk.io>
 <20200722234538.166697-2-posk@posk.io>
 <20200723112757.GN5523@worktop.programming.kicks-ass.net>
 <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:25:05PM -0700, Peter Oskolkov wrote:
> On Thu, Jul 23, 2020 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > What worries me is how FUTEX_SWAP would interact with the future
> > FUTEX_LOCK / FUTEX_UNLOCK. When we implement pthread_mutex with those,
> > there's very few WAIT/WAKE left.
> 
> [+cc Waiman Long]
> 
> I've looked through the latest FUTEX_LOCK patchset I could find (
> https://lore.kernel.org/patchwork/cover/772643/ and related), and it seems
> that FUTEX_SWAP and FUTEX_LOCK/FUTEX_UNLOCK patchsets
> address the same issue (slow wakeups) but for different use cases:
> 
> FUTEX_LOCK/FUTEX_UNLOCK uses spinning and lock stealing to
> improve futex wake/wait performance in high contention situations;

The spinning is best for light contention.

> FUTEX_SWAP is designed to be used for fast context switching with
> _no_ contention by design: the waker that is going to sleep, and the wakee
> are using different futexes; the userspace will have a futex per thread/task,
> and when needed the thread/task will either simply sleep on its futex,
> or context switch (=FUTEX_SWAP) into a different thread/task.

Right, but how can you tell what the next thing after UNLOCK is going to
be.. that's going to be tricky.

> I can also imagine that instead of combining WAIT/WAKE for
> fast context switching, a variant of FUTEX_SWAP can use LOCK/UNLOCK
> operations in the future, when these are available; but again, I fully
> expect that
> a single "FUTEX_LOCK the current task on futex A, FUTEX_UNLOCK futex B,
> context switch into the wakee" futex op will be much faster than doing
> the same thing
> in two syscalls, as FUTEX_LOCK/FUTEX_UNLOCK does not seem to be concerned
> with fast waking of a sleeping task, but more with minimizing sleeping
> in the first place.

Correct; however the reason I like LOCK/UNLOCK is that it exposes the
blocking relations to the kernel -- and that ties into yet another
unfinished patch-set :-/

  https://lkml.kernel.org/r/20181009092434.26221-1-juri.lelli@redhat.com

> What will be faster: FUTEX_SWAP that does
>    FUTEX_WAKE (futex A) + FUTEX_WAIT (current, futex B),
> or FUTEX_SWAP that does
>    FUTEX_UNLOCK (futex A) + FUTEX_LOCK (current, futex B)?

Well, perhaps both argue against having SWAP but instead having compound
futex ops. Something I think we're already starting to see with the new
futex API patches posted here:

  https://lkml.kernel.org/r/20200709175921.211387-1-andrealmeid@collabora.com

sys_futex_waitv() is effectively a whole bunch of WAIT ops combined.

> As wake+wait will always put the waker to sleep, it means that
> there will be a true context switch on the same CPU on the fast path;
> on the other hand, unlock+lock will potentially evade sleeping,
> so the wakee will often run on a different CPU (with the waker
> spinning instead of sleeping?), thus not benefitting from cache locality
> that fast context switching on the same CPU is meant to use...
> 
> I'll add some of the considerations above to the expanded cover letter
> (or a commit message).

It's Monday morning, so perhaps I'm making a mess of things, but
something like the below, where our thread t2 issues synchronous work to
t1:


	t1		t2
			LOCK A
	LOCK B
1:	LOCK A

			...


			UNLOCK A
			LOCK B
	...

	UNLOCK B
	UNLOCK A
	LOCK B
	GOTO 1
			UNLOCK B
			LOCK A
			...

Is an abuse of mutexes, that is, it implements completions using a
(fair) mutex. A guards the work-queue, B is the 'completion'.

Then, if you teach it that a compound UNLOCK-A + LOCK-B, where
the lock owner of B is on the wait list of A is a 'SWAP', should get you
the desired semantics, I think.

You can do SWAP and you get to have an exposed blocking relation.

Is this exactly what we want, I don't know. Because I'm not entirely
sure what problem we're solving. Why would you be setting things up like
that in the first place. IIRC you're using this to implement coroutines
in golang, and I'm not sure I have a firm enough grasp of all that to
make a cogent suggestion one way or the other.

> > Also, why would we commit to an ABI without ever having seen the rest?
> 
> I'm not completely sure what you mean here. We do not envision any
> expansion/changes to the ABI proposed here,

Well, you do not, but how can we verify this without having a complete
picture. Also, IIRC, there's a bunch of scheduler patches that goes on
top to implement the fast switch.

Also, how does this compare to some of the glorious hacks found in
GNU Pth? You can implement M:N threading using those as well.

