Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71AE2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ni6sIR0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHXP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:28:09 -0400
Received: from mail.efficios.com ([167.114.26.124]:34856 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgHXP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:27:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CA17524B433;
        Mon, 24 Aug 2020 11:27:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JI11sT3keksC; Mon, 24 Aug 2020 11:27:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3E03E24B430;
        Mon, 24 Aug 2020 11:27:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3E03E24B430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1598282869;
        bh=k/FdiPr2ljyOg552ab2M3cf84irwVHEhJWysUBT9k9g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Ni6sIR0PEc0CgtxVKZ6wMIzbQLDCkss7nxiW46dTEyDGBmXV1o4xpP5c3ZK/4x9xs
         3DXZGmkoG/0Kq/SbYlsaUWlJBVnaJeu+P8O1Ft2uozdPTpt0BpZxKqRZIBuygV/uZy
         Z95bDo2v5iaKVoWZTI1y/irli//d0B/yNqNWclGJ2Ee0REScmqVTznLbVsvXAN1tND
         syWol4QMIDiXtEhgeC63MoNJd7ZXOsq9hPUv1WYHSDKzQiQDriXiskHlTzIfrBEcfo
         Hnu9MkX0FltWdgQtMBWXKeETP0vclvB6Fy/DDDwbm7cq5+4W6HVbw3HVzRY/sJyXSy
         +exTORLV6+JpA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lVS9NMqoVrkb; Mon, 24 Aug 2020 11:27:49 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2F35124B8E7;
        Mon, 24 Aug 2020 11:27:49 -0400 (EDT)
Date:   Mon, 24 Aug 2020 11:27:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>
Message-ID: <764014395.16126.1598282869127.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200816152907.GB87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com> <20200814164358.4783-3-mathieu.desnoyers@efficios.com> <20200816152907.GB87259@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v2)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: sched: membarrier: cover kthread_use_mm (v2)
Thread-Index: s276cd/5raHQhg/Q8ooEoMEfpwMdNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 16, 2020, at 11:29 AM, Boqun Feng boqun.feng@gmail.com wrote:

> On Fri, Aug 14, 2020 at 12:43:57PM -0400, Mathieu Desnoyers wrote:
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
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> Changes since v1:
>> - Add WARN_ON_ONCE(current->mm) in play_idle_precise (PeterZ),
>> - Use smp_mb__after_spinlock rather than smp_mb after task_lock.
>> ---
>>  kernel/kthread.c          | 19 +++++++++++++++++++
>>  kernel/sched/idle.c       |  1 +
>>  kernel/sched/membarrier.c |  8 ++------
>>  3 files changed, 22 insertions(+), 6 deletions(-)
>> 
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 3edaa380dc7b..77aaaa7bc8d9 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -1255,8 +1255,19 @@ void kthread_use_mm(struct mm_struct *mm)
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
>> +	 * mmdrop(), or explicitly with smp_mb().
>> +	 */
>>  	if (active_mm != mm)
>>  		mmdrop(active_mm);
>> +	else
>> +		smp_mb();
> 
> Similar question here: could smp_mb() guarantee the correctness of
> GLOBAL_EXPEDITED? Don't you need membarrier_switch_mm() here and in
> kthread_unuse_mm(), too?
> 
> Am I miss something here?

I think you have a good point there. Which brings me to wonder why we
don't have membarrier_switch_mm() when entering/leaving lazy TLB mode.
This means an IPI can be sent to a kthread even if it does not use an
mm, just because the membarrier state in the runqueue is that of the
active_mm.

Thoughts ?

Thanks,

Mathieu

> 
> Regards,
> Boqun
> 
>>  
>>  	to_kthread(tsk)->oldfs = force_uaccess_begin();
>>  }
>> @@ -1276,6 +1287,14 @@ void kthread_unuse_mm(struct mm_struct *mm)
>>  	force_uaccess_end(to_kthread(tsk)->oldfs);
>>  
>>  	task_lock(tsk);
>> +	/*
>> +	 * When a kthread stops operating on an address space, the loop
>> +	 * in membarrier_{private,global}_expedited() may not observe
>> +	 * that tsk->mm, and not issue an IPI. Membarrier requires a
>> +	 * memory barrier after accessing user-space memory, before
>> +	 * clearing tsk->mm.
>> +	 */
>> +	smp_mb__after_spinlock();
>>  	sync_mm_rss(mm);
>>  	local_irq_disable();
>>  	tsk->mm = NULL;
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index 6bf34986f45c..3443ee8335d0 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -341,6 +341,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
>>  	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
>>  	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
>>  	WARN_ON_ONCE(!duration_ns);
>> +	WARN_ON_ONCE(current->mm);
>>  
>>  	rcu_sleep_check();
>>  	preempt_disable();
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
>>  
>>  		__cpumask_set_cpu(cpu, tmpmask);
>> --
>> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
