Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28BCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13BC205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgENPGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgENPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:06:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10648C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:06:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZFR1-0001aM-NT; Thu, 14 May 2020 17:06:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id F1E031004CE; Thu, 14 May 2020 17:06:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
In-Reply-To: <20200514131530.GQ2957@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de> <20200505135313.517429268@linutronix.de> <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com> <20200514093257.GT2978@hirez.programming.kicks-ass.net> <87h7wiznl7.fsf@nanos.tec.linutronix.de> <20200514131530.GQ2957@hirez.programming.kicks-ass.net>
Date:   Thu, 14 May 2020 17:06:06 +0200
Message-ID: <878shuzhcx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, May 14, 2020 at 02:51:32PM +0200, Thomas Gleixner wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> > On Wed, May 13, 2020 at 09:57:52PM -0700, Andy Lutomirski wrote:
>> >> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> >
>> >> > From: Peter Zijlstra <peterz@infradead.org>
>> >> >
>> >> > Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
>> >> > creeps in and ruins things.
>> >> >
>> >> > That is; this is the INT3 text poke handler, strictly limit the code
>> >> > that runs in it, lest it inadvertenly hits yet another INT3.
>> >> 
>> >> 
>> >> Acked-by: Andy Lutomirski <luto@kernel.org>
>> >> 
>> >> Does objtool catch this error?
>> >
>> > It does not. I'll put it on the (endless) todo list..
>> 
>> Well, at least it detects when that code calls out into something which
>> is not in the non-instrumentable section.
>
> True, but the more specific problem is that noinstr code can use
> jump_label/static_call just fine.
>
> So a more specific test is validating none of that happens in the INT3
> handler before poke_int3_handler(). Which is what I think Andy was
> after.

Indeed. Forgot about that one.

Hmm, alternatives and jumplabel patch locations in entry.text and
noinstr.text can be valid at least during early boot where we know that
we don't run those code pathes...

Thanks,

        tglx
