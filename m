Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D302420709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589997949;
	bh=kXoflEbp5ulmwEoxjarHhtSJEjOi/lhE28kVEiZxBns=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=e/XJRpAgnTvTPCf/Ro3GXM/ZzCb+fqeAKSyvD7Za//GrtFP85006lwXTTZ+48oEcf
	 dk4YxEqOxWeC5oHeulqMR+uJcnTe0Kg77sFdUbuqbjNunuUC23j9KfAzXQjt6HWDpq
	 dzYsCHspaI2fE1HJEZ3n/KCLCETPIOWn55h//0Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgETSFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETSFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:05:47 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B906420671;
        Wed, 20 May 2020 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997946;
        bh=kXoflEbp5ulmwEoxjarHhtSJEjOi/lhE28kVEiZxBns=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ujwYf10cYEUTD94IZ3hRka3qPIljRIMk5K6sC9F1xC6BWgXVUfeYzun63oZFgp+3o
         pWBjbN0Vm1VDFtZB3Qff7hFmtotlDe3tYrTZs1lKyXTbBtEuqsKGlNmEpF4TENGTxj
         l9B2W7YDZlCQPTHXxa17tKW8tZe2wbtqjkp7Btac=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1C5A3522A2B; Wed, 20 May 2020 11:05:46 -0700 (PDT)
Date:   Wed, 20 May 2020 11:05:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200520180546.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de>
 <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de>
 <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72>
 <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
 <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:51:17AM -0700, Andy Lutomirski wrote:
> On Wed, May 20, 2020 at 8:36 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, May 19, 2020 at 7:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Tue, May 19, 2020 at 05:26:58PM -0700, Andy Lutomirski wrote:
> > > > On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> First, the patch as you submitted it is Acked-by: Andy Lutomirski
> <luto@kernel.org>.  I think there are cleanups that should happen, but
> I think the patch is correct.
> 
> About cleanups, concretely:  I think that everything that calls
> __idtenter_entry() is called in one of a small number of relatively
> sane states:
> 
> 1. User mode.  This is easy.
> 
> 2. Kernel, RCU is watching, everything is sane.  We don't actually
> need to do any RCU entry/exit pairs -- we should be okay with just a
> hypothetical RCU tickle (and IRQ tracing, etc).  This variant can
> sleep after the entry part finishes if regs->flags & IF and no one
> turned off preemption.
> 
> 3. Kernel, RCU is not watching, system was idle.  This can only be an
> actual interrupt.
> 
> So maybe the code can change to:
> 
>     if (user_mode(regs)) {
>         enter_from_user_mode();
>     } else {
>         if (!__rcu_is_watching()) {
>             /*
>              * If RCU is not watching then the same careful
>              * sequence vs. lockdep and tracing is required.
>              *
>              * This only happens for IRQs that hit the idle loop, and
>              * even that only happens if we aren't using the sane
>              * MWAIT-while-IF=0 mode.
>              */
>             lockdep_hardirqs_off(CALLER_ADDR0);
>             rcu_irq_enter();
>             instrumentation_begin();
>             trace_hardirqs_off_prepare();
>             instrumentation_end();
>             return true;
>         } else {
>             /*
>              * If RCU is watching then the combo function
>              * can be used.
>              */
>             instrumentation_begin();
>             trace_hardirqs_off();
>             rcu_tickle();
>             instrumentation_end();
>         }
>     }
>     return false;
> 
> This is exactly what you have except that the cond_rcu part is gone
> and I added rcu_tickle().
> 
> Paul, the major change here is that if an IRQ hits normal kernel code
> (i.e. code where RCU is watching and we're not in an EQS), the IRQ
> won't call rcu_irq_enter() and rcu_irq_exit().  Instead it will call
> rcu_tickle() on entry and nothing on exit.  Does that cover all the
> bases?

From an RCU viewpoint, yes, give or take my concerns about someone
putting rcu_tickle() on entry and rcu_irq_exit() on exit.  Perhaps
I can bring some lockdep trickery to bear.

But I must defer to Thomas and Peter on the non-RCU/non-NO_HZ_FULL
portions of this.

							Thanx, Paul
