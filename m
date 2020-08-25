Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B49C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB082071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgHYJhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:37:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42451 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgHYJhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:37:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BbP632BtZzB09Zk;
        Tue, 25 Aug 2020 11:37:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VH4tJWpNzU26; Tue, 25 Aug 2020 11:37:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BbP631J8mzB09ZP;
        Tue, 25 Aug 2020 11:37:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52B5D8B806;
        Tue, 25 Aug 2020 11:37:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id uXubsWHjtDix; Tue, 25 Aug 2020 11:37:16 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F27A8B803;
        Tue, 25 Aug 2020 11:37:15 +0200 (CEST)
Subject: Re: [PATCH v5 5/8] powerpc/watchpoint: Fix exception handling for
 CONFIG_HAVE_HW_BREAKPOINT=N
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr
Cc:     mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
 <20200825043617.1073634-6-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <91d34b89-603a-fddc-ea0f-53a79b287eed@csgroup.eu>
Date:   Tue, 25 Aug 2020 11:37:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825043617.1073634-6-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/08/2020 à 06:36, Ravi Bangoria a écrit :
> On powerpc, ptrace watchpoint works in one-shot mode. i.e. kernel
> disables event every time it fires and user has to re-enable it.
> Also, in case of ptrace watchpoint, kernel notifies ptrace user
> before executing instruction.
> 
> With CONFIG_HAVE_HW_BREAKPOINT=N, kernel is missing to disable
> ptrace event and thus it's causing infinite loop of exceptions.
> This is especially harmful when user watches on a data which is
> also read/written by kernel, eg syscall parameters. In such case,
> infinite exceptions happens in kernel mode which causes soft-lockup.
> 
> Fixes: 9422de3e953d ("powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint registers")
> Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h  |  3 ++
>   arch/powerpc/kernel/process.c             | 48 +++++++++++++++++++++++
>   arch/powerpc/kernel/ptrace/ptrace-noadv.c |  5 +++
>   3 files changed, 56 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index 2eca3dd54b55..c72263214d3f 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -18,6 +18,7 @@ struct arch_hw_breakpoint {
>   	u16		type;
>   	u16		len; /* length of the target data symbol */
>   	u16		hw_len; /* length programmed in hw */
> +	u8		flags;
>   };
>   
>   /* Note: Don't change the first 6 bits below as they are in the same order
> @@ -37,6 +38,8 @@ struct arch_hw_breakpoint {
>   #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
>   				 HW_BRK_TYPE_HYP)
>   
> +#define HW_BRK_FLAG_DISABLED	0x1
> +
>   /* Minimum granularity */
>   #ifdef CONFIG_PPC_8xx
>   #define HW_BREAKPOINT_SIZE  0x4
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 016bd831908e..160fbbf41d40 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -636,6 +636,44 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
>   				    (void __user *)address);
>   }
>   #else	/* !CONFIG_PPC_ADV_DEBUG_REGS */
> +
> +static void do_break_handler(struct pt_regs *regs)
> +{
> +	struct arch_hw_breakpoint null_brk = {0};
> +	struct arch_hw_breakpoint *info;
> +	struct ppc_inst instr = ppc_inst(0);
> +	int type = 0;
> +	int size = 0;
> +	unsigned long ea;
> +	int i;
> +
> +	/*
> +	 * If underneath hw supports only one watchpoint, we know it
> +	 * caused exception. 8xx also falls into this category.
> +	 */
> +	if (nr_wp_slots() == 1) {
> +		__set_breakpoint(0, &null_brk);
> +		current->thread.hw_brk[0] = null_brk;
> +		current->thread.hw_brk[0].flags |= HW_BRK_FLAG_DISABLED;
> +		return;
> +	}
> +
> +	/* Otherwise findout which DAWR caused exception and disable it. */
> +	wp_get_instr_detail(regs, &instr, &type, &size, &ea);
> +
> +	for (i = 0; i < nr_wp_slots(); i++) {
> +		info = &current->thread.hw_brk[i];
> +		if (!info->address)
> +			continue;
> +
> +		if (wp_check_constraints(regs, instr, ea, type, size, info)) {
> +			__set_breakpoint(i, &null_brk);
> +			current->thread.hw_brk[i] = null_brk;
> +			current->thread.hw_brk[i].flags |= HW_BRK_FLAG_DISABLED;
> +		}
> +	}
> +}
> +
>   void do_break (struct pt_regs *regs, unsigned long address,
>   		    unsigned long error_code)
>   {
> @@ -647,6 +685,16 @@ void do_break (struct pt_regs *regs, unsigned long address,
>   	if (debugger_break_match(regs))
>   		return;
>   
> +	/*
> +	 * We reach here only when watchpoint exception is generated by ptrace
> +	 * event (or hw is buggy!). Now if CONFIG_HAVE_HW_BREAKPOINT is set,
> +	 * watchpoint is already handled by hw_breakpoint_handler() so we don't
> +	 * have to do anything. But when CONFIG_HAVE_HW_BREAKPOINT is not set,
> +	 * we need to manually handle the watchpoint here.
> +	 */
> +	if (!IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
> +		do_break_handler(regs);
> +
>   	/* Deliver the signal to userspace */
>   	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)address);
>   }
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> index 57a0ab822334..866597b407bc 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> @@ -286,11 +286,16 @@ long ppc_del_hwdebug(struct task_struct *child, long data)
>   	}
>   	return ret;
>   #else /* CONFIG_HAVE_HW_BREAKPOINT */
> +	if (child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED)

I think child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED 
should go around additionnal ()

> +		goto del;
> +
>   	if (child->thread.hw_brk[data - 1].address == 0)
>   		return -ENOENT;

What about replacing the above if by:
	if (!(child->thread.hw_brk[data - 1].flags) & HW_BRK_FLAG_DISABLED) &&
	    child->thread.hw_brk[data - 1].address == 0)
		return -ENOENT;

That would avoid the goto and the label.

>   
> +del:
>   	child->thread.hw_brk[data - 1].address = 0;
>   	child->thread.hw_brk[data - 1].type = 0;
> +	child->thread.hw_brk[data - 1].flags = 0;
>   #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>   
>   	return 0;
> 

Christophe
