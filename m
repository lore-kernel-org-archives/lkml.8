Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6054C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C68C2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1G+m2tS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgB1K1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:27:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1K1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:27:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SANa1W174884;
        Fri, 28 Feb 2020 10:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Sni9SQmZt0vQE/4J6rZo4v/IgF0TKZiuJcoFD/kUFmM=;
 b=a1G+m2tS15cDXqklJe8r73SNtSY3R2jBaBThnZ5d5PtTg31ncCmKnRWffBdhiS2miNg+
 FhMh2Pszoba6+WsmQeybuEP37K9B4ooIo8RlggSzX5vuVg21ASbCz59FxwzHHVEVEsvu
 d7b6aSuoazNYX0/DXp97pUsnqEaSdbwe+Yu8Vyv1+15BCWpYfyhIqz/gQEhll13NhcFK
 1KKliAruAfSRKkkNAOVhHj8lfNdIS8Wms12lTETugyVcSfBfKn/eGUY5u1R2PxeO/wR6
 o4mx94Im9Fu3sAooY77XvcyUbplnwnWCc/yLmRZZ20cB78Sh0BK4ccsHnr2BvLCj/lYB aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ydcsnt340-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 10:27:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SAIA11189755;
        Fri, 28 Feb 2020 10:27:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ydj4qd8dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 10:27:06 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01SAR0b6017381;
        Fri, 28 Feb 2020 10:27:00 GMT
Received: from [10.39.209.75] (/10.39.209.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 02:27:00 -0800
Subject: Re: [patch 04/24] x86/entry: Distangle idtentry
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.575747087@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <f45d95ca-e754-9c26-64c2-ad806bc7f5d2@oracle.com>
Date:   Fri, 28 Feb 2020 11:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.575747087@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 11:16 PM, Thomas Gleixner wrote:
> idtentry is a completely unreadable maze. Split it into distinct idtentry
> variants which only contain the minimal code:
> 
>    - idtentry for regular exceptions
>    - idtentry_mce_debug for #MCE and #DB
>    - idtentry_df for #DF
> 
> The generated binary code is equivalent.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_64.S |  402 +++++++++++++++++++++++++---------------------
>   1 file changed, 220 insertions(+), 182 deletions(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -37,6 +37,7 @@
>   #include <asm/pgtable_types.h>
>   #include <asm/export.h>
>   #include <asm/frame.h>
> +#include <asm/trapnr.h>
>   #include <asm/nospec-branch.h>
>   #include <linux/err.h>
>   
> @@ -490,6 +491,202 @@ SYM_CODE_END(spurious_entries_start)
>   	decl	PER_CPU_VAR(irq_count)
>   .endm
>   
> +/**
> + * idtentry_body - Macro to emit code calling the C function
> + * @vector:		Vector number
> + * @cfunc:		C function to be called
> + * @has_error_code:	Hardware pushed error code on stack
> + */
> +.macro idtentry_body vector cfunc has_error_code:req
> +
> +	call	error_entry
> +	UNWIND_HINT_REGS
> +
> +	.if \vector == X86_TRAP_PF
> +		/*
> +		 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
> +		 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
> +		 * GET_CR2_INTO can clobber RAX.
> +		 */
> +		GET_CR2_INTO(%r12);
> +	.endif
> +
> +	TRACE_IRQS_OFF
> +
> +#ifdef CONFIG_CONTEXT_TRACKING
> +	testb	$3, CS(%rsp)
> +	jz	.Lfrom_kernel_no_ctxt_tracking_\@
> +	CALL_enter_from_user_mode
> +.Lfrom_kernel_no_ctxt_tracking_\@:
> +#endif
> +
> +	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
> +
> +	.if \has_error_code == 1
> +		movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> +		movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> +	.else
> +		xorl	%esi, %esi		/* Clear the error code */
> +	.endif
> +
> +	.if \vector == X86_TRAP_PF
> +		movq	%r12, %rdx		/* Move CR2 into 3rd argument */
> +	.endif
> +
> +	call	\cfunc
> +
> +	jmp	error_exit
> +.endm
> +
> +/**
> + * idtentry - Macro to generate entry stubs for simple IDT entries
> + * @vector:		Vector number
> + * @asmsym:		ASM symbol for the entry point
> + * @cfunc:		C function to be called
> + * @has_error_code:	Hardware pushed error code on stack
> + *
> + * The macro emits code to set up the kernel context for straight forward
> + * and simple IDT entries. No IST stack, no paranoid entry checks.
> + */
> +.macro idtentry vector asmsym cfunc has_error_code:req

So the logic here is to remove idtentry non-generic argument (read_cr2, shift_ist,
ist_offset, create_gap) and instead have specific code depending on the vector
number, and the idtentry now has to reference the vector number.

Slight paranoid concern: we now have two different places where we associate a
vector number with a handler:

- in idt.c:
          INTG(X86_TRAP_DE,               divide_error),

- in entry_64.S:
idtentry	X86_TRAP_DE		divide_error		do_divide_error			has_error_code=0

Should we add a check to ensure the (vector number, handler) is the same at both
places?


> +SYM_CODE_START(\asmsym)
> +	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
> +	ASM_CLAC
> +
> +	.if \has_error_code == 0
> +		pushq	$-1			/* ORIG_RAX: no syscall to restart */
> +	.endif
> +
> +	.if \vector == X86_TRAP_BP
> +		/*
> +		 * If coming from kernel space, create a 6-word gap to allow the
> +		 * int3 handler to emulate a call instruction.
> +		 */
> +		testb	$3, CS-ORIG_RAX(%rsp)
> +		jnz	.Lfrom_usermode_no_gap_\@
> +		.rept	6
> +		pushq	5*8(%rsp)
> +		.endr
> +		UNWIND_HINT_IRET_REGS offset=8
> +.Lfrom_usermode_no_gap_\@:
> +	.endif
> +
> +	idtentry_body \vector \cfunc \has_error_code
> +
> +_ASM_NOKPROBE(\asmsym)
> +SYM_CODE_END(\asmsym)
> +.endm
> +
> +/*
> + * MCE and DB exceptions
> + */
> +#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
> +
> +/**
> + * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
> + * @vector:		Vector number
> + * @asmsym:		ASM symbol for the entry point
> + * @cfunc:		C function to be called
> + *
> + * The macro emits code to set up the kernel context for #MC and #DB
> + *
> + * If the entry comes from user space it uses the normal entry path
> + * including the return to user space work and preemption checks on
> + * exit.
> + *
> + * If hits in kernel mode then it needs to go through the paranoid
> + * entry as the exception can hit any random state. No preemption
> + * check on exit to keep the paranoid path simple.
> + *
> + * If the trap is #DB then the interrupt stack entry in the IST is
> + * moved to the second stack, so a potential recursion will have a
> + * fresh IST.
> + */
> +.macro idtentry_mce_db vector asmsym cfunc
> +SYM_CODE_START(\asmsym)
> +	UNWIND_HINT_IRET_REGS
> +	ASM_CLAC
> +
> +	pushq	$-1			/* ORIG_RAX: no syscall to restart */
> +
> +	/*
> +	 * If the entry is from userspace, switch stacks and treat it as
> +	 * a normal entry.
> +	 */
> +	testb	$3, CS-ORIG_RAX(%rsp)
> +	jnz	.Lfrom_usermode_switch_stack_\@
> +
> +	/*
> +	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
> +	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
> +	 */
> +	call	paranoid_entry
> +
> +	UNWIND_HINT_REGS
> +
> +	.if \vector == X86_TRAP_DB
> +		TRACE_IRQS_OFF_DEBUG
> +	.else
> +		TRACE_IRQS_OFF
> +	.endif
> +
> +	movq	%rsp, %rdi		/* pt_regs pointer */
> +	xorl	%esi, %esi		/* Clear the error code */
> +
> +	.if \vector == X86_TRAP_DB
> +		subq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
> +	.endif
> +
> +	call	\cfunc
> +
> +	.if \vector == X86_TRAP_DB
> +		addq	$DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
> +	.endif
> +
> +	jmp	paranoid_exit
> +
> +	/* Switch to the regular task stack and use the noist entry point */
> +.Lfrom_usermode_switch_stack_\@:
> +	idtentry_body vector \cfunc, has_error_code=0
> +
> +_ASM_NOKPROBE(\asmsym)
> +SYM_CODE_END(\asmsym)
> +.endm
> +
> +/*
> + * Double fault entry. Straight paranoid. No checks from which context
> + * this comes because for the espfix induced #DF this would do the wrong
> + * thing.
> + */
> +.macro idtentry_df vector asmsym cfunc
> +SYM_CODE_START(\asmsym)
> +	UNWIND_HINT_IRET_REGS offset=8
> +	ASM_CLAC
> +
> +	/*
> +	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
> +	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
> +	 */
> +	call	paranoid_entry
> +	UNWIND_HINT_REGS
> +
> +	/* Read CR2 early */
> +	GET_CR2_INTO(%r12);
> +
> +	TRACE_IRQS_OFF
> +
> +	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
> +	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> +	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> +	movq	%r12, %rdx		/* Move CR2 into 3rd argument */
> +	call	\cfunc
> +
> +	jmp	paranoid_exit
> +
> +_ASM_NOKPROBE(\asmsym)
> +SYM_CODE_END(\asmsym)
> +.endm
> +
>   /*
>    * Interrupt entry helper function.
>    *
> @@ -857,197 +1054,38 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
>   /*
>    * Exception entry points.
>    */
> -#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
> -
> -.macro idtentry_part do_sym, has_error_code:req, read_cr2:req, paranoid:req, shift_ist=-1, ist_offset=0
> -
> -	.if \paranoid
> -	call	paranoid_entry
> -	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
> -	.else
> -	call	error_entry
> -	.endif
> -	UNWIND_HINT_REGS
> -
> -	.if \read_cr2
> -	/*
> -	 * Store CR2 early so subsequent faults cannot clobber it. Use R12 as
> -	 * intermediate storage as RDX can be clobbered in enter_from_user_mode().
> -	 * GET_CR2_INTO can clobber RAX.
> -	 */
> -	GET_CR2_INTO(%r12);
> -	.endif
> -
> -	.if \shift_ist != -1
> -	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
> -	.else
> -	TRACE_IRQS_OFF
> -	.endif
> -
> -#ifdef CONFIG_CONTEXT_TRACKING
> -	.if \paranoid == 0
> -	testb	$3, CS(%rsp)
> -	jz	.Lfrom_kernel_no_context_tracking_\@
> -	CALL_enter_from_user_mode
> -.Lfrom_kernel_no_context_tracking_\@:
> -	.endif
> -#endif
> -
> -	movq	%rsp, %rdi			/* pt_regs pointer */
> -
> -	.if \has_error_code
> -	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
> -	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
> -	.else
> -	xorl	%esi, %esi			/* no error code */
> -	.endif
> -
> -	.if \shift_ist != -1
> -	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
> -	.endif
> -
> -	.if \read_cr2
> -	movq	%r12, %rdx			/* Move CR2 into 3rd argument */
> -	.endif
> -
> -	call	\do_sym
> -
> -	.if \shift_ist != -1
> -	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
> -	.endif
> -
> -	.if \paranoid
> -	/* this procedure expect "no swapgs" flag in ebx */
> -	jmp	paranoid_exit
> -	.else
> -	jmp	error_exit
> -	.endif
> -
> -.endm
> -
> -/**
> - * idtentry - Generate an IDT entry stub
> - * @sym:		Name of the generated entry point
> - * @do_sym:		C function to be called
> - * @has_error_code:	True if this IDT vector has an error code on the stack
> - * @paranoid:		non-zero means that this vector may be invoked from
> - *			kernel mode with user GSBASE and/or user CR3.
> - *			2 is special -- see below.
> - * @shift_ist:		Set to an IST index if entries from kernel mode should
> - *			decrement the IST stack so that nested entries get a
> - *			fresh stack.  (This is for #DB, which has a nasty habit
> - *			of recursing.)
> - * @create_gap:		create a 6-word stack gap when coming from kernel mode.
> - * @read_cr2:		load CR2 into the 3rd argument; done before calling any C code
> - *
> - * idtentry generates an IDT stub that sets up a usable kernel context,
> - * creates struct pt_regs, and calls @do_sym.  The stub has the following
> - * special behaviors:
> - *
> - * On an entry from user mode, the stub switches from the trampoline or
> - * IST stack to the normal thread stack.  On an exit to user mode, the
> - * normal exit-to-usermode path is invoked.
> - *
> - * On an exit to kernel mode, if @paranoid == 0, we check for preemption,
> - * whereas we omit the preemption check if @paranoid != 0.  This is purely
> - * because the implementation is simpler this way.  The kernel only needs
> - * to check for asynchronous kernel preemption when IRQ handlers return.
> - *
> - * If @paranoid == 0, then the stub will handle IRET faults by pretending
> - * that the fault came from user mode.  It will handle gs_change faults by
> - * pretending that the fault happened with kernel GSBASE.  Since this handling
> - * is omitted for @paranoid != 0, the #GP, #SS, and #NP stubs must have
> - * @paranoid == 0.  This special handling will do the wrong thing for
> - * espfix-induced #DF on IRET, so #DF must not use @paranoid == 0.
> - *
> - * @paranoid == 2 is special: the stub will never switch stacks.  This is for
> - * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
> - */
> -.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0 read_cr2=0
> -SYM_CODE_START(\sym)
> -	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
> -
> -	/* Sanity check */
> -	.if \shift_ist != -1 && \paranoid != 1
> -	.error "using shift_ist requires paranoid=1"
> -	.endif
> -
> -	.if \create_gap && \paranoid
> -	.error "using create_gap requires paranoid=0"
> -	.endif
> -
> -	ASM_CLAC
> -
> -	.if \has_error_code == 0
> -	pushq	$-1				/* ORIG_RAX: no syscall to restart */
> -	.endif
> -
> -	.if \paranoid == 1
> -	testb	$3, CS-ORIG_RAX(%rsp)		/* If coming from userspace, switch stacks */
> -	jnz	.Lfrom_usermode_switch_stack_\@
> -	.endif
> -
> -	.if \create_gap == 1
> -	/*
> -	 * If coming from kernel space, create a 6-word gap to allow the
> -	 * int3 handler to emulate a call instruction.
> -	 */
> -	testb	$3, CS-ORIG_RAX(%rsp)
> -	jnz	.Lfrom_usermode_no_gap_\@
> -	.rept	6
> -	pushq	5*8(%rsp)
> -	.endr
> -	UNWIND_HINT_IRET_REGS offset=8
> -.Lfrom_usermode_no_gap_\@:
> -	.endif
> -
> -	idtentry_part \do_sym, \has_error_code, \read_cr2, \paranoid, \shift_ist, \ist_offset
> -
> -	.if \paranoid == 1
> -	/*
> -	 * Entry from userspace.  Switch stacks and treat it
> -	 * as a normal entry.  This means that paranoid handlers
> -	 * run in real process context if user_mode(regs).
> -	 */
> -.Lfrom_usermode_switch_stack_\@:
> -	idtentry_part \do_sym, \has_error_code, \read_cr2, paranoid=0
> -	.endif
> -
> -_ASM_NOKPROBE(\sym)
> -SYM_CODE_END(\sym)
> -.endm
>   
> -idtentry divide_error			do_divide_error			has_error_code=0
> -idtentry overflow			do_overflow			has_error_code=0
> -idtentry int3				do_int3				has_error_code=0	create_gap=1
> -idtentry bounds				do_bounds			has_error_code=0
> -idtentry invalid_op			do_invalid_op			has_error_code=0
> -idtentry device_not_available		do_device_not_available		has_error_code=0
> -idtentry coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
> -idtentry invalid_TSS			do_invalid_TSS			has_error_code=1
> -idtentry segment_not_present		do_segment_not_present		has_error_code=1
> -idtentry stack_segment			do_stack_segment		has_error_code=1
> -idtentry general_protection		do_general_protection		has_error_code=1
> -idtentry spurious_interrupt_bug		do_spurious_interrupt_bug	has_error_code=0
> -idtentry coprocessor_error		do_coprocessor_error		has_error_code=0
> -idtentry alignment_check		do_alignment_check		has_error_code=1
> -idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
> +idtentry	X86_TRAP_DE		divide_error		do_divide_error			has_error_code=0
> +idtentry	X86_TRAP_OF		overflow		do_overflow			has_error_code=0
> +idtentry	X86_TRAP_BP		int3			do_int3				has_error_code=0
> +idtentry	X86_TRAP_BR		bounds			do_bounds			has_error_code=0
> +idtentry	X86_TRAP_UD		invalid_op		do_invalid_op			has_error_code=0
> +idtentry	X86_TRAP_NM		device_not_available	do_device_not_available		has_error_code=0
> +idtentry	X86_TRAP_OLD_MF		coprocessor_segment_overrun	do_coprocessor_segment_overrun	has_error_code=0
> +idtentry	X86_TRAP_TS		invalid_TSS		do_invalid_TSS			has_error_code=1
> +idtentry	X86_TRAP_NP		segment_not_present	do_segment_not_present		has_error_code=1
> +idtentry	X86_TRAP_SS		stack_segment		do_stack_segment		has_error_code=1
> +idtentry	X86_TRAP_GP		general_protection	do_general_protection		has_error_code=1
> +idtentry	X86_TRAP_SPURIOUS	spurious_interrupt_bug	do_spurious_interrupt_bug	has_error_code=0
> +idtentry	X86_TRAP_MF		coprocessor_error	do_coprocessor_error		has_error_code=0
> +idtentry	X86_TRAP_AC		alignment_check		do_alignment_check		has_error_code=1
> +idtentry	X86_TRAP_XF		simd_coprocessor_error	do_simd_coprocessor_error	has_error_code=0
>   
> -idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
> +idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
>   #ifdef CONFIG_KVM_GUEST
> -idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
> +idtentry	X86_TRAP_PF		async_page_fault	do_async_page_fault		has_error_code=1
>   #endif
>   
>   #ifdef CONFIG_X86_MCE
> -idtentry machine_check		do_mce			has_error_code=0 paranoid=1
> +idtentry_mce_db	X86_TRAP_MCE	 	machine_check		do_mce
>   #endif
> -idtentry debug			do_debug		has_error_code=0 paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
> -idtentry double_fault		do_double_fault		has_error_code=1 paranoid=2 read_cr2=1
> +idtentry_mce_db	X86_TRAP_DB		debug			do_debug
> +idtentry_df	X86_TRAP_DF		double_fault		do_double_fault
>   
>   #ifdef CONFIG_XEN_PV
> -idtentry hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
> -idtentry xennmi			do_nmi				has_error_code=0
> -idtentry xendebug		do_debug			has_error_code=0
> +idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0

Is it worth defining X86_TRAP_DUMMY=512 with an explanation comment?

In any case:

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


> +idtentry	X86_TRAP_NMI		xennmi			do_nmi				has_error_code=0
> +idtentry	X86_TRAP_DB		xendebug		do_debug			has_error_code=0
>   #endif
>   
>   	/*
> 
> 
