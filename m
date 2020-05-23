Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4204EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152E5207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yCdyHpiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgEWNLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:11:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54354 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgEWNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0oDw8wrBIYN7H/FUnJ33fdVz5scUf+AdJtVvf2cHYEY=; b=yCdyHpiTveEgCB8EtQjz5t69+Q
        GPk3J/Af1OJiUkj9Kz7/JcqiJuQVjsyGjYY9reXJOxXnW8QlSV8+SHaakrr5VLhhfIznucd3J8YBA
        lt0Ux8i3R4uJzJ27PIa9fP2BGIT0sgmmDZOLVWvmYHbfDLZbIVB7+t6vaJxpQ3813DAEMkRL90z3w
        AaYnY2TdF5AMUoSUo0TWOzrlEhpPCxMQryU6nosgye/JRPUr74s3Rtr+1KRzJG6B8KbYnmyi1Vhsn
        t3jbfAIMPxtosrUNzQ3+UYsSb9yNKv0ExoYBsfe4heET/d99YTCq4K8RZzROcK80Zuqn20e7dPvkX
        7Ry5IVWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcTtJ-0000EO-1t; Sat, 23 May 2020 13:08:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B97DF9834A3; Sat, 23 May 2020 15:08:36 +0200 (CEST)
Date:   Sat, 23 May 2020 15:08:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Message-ID: <20200523130836.GB2483@worktop.programming.kicks-ass.net>
References: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
 <87367xvvmy.fsf@nanos.tec.linutronix.de>
 <20200519083826.GC279861@hirez.programming.kicks-ass.net>
 <20200519090226.GD279861@hirez.programming.kicks-ass.net>
 <CAJhGHyCStHRzqv2Di57ALnBiPCpKjob4TG6Hj76+NowpNLqD7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCStHRzqv2Di57ALnBiPCpKjob4TG6Hj76+NowpNLqD7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 10:52:24AM +0800, Lai Jiangshan wrote:

> Hello,
> 
> I, who don't know how does the objtool handle it, am just curious.
> _begin() and _end() are symmetrical, which means if _end() (without nop)
> can escape, so can _begin() in a reverse way. For example:
> 
> noinstr void foo()
> {
>     instrumentation_begin();
>     do {
>             instrumentation_begin();
>             ...
>             instrumentation_end();
>     } while (cond);
>     bar();
>     instrumentation_end();
> }
> 
> Here, the first _begin() can be "dragged" into the do-while block.
> Expectedly, objtool validation should not complain here.
> 
> But objtool validation's not complaining means it can handle it
> magically correctly (by distinguishing how many _begin()s should
> be taken around the jmp target when jmp in a specific path), or
> handle it by not checking if all paths have the same count onto
> a jmp target (a little nervous to me), or other possible ways.

No, I tihnk you're right. It could be we never hit this particular
problem. Even the one described, where end leaks out, is quite rare. For
instance, the last one I debgged (that led to this patch) only showed
itself with gcc-9, but not with gcc-8 for example.

Anyway, if we ever find the above, I'll add the NOP to begin too.
