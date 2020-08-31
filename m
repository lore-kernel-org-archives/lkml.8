Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005ACC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC1821556
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NcchU9d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgHaPfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:35:11 -0400
Received: from mail.efficios.com ([167.114.26.124]:45058 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgHaPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:35:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 562C21CD4BA;
        Mon, 31 Aug 2020 11:34:59 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Vx6_xCq9ojVR; Mon, 31 Aug 2020 11:34:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D8B431CD270;
        Mon, 31 Aug 2020 11:34:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D8B431CD270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1598888098;
        bh=2Mam6DCLSCuSURMpjNaNaU52T6GrKrgXhYodBd4J1GU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NcchU9d9SZZg7LMgNSKDxZ+MXG8ran11AWQhGfpbNbuQUFEqRu5baTOurx+zAnFjt
         SfhOx3VEBdOBnEi8jku4lBY3tfZqUlQokmdIY/HyTMZy1OeFe3IvCcH5k9R+gBSJyR
         0KR51a6Z1JGaI0OZ97LuY2AMRjWE/teYijeOmDfYkdTU5QK799v21GJP4mU+s6AWnv
         JZcth9mfbgCZ84eNVoZl80E0jZqTjeD3RCvLbYRPuNl3NDo+970q0u0+KqD8fTmqwa
         kzACbCdIZ7994FzDDCaBfCGXH6NZSys3uwt0lCw6cox4M4F7nzwt0FBC1Ipx+K7hc4
         AZcU4pbmFu+5g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xw98-Ow0WDcx; Mon, 31 Aug 2020 11:34:58 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BDF5E1CD0DE;
        Mon, 31 Aug 2020 11:34:58 -0400 (EDT)
Date:   Mon, 31 Aug 2020 11:34:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <2086453141.23738.1598888098693.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200826230225.3782486-1-posk@google.com>
References: <20200826230225.3782486-1-posk@google.com>
Subject: Re: [PATCH 1/2 v5] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq/membarrier: add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: r7ar8Clu9Qv76aXZZzDu5muK3/7YYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On Aug 26, 2020, at 7:02 PM, Peter Oskolkov posk@google.com wrote:
[...]
> 
> static void ipi_mb(void *info)
> {
> +#ifdef CONFIG_RSEQ
> +	int *flags = info;
> +
> +	if (flags && (*flags == MEMBARRIER_FLAG_RSEQ))
> +		rseq_preempt(current);
> +#endif

Please lift this into a new ipi_rseq(), which will be defined as an empty function
if RSEQ is not defined.


> 	smp_mb();	/* IPIs should be serializing but paranoid. */
> }
> 
> @@ -129,19 +143,26 @@ static int membarrier_global_expedited(void)
> 	return 0;
> }
> 
> -static int membarrier_private_expedited(int flags)
> +static int membarrier_private_expedited(int flags, int cpu_id)
> {
> 	int cpu;
> 	cpumask_var_t tmpmask;
> 	struct mm_struct *mm = current->mm;
> 
> -	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
> +	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {

I'm not sure why we need to change the behavior from a mask on flags to
an equality, which means this behaves more like a list of items rather
than flags.

It's one thing to disallow combining things like SYNC_CORE and RSEQ in the
ABI, but I wonder why we need to change the flags behavior to an equality
for the internal flags.

> 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
> 			return -EINVAL;
> 		if (!(atomic_read(&mm->membarrier_state) &
> 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
> 			return -EPERM;
> +	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
> +		if (!IS_ENABLED(CONFIG_RSEQ))
> +			return -EINVAL;
> +		if (!(atomic_read(&mm->membarrier_state) &
> +		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
> +			return -EPERM;
> 	} else {
> +		BUG_ON(flags != 0);
> 		if (!(atomic_read(&mm->membarrier_state) &
> 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
> 			return -EPERM;
> @@ -174,6 +195,8 @@ static int membarrier_private_expedited(int flags)
> 		 */
> 		if (cpu == raw_smp_processor_id())
> 			continue;
> +		if (cpu_id >= 0 && cpu != cpu_id)
> +			continue;

When the cpu is specified, it seems rather inefficient to iterate on all
cpus to skip all but the one we are looking for. I suspect we don't want
to go through the loop in that case.

> 		p = rcu_dereference(cpu_rq(cpu)->curr);
> 		if (p && p->mm == mm)
> 			__cpumask_set_cpu(cpu, tmpmask);
> @@ -181,7 +204,7 @@ static int membarrier_private_expedited(int flags)
> 	rcu_read_unlock();
> 
> 	preempt_disable();
> -	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
> +	smp_call_function_many(tmpmask, ipi_mb, &flags, 1);
> 	preempt_enable();
> 
> 	free_cpumask_var(tmpmask);
> @@ -283,11 +306,18 @@ static int membarrier_register_private_expedited(int
> flags)
> 	    set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED,
> 	    ret;
> 
> -	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
> +	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {

Same comment about changing this internal flags behavior from mask to equality.

> 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
> 			return -EINVAL;
> 		ready_state =
> 			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
> +	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
> +		if (!IS_ENABLED(CONFIG_RSEQ))
> +			return -EINVAL;
> +		ready_state =
> +			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY;
> +	} else {
> +		BUG_ON(flags != 0);
> 	}
> 
> 	/*
> @@ -299,6 +329,8 @@ static int membarrier_register_private_expedited(int flags)
> 		return 0;
> 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
> 		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
> +	if (flags & MEMBARRIER_FLAG_RSEQ)
> +		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ;

This one still behaves like a mask, so there is a discrepancy between registration
and action functions.

> 	atomic_or(set_state, &mm->membarrier_state);
> 	ret = sync_runqueues_membarrier_state(mm);
> 	if (ret)
> @@ -310,8 +342,15 @@ static int membarrier_register_private_expedited(int flags)
> 
> /**
>  * sys_membarrier - issue memory barriers on a set of threads
> - * @cmd:   Takes command values defined in enum membarrier_cmd.
> - * @flags: Currently needs to be 0. For future extensions.
> + * @cmd:    Takes command values defined in enum membarrier_cmd.
> + * @flags:  Currently needs to be 0 for all commands other than
> + *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ: in the latter
> + *          case it can be MEMBARRIER_CMD_FLAG_CPU, indicating that @cpu_id
> + *          contains the CPU on which to interrupt (= restart)
> + *          the RSEQ critical section.
> + * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
> + *          RSEQ CS should be interrupted (@cmd must be
> + *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
>  *
>  * If this system call is not implemented, -ENOSYS is returned. If the
>  * command specified does not exist, not available on the running
> @@ -337,9 +376,9 @@ static int membarrier_register_private_expedited(int flags)
>  *        smp_mb()           X           O            O
>  *        sys_membarrier()   O           O            O
>  */
> -SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
> +SYSCALL_DEFINE3(membarrier, int, cmd, int, flags, int, cpu_id)
> {
> -	if (unlikely(flags))
> +	if (unlikely(flags) && cmd != MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ)

I would prefer that we deal with flags and cpu_id entirely here rather than
half here, half below, with e.g.:

switch (cmd) {
case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
    if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
        return -EINVAL;
    break;
default:
    if (unlikely(flags))
        return -EINVAL;
}

if (!(flags & MEMBARRIER_CMD_FLAG_CPU))
    cpu_id = -1;

> 		return -EINVAL;
> 	switch (cmd) {
> 	case MEMBARRIER_CMD_QUERY:
> @@ -362,13 +401,21 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
> 	case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
> 		return membarrier_register_global_expedited();
> 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
> -		return membarrier_private_expedited(0);
> +		return membarrier_private_expedited(0, -1);

We can then change the -1 for cpu_id here.

> 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
> 		return membarrier_register_private_expedited(0);
> 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
> -		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
> +		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, -1);

And here.

> 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
> 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
> +	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
> +		if (flags == 0)
> +			return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, -1);
> +		if (flags == MEMBARRIER_CMD_FLAG_CPU)
> +			return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
> +		return -EINVAL;

and here we can just call:

   return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);

Thanks,

Mathieu

> +	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
> +		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
> 	default:
> 		return -EINVAL;
> 	}
> --
> 2.28.0.297.g1956fa8f8d-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
