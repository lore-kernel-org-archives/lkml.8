Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B60C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD690206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgFJTjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgFJTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:39:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F8C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 12:39:35 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jj6Yq-0002IN-V7; Wed, 10 Jun 2020 21:38:57 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5506C1013D0; Wed, 10 Jun 2020 21:38:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
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
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <20200610123833.GD954@lca.pw>
References: <87zh9cnfmg.fsf@nanos.tec.linutronix.de> <87wo4gnetx.fsf@nanos.tec.linutronix.de> <20200610123833.GD954@lca.pw>
Date:   Wed, 10 Jun 2020 21:38:56 +0200
Message-ID: <87h7vig17z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> On Tue, Jun 09, 2020 at 10:50:50PM +0200, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> >> BAD (after oom02)
>> >> # cat /sys/kernel/debug/stackdepot/info
>> >> Unique stacks: 140476
>> >
>> > That's indeed odd. I try to reproduce and figure out what really breaks
>> > here.
>> 
>> I checked your config file and I think I know where this comes from. Can
>> you plase disable KASAN just for testing purposes and compare before
>> after again?
>
> It turns out I'll need a few days to be able to get ahold of those
> affected systems again. I'll be reporting back as soon as possible.

I figured it out. It has nothing to do with asm_call_on...(). It's also
unrelated to page_owner. It's purely a KASAN issue.

KASAN trims stack traces with the help of filter_irq_stacks() which
relies on __irqentry_text_start/end

The entry rework moved the interrupt entry points out of the irqentry
section, which breaks that filter function.

I made it work again. Here are the numbers which make that obvious:

Mainline:
Unique stacks: 23403
Depot index:   244
Depot offset:  4208

x86/entry:
Unique stacks: 38835
Depot index:   464
Depot offset:  7616

x86/entry + fix:
Unique stacks: 23607
Depot index:   247
Depot offset:  14224

So with the non-working trimming this generates more unique stacks and
because they are not trimmed they become larger and eat more storage
space. The resulting average per stack shows that:

Mainline:           171 bytes per stack
x86/entry:          195 bytes per stack
x86/entry + fix:    172 bytes per stack

I'll point you to a test branch shortly.

Thanks,

        tglx
