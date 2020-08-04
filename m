Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CFF21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CkttCXQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgHDO7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:59:50 -0400
Received: from mail.efficios.com ([167.114.26.124]:53520 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgHDO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:59:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1E42A2D7D34;
        Tue,  4 Aug 2020 10:59:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j61pavjEfe_F; Tue,  4 Aug 2020 10:59:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B03592D7F9E;
        Tue,  4 Aug 2020 10:59:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B03592D7F9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1596553173;
        bh=586Ig9PSGc+yUdvJdgfaWqOjTOAoEQnYWTHs3H8Yne0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CkttCXQD9FRdNGn7iULE/tJLO/t6zHskeRY1FOwmBj1MyGdHm6b0Gt9ReEF18JE+7
         QDDko8g1YDTSH3gwl4I5azfszwfaisF/rprwUmPSVA0QphpcSjCZxm0pN81gW4IZBH
         cMHZ1IQh/XzSy/pGgw32qdYvbzhRF7FlKEjtzJAdjAlXaF73b3h5bvmkiqnl8LINlW
         bMxAbwpN5UHIQ0xD82jm+9uiIfPDjJAuRYR8Dy3jsH+G4Paw/vcflZd+lz2G2YyVMj
         Rl05/jmJjDyW82cNGW3MO1r+fuk5Ge9nm6a4kTExscBReBAWstBEJLtjFS60pmJt7f
         qLdsYDbVPuY0Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AykP_FOrFIgL; Tue,  4 Aug 2020 10:59:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 689A02D7C5A;
        Tue,  4 Aug 2020 10:59:33 -0400 (EDT)
Date:   Tue, 4 Aug 2020 10:59:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200804145145.GM2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com> <20200728160010.3314-2-mathieu.desnoyers@efficios.com> <20200804145145.GM2657@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: membarrier: cover kthread_use_mm
Thread-Index: lJz/+qFGsVsWXklE3aHMpWTYdfNHyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 4, 2020, at 10:51 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 28, 2020 at 12:00:10PM -0400, Mathieu Desnoyers wrote:
>> Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
>> to allow the effect of membarrier(2) to apply to kthreads accessing
>> user-space memory as well.
>> 
>> Given that no prior kthread use this guarantee and that it only affects
>> kthreads, adding this guarantee does not affect user-space ABI.
>> 
>> Refine the check in membarrier_global_expedited to exclude runqueues
>> running the idle thread rather than all kthreads from the IPI cpumask.
>> 
>> This patch applies on top of this patch from Peter Zijlstra:
>> "mm: fix kthread_use_mm() vs TLB invalidate" currently in Andrew
>> Morton's tree.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  kernel/kthread.c          | 19 +++++++++++++++++++
>>  kernel/sched/membarrier.c |  8 ++------
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>> 
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 48925b17920e..ef2435517f14 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -1258,8 +1258,19 @@ void kthread_use_mm(struct mm_struct *mm)
>>  	finish_arch_post_lock_switch();
>>  #endif
>>  
>> +	/*
>> +	 * When a kthread starts operating on an address space, the loop
>> +	 * in membarrier_{private,global}_expedited() may not observe
>> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> +	 * memory barrier after storing to tsk->mm, before accessing
>> +	 * user-space memory. A full memory barrier for membarrier
>> +	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
>> +	 * mmdrop().
>> +	 */
>>  	if (active_mm != mm)
>>  		mmdrop(active_mm);
>> +	else
>> +		smp_mb();
>>  
>>  	to_kthread(tsk)->oldfs = get_fs();
>>  	set_fs(USER_DS);
>> @@ -1280,6 +1291,14 @@ void kthread_unuse_mm(struct mm_struct *mm)
>>  	set_fs(to_kthread(tsk)->oldfs);
>>  
>>  	task_lock(tsk);
>> +	/*
>> +	 * When a kthread stops operating on an address space, the loop
>> +	 * in membarrier_{private,global}_expedited() may not observe
>> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> +	 * memory barrier after accessing user-space memory, before
>> +	 * clearing tsk->mm.
>> +	 */
>> +	smp_mb();
>>  	sync_mm_rss(mm);
>>  	local_irq_disable();
> 
> Would it make sense to put the smp_mb() inside the IRQ disable region?

I've initially placed it right after task_lock so we could eventually
have a smp_mb__after_non_raw_spinlock or something with a much better naming,
which would allow removing the extra barrier when it is implied by the
spinlock.

I don't see moving the barrier inside the irq off region as having any
significant effect as far as membarrier is concern. Is it something you
need for tlb flush ?

> 
>>  	tsk->mm = NULL;
>> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
>> index 168479a7d61b..8a294483074d 100644
>> --- a/kernel/sched/membarrier.c
>> +++ b/kernel/sched/membarrier.c
>> @@ -100,13 +100,9 @@ static int membarrier_global_expedited(void)
>>  		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
>>  			continue;
>>  
>> -		/*
>> -		 * Skip the CPU if it runs a kernel thread. The scheduler
>> -		 * leaves the prior task mm in place as an optimization when
>> -		 * scheduling a kthread.
>> -		 */
>> +		/* Skip the CPU if it runs the idle thread. */
>>  		p = rcu_dereference(cpu_rq(cpu)->curr);
>> -		if (p->flags & PF_KTHREAD)
>> +		if (is_idle_task(p))
>>  			continue;
> 
> Do we want to add a:
> 
>	WARN_ON_ONCE(current->mm);
> 
> in play_idle_precise() ?
> 
> Because, if I read this right, we rely on the idle thread not having an
> mm.

Yes, that's a good idea.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
