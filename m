Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B8DC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAB320714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgELIOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgELIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:14:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:14:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYQ3A-000794-UD; Tue, 12 May 2020 10:14:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 321E41004DE; Tue, 12 May 2020 10:14:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 2 10/18] x86/entry/64: Check IF in __preempt_enable_notrace() thunk
In-Reply-To: <20200511215108.3ccea526@oasis.local.home>
References: <20200505134112.272268764@linutronix.de> <20200505134341.087595319@linutronix.de> <20200511215108.3ccea526@oasis.local.home>
Date:   Tue, 12 May 2020 10:14:04 +0200
Message-ID: <87blmt604z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> On Tue, 05 May 2020 15:41:22 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> The preempt_enable_notrace() ASM thunk is called from tracing, entry code
>> RCU and other places which are already in or going to be in the noinstr
>> section which protects sensitve code from being instrumented.
>> 
>> Calls out of these sections happen with interrupts disabled, which is
>> handled in C code, but the push regs, call, pop regs sequence can be
>> completely avoided in this case.
>> 
>> This is also a preparatory step for annotating the call from the thunk to
>> preempt_enable_notrace() safe from a noinstr section.
>> 
>
> BTW, after applying this patch, I get the following error:
>
> /work/git/linux-test.git/arch/x86/entry/thunk_64.S: Assembler messages:
> /work/git/linux-test.git/arch/x86/entry/thunk_64.S:67: Error: invalid operands (*UND* and *UND* sections) for `+'
> /work/git/linux-test.git/arch/x86/entry/thunk_64.S:67: Error: invalid operands (*UND* and *ABS* sections) for `/'
> make[3]: *** [/work/git/linux-test.git/scripts/Makefile.build:349: arch/x86/entry/thunk_64.o] Error 1
> make[3]: *** Waiting for unfinished jobs....

Yes I know, but I'm going to drop that patch completely.
