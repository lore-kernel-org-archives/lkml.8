Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C697FC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C8920658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="emVIIeWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgCQKsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:48:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28210 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQKsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:48:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hVJQ1HStz9v9FD;
        Tue, 17 Mar 2020 11:48:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=emVIIeWl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HJvjTYux4trp; Tue, 17 Mar 2020 11:48:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hVJP6k7nz9v9Dv;
        Tue, 17 Mar 2020 11:48:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584442101; bh=wLdjv3dVY0RXsHL3a5X6PrKv3uQSB4fvS8ryPLQU0ZE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=emVIIeWlficGn6I1qT7B8GjLh/33KCDgCbn7757pX1msComrs9eTY+dAcBi+kGti8
         6c011tbl3H6Rp0Lr8i4XEikOGw83HGbZVIu+ptP+phCneSmsv02fpTOCGeorgIBBfG
         wtLjesVln1UqCJnGxzQp9y42kXHua0iyyG7VsA14=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CF32C8B787;
        Tue, 17 Mar 2020 11:48:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HxQiT3sW3VxQ; Tue, 17 Mar 2020 11:48:22 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B19818B785;
        Tue, 17 Mar 2020 11:48:14 +0100 (CET)
Subject: Re: [PATCH 10/15] powerpc/watchpoint: Use loop for
 thread_struct->ptrace_bps
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-11-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0eeeac90-b5e3-722b-2d2c-bb95c81d851a@c-s.fr>
Date:   Tue, 17 Mar 2020 11:48:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-11-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
> ptrace_bps is already an array of size HBP_NUM_MAX. But we use
> hardcoded index 0 while fetching/updating it. Convert such code
> to loop over array.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/kernel/hw_breakpoint.c |  7 +++++--
>   arch/powerpc/kernel/process.c       |  6 +++++-
>   arch/powerpc/kernel/ptrace.c        | 28 +++++++++++++++++++++-------
>   3 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index f4d48f87dcb8..b27aca623267 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -419,10 +419,13 @@ NOKPROBE_SYMBOL(hw_breakpoint_exceptions_notify);
>    */
>   void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>   {
> +	int i;
>   	struct thread_struct *t = &tsk->thread;
>   
> -	unregister_hw_breakpoint(t->ptrace_bps[0]);
> -	t->ptrace_bps[0] = NULL;
> +	for (i = 0; i < nr_wp_slots(); i++) {
> +		unregister_hw_breakpoint(t->ptrace_bps[i]);
> +		t->ptrace_bps[i] = NULL;
> +	}
>   }
>   
>   void hw_breakpoint_pmu_read(struct perf_event *bp)
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 42ff62ef749c..b9ab740fcacf 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1628,6 +1628,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>   	void (*f)(void);
>   	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
>   	struct thread_info *ti = task_thread_info(p);
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	int i;
> +#endif

Could we avoid all those #ifdefs ?

I think if we make p->thread.ptrace_bps[] exist all the time, with a 
size of 0 when CONFIG_HAVE_HW_BREAKPOINT is not set, then we can drop a 
lot of #ifdefs.

>   
>   	klp_init_thread_info(p);
>   
> @@ -1687,7 +1690,8 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>   	p->thread.ksp_limit = (unsigned long)end_of_stack(p);
>   #endif
>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
> -	p->thread.ptrace_bps[0] = NULL;
> +	for (i = 0; i < nr_wp_slots(); i++)
> +		p->thread.ptrace_bps[i] = NULL;
>   #endif
>   
>   	p->thread.fp_save_area = NULL;
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index f6d7955fc61e..e2651f86d56f 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c

You'll have to rebase all this on the series 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=161356 
which is about to go into powerpc-next

> @@ -2829,6 +2829,19 @@ static int set_dac_range(struct task_struct *child,
>   }
>   #endif /* CONFIG_PPC_ADV_DEBUG_DAC_RANGE */
>   
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +static int empty_ptrace_bp(struct thread_struct *thread)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_wp_slots(); i++) {
> +		if (!thread->ptrace_bps[i])
> +			return i;
> +	}
> +	return -1;
> +}
> +#endif

What does this function do exactly ? I seems to do more than what its 
name suggests.

> +
>   #ifndef CONFIG_PPC_ADV_DEBUG_REGS
>   static int empty_hw_brk(struct thread_struct *thread)
>   {
> @@ -2915,8 +2928,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
>   		len = 1;
>   	else
>   		return -EINVAL;
> -	bp = thread->ptrace_bps[0];
> -	if (bp)
> +
> +	i = empty_ptrace_bp(thread);
> +	if (i < 0)
>   		return -ENOSPC;
>   
>   	/* Create a new breakpoint request if one doesn't exist already */
> @@ -2925,14 +2939,14 @@ static long ppc_set_hwdebug(struct task_struct *child,
>   	attr.bp_len = len;
>   	arch_bp_generic_fields(brk.type, &attr.bp_type);
>   
> -	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
> +	thread->ptrace_bps[i] = bp = register_user_hw_breakpoint(&attr,
>   					       ptrace_triggered, NULL, child);
>   	if (IS_ERR(bp)) {
> -		thread->ptrace_bps[0] = NULL;
> +		thread->ptrace_bps[i] = NULL;
>   		return PTR_ERR(bp);
>   	}
>   
> -	return 1;
> +	return i + 1;
>   #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>   
>   	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
> @@ -2979,10 +2993,10 @@ static long ppc_del_hwdebug(struct task_struct *child, long data)
>   		return -EINVAL;
>   
>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
> -	bp = thread->ptrace_bps[0];
> +	bp = thread->ptrace_bps[data - 1];

Is data checked somewhere to ensure it is not out of boundaries ? Or are 
we sure it is always within ?

>   	if (bp) {
>   		unregister_hw_breakpoint(bp);
> -		thread->ptrace_bps[0] = NULL;
> +		thread->ptrace_bps[data - 1] = NULL;
>   	} else
>   		ret = -ENOENT;
>   	return ret;
> 


Christophe
