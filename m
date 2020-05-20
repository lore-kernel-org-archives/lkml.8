Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B34C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7272A20759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589987361;
	bh=ySgQmZmFv9od/muKbGYKe76YZfs94UdkM+D0wOSk6eY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DutsUgvjLuPbCmTUSAbDWfnGsoKGLQ80iv5WX07id7tQRMQsFzI4rBXxxP7s4y1ay
	 ooJsJwobsKyB7/PaOM/AvgYwz3cWfaBg4VjeUBgW0mG4HzqNrBdCI/UOfp4DFCBV+o
	 OVBHxbaH47kpiVpxgIQW+q2OdolycvGyKd9QPALA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgETPJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETPJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:09:20 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFF820708
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589987359;
        bh=ySgQmZmFv9od/muKbGYKe76YZfs94UdkM+D0wOSk6eY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rxuTxF/92U1tDY+rVK34105yY6tSblEjVB6ZmEXWZOxcYh9O+Y0IU3hMwcCS7qz9D
         sh9WXaOq1qF5+ugu5XHi38GeseeTL+FIj8HZBuA69JJAUqNdbcbLi8Rkm697EyObJk
         p3J2bQ0eVG5H6NvGc6/UK6Uh1IsT5c+ag7v+J1is=
Received: by mail-wr1-f50.google.com with SMTP id v12so3467399wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:09:19 -0700 (PDT)
X-Gm-Message-State: AOAM531zNxMi06KAyQKd5TP3DE2gWEjT9jlV9Kx/DMh96cIfc56Ge35b
        nbzMJRquMIlvckLG6Xovetl1mWk4HFDs77Uf3GrBIw==
X-Google-Smtp-Source: ABdhPJxmXlp3EdBojOAzumVNXwuNuDsDOOJA7z9P1VkM5+0I3lXCGm00OO0m3LXYLM4Gx/SXtmz9HAFc/jN96VeckJk=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr4501790wro.70.1589987357773;
 Wed, 20 May 2020 08:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de>
 <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
 <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com>
 <87o8qkvm03.fsf@nanos.tec.linutronix.de> <CALCETrX4p71MyQHfUUCBWh8LicewyyVNj7T5mOmZevND2vvqoQ@mail.gmail.com>
 <871rne6ayr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rne6ayr.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 May 2020 08:09:06 -0700
X-Gmail-Original-Message-ID: <CALCETrW5uHQGLRyA8_JZ6Xv95Ui8g4OdrjCViWMVcG2W5B1cWg@mail.gmail.com>
Message-ID: <CALCETrW5uHQGLRyA8_JZ6Xv95Ui8g4OdrjCViWMVcG2W5B1cWg@mail.gmail.com>
Subject: Re: [patch V6 07/37] x86/entry: Provide helpers for execute on irqstack
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Wed, May 20, 2020 at 5:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Mon, May 18, 2020 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Andy Lutomirski <luto@kernel.org> writes:
> >> > Actually, I revoke my ack.  Can you make one of two changes:
> >> >
> >> > Option A: Add an assertion to run_on_irqstack to verify that irq_count
> >> > was -1 at the beginning?  I suppose this also means you could just
> >> > explicitly write 0 instead of adding and subtracting.
> >> >
> >> > Option B: Make run_on_irqstack() just call the function on the current
> >> > stack if we're already on the irq stack.
> >> >
> >> > Right now, it's too easy to mess up and not verify the right
> >> > precondition before calling run_on_irqstack().
> >> >
> >> > If you choose A, perhaps add a helper to do the if(irq_needs_irqstack)
> >> > dance so that users can just do:
> >> >
> >> > run_on_irqstack_if_needed(...);
> >> >
> >> > instead of checking everything themselves.
> >>
> >> I'll have a look tomorrow morning with brain awake.
> >
> > Also, reading more of the series, I suspect that asm_call_on_stack is
> > logically in the wrong section or that the noinstr stuff is otherwise
> > not quite right.  I think that objtool should not accept
> > run_on_irqstack() from noinstr code.  See followups on patch 10.
>
> It's in entry.text which is non-instrumentable as well.

Hmm.  I suppose we can chalk this up to the noinstr checking not being
entirely perfect.
