Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F5D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgERXx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgERXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:53:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:53:26 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1japZ7-0005wC-Ek; Tue, 19 May 2020 01:53:01 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E45CF1006A1; Tue, 19 May 2020 01:53:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 07/37] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de> <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com> <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com>
Date:   Tue, 19 May 2020 01:53:00 +0200
Message-ID: <87o8qkvm03.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> Actually, I revoke my ack.  Can you make one of two changes:
>
> Option A: Add an assertion to run_on_irqstack to verify that irq_count
> was -1 at the beginning?  I suppose this also means you could just
> explicitly write 0 instead of adding and subtracting.
>
> Option B: Make run_on_irqstack() just call the function on the current
> stack if we're already on the irq stack.
>
> Right now, it's too easy to mess up and not verify the right
> precondition before calling run_on_irqstack().
>
> If you choose A, perhaps add a helper to do the if(irq_needs_irqstack)
> dance so that users can just do:
>
> run_on_irqstack_if_needed(...);
>
> instead of checking everything themselves.

I'll have a look tomorrow morning with brain awake.
