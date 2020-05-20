Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD671C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0520671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589993493;
	bh=NNmpX8qsqR07aMp56pZuUcOFtIh8+LhgnAJftGVYzEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zdBAdBs+EwqUiOm6lGM5UFPXSc9pcezW+2wJSaneXHTTYqfexcyKjSezouSAmgLhj
	 rQPdYTPx9cwKYpopEjMDL/c9MV3BqQRRZ5mwGRH97byQf+3jiyOkRcf76x/6E1qhXo
	 L0ITYZf2frdPEe7PBIiVhrPkopnmbbnkznkP/2ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgETQvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbgETQvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:51:32 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8AC320873
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589993491;
        bh=NNmpX8qsqR07aMp56pZuUcOFtIh8+LhgnAJftGVYzEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xSFef6/9WTIA9gsF7U0oTKLdFFtDT7skpEeFDtg0drWZNmO0ap3cywUZlzeJ4iG+Z
         8CniZZHwLLd0cY4ibCWb4HYFE+SSSyJClGCSUFmSVx+lpOsPsA9l0fUfh+x8Z0Th/d
         D4yFlW1VnBscXFJ2AEe3FnBon/D+HmH2IkeM/U18=
Received: by mail-wr1-f53.google.com with SMTP id e1so3878391wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:51:30 -0700 (PDT)
X-Gm-Message-State: AOAM5336j88yfYw6CTIz40uXlvuzWOdSX7zIIQH9/Al3ywcOgkWf9iTV
        zQYZrxkOzPajQ/iGFTxARjr6bjuGWTjMTaFsY72nBA==
X-Google-Smtp-Source: ABdhPJwXSDXAhEaAEQaJT+UVc4mYYhYzepKhMQ2ehfJYM0DYVk0xMXG0PzV6aEFM/MlrF0qmW9R55uHd0Dy6BOVxm+w=
X-Received: by 2002:adf:a298:: with SMTP id s24mr4857429wra.184.1589993489259;
 Wed, 20 May 2020 09:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de>
 <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com>
 <87ftbv7nsd.fsf@nanos.tec.linutronix.de> <87a7237k3x.fsf@nanos.tec.linutronix.de>
 <CALCETrXbQkE1zTW5Ly+ZQgDFLQQa3crPxzK6to0YR+BP5B9q+g@mail.gmail.com>
 <874ksb7hbg.fsf@nanos.tec.linutronix.de> <CALCETrWw7Vz39ROdBV1QxOQS3gMbPgNu5RRSuhBaXG+UVcFAzw@mail.gmail.com>
 <20200520022353.GN2869@paulmck-ThinkPad-P72> <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
In-Reply-To: <CALCETrWAVTjsKwih06GeK237w7RLSE2D2+naiunA=VFEJY1meQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 09:51:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
Message-ID: <CALCETrVPM1x5v8Gq7xyF+QqxSWSWTShhc7K02nGJZuB-oVDxNw@mail.gmail.com>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 8:36 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 7:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, May 19, 2020 at 05:26:58PM -0700, Andy Lutomirski wrote:
> > > On Tue, May 19, 2020 at 2:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:

First, the patch as you submitted it is Acked-by: Andy Lutomirski
<luto@kernel.org>.  I think there are cleanups that should happen, but
I think the patch is correct.

About cleanups, concretely:  I think that everything that calls
__idtenter_entry() is called in one of a small number of relatively
sane states:

1. User mode.  This is easy.

2. Kernel, RCU is watching, everything is sane.  We don't actually
need to do any RCU entry/exit pairs -- we should be okay with just a
hypothetical RCU tickle (and IRQ tracing, etc).  This variant can
sleep after the entry part finishes if regs->flags & IF and no one
turned off preemption.

3. Kernel, RCU is not watching, system was idle.  This can only be an
actual interrupt.

So maybe the code can change to:

    if (user_mode(regs)) {
        enter_from_user_mode();
    } else {
        if (!__rcu_is_watching()) {
            /*
             * If RCU is not watching then the same careful
             * sequence vs. lockdep and tracing is required.
             *
             * This only happens for IRQs that hit the idle loop, and
             * even that only happens if we aren't using the sane
             * MWAIT-while-IF=0 mode.
             */
            lockdep_hardirqs_off(CALLER_ADDR0);
            rcu_irq_enter();
            instrumentation_begin();
            trace_hardirqs_off_prepare();
            instrumentation_end();
            return true;
        } else {
            /*
             * If RCU is watching then the combo function
             * can be used.
             */
            instrumentation_begin();
            trace_hardirqs_off();
            rcu_tickle();
            instrumentation_end();
        }
    }
    return false;

This is exactly what you have except that the cond_rcu part is gone
and I added rcu_tickle().

Paul, the major change here is that if an IRQ hits normal kernel code
(i.e. code where RCU is watching and we're not in an EQS), the IRQ
won't call rcu_irq_enter() and rcu_irq_exit().  Instead it will call
rcu_tickle() on entry and nothing on exit.  Does that cover all the
bases?
