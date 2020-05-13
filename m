Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C25C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86512053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bs2Ntbfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbgEMW51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:57:27 -0400
Received: from mail.efficios.com ([167.114.26.124]:50248 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbgEMW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:57:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 377A42BF609;
        Wed, 13 May 2020 18:57:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TuwXLXH0gSnV; Wed, 13 May 2020 18:57:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BD98B2BF608;
        Wed, 13 May 2020 18:57:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BD98B2BF608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589410645;
        bh=Cluae6xS+NJacs2cfgSwtFkKlrinLEd02WsEcRPO9vc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bs2NtbfhsXD5nwysRoERi6YdqNtvryQ3SDXeUAZUaiuRTxxIloorpB3fsu2uWnboC
         wpBiU65p6Hq458XNtPoE0AbkBSwfRe31w2UxmkIDv/qP/3vCqqDbPWyJ6svcXD4Tlf
         MRyJeDXAcC+9lP64xFUV75aif3PbLuD43QoSua53vlqyAFMAe5S58iuWbbea/z90bf
         lAN0zgasYbWvKprImw2T2V1HIkralNiLjTAPNAiBwwadrb8eznRZxX6PoR+aZIRKJR
         bc1JEcgWr54fj0T7v/gtzjgUVbMeFYlqxZWX26va18iwaDu0xres4cyrdWMgcXlHl1
         oJtGoV9slyxUQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o2CgufNFSekh; Wed, 13 May 2020 18:57:25 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id ABC1A2BF279;
        Wed, 13 May 2020 18:57:25 -0400 (EDT)
Date:   Wed, 13 May 2020 18:57:25 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Message-ID: <1777514130.20137.1589410645669.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134059.462640294@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134059.462640294@linutronix.de>
Subject: Re: [patch V4 part 1 14/36] x86/entry: Get rid of
 ist_begin/end_non_atomic()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry: Get rid of ist_begin/end_non_atomic()
Thread-Index: emYf3uO7ok2UHht9lN2XyjVuj2zs5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:

> This is completely overengineered and definitely not an interface which
> should be made available to anything else than this particular MCE case.

This patch introduces a significant change under the radar (not explained
in the changelog): it turns preempt_enable_no_resched() into preempt_enable().

Why, and why was it a no_resched() in the first place ? Was it for performance
or correctness reasons ?

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/x86/include/asm/traps.h   |    2 --
> arch/x86/kernel/cpu/mce/core.c |    6 ++++--
> arch/x86/kernel/traps.c        |   37 -------------------------------------
> 3 files changed, 4 insertions(+), 41 deletions(-)
> 
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -120,8 +120,6 @@ asmlinkage void smp_irq_move_cleanup_int
> 
> extern void ist_enter(struct pt_regs *regs);
> extern void ist_exit(struct pt_regs *regs);
> -extern void ist_begin_non_atomic(struct pt_regs *regs);
> -extern void ist_end_non_atomic(void);
> 
> #ifdef CONFIG_VMAP_STACK
> void __noreturn handle_stack_overflow(const char *message,
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1352,13 +1352,15 @@ void notrace do_machine_check(struct pt_
> 
> 	/* Fault was in user mode and we need to take some action */
> 	if ((m.cs & 3) == 3) {
> -		ist_begin_non_atomic(regs);
> +		/* If this triggers there is no way to recover. Die hard. */
> +		BUG_ON(!on_thread_stack() || !user_mode(regs));
> 		local_irq_enable();
> +		preempt_enable();
> 
> 		if (kill_it || do_memory_failure(&m))
> 			force_sig(SIGBUS);
> +		preempt_disable();
> 		local_irq_disable();
> -		ist_end_non_atomic();
> 	} else {
> 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
> 			mce_panic("Failed kernel mode recovery", &m, msg);
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -117,43 +117,6 @@ void ist_exit(struct pt_regs *regs)
> 		rcu_nmi_exit();
> }
> 
> -/**
> - * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
> - * @regs:	regs passed to the IST exception handler
> - *
> - * IST exception handlers normally cannot schedule.  As a special
> - * exception, if the exception interrupted userspace code (i.e.
> - * user_mode(regs) would return true) and the exception was not
> - * a double fault, it can be safe to schedule.  ist_begin_non_atomic()
> - * begins a non-atomic section within an ist_enter()/ist_exit() region.
> - * Callers are responsible for enabling interrupts themselves inside
> - * the non-atomic section, and callers must call ist_end_non_atomic()
> - * before ist_exit().
> - */
> -void ist_begin_non_atomic(struct pt_regs *regs)
> -{
> -	BUG_ON(!user_mode(regs));
> -
> -	/*
> -	 * Sanity check: we need to be on the normal thread stack.  This
> -	 * will catch asm bugs and any attempt to use ist_preempt_enable
> -	 * from double_fault.
> -	 */
> -	BUG_ON(!on_thread_stack());
> -
> -	preempt_enable_no_resched();
> -}
> -
> -/**
> - * ist_end_non_atomic() - begin a non-atomic section in an IST exception
> - *
> - * Ends a non-atomic section started with ist_begin_non_atomic().
> - */
> -void ist_end_non_atomic(void)
> -{
> -	preempt_disable();
> -}
> -
> int is_valid_bugaddr(unsigned long addr)
> {
>  	unsigned short ud;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
