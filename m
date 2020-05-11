Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA48C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C18206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgEKSmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729768AbgEKSmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:42:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6764C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:42:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYDNX-0003b7-E8; Mon, 11 May 2020 20:42:15 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E30B9FFBF8; Mon, 11 May 2020 20:42:14 +0200 (CEST)
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V5 part 3 12/29] x86/entry/common: Provide idtentry_enter/exit()
In-Reply-To: <CALCETrX6p6o0NJszjon7R8Tb+fFa=Jw5=CQQ56yZi+YVggopiQ@mail.gmail.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.457578656@linutronix.de> <CALCETrXwuxtZgniJxKZOy5ryqXSbbGMHMBwgEb400Pn9XpynzQ@mail.gmail.com> <874ksm7n5d.fsf@nanos.tec.linutronix.de> <CALCETrX6p6o0NJszjon7R8Tb+fFa=Jw5=CQQ56yZi+YVggopiQ@mail.gmail.com>
Date:   Mon, 11 May 2020 20:42:14 +0200
Message-ID: <87o8qu5n5l.fsf@nanos.tec.linutronix.de>
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
> On Mon, May 11, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>> >> + * Invoked by all exception/interrupt IDTENTRY handlers which are not
>> >> + * returning through the paranoid exit path (all except NMI, #DF and the IST
>> >> + * variants of #MC and #DB).
>> >
>
>> +void noinstr idtentry_exit(struct pt_regs *regs)
>> +{
>> +       lockdep_assert_irqs_disabled();
>> +
>> +       if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>> +               WARN_ON_ONCE(!on_thread_stack());
>
> Whoops.  After sleeping on this, this is obviously wrong.  If this is
> something like a page fault, we can be on an IST or IRQ stack.
> Perhaps the actual condition should be:
>
> WARN_ON_ONCE(!on_thread_stack() && (regs->flags & X86_FLAGS_IF) &&
> preempt_count() == 0);
>
> IOW, the actual condition we want is that, if the idtenter_entry/exit
> code might schedule or if a cond_local_irq_enable() path might
> schedule, we had better be on the correct stack.
>
> Sorry for causing confusion.

Nothing to be sorry about. I could have thought about it myself :)
Let me try again.
