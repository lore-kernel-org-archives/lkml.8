Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E245C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119D4208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgCaPbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCaPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:31:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE3320786;
        Tue, 31 Mar 2020 15:31:38 +0000 (UTC)
Date:   Tue, 31 Mar 2020 11:31:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331113136.01316614@gandalf.local.home>
In-Reply-To: <20200331111652.GH20760@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
        <20200325174605.369570202@infradead.org>
        <20200326113049.GD20696@hirez.programming.kicks-ass.net>
        <20200326135620.tlmof5fa7p5wct62@treble>
        <20200326154938.GO20713@hirez.programming.kicks-ass.net>
        <20200326195718.GD2452@worktop.programming.kicks-ass.net>
        <20200327010001.i3kebxb4um422ycb@treble>
        <20200330170200.GU20713@hirez.programming.kicks-ass.net>
        <20200330190205.k5ssixd5hpshpjjq@treble>
        <20200330200254.GV20713@hirez.programming.kicks-ass.net>
        <20200331111652.GH20760@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 13:16:52 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> @@ -235,8 +237,8 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>  
>  	/* If ORIG_RAX is anything but zero, make this a call to that */
>  	movq ORIG_RAX(%rsp), %rax
> -	cmpq	$0, %rax
> -	je	1f
> +	testq	%rax, %rax
> +	jz	1f
>  
>  	/* Swap the flags with orig_rax */
>  	movq MCOUNT_REG_SIZE(%rsp), %rdi

Hi Peter,

Can you send this change as a separate patch as it has nothing to do with
this current change, and is a clean up patch that stands on its own.

Thanks,

-- Steve
