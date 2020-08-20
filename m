Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A86C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30C92075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882478;
	bh=ErsxOzudaYAqd/JOMw1cblnI0Jw1+r4C15tCDSy35Mw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vLJFnKEcyIy5J2bQm5aHVkCcrJE7ucTpkzWbhfvIgt6CB4vTQi1t9VvzZiWGO++tx
	 YBGyNg+eDNIR9muASDHqHIFrjryIXYXqPY3CJk1DYp4oWyTVJbort9SA5xmZ2m1oIk
	 FH92Cc/PvtoFY/od7Bm54MPa6fkyh+Sf6qE5vzX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTAOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgHTAOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:14:31 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD88E22B45
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597882471;
        bh=ErsxOzudaYAqd/JOMw1cblnI0Jw1+r4C15tCDSy35Mw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yue7lrmosAlgj8CCubCKwjR2GdG5sCA0nA5lNCxkUmFszRG/XaSYaQzp66SO/kx+W
         LQaMf9wycov2ECJiIx4pMyrFANfDjqS0W1xt78gIsh2R7wO+Us6bgXznij9+I5fH4I
         MZiu7ZmnePaj0OUmph3xa8JkAq21mbrxrMLttbik=
Received: by mail-wm1-f42.google.com with SMTP id g75so103843wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:14:30 -0700 (PDT)
X-Gm-Message-State: AOAM533vTE1GQmbQwg4Efqv0R8GNkoxM7zvHX6s+jL5plSq21Mr+axWd
        NoihyPrDh8LX+znEuHFf1fSVLpiPnil9y4ONrAX20A==
X-Google-Smtp-Source: ABdhPJzK7uFbomAuzonPEM1aKx4TLzsdUQTwYMDJ/Jef5VbDAxL3CoZfOMnG+NMjcLbBwzFea4wYD33BMgOHG66qcnc=
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr757787wmf.49.1597882469268;
 Wed, 19 Aug 2020 17:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
 <20200819184149.GH2674@hirez.programming.kicks-ass.net> <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
 <20200819213534.GQ3982@worktop.programming.kicks-ass.net> <20200819224731.3edo5lqw6lbuprdx@treble>
In-Reply-To: <20200819224731.3edo5lqw6lbuprdx@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Aug 2020 17:14:18 -0700
X-Gmail-Original-Message-ID: <CALCETrV8sVjhVYig4ZvYDN3pEbF0tvekXCcJCBakeZbMn0gZ=A@mail.gmail.com>
Message-ID: <CALCETrV8sVjhVYig4ZvYDN3pEbF0tvekXCcJCBakeZbMn0gZ=A@mail.gmail.com>
Subject: Re: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
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
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 3:47 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 11:35:34PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 19, 2020 at 12:28:16PM -0700, Kyle Huey wrote:
> >
> > > > I'm guess that is not the expected outcome, is that the same failure you
> > > > saw?
> > >
> > > Yes. Is status also 0x4d00 for you?
> >
> > Indeed.
> >
> > > The program is expected to complete with no assertions firing.
> >
> > When I comment out the break-on-exec test, the break-on-write test
> > succeeds.
> >
> > When I add a few printk()'s to our #DB handler (6) the program will
> > magically work again.
>
> I added some trace_printk()'s and I think the #DB handler is calling
> schedule????
>
> exc_debug_user()
>   irqentry_exit_to_user_mode()
>     exit_to_user_mode_prepare()
>       exit_to_user_mode_loop()
>         schedule()
>
> So #DB schedules out, then the process scheduls in and tells ptrace to
> set the data breakpoint in DR7.  Then the #DB handler schedules back in
> and overwrites DR7 with the original value.
>
> What amazes me is that it successfully schedules back to the end of the
> #DB handler finish and everything keeps working.
>
> Do we not have assertions in the scheduler to catch this?

You almost nailed it.

I'm pretty sure you have the buggy sequence of events right, but for
the wrong reason.  There's nothing wrong with scheduling when
delivering SIGTRAP, but it's definitely wrong to blindly save and
restore DR7 around scheduling and around ptrace invocations.  Remember
this is an entry from user mode, so it runs on the user stack.

Patch coming.

--Andy
