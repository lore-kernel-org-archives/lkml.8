Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3432C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A579D207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgEUKp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgEUKp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:45:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE35C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 03:45:57 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbihP-0006pf-UO; Thu, 21 May 2020 12:45:16 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C639B100C2D; Thu, 21 May 2020 12:45:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
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
Subject: Re: [patch V6 10/37] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
In-Reply-To: <CALCETrU4xaawDfFkYCLzaEFf3TJ2JTcD3ba_q5jbqhmJQ7qV0A@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235125.425810667@linutronix.de> <CALCETrUqK6hv4AuGL=GtK+12TCmr5nBA7CBy=X7TNA=w_Jk0Qw@mail.gmail.com> <87imgr7nwp.fsf@nanos.tec.linutronix.de> <CALCETrW4BxfTVzv8mXntNXiAPnKxqdMEv7djUknGZcrno2WJHg@mail.gmail.com> <87y2pm4ruh.fsf@nanos.tec.linutronix.de> <CALCETrUvH5DQvL6Lo6EkM04pr7wWj+7eZbTg3H_eLNXcZsH0FA@mail.gmail.com> <CALCETrX4Zy2iuc39XTifYd_mvezCEUtW2ax3=ec1TF=yZxAHDg@mail.gmail.com> <871rnewh5w.fsf@nanos.tec.linutronix.de> <CALCETrU4xaawDfFkYCLzaEFf3TJ2JTcD3ba_q5jbqhmJQ7qV0A@mail.gmail.com>
Date:   Thu, 21 May 2020 12:45:14 +0200
Message-ID: <87wo55tvlx.fsf@nanos.tec.linutronix.de>
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
> On Wed, May 20, 2020 at 12:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>> > Andrew Cooper pointed out that there is too much magic in Xen for this
>> > to work.  So never mind.
>>
>> :)
>>
>> But you made me stare more at that stuff and I came up with a way
>> simpler solution. See below.
>
> I like it, but I bet it can be even simpler if you do the
> tickle_whatever_paulmck_call_it() change:
>
>> +__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
>> +{
>> +       struct pt_regs *old_regs;
>> +       bool inhcall;
>> +
>> +       idtentry_enter(regs);
>> +       old_regs = set_irq_regs(regs);
>> +
>> +       run_on_irqstack(__xen_pv_evtchn_do_upcall, NULL, regs);
>> +
>> +       set_irq_regs(old_regs);
>> +
>> +       inhcall = get_and_clear_inhcall();
>> +       __idtentry_exit(regs, inhcall);
>> +       restore_inhcall(inhcall);
>
> How about:
>
>        inhcall = get_and_clear_inhcall();
>        if (inhcall) {
>         if (!WARN_ON_ONCE((regs->flags & X86_EFLAGS_IF) || preempt_count()) {
>           local_irq_enable();
>           cond_resched();
>           local_irq_disable();

This really want's to use preempt_schedule_irq() as the above is racy
vs. need_resched().

>         }
>      }
>      restore_inhcall(inhcall);
>      idtentry_exit(regs);
>
> This could probably be tidied up by having a xen_maybe_preempt() that
> does the inhcall and resched mess.
>
> The point is that, with the tickle_nohz_ stuff, there is nothing
> actually preventing IRQ handlers from sleeping as long as they aren't
> on the IRQ stack and as long as the interrupted context was safe to
> sleep in.

You still lose the debug checks. I'm working on it ...

Thanks,

        tglx
