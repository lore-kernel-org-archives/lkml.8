Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC77C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 12:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BB520723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 12:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFGMAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFGMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 08:00:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD2C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 05:00:53 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jhtxy-0001Yd-Hk; Sun, 07 Jun 2020 13:59:54 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B5D5810108F; Sun,  7 Jun 2020 13:59:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qian Cai <cai@lca.pw>, Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <20200605175200.GA5393@lca.pw>
References: <20200521200513.656533920@linutronix.de> <20200521202117.763775313@linutronix.de> <20200605171816.GA4259@lca.pw> <20200605173622.GL3976@hirez.programming.kicks-ass.net> <20200605175200.GA5393@lca.pw>
Date:   Sun, 07 Jun 2020 13:59:53 +0200
Message-ID: <87v9k3jdc6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


CC:+ Alexander

Qian Cai <cai@lca.pw> writes:
> On Fri, Jun 05, 2020 at 07:36:22PM +0200, Peter Zijlstra wrote:
>> > [ 9371.959858]  asm_call_on_stack+0x12/0x20
>> > asm_call_on_stack at arch/x86/entry/entry_64.S:710
>
> This is one piece of call from the warning call traces that introduced
> by the patch which leads me to revert the commit in the first place. It
> may or may not be the real culprit, but just wanted to highlight it in
> case.

Oh well. The warning is a storage check in the stack depot code,
i.e. stack depot ran out of storage space.

Even if that commit causes stack traces to be larger that revert does
not make any sense at all and handwaving about recursions does not help
either. If that commit introduced a recursion then that would have worse
effects than triggering this warning.

The difference between the interrupt stack switching introduced by this
commit is that it generates another entry in the stack trace compared to
the state before it, which obviously has an effect on the storage
requirements in the stack depot.

Thanks,

        tglx
