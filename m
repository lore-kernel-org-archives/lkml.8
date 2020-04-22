Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0897C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FC220767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgDVUR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:17:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409E02074B;
        Wed, 22 Apr 2020 20:17:27 +0000 (UTC)
Date:   Wed, 22 Apr 2020 16:17:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH 3/3] x86/ftrace: Do not jump to direct code in created
 trampolines
Message-ID: <20200422161725.667fa9aa@gandalf.local.home>
In-Reply-To: <20200422200808.GX2483@worktop.programming.kicks-ass.net>
References: <20200422162539.808362933@goodmis.org>
        <20200422162750.638839749@goodmis.org>
        <20200422200808.GX2483@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 22:08:08 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 22, 2020 at 12:25:42PM -0400, Steven Rostedt wrote:
> 
> > @@ -367,6 +371,17 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
> >  	if (WARN_ON(ret < 0))
> >  		goto fail;
> >  
> > +	/* No need to test direct calls on created trampolines */
> > +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> > +		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */
> > +		ip = trampoline + (jmp_offset - start_offset);
> > +		if (WARN_ON(*(char *)ip != 0x75))
> > +			goto fail;
> > +		ret = probe_kernel_read(ip, ideal_nops[2], 2);  
> 
> Now you're just being silly, are you really, actually worried you can't
> read ideal_nops[] ?

Hah, that was more cut and paste. I guess a memcpy() would be more
appropriate.


> 
> > +		if (ret < 0)
> > +			goto fail;
> > +	}
> > +
> >  	/*
> >  	 * The address of the ftrace_ops that is used for this trampoline
> >  	 * is stored at the end of the trampoline. This will be used to
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 0882758d165a..f72ef157feb3 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -241,6 +241,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
> >  	 */
> >  	movq ORIG_RAX(%rsp), %rax
> >  	testq	%rax, %rax
> > +SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
> >  	jnz	1f
> >    
> 
> I you worry about performance, it would make more sense to do something
> like so:
> 
> SYM_INNER_LABEL(ftrace_regs_caller_from, SYM_L_GLOBAL)
> 	movq ORIG_RAX(%rsp), %rax
> 	testq	%rax, %rax
> 	jnz	1f
> SYM_INNER_LABEL(ftrace_regs_caller_to, SYM_L_GLOBAL)
> 
> 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> 		ip = trampoline + (ftrace_regs_caller_from - start_offset);
> 		((u8[])ip)[0] = JMP8_INSN_OPCODE;
> 		((u8[])ip)[1] = ftrace_regs_caller_to - ftrace_regs_caller_from - JMP8_INSN_SIZE;
> 	}
> 
> Or nop the whole range, but it's like 10 bytes so I'm not sure that's
> actually faster.

That could work too. I'll play with that and actually do some benchmarks to
see how much it affects things.

Thanks!

-- Steve
