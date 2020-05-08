Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B323BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D1521582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588973416;
	bh=EyjmbmXI3g+Mp7HyMVSIq0UHOgJUZrYjphlm8BnwL3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xLCVcX3ZuOI+GQFcFkKui4OrID3vAN5k+EeBFxW+RVT4z+ITrj56VEBa79bUEUpEg
	 LyS1YqqwXh7cQdk3yyZbZ6LxkTa+qWdVK9OuMXqYMLyyRgQq1N3N3aTWNchQDsG0iC
	 TrIFDwr+D9S1zmHWH11hB0EdeEakEKupdgAONfLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEHVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:30:14 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5A724956
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588973414;
        bh=EyjmbmXI3g+Mp7HyMVSIq0UHOgJUZrYjphlm8BnwL3s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oW/Pm4ZZxxmIR0YODD3+3/JxEs0EHH9l713SREJn88P52HWJ64NQa2n+xxP/EQjJO
         QDb+khPTXffJzSk0eTW+EKdhnCik8V/S2XyC5xBcuQblU5Kj+AksEb8T93JKZBGC2N
         Bvu0my9UNCJL/38cS8AwkgHVyeWnrt8hE/L6zkoA=
Received: by mail-wm1-f45.google.com with SMTP id g12so12217718wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:30:13 -0700 (PDT)
X-Gm-Message-State: AGi0PubimyoXXYDJyQ4OtN5+LrLo2XxA/+x5Nl6nB/rsEmu0wU2maGbB
        8YLmHl/0lbVkwWJMCiUOi/iZaSbqrp56aga2a95t9w==
X-Google-Smtp-Source: APiQypK/QTCxRQov2Fytn5gbiUp1ja3pqZrBCDEl7UorZ5Z0YSoBSKit5kSrsGG0XPnRrTxpT6CUKp+SrSPb3GcKAq8=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr11007945wmk.21.1588973412230;
 Fri, 08 May 2020 14:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de>
 <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com> <20200508084809.GS5298@hirez.programming.kicks-ass.net>
In-Reply-To: <20200508084809.GS5298@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 14:30:01 -0700
X-Gmail-Original-Message-ID: <CALCETrWcEQdT2kLYQknWWVcNdqnuaZcA6RMDPbD5c9Scf2uUVg@mail.gmail.com>
Message-ID: <CALCETrWcEQdT2kLYQknWWVcNdqnuaZcA6RMDPbD5c9Scf2uUVg@mail.gmail.com>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 1:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 07, 2020 at 11:02:09AM -0700, Andy Lutomirski wrote:
> > On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Convert #MC over to using task_work_add(); it will run the same code
> > > slightly later, on the return to user path of the same exception.
> >
> > I think this patch is correct, but I think it's only one small and not
> > that obviously wrong step away from being broken:
> >
> > >         if ((m.cs & 3) == 3) {
> > >                 /* If this triggers there is no way to recover. Die hard. */
> > >                 BUG_ON(!on_thread_stack() || !user_mode(regs));
> > > -               local_irq_enable();
> > > -               preempt_enable();
> > >
> > > -               if (kill_it || do_memory_failure(&m))
> > > -                       force_sig(SIGBUS);
> > > -               preempt_disable();
> > > -               local_irq_disable();
> > > +               current->mce_addr = m.addr;
> > > +               current->mce_status = m.mcgstatus;
> > > +               current->mce_kill_me.func = kill_me_maybe;
> > > +               if (kill_it)
> > > +                       current->mce_kill_me.func = kill_me_now;
> > > +               task_work_add(current, &current->mce_kill_me, true);
> >
> > This is fine if the source was CPL3, but it's not going to work if CPL
> > was 0.  We don't *currently* do this from CPL0, but people keep
> > wanting to.  So perhaps there should be a comment like:
> >
> > /*
> >  * The #MC originated at CPL3, so we know that we will go execute the
> > task_work before returning to the offending user code.
> >  */
> >
> > IOW, if we want to recover from CPL0 #MC, we will need a different mechanism.
>
> See part4-18's IDTRENTRY_NOIST. That will get us a clear CPL3/CPL0
> separation.

I will hold my breath.

>
> > I also confess a certain amount of sadness that my beautiful
> > haha-not-really-atomic-here mechanism isn't being used anymore. :(
>
> I think we have a subtely different interpretation of 'beautiful' here.

Beauty is in the eye of the beholder.  And sometimes in the eye of the
person who wrote the code :)
