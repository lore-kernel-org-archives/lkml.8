Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27547C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9C9206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:27:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B031AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:27:41 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbQcj-0004FE-Bq; Wed, 20 May 2020 17:27:13 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AF656100C99; Wed, 20 May 2020 17:27:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
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
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 07/37] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <CALCETrW5uHQGLRyA8_JZ6Xv95Ui8g4OdrjCViWMVcG2W5B1cWg@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.110889386@linutronix.de> <CALCETrXPDAPtWMS6_KX8_GUsnPs1osmFsLokeGYczJwXZisLvg@mail.gmail.com> <CALCETrWD8qH-P4J3MB6Q9mr1MRLzsR7Fpab+Fk9Ac60qQBZPaA@mail.gmail.com> <87o8qkvm03.fsf@nanos.tec.linutronix.de> <CALCETrX4p71MyQHfUUCBWh8LicewyyVNj7T5mOmZevND2vvqoQ@mail.gmail.com> <871rne6ayr.fsf@nanos.tec.linutronix.de> <CALCETrW5uHQGLRyA8_JZ6Xv95Ui8g4OdrjCViWMVcG2W5B1cWg@mail.gmail.com>
Date:   Wed, 20 May 2020 17:27:12 +0200
Message-ID: <87d06ywrsf.fsf@nanos.tec.linutronix.de>
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
> On Wed, May 20, 2020 at 5:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>> > On Mon, May 18, 2020 at 4:53 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >>
>> >> Andy Lutomirski <luto@kernel.org> writes:
>> >> > Actually, I revoke my ack.  Can you make one of two changes:
>> >> >
>> >> > Option A: Add an assertion to run_on_irqstack to verify that irq_count
>> >> > was -1 at the beginning?  I suppose this also means you could just
>> >> > explicitly write 0 instead of adding and subtracting.
>> >> >
>> >> > Option B: Make run_on_irqstack() just call the function on the current
>> >> > stack if we're already on the irq stack.
>> >> >
>> >> > Right now, it's too easy to mess up and not verify the right
>> >> > precondition before calling run_on_irqstack().
>> >> >
>> >> > If you choose A, perhaps add a helper to do the if(irq_needs_irqstack)
>> >> > dance so that users can just do:
>> >> >
>> >> > run_on_irqstack_if_needed(...);
>> >> >
>> >> > instead of checking everything themselves.
>> >>
>> >> I'll have a look tomorrow morning with brain awake.
>> >
>> > Also, reading more of the series, I suspect that asm_call_on_stack is
>> > logically in the wrong section or that the noinstr stuff is otherwise
>> > not quite right.  I think that objtool should not accept
>> > run_on_irqstack() from noinstr code.  See followups on patch 10.
>>
>> It's in entry.text which is non-instrumentable as well.
>
> Hmm.  I suppose we can chalk this up to the noinstr checking not being
> entirely perfect.

objtool considers both entry.text and noinstr.text. We just can't stick
everything into entry.text for these !%@#45@# reasons.

