Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE3FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25F120706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598310565;
	bh=6pa4lqUDiurjDqiVAmXPKSol+FEUfoTkf0ynhiaV5OA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2pRcY5h/2zHl2GlfackU7VMyMk3ioEArdC2LBBW/Wr3eyV3ELsSv4I//QBKQBBO50
	 VrC5WANzRADP2q5iD1snI+bMYjXKAtxn60Il2+7KvnyOkoeTwA2n6IFpWfgYptRfwR
	 IFEhgN/BNLcpBvDQYAQR2+H0IiuK09AZyODtOS2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHXXJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgHXXJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:09:22 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15061207D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598310561;
        bh=6pa4lqUDiurjDqiVAmXPKSol+FEUfoTkf0ynhiaV5OA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=drwGTVBuQgA1JO7h4QjCAex48sdmcda/tCXt28eTxFDi3qBdKwv0CjSlr+mHX31MK
         ZvctVaLg6eSXQQhRGk1Asx6PAjgO0jMOKLItaCu/aPWw65AWdp8OHTOIZC+MP9tO2C
         15LjIDXouxk1T9EukuR4VraG3kl6o90wMCsZKNLY=
Received: by mail-wm1-f47.google.com with SMTP id x5so540597wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 16:09:21 -0700 (PDT)
X-Gm-Message-State: AOAM531y7Fs0Y343rKPrUHSyziYeMDF0bv1iVMDUflPczxvLcYZ84fr8
        PcTXY/VB2ncvG0zyRDiczXnO/aue//rmKaLDpxOdUg==
X-Google-Smtp-Source: ABdhPJyftn4+xu9/jDhuGS2zyhpAlQmmZOpUSN9ee1ce6MYNUOEpARm+foBL9OWKbA/DcctII3Uz0mxP7VXgKN42/yU=
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr1358759wml.36.1598310559686;
 Mon, 24 Aug 2020 16:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102053.034965283@infradead.org>
 <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com> <20200824110501.GT1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200824110501.GT1362448@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 16:09:07 -0700
X-Gmail-Original-Message-ID: <CALCETrV6ZOBg66B9ePEt71_H8L+080uUdmxNKVVX=rA-19syTQ@mail.gmail.com>
Message-ID: <CALCETrV6ZOBg66B9ePEt71_H8L+080uUdmxNKVVX=rA-19syTQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 4:05 AM <peterz@infradead.org> wrote:
>
> On Sun, Aug 23, 2020 at 04:09:42PM -0700, Andy Lutomirski wrote:
> > On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Get rid of the two variables, avoid computing si_code when not needed
> > > and be consistent about which dr6 value is used.
> > >
> >
> > > -       if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
> > > -               send_sigtrap(regs, 0, si_code);
> > > +       /*
> > > +        * If dr6 has no reason to give us about the origin of this trap,
> > > +        * then it's very likely the result of an icebp/int01 trap.
> > > +        * User wants a sigtrap for that.
> > > +        */
> > > +       if (dr6 & (DR_STEP | DR_TRAP_BITS) || !dr6)
> > > +               send_sigtrap(regs, 0, get_si_code(dr6));
> >
> > The old condition was ... || (actual DR6 value) and the new condition
> > was ... || (stupid notifier-modified DR6 value).  I think the old code
> > was more correct.
>
> Hurmph.. /me goes re-read the SDM.
>
> INT1 is a trap,
> instruction breakpoint is a fault
>
> So if you have:
>
>         INT1
> 1:      some-instr
>
> and set an X breakpoint on 1, we'll loose the INT1, right?
>
> And because INT1 is a trap, we can't easily decode the instruction
> stream either :-(
>
> Now, OTOH, I suppose you're right in that looking at DR6 early (before
> we let people muck about with it) is more reliable for detecting INT1.
> Esp since the hw_breakpoint crud can consume all bits.
>
> So I'll go fix that. What a giant pain in the ass all this is.
>
> > The right fix is to get rid of the notifier garbage.  Want to pick up
> > these two changes into your series:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=b695a5adfdd661a10eead1eebd4002d08400e7ef
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/entry&id=40ca016606bd39a465feaf5802a8dc3e937aaa06
> >
> > And then there is no code left that modifies ->debugreg6 out from under you.
>
> I'm not convinced. Even with those patches applied we have to use
> debugreg6, and that code very much relies on clearing DR_TRAP_BITS
> early, and then having ptrace_triggered() re-set bits in it.
>
> This is so that hw_breakpoint handlers can use breakpoints in userspace
> without causing send_sigtrap() on them.

Ick.

Maybe we can rename this to thread->virtual_dr6.  So the traps.c
machinery would process dr6 (the actual value from hardware) and
generate virtual_dr6 to report to userspace.  And no one gets confused
about which is which, and no one ever consumes bits from the virtual
one.
