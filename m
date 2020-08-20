Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EB1206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdQPS5aH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgHTPVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTPVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:21:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A500C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WO117o7rJcvrbn+tJaLD6rskyy5H89U6ereeOLtJe1c=; b=CdQPS5aHR7EtJZbvyYojM200RK
        Oog4l+FWkvps1fksUvEm2LgpR8YoCNcGlaZ7ahdVeikJxopfqkNGCTKwbbDa0xO7fSURL6vdQVyIV
        GuTi0blZ33rKqdURzQq2jg4gdfXT03Bsy9zqMQoYYfC0ruwfmA3Q2Wv3Kzk1MktcCffSaNoSo8CWN
        y4UNc3bH35nfRVz+0Xp422bGg9aWyde/ukgOTbYJaqcJxxaseiFStDfHtsqM6ubv3zp929BzXsPKH
        a2Mn9KUzg+MJLWdetibJ938MrojI2GRnPohlrWp4y78KUX2QZUPjpiuJMZZfk7MER3nZCFgnHwLO+
        E8rxPj9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8mNN-000654-0z; Thu, 20 Aug 2020 15:21:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3C16302526;
        Thu, 20 Aug 2020 17:21:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD97A21296C3B; Thu, 20 Aug 2020 17:21:11 +0200 (CEST)
Date:   Thu, 20 Aug 2020 17:21:11 +0200
From:   peterz@infradead.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820152111.GC1362448@hirez.programming.kicks-ass.net>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <CAMzpN2gmCu0q_8gLAOcSuLjpKF+rNj=wiCFsGZXgNwz000HCvg@mail.gmail.com>
 <20200820150841.GB1362448@hirez.programming.kicks-ass.net>
 <20200820151659.b7q7hspe5zsf46eg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820151659.b7q7hspe5zsf46eg@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:16:59AM -0500, Josh Poimboeuf wrote:
> On Thu, Aug 20, 2020 at 05:08:41PM +0200, peterz@infradead.org wrote:
> > On Thu, Aug 20, 2020 at 10:45:12AM -0400, Brian Gerst wrote:
> > > On Thu, Aug 20, 2020 at 6:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > >
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > ---
> > > >  arch/x86/kernel/traps.c |   24 ++++++++++++------------
> > > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > > >
> > > > --- a/arch/x86/kernel/traps.c
> > > > +++ b/arch/x86/kernel/traps.c
> > > > @@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
> > > >                 goto out;
> > > >         }
> > > >
> > > > -       if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
> > > > -               /*
> > > > -                * Historical junk that used to handle SYSENTER single-stepping.
> > > > -                * This should be unreachable now.  If we survive for a while
> > > > -                * without anyone hitting this warning, we'll turn this into
> > > > -                * an oops.
> > > > -                */
> > > > -               tsk->thread.debugreg6 &= ~DR_STEP;
> > > > -               set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> > > > -               regs->flags &= ~X86_EFLAGS_TF;
> > > > -       }
> > > > -
> > > >         si_code = get_si_code(tsk->thread.debugreg6);
> > > >         if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> > > >                 send_sigtrap(regs, 0, si_code);
> > > > @@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
> > > >         if (kprobe_debug_handler(regs))
> > > >                 goto out;
> > > >
> > > > +       if (WARN_ON_ONCE(dr6 & DR_STEP)) {
> > > > +               /*
> > > > +                * Historical junk that used to handle SYSENTER single-stepping.
> > > > +                * This should be unreachable now.  If we survive for a while
> > > > +                * without anyone hitting this warning, we'll turn this into
> > > > +                * an oops.
> > > > +                */
> > > > +               dr6 &= ~DR_STEP;
> > > > +               set_thread_flag(TIF_SINGLESTEP);
> > > > +               regs->flags &= ~X86_EFLAGS_TF;
> > > > +       }
> > > > +
> > > >         handle_debug(regs, dr6, false);
> > > >
> > > >  out:
> > > 
> > > Can this be removed or changed to a BUG()?  The warning has been there
> > > since 2016 and nobody has apparently complained about it.
> > 
> > Something like:
> > 
> > 	/*
> > 	 * The kernel doesn't do TF outside of Kprobes, so if we get
> > 	 * here, something's fishy.
> > 	 */
> > 	BUG_ON(dr6 & DR_STEP);
> > 
> > ?
> 
> What about kernel debuggers like kgdb and qemu gdb?

qemu-gdb stub should eat the event before it lands in the guest, kgdb
should eat it through the notifier.

Thank you!

Because that means I got the order wrong :/


