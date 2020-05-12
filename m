Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC2C47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DF39206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgELBsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgELBsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:48:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E4820575;
        Tue, 12 May 2020 01:48:37 +0000 (UTC)
Date:   Mon, 11 May 2020 21:48:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 2 10/18] x86/entry/64: Check IF in
 __preempt_enable_notrace() thunk
Message-ID: <20200511214835.7c71cabb@oasis.local.home>
In-Reply-To: <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com>
References: <20200505134112.272268764@linutronix.de>
        <20200505134341.087595319@linutronix.de>
        <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 17:10:09 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > The preempt_enable_notrace() ASM thunk is called from tracing, entry code
> > RCU and other places which are already in or going to be in the noinstr
> > section which protects sensitve code from being instrumented.  
> 
> This text and $SUBJECT agree that you're talking about
> preempt_enable_notrace(), but:
> 
> > +       THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace, check_if=1  
> 
> You actually seem to be changing preempt_schedule_notrace().
> 
> The actual code in question has this comment:
> 
> /**
>  * preempt_schedule_notrace - preempt_schedule called by tracing
>  *
>  * The tracing infrastructure uses preempt_enable_notrace to prevent
>  * recursion and tracing preempt enabling caused by the tracing
>  * infrastructure itself. But as tracing can happen in areas coming
>  * from userspace or just about to enter userspace, a preempt enable
>  * can occur before user_exit() is called. This will cause the scheduler
>  * to be called when the system is still in usermode.
>  *
>  * To prevent this, the preempt_enable_notrace will use this function
>  * instead of preempt_schedule() to exit user context if needed before
>  * calling the scheduler.
>  */
> 
> Which is no longer really applicable to x86 -- in the state that this
> comment nonsensically refers to as "userspace", x86 *always* has IRQs
> off, which means that preempt_enable() will not schedule.
> 
> So I'm guessing that the issue you're solving is that we have
> redundant preempt disable/enable pairs somewhere in the bowels of
> tracing code that is called with IRQs off, and objtool is now
> complaining.  Could the actual code in question be fixed to assert
> that IRQs are off instead of disabling preemption?  If not, can you
> fix the $SUBJECT and changelog and perhaps add a comment to the code
> as to *why* you're checking IF?  Otherwise some intrepid programmer is
> going to notice it down the road, wonder if it's optimizing anything
> useful at all, and get rid of it.

The commit that added that code is this:

  29bb9e5a75684106a37593ad75ec75ff8312731b

And it may not be applicable anymore, especially after Thomas's
patches. I'll go and stare at that some more. A lot has changed since
2013 ;-)

-- Steve
