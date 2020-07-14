Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51906C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3363D2071B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGNDZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgGNDZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:25:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BB42071B;
        Tue, 14 Jul 2020 03:25:00 +0000 (UTC)
Date:   Mon, 13 Jul 2020 23:24:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/18] x86/ftrace: Do not jump to direct code
 in created trampolines
Message-ID: <20200713232459.039683cc@oasis.local.home>
In-Reply-To: <20200703081000.GT4800@hirez.programming.kicks-ass.net>
References: <20200702215812.428188663@goodmis.org>
        <20200702215832.049969400@goodmis.org>
        <20200703081000.GT4800@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 10:10:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 02, 2020 at 05:58:16PM -0400, Steven Rostedt wrote:
> 
> > +	/* No need to test direct calls on created trampolines */
> > +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> > +		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */
> > +		ip = trampoline + (jmp_offset - start_offset);
> > +		if (WARN_ON(*(char *)ip != 0x75))
> > +			goto fail;
> > +		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);  
> 
> I really don't get this paranoia, what's wrong with memcpy() ?

Habit. As when ftrace was introduced, it was extremely careful about
touching memory like this. And even with all of that extra care, we
still broke NICs (actually, some of the reason those NICs broke was
because of the extra care we took :-p)

> 
> > +		if (ret < 0)
> > +			goto fail;
> > +	}  
> 
> How about something like this?
> 
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -359,17 +359,11 @@ create_trampoline(struct ftrace_ops *ops
>  	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
>  
>  	/* Copy ftrace_caller onto the trampoline memory */
> -	ret = copy_from_kernel_nofault(trampoline, (void *)start_offset, size);
> -	if (WARN_ON(ret < 0))
> -		goto fail;
> -
> -	ip = trampoline + size;
> +	memcpy(trampoline, (void *)start_offset, size);
>  
>  	/* The trampoline ends with ret(q) */
> -	retq = (unsigned long)ftrace_stub;
> -	ret = copy_from_kernel_nofault(ip, (void *)retq, RET_SIZE);
> -	if (WARN_ON(ret < 0))
> -		goto fail;
> +	ip = trampoline + size;
> +	memcpy(ip, text_gen_insn(RET_INSN_OPCODE, NULL, NULL), RET_INSN_SIZE);
>  
>  	/* No need to test direct calls on created trampolines */
>  	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> @@ -377,9 +371,7 @@ create_trampoline(struct ftrace_ops *ops
>  		ip = trampoline + (jmp_offset - start_offset);
>  		if (WARN_ON(*(char *)ip != 0x75))
>  			goto fail;
> -		ret = copy_from_kernel_nofault(ip, ideal_nops[2], 2);
> -		if (ret < 0)
> -			goto fail;
> +		memcpy(ip, ideal_nops[2], 2);

If you want to add this change on top of this, then I'm fine with that.

If it breaks something, I can at least point the blame at you ;-)

-- Steve


>  	}
>  
>  	/*

