Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0531205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733070AbgENANG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733001AbgENANG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:13:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E465DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:13:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZ1U6-0006qT-Th; Thu, 14 May 2020 02:12:23 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 07BFC1004CE; Thu, 14 May 2020 02:12:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
In-Reply-To: <20200513171047.04c2c10e@gandalf.local.home>
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de> <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com> <20200513171047.04c2c10e@gandalf.local.home>
Date:   Thu, 14 May 2020 02:12:21 +0200
Message-ID: <87v9kzz862.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven, Mathieu

(combo reply)

Steven Rostedt <rostedt@goodmis.org> writes:
> On Wed, 13 May 2020 16:56:41 -0400 (EDT)
>> > +		/* deal with pending signal delivery */
>> > +		if (cached_flags & _TIF_SIGPENDING)
>> > +			do_signal(regs);
>
> Looking deeper into this, it appears that do_signal() can freeze or kill the
> task.
>
> That is, it wont go back to user space here, but simply schedule out (being
> traced) or even exit (killed).
>
> Before the resume hooks would never be called in such cases, and now they
> are.

It theoretically matters because pending task work might kill the
task. That's the concern Andy and Peter had. Assume the following:

usermode

 -> exception
    set not fatal signal

    -> exception
        queue task work to kill task
    <- return

  <- return

The same could happen when the non fatal signal is set from a remote CPU.

So in theory that would result in:

   handle non fatal signal first

   handle task work which kills task

which would be the wrong order.

But that's just illusion.

>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

>> Also, color me confused: is "do_signal()" actually running any user-space,
>> or just setting up the user-space stack for eventual return to signal
>> handler ?

I'm surprised that you can't answer that question yourself. How did you
ever make rseq work and how did rseq_signal_deliver() end up in
setup_rt_frame()?

Hint: Tracing might answer that question

And to cut it short:

    Exit to user space happnes only through ONE channel, i.e. leaving
    prepare_exit_to usermode().

      exit_to_usermode_loop <-prepare_exit_to_usermode
      do_signal <-exit_to_usermode_loop
      get_signal <-do_signal
      setup_sigcontext <-do_signal
      do_syscall_64 <-entry_SYSCALL_64_after_hwframe
      syscall_trace_enter <-do_syscall_64

      sys_rt_sigreturn()
      restore_altstack <-__ia32_sys_rt_sigreturn
      syscall_slow_exit_work <-do_syscall_64
      exit_to_usermode_loop <-do_syscall_64

>> Also, it might be OK, but we're changing the order of two things which
>> have effects on each other: restartable sequences abort fixup for preemption
>> and do_signal(), which also have effects on rseq abort.
>> 
>> Because those two will cause the abort to trigger, I suspect changing
>> the order might be OK, but we really need to think this through.

That's a purely academic problem. The order is completely
irrelevant. You have to handle any order anyway:

usermode

  -> exception / syscall
       sets signal

   <- return

  prepare_exit_to_usemode()
      cached_flags = READ_ONCE(t->flags);
      exit_to_user_mode_loop(regs, cached_flags) {
        while (cached_flags) {
           local_irq_enable();

           handle(cached_flags & RESCHED);
           handle(cached_flags & UPROBE);
           handle(cached_flags & PATCHING);
           handle(cached_flags & SIGNAL);
           handle(cached_flags & NOTIFY_RESUME);
           handle(cached_flags & RETURN_NOTIFY);

           local_irq_disable();
           
           cached_flags = READ_ONCE(t->flags);
         }

cached_flag is a momentary snapshot when attempting to return to user
space.

But after reenabling interrupts any of the relevant flag bits can be set
by an exception/interrupt or from remote. If preemption is enabled the
task can be scheduled out, migrated at any point before disabling
interrupts again. Even after disabling interrupts and before re-reading
cached flags there might be a remote change of flags.

That said, even for the case Andy and Peter were looking at (MCE) the
ordering is completely irrelevant.

I should have thought about this before, so thanks to both of you for
making me look at it again for the very wrong reasons.

Consider the patch dropped.

Thanks,

        tglx
