Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC8BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FCF246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R4eVEXdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgB0QrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:47:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbgB0QrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:47:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RGNrCP127406;
        Thu, 27 Feb 2020 16:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OedPbJmCQEZmdH7uYFQSe/e5cPijXE0M8sv3UkguQN0=;
 b=R4eVEXdHleOw59LawwO6VOaQElOWkzwa6DtxGjiPJ24qJDoLceFNOP1YEGgJzVwDdIwn
 yDHQ28yCFS4A8HZy7h9Xr62u3i569p4P4ucWsyvAVqECZkCbh/pPRNfN3HllYiDwhpxS
 Eb4qOMdXWBr/xZXslj8dadjaF/+XNEn9GG75FJEMDNS05dlmhaEhyZZFkIGE3llLUZCu
 yVH5N/G06z0hyIF+8pdV1RB5+JBYQDb4W1oistDI9XW0zuK2VvE8w1Im0kCMbanHMKKW
 tIxOf9mUEM+kqckjSSbT95Z9qipPf8NTTMBGcExv5q1CSxRledh+f1KDw+RmuxyFmHsz WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ydybcp78b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:46:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RGiSYr185970;
        Thu, 27 Feb 2020 16:46:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ydcs5nrqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 16:46:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01RGkP95000585;
        Thu, 27 Feb 2020 16:46:26 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 08:46:25 -0800
Subject: Re: [patch 8/8] x86/entry: Move irqflags tracing to
 do_int80_syscall_32()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221306.026841950@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <fee191b3-bcce-3a72-92ab-6c15992d3ece@oracle.com>
Date:   Thu, 27 Feb 2020 17:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221306.026841950@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 11:08 PM, Thomas Gleixner wrote:
> which cleans up the ASM maze.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c          |    8 +++++++-
>   arch/x86/entry/entry_32.S        |    9 ++-------
>   arch/x86/entry/entry_64_compat.S |   14 +++++---------
>   3 files changed, 14 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -333,6 +333,7 @@ void do_syscall_64_irqs_on(unsigned long
>   {
>   	syscall_entry_fixups();
>   	do_syscall_64_irqs_on(nr, regs);
> +	trace_hardirqs_on();
>   }

trace_hardirqs_on() is already called through syscall_return_slowpath()
(from the previous patch):

do_syscall_64()
   -> do_syscall_64_irqs_on()
     -> syscall_return_slowpath()
       -> trace_hardirqs_on()

>   NOKPROBE_SYMBOL(do_syscall_64);
>   #endif
> @@ -389,6 +390,7 @@ static __always_inline void do_syscall_3
>   {
>   	syscall_entry_fixups();
>   	do_syscall_32_irqs_on(regs);
> +	trace_hardirqs_on();
>   }

Same here:

do_int80_syscall_32()
   -> do_syscall_32_irqs_on()
     -> syscall_return_slowpath()
       -> trace_hardirqs_on()

>   NOKPROBE_SYMBOL(do_int80_syscall_32);
>   
> @@ -468,8 +470,12 @@ static __always_inline long do_fast_sysc
>   /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
>   __visible notrace long do_fast_syscall_32(struct pt_regs *regs)
>   {
> +	long ret;
> +
>   	syscall_entry_fixups();
> -	return do_fast_syscall_32_irqs_on(regs);
> +	ret = do_fast_syscall_32_irqs_on(regs);
> +	trace_hardirqs_on();
> +	return ret;
>   }
>   NOKPROBE_SYMBOL(do_fast_syscall_32);

Same here:

   do_fast_syscall_32()
     -> do_fast_syscall_32_irqs_on()
       -> do_syscall_32_irqs_on()
         -> syscall_return_slowpath()
           -> trace_hardirqs_on()

Except for one case (if the get_user() call is true in
do_fast_syscall_32_irqs_on()):

   do_fast_syscall_32()
     -> do_fast_syscall_32_irqs_on()
       -> prepare_exit_to_usermode()

So we need to call trace_hardirqs_on() but only in that case:

static __always_inline long do_fast_syscall_32_irqs_on(struct pt_regs *regs)
{
           ...
	if (
#ifdef CONFIG_X86_64
		/*
		 * Micro-optimization: the pointer we're following is explicitly
		 * 32 bits, so it can't be out of range.
		 */
		__get_user(*(u32 *)&regs->bp,
			    (u32 __user __force *)(unsigned long)(u32)regs->sp)
#else
		get_user(*(u32 *)&regs->bp,
			 (u32 __user __force *)(unsigned long)(u32)regs->sp)
#endif
		) {

		/* User code screwed up. */
		local_irq_disable();
		regs->ax = -EFAULT;
		prepare_exit_to_usermode(regs);
                 trace_hardirqs_on();                <<<=== HERE
		return 0;	/* Keep it simple: use IRET. */
	}
         ...
}

alex.


> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -811,8 +811,7 @@ SYM_CODE_START(ret_from_fork)
>   	/* When we fork, we trace the syscall return in the child, too. */
>   	movl    %esp, %eax
>   	call    syscall_return_slowpath
> -	STACKLEAK_ERASE
> -	jmp     restore_all_switch_stack
> +	jmp     .Lsyscall_32_done
>   
>   	/* kernel thread */
>   1:	movl	%edi, %eax
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
> @@ -1072,11 +1070,8 @@ SYM_FUNC_START(entry_INT80_32)
>   	movl	%esp, %eax
>   	call	do_int80_syscall_32
>   .Lsyscall_32_done:
> -
>   	STACKLEAK_ERASE
>   
> -restore_all:
> -	TRACE_IRQS_IRET
>   restore_all_switch_stack:
>   	SWITCH_TO_ENTRY_STACK
>   	CHECK_AND_APPLY_ESPFIX
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
