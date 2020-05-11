Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4515C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FC62075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uV+sywWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgEKJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:09:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44732 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgEKJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:09:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04B96uEU050251;
        Mon, 11 May 2020 09:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wOBzKyy03D/2V4CE+FqXOu3btPJn2E7xfVbo2tN2DC0=;
 b=uV+sywWEiszZnTVE4n8BuMP00P51Y6rpJp5r6KW2akLbmFCPK/6VUFbWckbcLcJGp0/h
 sV2aH2U7KsVbqYok406Gl6VAE19B90GfBUuA6lS9VNPTZV+GWfTzBAc/sccySYHFYgBq
 J75tr+Z1mi2CzFwOmF1bUWE1p3bHK+j7zpOizX5pPFyuZNPbtAG6PuRWNvS4OQi/oYMV
 crKdOpMjgVbKp7TAgTKpnplvsGUI+AuRDO84Li0OIbiPF0ujzlBMiZNtawfoCHpbgkW+
 1W4JvszvHIdZ194MGP49VdgzMPLaTkKaZekKalX3kjp5AojiRlPkAQoxnp3pydTRjeGB iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30x3gsbw1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 09:08:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04B94QcW149497;
        Mon, 11 May 2020 09:08:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30xbgdgvv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 09:08:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04B98k5L015469;
        Mon, 11 May 2020 09:08:46 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 02:08:46 -0700
Subject: Re: [patch V4 part 5 02/31] x86/entry: Provide helpers for execute on
 irqstack
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
References: <20200505135341.730586321@linutronix.de>
 <20200505135828.316937774@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <7477e59e-50d9-3446-dce7-3aa07e74cf5f@oracle.com>
Date:   Mon, 11 May 2020 11:07:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505135828.316937774@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:53 PM, Thomas Gleixner wrote:
> Device interrupt handlers and system vector handlers are executed on the
> interrupt stack. The stack switch happens in the low level assembly entry
> code. This conflicts with the efforts to consolidate the exit code in C to
> ensure correctness vs. RCU and tracing.
> 
> As there is no way to move #DB away from IST due to the MOV SS issue, the
> requirements vs. #DB and NMI for switching to the interrupt stack do not
> exist anymore. The only requirement is that interrupts are disabled.
> 
> That allows to move the stack switching to C code which simplifies the
> entry/exit handling further because it allows to switch stacks after
> handling the entry and on exit before handling RCU, return to usermode and
> kernel preemption in the same way as for regular exceptions.
> 
> That also allows to move the xen hypercall extra magic code and the softirq
> stack switching into C.
> 
> The mechanism is straight forward:
> 
>    1) Store the current stack pointer on top of the interrupt stack. That's
>       required for the unwinder.
> 
>    2) Switch the stack pointer
> 
>    3) Call the function
> 
>    4) Restore the stackpointer
> 
> The full code sequence to make the unwinder happy is:
> 
>      	pushq	%rbp
> 	movq	%rsp, %rbp
> 	movq    $(top_of_hardirq_stack - 8), %reg
> 	movq	%rsp, (%reg)
>    	movq	%reg , %rsp
> 	call    function
> 	popq	%rsp
> 	leaveq
> 	
> While the following sequence would spare the 'popq %rsp':
> 
>      	pushq	%rbp
> 	movq    $(top_of_hardirq_stack - 8), %rbp
> 	movq	%rsp, (%rrbp)

Should be (%rbp) instead of  (%rrbp).


>    	xchgq	%rbp, %rsp
> 	call    function
>   	movq	%rbp, %rsp
> 	leaveq
> 
> but that requires further changes to objtool so that the unwinder works
> correctly. Can be done on top and is not critical for now.
> 
> Provide helper functions to check whether the interrupt stack is already
> active and whether stack switching is required.
> 
> 64 bit only for now. 32 bit has a variant of that already. Once this is
> cleaned up the two implementations might be consolidated as a cleanup on
> top.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/include/asm/irq_stack.h |   61 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> --- /dev/null
> +++ b/arch/x86/include/asm/irq_stack.h
...
> +/*
> + * Macro to emit code for running @func on the irq stack.
> + */
> +#define RUN_ON_IRQSTACK(func)	{					\
> +	unsigned long tos;						\
> +									\
> +	lockdep_assert_irqs_disabled();					\
> +									\
> +	tos = ((unsigned long)__this_cpu_read(hardirq_stack_ptr)) - 8;	\
> +									\
> +	__this_cpu_add(irq_count, 1);					\
> +	asm volatile(							\
> +		"pushq  %%rbp					\n"	\
> +		"movq   %%rsp, %%rbp				\n"	\
> +		"movq	%%rsp, (%[ts])				\n"	\
> +		"movq	%[ts], %%rsp				\n"	\
> +		"1:						\n"	\
> +		"	.pushsection .discard.instr_begin	\n"	\
> +		"	.long 1b - .				\n"	\
> +		"	.popsection				\n"	\
> +		"call	" __ASM_FORM(func) "			\n"	\
> +		"2:						\n"	\
> +		"	.pushsection .discard.instr_end		\n"	\
> +		"	.long 2b - .				\n"	\
> +		"	.popsection				\n"	\
> +		"popq	%%rsp					\n"	\
> +		"leaveq						\n"	\
> +		:							\
> +		: [ts] "r" (tos)					\
> +		: "memory"						\
> +		);							\
> +	__this_cpu_sub(irq_count, 1);					\
> +}

The pushsection/popsection discard.instr_begin/end sequences are used several
times in asm() statement at different places, so I wonder if it might be worth
having a macro.

In part 1, patch 20/36 adds instr_begin()/end(): they provide the sequence
but already encapsulated into an asm() statement, then we could do something
like this:

/* Begin/end of an instrumentation safe region */
#define instr_begin_insn(label)				\
	__stringify(label) ":\n\t"			\
	".pushsection .discard.instr_begin\n\t"		\
	".long " __stringify(label) "b - .\n\t"		\
	".popsection\n\t"

#define instr_end_insn(label)				\
	__stringify(label) ":\n\t"			\
	".pushsection .discard.instr_end\n\t"		\
	".long " __stringify(label) "b - .\n\t"		\
	".popsection\n\t"

#define instr_begin() ({asm volatile(instr_begin_insn(__COUNTER__));})
#define instr_end() ({asm volatile(instr_end_insn(__COUNTER__));})> +#else /* CONFIG_X86_64 */

And the RUN_ON_IRQSTACK macro would become:

#define RUN_ON_IRQSTACK(func)	{					\
	unsigned long tos;						\
									\
	lockdep_assert_irqs_disabled();					\
									\
	tos = ((unsigned long)__this_cpu_read(hardirq_stack_ptr)) - 8;	\
									\
	__this_cpu_add(irq_count, 1);					\
	asm volatile(							\
		"pushq  %%rbp					\n"	\
		"movq   %%rsp, %%rbp				\n"	\
		"movq	%%rsp, (%[ts])				\n"	\
		"movq	%[ts], %%rsp				\n"	\
		instr_begin_insn(1)					\
		"call	" __ASM_FORM(func) "			\n"	\
		instr_end_insn(2)					\
		"popq	%%rsp					\n"	\
		"leaveq						\n"	\
		:							\
		: [ts] "r" (tos)					\
		: "memory"						\
		);							\
	__this_cpu_sub(irq_count, 1);					\
}

alex.
