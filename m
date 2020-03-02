Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A3A2468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCBIKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:10:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:10:20 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j8g9K-0005TZ-BJ; Mon, 02 Mar 2020 09:10:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7A7B2101161; Mon,  2 Mar 2020 09:10:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <CALCETrVfXmKLN9AxOeizr1mHTA9CSG5-_UgoH8hruTMrrA-0vA@mail.gmail.com>
References: <87imjofkhx.fsf@nanos.tec.linutronix.de> <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net> <87d09wf6dw.fsf@nanos.tec.linutronix.de> <CALCETrVNcpoubrpVrtGjXSQrod8jzjweszEPX_WSJM747xr8wQ@mail.gmail.com> <878skkeygm.fsf@nanos.tec.linutronix.de> <20200301182605.GT2935@paulmck-ThinkPad-P72> <CALCETrVfXmKLN9AxOeizr1mHTA9CSG5-_UgoH8hruTMrrA-0vA@mail.gmail.com>
Date:   Mon, 02 Mar 2020 09:10:01 +0100
Message-ID: <8736arfa92.fsf@nanos.tec.linutronix.de>
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
> On Sun, Mar 1, 2020 at 10:26 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>> > So tracing itself is fine, but then if you have probes or bpf programs
>> > attached to a tracepoint these use rcu_read_lock()/unlock() which is
>> > obviosly wrong in rcuidle context.
>>
>> Definitely, any such code needs to use tricks similar to that of the
>> tracing code.  Or instead use something like SRCU, which is OK with
>> readers from idle.  Or use something like Steve Rostedt's workqueue-based
>> approach, though please be very careful with this latter, lest the
>> battery-powered embedded guys come after you for waking up idle CPUs
>> too often.  ;-)
>>
>
> Are we okay if we somehow ensure that all the entry code before
> enter_from_user_mode() only does rcuidle tracing variants and has
> kprobes off?  Including for BPF use cases?

I think this is the right thing to do. The only requirement we have
_before_ enter_from_user_mode() is to tell lockdep that interrupts are
off. There is not even the need for a real tracepoint IMO. The fact that
the lockdep call is hidden in that tracepoint is just an implementation
detail.

That would clearly set the rules straight: Anything low level entry code
before enter_from_user_mode() returns is neither probable nor
traceable.

I know that some people will argue that this is too restrictive in terms
of instrumentation, but OTOH the whole low level entry code has to be
excluded from instrumentation anyway, so having a dozen instructions
more excluded does not matter at all. Keep it simple!

> It would be *really* nice if we could statically verify this, as has
> been mentioned elsewhere in the thread.  It would also probably be
> good enough if we could do it at runtime.  Maybe with lockdep on, we
> verify rcu state in tracepoints even if the tracepoint isn't active?
> And we could plausibly have some widget that could inject something
> into *every* kprobeable function to check rcu state.

That surely would be useful.

Thanks,

        tglx
