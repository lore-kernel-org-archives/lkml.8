Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD76C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38D120781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390770AbgFYSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:25:07 -0400
Received: from foss.arm.com ([217.140.110.172]:43018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390025AbgFYSZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:25:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F2CD6E;
        Thu, 25 Jun 2020 11:25:06 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3BAE3F71E;
        Thu, 25 Jun 2020 11:25:04 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Subject: Re: [PATCH v2 00/17] arm/arm64: Turning IPIs into normal interrupts
In-reply-to: <20200624195811.435857-1-maz@kernel.org>
Date:   Thu, 25 Jun 2020 19:24:59 +0100
Message-ID: <jhjmu4rgg04.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 24/06/20 20:57, Marc Zyngier wrote:
> For as long as SMP ARM has existed, IPIs have been handled as
> something special. The arch code and the interrupt controller exchange
> a couple of hooks (one to generate an IPI, another to handle it).
>
> Although this is perfectly manageable, it prevents the use of features
> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
> also means that each interrupt controller driver has to follow an
> architecture-specific interface instead of just implementing the base
> irqchip functionalities. The arch code also duplicates a number of
> things that the core irq code already does (such as calling
> set_irq_regs(), irq_enter()...).
>
> This series tries to remedy this on arm/arm64 by offering a new
> registration interface where the irqchip gives the arch code a range
> of interrupts to use for IPIs. The arch code requests these as normal
> per-cpu interrupts.
>
> The bulk of the work is at the interrupt controller level, where all 5
> irqchips used on arm+SMP/arm64 get converted.
>
> Finally, we drop the legacy registration interface as well as the
> custom statistics accounting.
>
> Note that I have had a look at providing a "generic" interface by
> expanding the kernel/irq/ipi.c bag of helpers, but so far all
> irqchips have very different requirements, so there is hardly anything
> to consolidate for now. Maybe some as hip04 and the Marvell horror get
> cleaned up (the latter certainly could do with a good dusting).
>
> This has been tested on a bunch of 32 and 64bit guests (GICv2, GICv3),
> as well as 64bit bare metal (GICv3). The RPi part has only been tested
> in QEMU as a 64bit guest, while the HiSi and Marvell parts have only
> been compile-tested.
>

I gave that a spin on Juno r0 and HiKey960 (both GICv2), all good! I also
wanted to try it out on my eMAG (to get some GICv3 airtime) but ran into
"technical difficulties". I think I'll need to get someone to go poke
it (most likely next week). I'm pretty sure I'm the one who should be
asking you for hardware, but if there's anything specific you need me to
test, please shout.

I have a few extra nits/comments in some patches, but it's all fairly minor
so FWIW you can also add, for patches [01-10, 14-15]:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

I haven't really looked at those other irqchips, but I can give it a shot
if no one else shows up. Also I'll most likely look at the arm side, but
I'm afraid I'm too well-done right now to pay much more attention to
details.
