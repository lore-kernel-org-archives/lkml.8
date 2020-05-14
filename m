Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE8920671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLLzbCD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgENJkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENJkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:40:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7697CC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=feVO4yYYy91KQ8GH1eVp8sWHqYIeINuLBbymblGHXzU=; b=JLLzbCD3UvhuKXY++75GNCFsHW
        OBLi+sl4KiVTYJMFi4OpMeZT1GhwrtTyUK2kiA8tZkoBh8p/8lNYQlUHgJlzyWEjS1mAz1qnhHt+0
        moPPJpURfFz6AIehxTyOlMvMky/n7gi4Ul7MwWKBzMyk92hi1xrv5agoXI+LHjj/i9MvOEdsrQtk8
        I7ispjujO9SOcQFdsH8yEkCXR8d+CSBzg6Qf+r6M2rVCisElfjlVfW06uYpgl0X0dmKsn/+Je/j4D
        0uSSAgwK1ID7y245F5I1K0BqQiIn7YRY2NY/yTvJ3KXpKtUxrriLU6Zr2+Rw+JgTMnlPuDwi12mie
        uqVffDlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZALP-0006zc-A9; Thu, 14 May 2020 09:40:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F82D301A66;
        Thu, 14 May 2020 11:39:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18A6F28B3BD89; Thu, 14 May 2020 11:39:57 +0200 (CEST)
Date:   Thu, 14 May 2020 11:39:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 07/24] x86/traps: Split int3 handler up
Message-ID: <20200514093957.GU2978@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de>
 <20200505135314.045220765@linutronix.de>
 <CALCETrUwwKG_JZH6NWP5WMT0B3YzhwviBxyDM5FWeMC86cNrQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUwwKG_JZH6NWP5WMT0B3YzhwviBxyDM5FWeMC86cNrQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:03:13PM -0700, Andy Lutomirski wrote:
> On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > For code simplicity split up the int3 handler into a kernel and user part
> > which makes the code flow simpler to understand.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/kernel/traps.c |   67 +++++++++++++++++++++++++++---------------------
> >  1 file changed, 39 insertions(+), 28 deletions(-)
> >
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -564,6 +564,35 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
> >         cond_local_irq_disable(regs);
> >  }
> >
> > +static bool do_int3(struct pt_regs *regs)
> > +{
> > +       int res;
> > +
> > +#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
> > +       if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
> > +                        SIGTRAP) == NOTIFY_STOP)
> > +               return true;
> > +#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
> > +
> > +#ifdef CONFIG_KPROBES
> > +       if (kprobe_int3_handler(regs))
> > +               return true;
> > +#endif
> > +       res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);
> > +
> > +       return res == NOTIFY_STOP;
> > +}
> > +
> > +static void do_int3_user(struct pt_regs *regs)
> > +{
> > +       if (do_int3(regs))
> > +               return;
> > +
> > +       cond_local_irq_enable(regs);
> > +       do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
> > +       cond_local_irq_disable(regs);
> > +}
> > +
> >  DEFINE_IDTENTRY_RAW(exc_int3)
> >  {
> >         /*
> > @@ -581,37 +610,19 @@ DEFINE_IDTENTRY_RAW(exc_int3)
> >          * because the INT3 could have been hit in any context including
> >          * NMI.
> >          */
> > +       if (user_mode(regs)) {
> >                 idtentry_enter(regs);
> > +               instr_begin();
> > +               do_int3_user(regs);
> > +               instr_end();
> >                 idtentry_exit(regs);
> > +       } else {
> > +               nmi_enter();
> > +               instr_begin();
> > +               do_int3(regs);
> 
> I think you should be checking the return value here.  Presumably this
> should die() if it's not handled, since otherwise it will just
> infinite loop.

Indeed. Thanks!

> > +               instr_end();
> >                 nmi_exit();
> > +       }
> >  }
> >
> >  #ifdef CONFIG_X86_64
> >
