Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC1C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00432205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GFWKRnSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgEGN7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:59:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38612 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgEGN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:59:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047DrVFT136671;
        Thu, 7 May 2020 13:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YU15r621OlxLZgZddfPSSDnCj4R1bA5V8aVSb2kNOP8=;
 b=GFWKRnSQVSx6QDERNdt/7spKSICV89ozDCeuTFEs8jXuYZ3VbkbbMbtdQp35eAIfGnkn
 6iR2qkVJNu//sYqLcOA1mKCxDyfAwUgxvdUIxYsP/lLYVGw4IVPNe6SKqLAGQWG6OmNq
 3yANHhl+Lth09I48l5GbBeQDaGo0qTUxDleSYS79qSJCQTiWRR06UTrc753DnH/U0hwd
 P0mHOHrKq745Rp2nyOCHkEajHfbvrhxBbNBYmgHI6PPNgU9wR7MzflucDb0Q8WLoZb2z
 c8EsieST2iK4wZmN1UZuTmVVmDeaQP4AWSejagjwJPc5Hhur2AMrgssmHb4/tj51+HEB uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq7c05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:58:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047DqtSx101341;
        Thu, 7 May 2020 13:56:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30sjdy51mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:56:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047DunhQ009977;
        Thu, 7 May 2020 13:56:49 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 06:56:49 -0700
Subject: Re: [patch V4 part 2 05/18] x86/entry: Move irq tracing on syscall
 entry to C-code
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200505134112.272268764@linutronix.de>
 <20200505134340.611961721@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <207acd23-4acb-3fd1-7c92-9f48c79fa059@oracle.com>
Date:   Thu, 7 May 2020 15:55:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134340.611961721@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:41 PM, Thomas Gleixner wrote:
> Now that the C entry points are safe, move the irq flags tracing code into
> the entry helper:
> 
>      - Invoke lockdep before calling into context tracking
> 
>      - Use the safe trace_hardirqs_on_prepare() trace function after context
>        tracking established state and RCU is watching.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c          |   21 +++++++++++++++++++--
>   arch/x86/entry/entry_32.S        |   12 ------------
>   arch/x86/entry/entry_64.S        |    2 --
>   arch/x86/entry/entry_64_compat.S |   18 ------------------
>   4 files changed, 19 insertions(+), 34 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -40,19 +40,36 @@
>   #include <trace/events/syscalls.h>
>   
>   #ifdef CONFIG_CONTEXT_TRACKING
> -/* Called on entry from user mode with IRQs off. */
> +/**
> + * enter_from_user_mode - Establish state when coming from user mode
> + *
> + * Syscall entry disables interrupts, but user mode is traced as interrupts
> + * enabled. Also with NO_HZ_FULL RCU might be idle.
> + *
> + * 1) Tell lockdep that interrupts are disabled
> + * 2) Invoke context tracking if enabled to reactivate RCU
> + * 3) Trace interrupts off state
> + */
>   __visible noinstr void enter_from_user_mode(void)
>   {
>   	enum ctx_state state = ct_state();
>   
> +	lockdep_hardirqs_off(CALLER_ADDR0);
>   	user_exit_irqoff();
>   
>   	instr_begin();
>   	CT_WARN_ON(state != CONTEXT_USER);
> +	trace_hardirqs_off_prepare();
>   	instr_end();
>   }
>   #else
> -static inline void enter_from_user_mode(void) {}
> +static __always_inline void enter_from_user_mode(void)
> +{
> +	lockdep_hardirqs_off(CALLER_ADDR0);
> +	instr_begin();
> +	trace_hardirqs_off_prepare();
> +	instr_end();
> +}
>   #endif
>   
>   static noinstr void exit_to_user_mode(void)
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -967,12 +967,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
>   	jnz	.Lsysenter_fix_flags
>   .Lsysenter_flags_fixed:
>   
> -	/*
> -	 * User mode is traced as though IRQs are on, and SYSENTER
> -	 * turned them off.
> -	 */
> -	TRACE_IRQS_OFF
> -
>   	movl	%esp, %eax
>   	call	do_fast_syscall_32
>   	/* XEN PV guests always use IRET path */
> @@ -1082,12 +1076,6 @@ SYM_FUNC_START(entry_INT80_32)
>   
>   	SAVE_ALL pt_regs_ax=$-ENOSYS switch_stacks=1	/* save rest */
>   
> -	/*
> -	 * User mode is traced as though IRQs are on, and the interrupt gate
> -	 * turned them off.
> -	 */
> -	TRACE_IRQS_OFF
> -
>   	movl	%esp, %eax
>   	call	do_int80_syscall_32
>   .Lsyscall_32_done:
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -167,8 +167,6 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
>   
>   	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
>   
> -	TRACE_IRQS_OFF
> -
>   	/* IRQs are off. */
>   	movq	%rax, %rdi
>   	movq	%rsp, %rsi
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -129,12 +129,6 @@ SYM_FUNC_START(entry_SYSENTER_compat)
>   	jnz	.Lsysenter_fix_flags
>   .Lsysenter_flags_fixed:
>   
> -	/*
> -	 * User mode is traced as though IRQs are on, and SYSENTER
> -	 * turned them off.
> -	 */
> -	TRACE_IRQS_OFF
> -
>   	movq	%rsp, %rdi
>   	call	do_fast_syscall_32
>   	/* XEN PV guests always use IRET path */
> @@ -247,12 +241,6 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_aft
>   	pushq   $0			/* pt_regs->r15 = 0 */
>   	xorl	%r15d, %r15d		/* nospec   r15 */
>   
> -	/*
> -	 * User mode is traced as though IRQs are on, and SYSENTER
> -	 * turned them off.
> -	 */
> -	TRACE_IRQS_OFF
> -
>   	movq	%rsp, %rdi
>   	call	do_fast_syscall_32
>   	/* XEN PV guests always use IRET path */
> @@ -403,12 +391,6 @@ SYM_CODE_START(entry_INT80_compat)
>   	xorl	%r15d, %r15d		/* nospec   r15 */
>   	cld
>   
> -	/*
> -	 * User mode is traced as though IRQs are on, and the interrupt
> -	 * gate turned them off.
> -	 */
> -	TRACE_IRQS_OFF
> -
>   	movq	%rsp, %rdi
>   	call	do_int80_syscall_32
>   .Lsyscall_32_done:
> 

enter_from_user_mode() is also called with the CALL_enter_from_user_mode macro,
which is used in interrupt_entry() and identry. Don't you need to also remove
the TRACE_IRQS_OFF there now?

alex.
