Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B96C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEABD2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UsCuAQox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgHETw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:52:26 -0400
Received: from mail.efficios.com ([167.114.26.124]:32988 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgHEQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:51:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 138C32410FB;
        Wed,  5 Aug 2020 11:22:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g8E5Syga9F-S; Wed,  5 Aug 2020 11:22:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B55412410FA;
        Wed,  5 Aug 2020 11:22:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B55412410FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596640956;
        bh=PHVRLh6Cmkd9W13moPK4iqU63eBTINCfC1k584pKmOI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=UsCuAQoxDUQr2njf/HwYp6eQfL/v74fiL53wRUY4El3KPVlJInCE+k2vIf684o08J
         4Khc8GIIjYGHAaGqIyQIlNyhYEjKsE6ujAMP8j//4AEqevxRseZdFh4nM1SnIgITO0
         JWkZ+6q74w9XQKwGbKziCQIaMRrrB/w8z9A0wCWASaqUo9PUSH5D2qlZVUqWAqTYwF
         JhTlD9AvEzKIQ2OEdBHEvQYrFX/iKWRA6Cwp6L/g7WFjOiV9R3PlcCu9uzCfUgcEMB
         hvUlhOayDsR9a86J0ve/gs0k28fx/jKP2Ps7tpt5F2qI/Vfn9LAzWh9hfD9xoiVrgG
         kqz74o0d8TNFg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RFWI2s-X7TAy; Wed,  5 Aug 2020 11:22:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A308D241373;
        Wed,  5 Aug 2020 11:22:36 -0400 (EDT)
Date:   Wed, 5 Aug 2020 11:22:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <498869868.209.1596640956570.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200805105920.GB35926@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com> <20200728160010.3314-2-mathieu.desnoyers@efficios.com> <20200804145145.GM2657@hirez.programming.kicks-ass.net> <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com> <20200804170153.GO2657@hirez.programming.kicks-ass.net> <20200805105920.GB35926@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: membarrier: cover kthread_use_mm
Thread-Index: 5QouM8yhSnNFf8/xdSYji3LqtJUJCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 5, 2020, at 6:59 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Aug 04, 2020 at 07:01:53PM +0200, peterz@infradead.org wrote:
>> On Tue, Aug 04, 2020 at 10:59:33AM -0400, Mathieu Desnoyers wrote:
>> > ----- On Aug 4, 2020, at 10:51 AM, Peter Zijlstra peterz@infradead.org wrote:
>> > > On Tue, Jul 28, 2020 at 12:00:10PM -0400, Mathieu Desnoyers wrote:
>> 
>> > >>  	task_lock(tsk);
>> > >> +	/*
>> > >> +	 * When a kthread stops operating on an address space, the loop
>> > >> +	 * in membarrier_{private,global}_expedited() may not observe
>> > >> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> > >> +	 * memory barrier after accessing user-space memory, before
>> > >> +	 * clearing tsk->mm.
>> > >> +	 */
>> > >> +	smp_mb();
>> > >>  	sync_mm_rss(mm);
>> > >>  	local_irq_disable();
>> > > 
>> > > Would it make sense to put the smp_mb() inside the IRQ disable region?
>> > 
>> > I've initially placed it right after task_lock so we could eventually
>> > have a smp_mb__after_non_raw_spinlock or something with a much better naming,
>> > which would allow removing the extra barrier when it is implied by the
>> > spinlock.
>> 
>> Oh, right, fair enough. I'll go think about if smp_mb__after_spinlock()
>> will work for mutexes too.
>> 
>> It basically needs to upgrade atomic*_acquire() to smp_mb(). So that's
>> all architectures that have their own _acquire() and an actual
>> smp_mb__after_atomic().
>> 
>> Which, from the top of my head are only arm64, power and possibly riscv.
>> And if I then git-grep smp_mb__after_spinlock, all those seem to be
>> covered.
>> 
>> But let me do a better audit..
> 
> All I could find is csky, which, afaict, defines a superfluous
> smp_mb__after_spinlock.
> 
> The relevant architectures are indeed power, arm64 and riscv, they all
> have custom acquire/release and all define smp_mb__after_spinlock()
> appropriately.
> 
> Should we rename it to smp_mb__after_acquire() ?

As discussed over IRC, smp_mb__after_atomic_acquire() would be better, because
load_acquire and spin_lock have different semantic.

We could keep a define of smp_mb__after_spinlock to smp_mb__after_atomic_acquire
to make the transition simpler.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
