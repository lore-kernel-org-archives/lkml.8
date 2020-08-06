Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B26C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0702311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fWIiJ3CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgHFQt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:49:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:56714 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgHFQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5C1BA2999C7;
        Thu,  6 Aug 2020 08:57:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fsCxb9mpDnGb; Thu,  6 Aug 2020 08:57:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 05E1F299AAB;
        Thu,  6 Aug 2020 08:57:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 05E1F299AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596718673;
        bh=TbqNDc8HvZfMw4xy6HohFyxAGK7CmqP9uVfXuSYcTEo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fWIiJ3CZMC0VGeFt+gt31xwIRcKYU1wWXjRSmn3ZvYv56MbCGMrecWFbmZhBIjbEa
         9hUunaoqhq+HrnnNubXDBZiVi4JDsijeqcBrHUuUvfutd2x3jM5glxvA02/r5mIeSS
         UkfP2yRB7ZUCB0oJGbAZgb7JElT9xUL6eF44y2UpePHUBcTBQB9uLBbIjFDJFaz6OO
         liuZYhov9y1cJoqTnLsskvcdVrz1vG77xwO1nI+RuPkZQpGBoNU+MfQ4otxKhl9r/P
         pMrn5hsotHkzCmh6J2RSOyKhsbr32n/7Q/FVXaI8SvSjodzMJpOnyqfnoc3ca11n9N
         DOcvvF0xQEQMg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WslYZSdaxtTR; Thu,  6 Aug 2020 08:57:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EAEF1299907;
        Thu,  6 Aug 2020 08:57:52 -0400 (EDT)
Date:   Thu, 6 Aug 2020 08:57:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <457267869.1379.1596718672867.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200806080351.GA31889@willie-the-truck>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com> <20200728160010.3314-2-mathieu.desnoyers@efficios.com> <20200804145145.GM2657@hirez.programming.kicks-ass.net> <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com> <20200804170153.GO2657@hirez.programming.kicks-ass.net> <20200805105920.GB35926@hirez.programming.kicks-ass.net> <498869868.209.1596640956570.JavaMail.zimbra@efficios.com> <20200806080351.GA31889@willie-the-truck>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: membarrier: cover kthread_use_mm
Thread-Index: Rd2eLbM7vipz4MRqPtD9G/KI60o4cg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 6, 2020, at 8:13 AM, Will Deacon will@kernel.org wrote:

> On Wed, Aug 05, 2020 at 11:22:36AM -0400, Mathieu Desnoyers wrote:
>> ----- On Aug 5, 2020, at 6:59 AM, Peter Zijlstra peterz@infradead.org wrote:
>> > On Tue, Aug 04, 2020 at 07:01:53PM +0200, peterz@infradead.org wrote:
>> >> On Tue, Aug 04, 2020 at 10:59:33AM -0400, Mathieu Desnoyers wrote:
>> >> > ----- On Aug 4, 2020, at 10:51 AM, Peter Zijlstra peterz@infradead.org wrote:
>> >> > > On Tue, Jul 28, 2020 at 12:00:10PM -0400, Mathieu Desnoyers wrote:
>> >> > >>  	task_lock(tsk);
>> >> > >> +	/*
>> >> > >> +	 * When a kthread stops operating on an address space, the loop
>> >> > >> +	 * in membarrier_{private,global}_expedited() may not observe
>> >> > >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> >> > >> +	 * memory barrier after accessing user-space memory, before
>> >> > >> +	 * clearing tsk->mm.
>> >> > >> +	 */
>> >> > >> +	smp_mb();
>> >> > >>  	sync_mm_rss(mm);
>> >> > >>  	local_irq_disable();
>> >> > > 
>> >> > > Would it make sense to put the smp_mb() inside the IRQ disable region?
>> >> > 
>> >> > I've initially placed it right after task_lock so we could eventually
>> >> > have a smp_mb__after_non_raw_spinlock or something with a much better naming,
>> >> > which would allow removing the extra barrier when it is implied by the
>> >> > spinlock.
>> >> 
>> >> Oh, right, fair enough. I'll go think about if smp_mb__after_spinlock()
>> >> will work for mutexes too.
>> >> 
>> >> It basically needs to upgrade atomic*_acquire() to smp_mb(). So that's
>> >> all architectures that have their own _acquire() and an actual
>> >> smp_mb__after_atomic().
>> >> 
>> >> Which, from the top of my head are only arm64, power and possibly riscv.
>> >> And if I then git-grep smp_mb__after_spinlock, all those seem to be
>> >> covered.
>> >> 
>> >> But let me do a better audit..
>> > 
>> > All I could find is csky, which, afaict, defines a superfluous
>> > smp_mb__after_spinlock.
>> > 
>> > The relevant architectures are indeed power, arm64 and riscv, they all
>> > have custom acquire/release and all define smp_mb__after_spinlock()
>> > appropriately.
>> > 
>> > Should we rename it to smp_mb__after_acquire() ?
>> 
>> As discussed over IRC, smp_mb__after_atomic_acquire() would be better, because
>> load_acquire and spin_lock have different semantic.
> 
> Just to clarify here, are you talking about acquire on atomic RMW operations
> being different to non-RMW operations, or are you talking about
> atomic_read_acquire() being different to smp_load_acquire() (which I don't
> think is the case, but wanted to check)?

I was referring to the two following APIs:

- spin_lock()
- smp_load_acquire()

on x86, spin_lock() happens to be implemented with an atomic instruction, which
implies a full memory barrier. However, its smp_load_acquire() does not provide
a full memory barrier. Therefore, if we implement a smp_mb__after_acquire() as
proposed by Peter, we could expect it to cover both APIs, which is tricky to do
efficiently without adding a superfluous barrier.

Hence the discussion about make its naming more specific, so it does not cover
smp_load_acquire.

> 
> We need to write this stuff down.
> 
>> We could keep a define of smp_mb__after_spinlock to smp_mb__after_atomic_acquire
>> to make the transition simpler.
> 
> I'm not sure I really see the benefit of the rename, to be honest with you,
> especially if smp_mb__after_spinlock() doesn't disappear at the same time.
> The only reason you'd use this barrier is because the atomic is hidden away
> behind a locking API, otherwise you'd just have used the full-barrier variant
> of the atomic op to start with, wouldn't you?

Good point.

As long as we can state that smp_mb__after_spinlock applies both to raw_spinlock
and non-raw spinlock (which AFAIU are mutexes on RT), I think it would suffice for
our immediate needs.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
