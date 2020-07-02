Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C46C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D6E20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgGBNXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:23:10 -0400
Received: from foss.arm.com ([217.140.110.172]:51592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729067AbgGBNXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:23:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0417B1FB;
        Thu,  2 Jul 2020 06:23:08 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C1A3F68F;
        Thu,  2 Jul 2020 06:23:06 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-7-maz@kernel.org> <jhjimffgfyt.mognet@arm.com> <f9502c41d941e56ffcc30c51f2d23ab9@kernel.org>
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
Subject: Re: [PATCH v2 06/17] irqchip/gic-v3: Configure SGIs as standard interrupts
In-reply-to: <f9502c41d941e56ffcc30c51f2d23ab9@kernel.org>
Date:   Thu, 02 Jul 2020 14:23:04 +0100
Message-ID: <jhjmu4i830n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/20 11:15, Marc Zyngier wrote:
> On 2020-06-25 19:25, Valentin Schneider wrote:
>> Also, while staring at this it dawned on me that IPI's don't need the
>> eoimode=0 isb(): due to how the IPI flow-handler is structured, we'll
>> get a
>> gic_eoi_irq() just before calling into the irqaction. Dunno how much we
>> care about it.
>
> That's interesting. This ISB is a leftover from the loop we had before
> the pseudo-NMI code, where we had to make sure the write to EOIR was
> ordered with the read from IAR.
>
> Given that we have an exception return right after the interrupt
> handling, I *think* we could get rid of it (but that would need
> mode checking on broken systems such as TX1...).  I don't think
> this is specific to IPIs though.
>

If I got this one right:

  39a06b67c2c1 ("irqchip/gic: Ensure we have an ISB between ack and ->handle_irq")

you're describing case 2, which is indeed gone on gic-v3. However IIUC we
also want an ISB between poking IAR and calling into the irqaction (case 1)
- we get just that with IPIs due to the early gic_eoi_irq(), but we don't
for the other flows.

> Thanks,
>
>          M.
