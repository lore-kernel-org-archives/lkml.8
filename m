Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDD1C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B715421473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEIK0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgEIK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:26:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3A7C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 03:26:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXMfn-0005fc-EP; Sat, 09 May 2020 12:25:35 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D3A1B100C8A; Sat,  9 May 2020 12:25:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [patch V4 part 2 10/18] x86/entry/64: Check IF in __preempt_enable_notrace() thunk
In-Reply-To: <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com>
References: <20200505134112.272268764@linutronix.de> <20200505134341.087595319@linutronix.de> <CALCETrVpSj9fVyUHp-Q_tT-xLgTfYR5JFv52AsOuGJsDYeN3-Q@mail.gmail.com>
Date:   Sat, 09 May 2020 12:25:34 +0200
Message-ID: <87k11l4d7l.fsf@nanos.tec.linutronix.de>
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
> On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> The preempt_enable_notrace() ASM thunk is called from tracing, entry code
>> RCU and other places which are already in or going to be in the noinstr
>> section which protects sensitve code from being instrumented.
>
> This text and $SUBJECT agree that you're talking about
> preempt_enable_notrace(), but:
>
>> +       THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace, check_if=1
>
> You actually seem to be changing preempt_schedule_notrace().

Duh, yes.

> The actual code in question has this comment:
>
> /**
>  * preempt_schedule_notrace - preempt_schedule called by tracing
>  *
>  * The tracing infrastructure uses preempt_enable_notrace to prevent
>  * recursion and tracing preempt enabling caused by the tracing
>  * infrastructure itself. But as tracing can happen in areas coming
>  * from userspace or just about to enter userspace, a preempt enable
>  * can occur before user_exit() is called. This will cause the scheduler
>  * to be called when the system is still in usermode.
>  *
>  * To prevent this, the preempt_enable_notrace will use this function
>  * instead of preempt_schedule() to exit user context if needed before
>  * calling the scheduler.
>  */
>
> Which is no longer really applicable to x86 -- in the state that this
> comment nonsensically refers to as "userspace", x86 *always* has IRQs
> off, which means that preempt_enable() will not schedule.
>
> So I'm guessing that the issue you're solving is that we have
> redundant preempt disable/enable pairs somewhere in the bowels of
> tracing code that is called with IRQs off, and objtool is now
> complaining.  Could the actual code in question be fixed to assert
> that IRQs are off instead of disabling preemption?  If not, can you
> fix the $SUBJECT and changelog and perhaps add a comment to the code
> as to *why* you're checking IF?  Otherwise some intrepid programmer is
> going to notice it down the road, wonder if it's optimizing anything
> useful at all, and get rid of it.

Let me stare into that again.

Thanks,

        tglx
