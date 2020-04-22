Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B14CC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C8420774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgDVNdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDVNdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:33:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5305C2076E;
        Wed, 22 Apr 2020 13:33:42 +0000 (UTC)
Date:   Wed, 22 Apr 2020 09:33:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 04/17] x86,ftrace: Fix ftrace_regs_caller() unwind
Message-ID: <20200422093339.6897e40f@gandalf.local.home>
In-Reply-To: <20200422094446.GY20730@hirez.programming.kicks-ass.net>
References: <20200416114706.625340212@infradead.org>
        <20200416115118.749606694@infradead.org>
        <20200421203345.4e165c4b@oasis.local.home>
        <20200422094446.GY20730@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 11:44:46 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > Anyway, I added the below patch on top of your patches and it appears
> > to work. Thoughts?  
> 
> So can I push out those patches as is? :-) We can do this on top I
> suppose.

My tests are still running on your series. I want to make sure that nothing
breaks between them. If the tests succeed, then sure, I'm OK building on
top of this series.


> 
> Firstly; your patch isn't objtool clean:
> 
>   arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0x199: sibling call from callable instruction with modified stack frame
> 
> So 10 points deduction for that :-). You got the RET_OFFSET hint on the
> wrong sibling call.

Ah, I just did his patch quickly and made sure that it booted and ran
function tracing and direct calls. I didn't bother caring much about the
objtool annotations.

> 
> Secondly, yes, that ORIG_RAX issue for copies, that _might_ crash and
> burn, but who knows, you're jumping into uninitialized memory afaict. So
> that definitely needs fixing. I'm also not sure of stubbing out the
> test, that's actually more work than poking in the 1 extra ret and also
> gives unexpected behaviour. If anything we should poke an UD2 at the 1:
> location in the copy.

Well, that would crash the system just as well.

We could also just make the jnz into a nop (which would make the trampoline
slightly faster as well).

> 
> Over all, I'm thinking we should keep it as is. If you want to simplify
> the poking we can do something like the below; reading a known retq is
> daft.

I'm actually more concerned about the performance of the created
trampoline, as that is a fast path. I rather get rid of that jump.

I'll play a little more with it while the tests continue.

-- Steve



> 
> ---
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 867c126ddabe..b334adbacb0e 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -307,8 +307,6 @@ union ftrace_op_code_union {
>  	} __attribute__((packed));
>  };
>  
> -#define RET_SIZE		1
> -
>  static unsigned long
>  create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  {
> @@ -319,7 +317,6 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	unsigned long offset;
>  	unsigned long npages;
>  	unsigned long size;
> -	unsigned long retq;
>  	unsigned long *ptr;
>  	void *trampoline;
>  	void *ip;
> @@ -347,11 +344,11 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	 * the iret , as well as the address of the ftrace_ops this
>  	 * trampoline is used for.
>  	 */
> -	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
> +	trampoline = alloc_tramp(size + RET_INSN_SIZE + sizeof(void *));
>  	if (!trampoline)
>  		return 0;
>  
> -	*tramp_size = size + RET_SIZE + sizeof(void *);
> +	*tramp_size = size + RET_INSN_SIZE + sizeof(void *);
>  	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
>  
>  	/* Copy ftrace_caller onto the trampoline memory */
> @@ -359,19 +356,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	if (WARN_ON(ret < 0))
>  		goto fail;
>  
> -	ip = trampoline + size;
> -
>  	/* The trampoline ends with ret(q) */
> -	retq = (unsigned long)ftrace_stub;
> -	ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> -	if (WARN_ON(ret < 0))
> -		goto fail;
> +	ip = trampoline + size;
> +	*(u8 *)ip = RET_INSN_OPCODE;
>  
>  	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
>  		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);
> -		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
> -		if (WARN_ON(ret < 0))
> -			goto fail;
> +		*(u8 *)ip = RET_INSN_OPCODE;
>  	}
>  
>  	/*
> @@ -382,7 +373,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	 * the global function_trace_op variable.
>  	 */
>  
> -	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
> +	ptr = (unsigned long *)(trampoline + size + RET_INSN_SIZE);
>  	*ptr = (unsigned long)ops;
>  
>  	op_offset -= start_offset;

