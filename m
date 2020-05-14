Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26313C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44035205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbgENANy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732981AbgENANx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:13:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D0362065C;
        Thu, 14 May 2020 00:13:51 +0000 (UTC)
Date:   Wed, 13 May 2020 20:13:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 14/36] x86/entry: Get rid of
 ist_begin/end_non_atomic()
Message-ID: <20200513201349.35132f23@oasis.local.home>
In-Reply-To: <1777514130.20137.1589410645669.JavaMail.zimbra@efficios.com>
References: <20200505131602.633487962@linutronix.de>
        <20200505134059.462640294@linutronix.de>
        <1777514130.20137.1589410645669.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 18:57:25 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
> 
> > This is completely overengineered and definitely not an interface which
> > should be made available to anything else than this particular MCE case.  
> 
> This patch introduces a significant change under the radar (not explained
> in the changelog): it turns preempt_enable_no_resched() into preempt_enable().
> 
> Why, and why was it a no_resched() in the first place ? Was it for performance
> or correctness reasons ?

I believe the reason for no_resched, is because it was within a
local_irq_disable() section, which means it couldn't schedule anyway.

-- Steve


> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -1352,13 +1352,15 @@ void notrace do_machine_check(struct pt_
> > 
> > 	/* Fault was in user mode and we need to take some action */
> > 	if ((m.cs & 3) == 3) {
> > -		ist_begin_non_atomic(regs);
> > +		/* If this triggers there is no way to recover.
> > Die hard. */
> > +		BUG_ON(!on_thread_stack() || !user_mode(regs));
> > 		local_irq_enable();
> > +		preempt_enable();
> > 
> > 		if (kill_it || do_memory_failure(&m))
> > 			force_sig(SIGBUS);
> > +		preempt_disable();
> > 		local_irq_disable();
> > -		ist_end_non_atomic();
> > 	} else {
> > 		if (!fixup_exception(regs, X86_TRAP_MC, error_code,


> > -void ist_begin_non_atomic(struct pt_regs *regs)
> > -{
> > -	BUG_ON(!user_mode(regs));
> > -
> > -	/*
> > -	 * Sanity check: we need to be on the normal thread
> > stack.  This
> > -	 * will catch asm bugs and any attempt to use
> > ist_preempt_enable
> > -	 * from double_fault.
> > -	 */
> > -	BUG_ON(!on_thread_stack());
> > -
> > -	preempt_enable_no_resched();
> > -}
> > -
> > -/**
> > - * ist_end_non_atomic() - begin a non-atomic section in an IST
> > exception
> > - *
> > - * Ends a non-atomic section started with ist_begin_non_atomic().
> > - */
> > -void ist_end_non_atomic(void)
> > -{
> > -	preempt_disable();
> > -}
> > -
> > int is_valid_bugaddr(unsigned long addr)
> > {
> >  	unsigned short ud;  
> 

