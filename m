Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11306C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ECC2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589846231;
	bh=h6KxhIm7OBbPaPIH7T0Ls1bsgtVMZKmf4J1myjzm+m4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vYAwsZUVuT1eLE6POfe3qiyzkkiyfVGXyPB0Qtj97uVlkxVUM7cfTyx9GDVA3rqEr
	 2zXhD+dTFKAVEFoy66XQOX8Fk8zDNEJ6ecgoBiVjt9uvocWURrDnOsLxr+raCwztn+
	 olKgBCVisRHnZQZSAWBJMXHDrKj73IqNb54rr4/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgERX5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgERX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:57:10 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89FE120835
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589846229;
        bh=h6KxhIm7OBbPaPIH7T0Ls1bsgtVMZKmf4J1myjzm+m4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oSGaLG7knkTnl7oa0iH6BmQgWE3jaiZYUsSlcK3oUAP5b2shCjDRNIEgYaU+snt8X
         ULB9ySi+OB0pToBh/WQClW2CWG1AkHTQaec5tYF42WqGMvXJXz7sLYsPspoIekDTqF
         fcpSMfDmMDYEAeby3Y+vGWz5/qpoXvyaVlV+9UrY=
Received: by mail-wr1-f42.google.com with SMTP id h17so13769512wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:57:09 -0700 (PDT)
X-Gm-Message-State: AOAM5302rlzwI89vSx08mv8lkb8B/8644fgmpZqAT9cibqiW5m1g665U
        wFrL3cc2Z4Ndcm+6wFCVpugAFAr+S46D9NilKSnvvg==
X-Google-Smtp-Source: ABdhPJxjifsM7UYJVuBu+J8n7kUubaLLVDIfcp5S83OBH9fzLhe3ms6e16t8OuSo/5CGoDnocncxp/HgxnJLL9QFuLc=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr22209964wrs.257.1589846228019;
 Mon, 18 May 2020 16:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de>
 <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com>
 <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com> <87o8qkvm03.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8qkvm03.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 May 2020 16:56:56 -0700
X-Gmail-Original-Message-ID: <CALCETrX4p71MyQHfUUCBWh8LicewyyVNj7T5mOmZevND2vvqoQ@mail.gmail.com>
Message-ID: <CALCETrX4p71MyQHfUUCBWh8LicewyyVNj7T5mOmZevND2vvqoQ@mail.gmail.com>
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

On Mon, May 18, 2020 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > Actually, I revoke my ack.  Can you make one of two changes:
> >
> > Option A: Add an assertion to run_on_irqstack to verify that irq_count
> > was -1 at the beginning?  I suppose this also means you could just
> > explicitly write 0 instead of adding and subtracting.
> >
> > Option B: Make run_on_irqstack() just call the function on the current
> > stack if we're already on the irq stack.
> >
> > Right now, it's too easy to mess up and not verify the right
> > precondition before calling run_on_irqstack().
> >
> > If you choose A, perhaps add a helper to do the if(irq_needs_irqstack)
> > dance so that users can just do:
> >
> > run_on_irqstack_if_needed(...);
> >
> > instead of checking everything themselves.
>
> I'll have a look tomorrow morning with brain awake.

Also, reading more of the series, I suspect that asm_call_on_stack is
logically in the wrong section or that the noinstr stuff is otherwise
not quite right.  I think that objtool should not accept
run_on_irqstack() from noinstr code.  See followups on patch 10.
