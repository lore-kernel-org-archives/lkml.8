Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169ED20671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgEUNYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgEUNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:24:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7325C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:24:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbl9o-0000mn-Ld; Thu, 21 May 2020 15:22:44 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C5455100C2D; Thu, 21 May 2020 15:22:43 +0200 (CEST)
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
Subject: Re: [patch V6 19/37] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <CALCETrWjT+A_AAuv=zZ52vJhR2ZADktB3XZnO8n_qu09S0P0vQ@mail.gmail.com>
Date:   Thu, 21 May 2020 15:22:43 +0200
Message-ID: <87sgfttobg.fsf@nanos.tec.linutronix.de>
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
>
>  +       .align 8
>> +SYM_CODE_START(irq_entries_start)
>> +    vector=FIRST_EXTERNAL_VECTOR
>> +    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
>> +       UNWIND_HINT_IRET_REGS
>> +       .byte   0x6a, vector
>> +       jmp     common_interrupt
>> +       .align  8
>> +    vector=vector+1
>> +    .endr
>> +SYM_CODE_END(irq_entries_start)
>
> Having battled code like this in the past (for early exceptions), I
> prefer the variant like:
>
> pos = .;
> .rept blah blah blah
>   .byte whatever
>   jmp whatever
>   . = pos + 8;
>  vector = vector + 1
> .endr
>
> or maybe:
>
> .rept blah blah blah
>   .byte whatever
>   jmp whatever;
>   . = irq_entries_start + 8 * vector;
>   vector = vector + 1
> .endr
>
> The reason is that these variants will fail to assemble if something
> goes wrong and the code expands to more than 8 bytes, whereas using
> .align will cause gas to happily emit 16 bytes and result in
> hard-to-debug mayhem.

Yes. They just make objtool very unhappy:

arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0xfd0: special:
can't find orig instruction

Peter suggested to use:

      .pos = .
      .byte..
      jmp
      .nops (pos + 8) - .

That works ...
