Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981EC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5200B20777
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AXRKABpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCYSN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:13:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60972 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2plezOlRw7hkkh6LziCfkccVGAATkcpghrKnzymW3hs=; b=AXRKABpBtNDx/hoGYGMf6QE6g8
        I64wQNxK1qd2fOyN33i1Ws85v7xQpI5JKRwdR4eiDlkCahOjxUJPXlBZM+zf2RirH/5vJO36tjzEY
        IkKIwzcdXQALUKP+hyz86GNLwTLG0oLY0TEwD7R9Xibr569arxZ7HKmfq79OR7rbjis+ZJdJAADaQ
        IrZpva/sSPcQYPbkmUYkE42gO8XdG+3sivhrKBOkVfHVqlBmYLsuYgN3ONx4JsVD6IM7b7X0fzC68
        gd1mR7nJJrO96wTgcHMNyuW6plaCcMBAsu4XhgtLZMAN7ki/b3idKDdKpr1qyr0gnsbcH9t1+xyQU
        JEcb/WdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHAX8-0004Xw-PB; Wed, 25 Mar 2020 18:13:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86EE23010CF;
        Wed, 25 Mar 2020 19:13:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64524201CEE51; Wed, 25 Mar 2020 19:13:39 +0100 (CET)
Date:   Wed, 25 Mar 2020 19:13:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
Message-ID: <20200325181339.GK20713@hirez.programming.kicks-ass.net>
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
 <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net>
 <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
 <20200324170306.GU20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324170306.GU20696@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:03:06PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 24, 2020 at 09:33:21AM -0700, Linus Torvalds wrote:

> > Of course, one alternative is to just say "instead of using NOP, use
> > 'xorl %eax,%eax'", and then we'd have the rule that a NULL conditional
> > function returns zero (or NULL).
> > 
> > I _think_ a "xorl %eax,%eax ; retq" is just three bytes and would fit
> > in the tailcall slot too.
> 
> Correct. The only problem is that our text patching machinery can't
> replace multiple instructions :/

To clarify; the problem is a task getting preempted with its RIP at the
RET. Then when we rewrite the text to be a CALL/JMP.d32 it will read
garbage (1 byte into the displacement of the instruction) instead of a
RET when it resumes.

Now, there are ways to fix this, the easiest being calling
synchronize_rcu_tasks() just like optprobes does (see also commit
5c02ece81848 ("x86/kprobes: Fix ordering while text-patching")).

It would mean patching a call away from NULL will be 'expensive' but it
ought to work.

I'll try and do the patch, see what it looks like.
