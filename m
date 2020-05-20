Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81099C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCAC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETSdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:33:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:33:38 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbTWj-00006C-6t; Wed, 20 May 2020 20:33:13 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8BD49100C99; Wed, 20 May 2020 20:33:12 +0200 (CEST)
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
Subject: Re: [patch V6 36/37] x86/entry: Move paranoid irq tracing out of ASM code
In-Reply-To: <CALCETrVCBMjEZmohRmJ0=F26LjYxyxP0L_x=c68ExGUampVk3g@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235127.996226788@linutronix.de> <CALCETrVwTZA6OwrMDhhaNgpkvwsn9ajfuwrfH6xYExvCsFcXjQ@mail.gmail.com> <87lflm4owm.fsf@nanos.tec.linutronix.de> <CALCETrVCBMjEZmohRmJ0=F26LjYxyxP0L_x=c68ExGUampVk3g@mail.gmail.com>
Date:   Wed, 20 May 2020 20:33:12 +0200
Message-ID: <874ksawj6f.fsf@nanos.tec.linutronix.de>
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

> On Wed, May 20, 2020 at 8:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>>
>> > On Fri, May 15, 2020 at 5:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>> > I think something's missing here.  With this patch applied, don't we
>> > get to exc_debug_kernel() -> handle_debug() without doing
>> > idtentry_enter() or equivalent?  And that can even enable IRQs.
>> >
>> > Maybe exc_debug_kernel() should wrap handle_debug() in some
>> > appropriate _enter() / _exit() pair?
>>
>> I'm the one who is missing something here, i.e. the connection of this
>> patch to #DB. exc_debug_kernel() still looks like this:
>>
>>         nmi_enter_notrace();
>>         handle_debug(regs, dr6, false);
>>         nmi_exit_notrace();
>>
>> Confused.
>>
>
> Hmm.  I guess the code is correct-ish or at least as correct as it
> ever was.  But $SUBJECT says "Move paranoid irq tracing out of ASM
> code" but you didn't move it into all the users.  So now the NMI code
> does trace_hardirqs_on_prepare() but the #DB code doesn't.  Perhaps
> the changelog should mention this.

Duh. I simply missed to add it.

> exc_kernel_debug() is an atrocity.  Every now and then I get started
> on cleanup it up and so far I always get mired in the giant amount of
> indirection.
>
> So Acked-by: Andy Lutomirski <luto@kernel.org> if you write a credible
> changelog.
