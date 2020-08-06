Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4887C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3148A206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735140;
	bh=o1NhbbO37tPDJ9A8+WXaEbud/NTVA5s/e1neRj6aPQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hKt+a7d/BFi0aGJDzAvuofswgE+0XViAK+plNDxDGEU/f1PAQ2Igw2J/QIv4D6w+L
	 x5UUl0S8DhWG10g32dbE62e+39+lE75LLwhIP1JgiP0V+99BvUNPdxZllWtqH8G1q7
	 NSoj76lLr1V2XIoRm1VefXBARwC2tr/rGHDY9QiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgHFRcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357B022D3E;
        Thu,  6 Aug 2020 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596716030;
        bh=o1NhbbO37tPDJ9A8+WXaEbud/NTVA5s/e1neRj6aPQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgCZLTgM3F0uw8wfNFErDaBQWSTt1ACqVyj15myhO3MgfDmxrZ0Ah38H4rr+kCEHq
         2zcfeFFbVu35okZB0FO1ZE3Oc9oTkc1hntGaVLbGVPXzqIxmgS6Z4MZ1SEJmssrrqe
         w0ycAsHjQKmH2I1MahCaJYopOZJljdVQwNrhnjZ8=
Date:   Thu, 6 Aug 2020 13:13:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
Message-ID: <20200806080351.GA31889@willie-the-truck>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
 <20200728160010.3314-2-mathieu.desnoyers@efficios.com>
 <20200804145145.GM2657@hirez.programming.kicks-ass.net>
 <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com>
 <20200804170153.GO2657@hirez.programming.kicks-ass.net>
 <20200805105920.GB35926@hirez.programming.kicks-ass.net>
 <498869868.209.1596640956570.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498869868.209.1596640956570.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:22:36AM -0400, Mathieu Desnoyers wrote:
> ----- On Aug 5, 2020, at 6:59 AM, Peter Zijlstra peterz@infradead.org wrote:
> > On Tue, Aug 04, 2020 at 07:01:53PM +0200, peterz@infradead.org wrote:
> >> On Tue, Aug 04, 2020 at 10:59:33AM -0400, Mathieu Desnoyers wrote:
> >> > ----- On Aug 4, 2020, at 10:51 AM, Peter Zijlstra peterz@infradead.org wrote:
> >> > > On Tue, Jul 28, 2020 at 12:00:10PM -0400, Mathieu Desnoyers wrote:
> >> > >>  	task_lock(tsk);
> >> > >> +	/*
> >> > >> +	 * When a kthread stops operating on an address space, the loop
> >> > >> +	 * in membarrier_{private,global}_expedited() may not observe
> >> > >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
> >> > >> +	 * memory barrier after accessing user-space memory, before
> >> > >> +	 * clearing tsk->mm.
> >> > >> +	 */
> >> > >> +	smp_mb();
> >> > >>  	sync_mm_rss(mm);
> >> > >>  	local_irq_disable();
> >> > > 
> >> > > Would it make sense to put the smp_mb() inside the IRQ disable region?
> >> > 
> >> > I've initially placed it right after task_lock so we could eventually
> >> > have a smp_mb__after_non_raw_spinlock or something with a much better naming,
> >> > which would allow removing the extra barrier when it is implied by the
> >> > spinlock.
> >> 
> >> Oh, right, fair enough. I'll go think about if smp_mb__after_spinlock()
> >> will work for mutexes too.
> >> 
> >> It basically needs to upgrade atomic*_acquire() to smp_mb(). So that's
> >> all architectures that have their own _acquire() and an actual
> >> smp_mb__after_atomic().
> >> 
> >> Which, from the top of my head are only arm64, power and possibly riscv.
> >> And if I then git-grep smp_mb__after_spinlock, all those seem to be
> >> covered.
> >> 
> >> But let me do a better audit..
> > 
> > All I could find is csky, which, afaict, defines a superfluous
> > smp_mb__after_spinlock.
> > 
> > The relevant architectures are indeed power, arm64 and riscv, they all
> > have custom acquire/release and all define smp_mb__after_spinlock()
> > appropriately.
> > 
> > Should we rename it to smp_mb__after_acquire() ?
> 
> As discussed over IRC, smp_mb__after_atomic_acquire() would be better, because
> load_acquire and spin_lock have different semantic.

Just to clarify here, are you talking about acquire on atomic RMW operations
being different to non-RMW operations, or are you talking about
atomic_read_acquire() being different to smp_load_acquire() (which I don't
think is the case, but wanted to check)?

We need to write this stuff down.

> We could keep a define of smp_mb__after_spinlock to smp_mb__after_atomic_acquire
> to make the transition simpler.

I'm not sure I really see the benefit of the rename, to be honest with you,
especially if smp_mb__after_spinlock() doesn't disappear at the same time.
The only reason you'd use this barrier is because the atomic is hidden away
behind a locking API, otherwise you'd just have used the full-barrier variant
of the atomic op to start with, wouldn't you?

Will
