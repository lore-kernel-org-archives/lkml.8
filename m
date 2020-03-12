Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A4AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgCLPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:55:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCLPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:55:33 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jCQBF-0005ev-Tx; Thu, 12 Mar 2020 16:55:29 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7E8DE10161D; Thu, 12 Mar 2020 16:55:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
In-Reply-To: <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
References: <20200123210242.53367-1-hdegoede@redhat.com> <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2> <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com>
Date:   Thu, 12 Mar 2020 16:55:29 +0100
Message-ID: <87mu8lin4e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:
> On Wed, Mar 11, 2020 at 10:42 PM tip-bot2 for Hans de Goede
> Just help me understand the semantics of this thing...
>
> According to the text in KConfig:
>
> # Tasklet based software resend for pending interrupts on enable_irq()
> config HARDIRQS_SW_RESEND
>        bool
>
> According to
> commit a4633adcdbc15ac51afcd0e1395de58cee27cf92
>
>     [PATCH] genirq: add genirq sw IRQ-retrigger
>
>     Enable platforms that do not have a hardware-assisted
> hardirq-resend mechanism
>     to resend them via a softirq-driven IRQ emulation mechanism.
>
> so when enable_irq() is called, if the IRQ is already asserted,
> it will be distributed in the form of a software irq?
>
> OK I give up I don't understand the semantics of this thing.

Level type interrupts are "resending" in hardware as long as the device
interrupt is still asserted.

The problem are edge interrupts.

    When an edge interrupt is disabled via disable_irq() the core does
    not mask the chip because if the device raises an interrupt not all
    interrupt chips latch that and forward it to the CPU on unmask,
    i.e. some interrupt chips simply ignore an etch when the line is
    masked.

    So when the device raises an edge while the interrupt is disabled
    the core still handles the hardware interrupt and:

      - masks the interrupt line
      - sets the pending bit
      - does not invoke the device handler

    On enable_irq() the pending bit is checked and if set the interrupt
    is tried to be retriggered or resent, but only if it's edge type.
    
    So if the interrupt chip provides a irq_retrigger() callback the
    core uses that and only if this fails or is not available it resorts
    to software "resend" which means queueing it for execution in
    tasklet context.

> I see that ARM and ARM64 simply just select this. What
> happens if you do that and why is x86 not selecting it in general?

irq resending on X86 is not really problem free for interrupts
which are directly connect to the local APIC. The only way which is
halfways safe is the hardware retrigger. See

    https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de
    https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de

for the gory details. The GPIO interrupts which hang off behind some
slow bus or are multiplexed in other ways are not affected by this
hardware design induced madness.

As I don't know how many other architectures have trainwrecked interrupt
delivery mechanisms (IA64 definitely does), I'm more than reluctant to
inflict this on the world unconditionally.

Hope that helps.

Thanks,

        tglx
