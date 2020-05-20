Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43740C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1D92054F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgETPJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgETPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:09:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE7C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:09:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbQKn-0003t3-NK; Wed, 20 May 2020 17:08:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3580A100C99; Wed, 20 May 2020 17:08:41 +0200 (CEST)
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 30/37] x86/entry: Convert reschedule interrupt to IDTENTRY_RAW
In-Reply-To: <CALCETrUYwedYeia=DoS8OXGmHVScdqP6vCoWrbfaAi7j83U-_A@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235127.404958221@linutronix.de> <CALCETrUYwedYeia=DoS8OXGmHVScdqP6vCoWrbfaAi7j83U-_A@mail.gmail.com>
Date:   Wed, 20 May 2020 17:08:41 +0200
Message-ID: <87o8qi4pae.fsf@nanos.tec.linutronix.de>
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

> On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>
>> The scheduler IPI does not need the full interrupt entry handling logic
>> when the entry is from kernel mode.
>>
>> Even if tracing is enabled the only requirement is that RCU is watching and
>> preempt_count has the hardirq bit on.
>>
>> The NOHZ tick state does not have to be adjusted. If the tick is not
>> running then the CPU is in idle and the idle exit will restore the
>> tick. Softinterrupts are not raised here, so handling them on return is not
>> required either.
>>
>> User mode entry must go through the regular entry path as it will invoke
>> the scheduler on return so context tracking needs to be in the correct
>> state.
>>
>> Use IDTENTRY_RAW and the RCU conditional variants of idtentry_enter/exit()
>> to guarantee that RCU is watching even if the IPI hits a RCU idle section.
>>
>> Remove the tracepoint static key conditional which is incomplete
>> vs. tracing anyway because e.g. ack_APIC_irq() calls out into
>> instrumentable code.
>>
>> Avoid the overhead of irq time accounting and introduce variants of
>> __irq_enter/exit() so instrumentation observes the correct preempt count
>> state.
>
> Leftover text from an old version?

Indeed

> The code is Reviewed-by: Andy Lutomirski <luto@kernel.org>
