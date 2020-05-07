Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCE2C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FA72075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DwMjZ44/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGORo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:17:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEGORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:17:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047EDCXd178455;
        Thu, 7 May 2020 14:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XDyBRvL5lI4I7H6ALABny559SkHoGb5mPvY4tScvgk4=;
 b=DwMjZ44/GDy4FUXGNwRPr3nVVFsxbo8nPtX8NqrlEXlhn5ZTOQ+LQulu2Ng0nJPNJQk9
 hLIkz/WA/fTktjv6sfjKG7oksiD0bskrL6g4nLzMfNdpcez4pJICDEmOoE3/9FjwlhJu
 URL7ChitNHBGkT3oIGnZVquIxM2qr9IEXXabkxIoOg+47ijCYsACylO4ACWoCnCIJlcW
 TrUBWY+dsVAQ/Xdp6Kte/wvXxzEYR3p/ZcIIfI0pxaAN+rxB81LyWo/hk3Q1xRL0mHXi
 ovAU4GDsgNX0ERhjw/XyX7zkYKvHlAopFAj8Bdp9ecMGrAZMiSL7CN30+ws/CUjSGVsm GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30usgq7f8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 14:16:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047EBXNY128249;
        Thu, 7 May 2020 14:16:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnpetg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 14:16:56 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047EGrjY000818;
        Thu, 7 May 2020 14:16:54 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 07:16:52 -0700
Subject: Re: [patch V4 part 2 10/18] x86/entry/64: Check IF in
 __preempt_enable_notrace() thunk
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
 <20200505134341.087595319@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <d9f8753c-7e12-a81b-37e8-e7345f2d0150@oracle.com>
Date:   Thu, 7 May 2020 16:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134341.087595319@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/20 3:41 PM, Thomas Gleixner wrote:
> The preempt_enable_notrace() ASM thunk is called from tracing, entry code
> RCU and other places which are already in or going to be in the noinstr
> section which protects sensitve code from being instrumented.

typo: "sensitve"

alex.

> Calls out of these sections happen with interrupts disabled, which is
> handled in C code, but the push regs, call, pop regs sequence can be
> completely avoided in this case.
> 
> This is also a preparatory step for annotating the call from the thunk to
> preempt_enable_notrace() safe from a noinstr section.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/thunk_64.S       |   27 +++++++++++++++++++++++----
>   arch/x86/include/asm/irqflags.h |    3 +--
>   arch/x86/include/asm/paravirt.h |    3 +--
>   3 files changed, 25 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/entry/thunk_64.S
> +++ b/arch/x86/entry/thunk_64.S
> @@ -9,10 +9,28 @@
>   #include "calling.h"
>   #include <asm/asm.h>
>   #include <asm/export.h>
> +#include <asm/irqflags.h>
> +
> +.code64
>   
>   	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
> -	.macro THUNK name, func, put_ret_addr_in_rdi=0
> +	.macro THUNK name, func, put_ret_addr_in_rdi=0, check_if=0
>   SYM_FUNC_START_NOALIGN(\name)
> +
> +	.if \check_if
> +	/*
> +	 * Check for interrupts disabled right here. No point in
> +	 * going all the way down
> +	 */
> +	pushq	%rax
> +	SAVE_FLAGS(CLBR_RAX)
> +	testl	$X86_EFLAGS_IF, %eax
> +	popq	%rax
> +	jnz	1f
> +	ret
> +1:
> +	.endif
> +
>   	pushq %rbp
>   	movq %rsp, %rbp
>   
> @@ -38,14 +56,15 @@ SYM_FUNC_END(\name)
>   	.endm
>   
>   #ifdef CONFIG_TRACE_IRQFLAGS
> -	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
> -	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
> +	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller, put_ret_addr_in_rdi=1
> +	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller, put_ret_addr_in_rdi=1
>   #endif
>   
>   #ifdef CONFIG_PREEMPTION
>   	THUNK preempt_schedule_thunk, preempt_schedule
> -	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
>   	EXPORT_SYMBOL(preempt_schedule_thunk)
> +
> +	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace, check_if=1
>   	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
>   #endif
>   
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -127,9 +127,8 @@ static inline notrace unsigned long arch
>   #define DISABLE_INTERRUPTS(x)	cli
>   
>   #ifdef CONFIG_X86_64
> -#ifdef CONFIG_DEBUG_ENTRY
> +
>   #define SAVE_FLAGS(x)		pushfq; popq %rax
> -#endif
>   
>   #define SWAPGS	swapgs
>   /*
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -907,14 +907,13 @@ extern void default_banner(void);
>   		  ANNOTATE_RETPOLINE_SAFE;				\
>   		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
>   
> -#ifdef CONFIG_DEBUG_ENTRY
>   #define SAVE_FLAGS(clobbers)                                        \
>   	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
>   		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
>   		  ANNOTATE_RETPOLINE_SAFE;			    \
>   		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
>   		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
> -#endif
> +
>   #endif /* CONFIG_PARAVIRT_XXL */
>   #endif	/* CONFIG_X86_64 */
>   
> 
