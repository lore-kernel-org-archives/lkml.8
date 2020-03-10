Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558A2C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF324677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5C1pYb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCJOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:04:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCJOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:04:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AE3F7w007778;
        Tue, 10 Mar 2020 14:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tmA+B5ZoHJ9yCSrn3VxvfaLD+xQtiRYNAjpJicXo2VE=;
 b=T5C1pYb9oHB3d8HnpM+s7BRNRyN6Z9wez8gPCX+mplF07jZppC9pZKpRG7Nx8OVIDEgb
 S5xI8e5QCD/8m/lTJlw/lqBSmH5GqtD5IR1ZLgpuJydUykS/n+Q+/Aj08yP/3RPLIBU4
 opmZBoRZypciyo+Jt8UItwALSgJkKMU5Psa5Gfpm237LNAUSKK+q02ajvcRfZYTVV5GA
 jVLcWOyvjzygqw0lzH2hxTNHCbhcos9CMPCz9uW3Z/UlPXyCZTbvtsemIm4xIoOl8oJZ
 xAbscnUw7oayKFsuee3a0oJlgCcq2VZ6S8xB1fWnJll/9xqfZsiawF5yTQCXywVHf++O dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yp7hm23d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 14:03:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AE2Qs5132062;
        Tue, 10 Mar 2020 14:03:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yp8nswtk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 14:03:46 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AE3ii6024764;
        Tue, 10 Mar 2020 14:03:45 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 07:03:44 -0700
Subject: Re: [patch part-II V2 12/13] x86/entry: Move irq flags tracing to
 prepare_exit_to_usermode()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222610.150951641@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <b3dbbb17-23c0-c43c-6df1-f94b0880d0c0@oracle.com>
Date:   Tue, 10 Mar 2020 15:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222610.150951641@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> This is another step towards more C-code and less convoluted ASM.
> 
> Note, that trace_hardirqs_on() is still incorrect vs. RCU idle when the
> tracepoint is used by e.g. BPF. Will be addressed in the next step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> 
> V2: New patch simplifying the conversion and addressing Alex' review
>      comment of redundant tracing.
> ---
>   arch/x86/entry/common.c          |    1 +
>   arch/x86/entry/entry_32.S        |   12 ++++--------
>   arch/x86/entry/entry_64.S        |    4 ----
>   arch/x86/entry/entry_64_compat.S |   14 +++++---------
>   4 files changed, 10 insertions(+), 21 deletions(-)


Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -253,6 +253,7 @@ static noinline void __prepare_exit_to_u
>   
>   	user_enter_irqoff();
>   	mds_user_clear_cpu_buffers();
> +	trace_hardirqs_on();
>   }
>   NOKPROBE_SYMBOL(prepare_exit_to_usermode);
>   
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -811,8 +811,7 @@ SYM_CODE_START(ret_from_fork)
>   	/* When we fork, we trace the syscall return in the child, too. */
>   	movl    %esp, %eax
>   	call    syscall_return_slowpath
> -	STACKLEAK_ERASE
> -	jmp     restore_all
> +	jmp     .Lsyscall_32_done
>   
>   	/* kernel thread */
>   1:	movl	%edi, %eax
> @@ -855,7 +854,7 @@ SYM_CODE_START_LOCAL(ret_from_exception)
>   	TRACE_IRQS_OFF
>   	movl	%esp, %eax
>   	call	prepare_exit_to_usermode
> -	jmp	restore_all
> +	jmp	restore_all_switch_stack
>   SYM_CODE_END(ret_from_exception)
>   
>   SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
> @@ -968,8 +967,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
>   
>   	STACKLEAK_ERASE
>   
> -/* Opportunistic SYSEXIT */
> -	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
> +	/* Opportunistic SYSEXIT */
>   
>   	/*
>   	 * Setup entry stack - we keep the pointer in %eax and do the
> @@ -1072,11 +1070,9 @@ SYM_FUNC_START(entry_INT80_32)
>   	movl	%esp, %eax
>   	call	do_int80_syscall_32
>   .Lsyscall_32_done:
> -
>   	STACKLEAK_ERASE
>   
> -restore_all:
> -	TRACE_IRQS_ON
> +restore_all_switch_stack:
>   	SWITCH_TO_ENTRY_STACK
>   	CHECK_AND_APPLY_ESPFIX
>   
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -172,8 +172,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
>   	movq	%rsp, %rsi
>   	call	do_syscall_64		/* returns with IRQs disabled */
>   
> -	TRACE_IRQS_ON			/* return enables interrupts */
> -
>   	/*
>   	 * Try to use SYSRET instead of IRET if we're returning to
>   	 * a completely clean 64-bit userspace context.  If we're not,
> @@ -340,7 +338,6 @@ SYM_CODE_START(ret_from_fork)
>   	UNWIND_HINT_REGS
>   	movq	%rsp, %rdi
>   	call	syscall_return_slowpath	/* returns with IRQs disabled */
> -	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
>   	jmp	swapgs_restore_regs_and_return_to_usermode
>   
>   1:
> @@ -617,7 +614,6 @@ SYM_CODE_START_LOCAL(common_interrupt)
>   .Lretint_user:
>   	mov	%rsp,%rdi
>   	call	prepare_exit_to_usermode
> -	TRACE_IRQS_ON
>   
>   SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
>   #ifdef CONFIG_DEBUG_ENTRY
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -132,8 +132,8 @@ SYM_FUNC_START(entry_SYSENTER_compat)
>   	movq	%rsp, %rdi
>   	call	do_fast_syscall_32
>   	/* XEN PV guests always use IRET path */
> -	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
> -		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
> +	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
> +		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
>   	jmp	sysret32_from_system_call
>   
>   .Lsysenter_fix_flags:
> @@ -244,8 +244,8 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
>   	movq	%rsp, %rdi
>   	call	do_fast_syscall_32
>   	/* XEN PV guests always use IRET path */
> -	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
> -		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
> +	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
> +		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
>   
>   	/* Opportunistic SYSRET */
>   sysret32_from_system_call:
> @@ -254,7 +254,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
>   	 * stack. So let's erase the thread stack right now.
>   	 */
>   	STACKLEAK_ERASE
> -	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
> +
>   	movq	RBX(%rsp), %rbx		/* pt_regs->rbx */
>   	movq	RBP(%rsp), %rbp		/* pt_regs->rbp */
>   	movq	EFLAGS(%rsp), %r11	/* pt_regs->flags (in r11) */
> @@ -393,9 +393,5 @@ SYM_CODE_START(entry_INT80_compat)
>   
>   	movq	%rsp, %rdi
>   	call	do_int80_syscall_32
> -.Lsyscall_32_done:
> -
> -	/* Go back to user mode. */
> -	TRACE_IRQS_ON
>   	jmp	swapgs_restore_regs_and_return_to_usermode
>   SYM_CODE_END(entry_INT80_compat)
> 
