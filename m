Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F0C2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgEVTyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgEVTyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:54:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40F6C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 12:54:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcDkB-0003sk-Hq; Fri, 22 May 2020 21:54:11 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 06578100F17; Fri, 22 May 2020 21:54:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 19/37] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <20200522192615.5asnbnanfdiofaj6@treble>
References: <87sgfttobg.fsf@nanos.tec.linutronix.de> <f3be26a9-a0ed-fc6c-f25c-3fd41e718292@oracle.com> <20200522192615.5asnbnanfdiofaj6@treble>
Date:   Fri, 22 May 2020 21:54:10 +0200
Message-ID: <87sgfrrbj1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:

> On Fri, May 22, 2020 at 02:48:53PM -0400, Boris Ostrovsky wrote:
>> > Yes. They just make objtool very unhappy:
>> >
>> > arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0xfd0: special:
>> > can't find orig instruction
>> >
>> > Peter suggested to use:
>> >
>> >       .pos = .
>> >       .byte..
>> >       jmp
>> >       .nops (pos + 8) - .
>> 
>> 
>> Unfortunately this (.nops directive) only works for newer assemblers
>> (2.31, per
>> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=gas/NEWS;h=9a3f352108e439754688e19e63a6235b38801182;hb=5eb617a71463fa6810cd14f57adfe7a1efc93a96)
>> 
>> 
>> I have 2.27 and things don't go well.
>
> A single nop should be fine, since gas will complain if it tries to move
> the IP backwards.

Yes. That's what I posted in the V9 thread :)

> (Also I'd vote for normal indentation instead of the "assembler magic
> at 4 spaces" thing.)

let me fix that
