Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F6BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C571206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K1nuKyO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgENNQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:16:10 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF0FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TpLw4BdJT0JveDtO4r1F8bJeWxiAnJbyCG4f/8DEh+w=; b=K1nuKyO9v7e/WFY//uVAMPcEwp
        WJkX8ripvNzw4cpzMXS5ArXCwZKrcYEs+sIWd8kzPYCTpBQEcsHezZ9EFkUv9VaH5DGHTxgV1b8tg
        Du61eFF8etGcz5sT5bqOP41re+HBV9eAHnLjCT1i9o86+/WDGiGzMF4zyi8tv6JeUbZVoROf7UU09
        GbARtX6P6qoiashn9XcLC5gaWETrYhjFms99a4VN8BRR6U5j7nxyXNe8LajLnj4syY4u+V9LLbhBJ
        VfuRY7tK5GvuFMSARfBklSW14Kn8h6cHwCBxoM8z0NEnXd0CrMGI5h+A9bpD+b1t+mzZKUoam7qHu
        88SUcd/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZDi0-0007nQ-O6; Thu, 14 May 2020 13:15:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 166C4300455;
        Thu, 14 May 2020 15:15:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C62A6213C8B61; Thu, 14 May 2020 15:15:30 +0200 (CEST)
Date:   Thu, 14 May 2020 15:15:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
Message-ID: <20200514131530.GQ2957@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de>
 <20200505135313.517429268@linutronix.de>
 <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com>
 <20200514093257.GT2978@hirez.programming.kicks-ass.net>
 <87h7wiznl7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7wiznl7.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 02:51:32PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Wed, May 13, 2020 at 09:57:52PM -0700, Andy Lutomirski wrote:
> >> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >
> >> > From: Peter Zijlstra <peterz@infradead.org>
> >> >
> >> > Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
> >> > creeps in and ruins things.
> >> >
> >> > That is; this is the INT3 text poke handler, strictly limit the code
> >> > that runs in it, lest it inadvertenly hits yet another INT3.
> >> 
> >> 
> >> Acked-by: Andy Lutomirski <luto@kernel.org>
> >> 
> >> Does objtool catch this error?
> >
> > It does not. I'll put it on the (endless) todo list..
> 
> Well, at least it detects when that code calls out into something which
> is not in the non-instrumentable section.

True, but the more specific problem is that noinstr code can use
jump_label/static_call just fine.

So a more specific test is validating none of that happens in the INT3
handler before poke_int3_handler(). Which is what I think Andy was
after.
