Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28B8C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0C206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgEKOgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgEKOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:36:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C077C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:36:31 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jY9X7-0008BQ-AC; Mon, 11 May 2020 16:35:53 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6510FFFBF8; Mon, 11 May 2020 16:35:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
Subject: Re: [patch V4 part 5 13/31] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <CAJhGHyCgGxia1hzTWVF+-s5AXnUM9SnvxdfJK5PsZQCDbWfKNw@mail.gmail.com>
References: <20200505135341.730586321@linutronix.de> <20200505135829.384803459@linutronix.de> <CAJhGHyCgGxia1hzTWVF+-s5AXnUM9SnvxdfJK5PsZQCDbWfKNw@mail.gmail.com>
Date:   Mon, 11 May 2020 16:35:52 +0200
Message-ID: <87v9l25yk7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai,

Lai Jiangshan <jiangshanlai+lkml@gmail.com> writes:
> On Tue, May 5, 2020 at 10:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:
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
> Using ".byte   0x6a, vector" is somewhat ugly.
>
> I hope it should be " pushq $(s8_to_s64(vector))", which can also
> help to reduce bunches of comments about ".byte   0x6a, vector".
>
> However, I don't know how to implement s8_to_s64() here.

Neither do I.

> But at least the following code works (generates the same two-byte
> machine code as ".byte 0x6a, vector" does):
>
>         .if vector < 128
>         pushq $(vector)
>         .else
>         pushq $(0xffffffffffffff00+vector)
>         .endif

Only slightly less ugly and needs as much commentry as the above.

Thanks,

        tglx
