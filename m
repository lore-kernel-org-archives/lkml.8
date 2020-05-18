Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5296DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7720849
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589845599;
	bh=CNbucCilmQWgmoPahZxwFxBbyz+IJqaVp50vq3Zrguk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lj/c4T3LEw6UeCViS0ySfFx+dTlfjWFLgfPL753gEmz2jLmLm1Fu2VShFxAUHKFFc
	 BLq37UJZungTjAyrEnK+/uypQSqnifFKhtt9dXHTJKAEz5lZ0FqIIlNB2pgyvK0XWI
	 rv4rk6bhxoPFCzMj/wJZ3tNamq94VyXTpglkY84I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgERXqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgERXqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:46:37 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73722086A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589845597;
        bh=CNbucCilmQWgmoPahZxwFxBbyz+IJqaVp50vq3Zrguk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PxKbLXntOMChu8LZfjCpD46s5PrMyFJ2O10vGw5bzjQed8MPaSHhEZnU6EuzAKrBK
         Vq5yWQImXMxE8Dp2BwghQmldQ49Y1WNcwdNBme9IjeC/KnTF7wL5b3n/jIczkeBgz6
         rGZSUxSFeor/dGk1XUeWQpFcxMLElEBkOFrQgSco=
Received: by mail-wm1-f44.google.com with SMTP id f134so1193008wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:46:36 -0700 (PDT)
X-Gm-Message-State: AOAM533yYpnHQcdrUHZuIL8gO94F6ZBvkJXJ8s/UHEwVEFYpNTve3Xkt
        OJF7YhiP165KmERTSYYOMpRR8haI7EFU9O8ZhDw3iw==
X-Google-Smtp-Source: ABdhPJxeeGCauCdDatVZLOyvbp6x62lGL1VS69l0gVVLXNKu5wn9lLXmXDnGyTle0192sKDaBqPMIsHwXY+Iwj2lpvI=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr1925003wme.176.1589845595172;
 Mon, 18 May 2020 16:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de>
 <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
In-Reply-To: <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:46:22 -0700
X-Gmail-Original-Message-ID: <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com>
Message-ID: <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com>
Subject: Re: [patch V6 07/37] x86/entry: Provide helpers for execute on irqstack
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

On Mon, May 18, 2020 at 4:11 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >
> > Device interrupt handlers and system vector handlers are executed on the
> > interrupt stack. The stack switch happens in the low level assembly entry
> > code. This conflicts with the efforts to consolidate the exit code in C to
> > ensure correctness vs. RCU and tracing.
> >
> > As there is no way to move #DB away from IST due to the MOV SS issue, the
> > requirements vs. #DB and NMI for switching to the interrupt stack do not
> > exist anymore. The only requirement is that interrupts are disabled.
> >
> > That allows to move the stack switching to C code which simplifies the
> > entry/exit handling further because it allows to switch stacks after
> > handling the entry and on exit before handling RCU, return to usermode and
> > kernel preemption in the same way as for regular exceptions.
> >
> > The initial attempt of having the stack switching in inline ASM caused too
> > much headache vs. objtool and the unwinder. After analysing the use cases
> > it was agreed on that having the stack switch in ASM for the price of an
> > indirect call is acceptable as the main users are indirect call heavy
> > anyway and the few system vectors which are empty shells (scheduler IPI and
> > KVM posted interrupt vectors) can run from the regular stack.
> >
> > Provide helper functions to check whether the interrupt stack is already
> > active and whether stack switching is required.
> >
> > 64 bit only for now. 32 bit has a variant of that already. Once this is
> > cleaned up the two implementations might be consolidated as a cleanup on
> > top.
> >
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> Have you tested by forcing a stack trace from the IRQ stack and making
> sure it unwinds all the way out?

Actually, I revoke my ack.  Can you make one of two changes:

Option A: Add an assertion to run_on_irqstack to verify that irq_count
was -1 at the beginning?  I suppose this also means you could just
explicitly write 0 instead of adding and subtracting.

Option B: Make run_on_irqstack() just call the function on the current
stack if we're already on the irq stack.

Right now, it's too easy to mess up and not verify the right
precondition before calling run_on_irqstack().

If you choose A, perhaps add a helper to do the if(irq_needs_irqstack)
dance so that users can just do:

run_on_irqstack_if_needed(...);

instead of checking everything themselves.
