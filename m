Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BCCC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD42921556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBZUN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:13:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59417 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBZUN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:13:59 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j733y-0005cV-SR; Wed, 26 Feb 2020 21:13:47 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EE577104099; Wed, 26 Feb 2020 21:13:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <CAMzpN2ij8ReOXZH00puhzraCGRdKY8qt+TMipd_14_XWTu8xtg@mail.gmail.com>
References: <20200225224719.950376311@linutronix.de> <20200225231609.000955823@linutronix.de> <CAMzpN2ij8ReOXZH00puhzraCGRdKY8qt+TMipd_14_XWTu8xtg@mail.gmail.com>
Date:   Wed, 26 Feb 2020 21:13:45 +0100
Message-ID: <87k149p0na.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:

> On Tue, Feb 25, 2020 at 6:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Device interrupts which go through do_IRQ() or the spurious interrupt
>> handler have their separate entry code on 64 bit for no good reason.
>>
>> Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
>> pt_regs. Further the vector number is forced to fit into an u8 and is
>> complemented and offset by 0x80 for historical reasons.
>
> The reason for the 0x80 offset is so that the push instruction only
> takes two bytes.  This allows each entry stub to be packed into a
> fixed 8 bytes.  idt_setup_apic_and_irq_gates() assumes this 8-byte
> fixed length for the stubs, so now every odd vector after 0x80 is
> broken.
>
>      508:       6a 7f                   pushq  $0x7f
>      50a:       e9 f1 08 00 00          jmpq   e00 <common_interrupt>
>      50f:       90                      nop
>      510:       68 80 00 00 00          pushq  $0x80
>      515:       e9 e6 08 00 00          jmpq   e00 <common_interrupt>
>      51a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
>      520:       68 81 00 00 00          pushq  $0x81
>      525:       e9 d6 08 00 00          jmpq   e00 <common_interrupt>
>      52a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
>
> The 0x81 vector should start at 0x518, not 0x520.

Bah, I somehow missed that big fat comment explaining it. :)

Thanks for catching it. So my testing just has been lucky to not hit one
of those.

Now the question is whether we care about the packed stubs or just make
them larger by using alignment to get rid of this silly +0x80 and
~vector fixup later on. The straight forward thing clearly has its charm
and I doubt it matters in measurable ways.

Thanks,

        tglx


