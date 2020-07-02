Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35394C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1850220772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgGBOYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:24:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbgGBOYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:24:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 599A331B;
        Thu,  2 Jul 2020 07:24:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB2A3F68F;
        Thu,  2 Jul 2020 07:24:35 -0700 (PDT)
References: <20200624195811.435857-1-maz@kernel.org> <20200624195811.435857-7-maz@kernel.org> <jhjimffgfyt.mognet@arm.com> <f9502c41d941e56ffcc30c51f2d23ab9@kernel.org> <jhjmu4i830n.mognet@arm.com> <1f3ac757acd15f6804917e222194c9cf@kernel.org>
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
In-reply-to: <1f3ac757acd15f6804917e222194c9cf@kernel.org>
Date:   Thu, 02 Jul 2020 15:24:30 +0100
Message-ID: <jhjlfk28069.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/20 14:48, Marc Zyngier wrote:
> On 2020-07-02 14:23, Valentin Schneider wrote:
>> On 30/06/20 11:15, Marc Zyngier wrote:
>>> On 2020-06-25 19:25, Valentin Schneider wrote:
>>>> Also, while staring at this it dawned on me that IPI's don't need the
>>>> eoimode=0 isb(): due to how the IPI flow-handler is structured, we'll
>>>> get a
>>>> gic_eoi_irq() just before calling into the irqaction. Dunno how much
>>>> we
>>>> care about it.
>>>
>>> That's interesting. This ISB is a leftover from the loop we had before
>>> the pseudo-NMI code, where we had to make sure the write to EOIR was
>>> ordered with the read from IAR.
>>>
>>> Given that we have an exception return right after the interrupt
>>> handling, I *think* we could get rid of it (but that would need
>>> mode checking on broken systems such as TX1...).  I don't think
>>> this is specific to IPIs though.
>>>
>>
>> If I got this one right:
>>
>>   39a06b67c2c1 ("irqchip/gic: Ensure we have an ISB between ack and
>> ->handle_irq")
>>
>> you're describing case 2, which is indeed gone on gic-v3. However IIUC
>> we
>> also want an ISB between poking IAR and calling into the irqaction
>> (case 1)
>> - we get just that with IPIs due to the early gic_eoi_irq(), but we
>> don't
>> for the other flows.
>
> You just made me realise something amazing: I've started to forget about
> all this crap. Which is wonderful! ;-)
>

:)

> More seriously, you are absolutely right. If we wanted to address this,
> we'd probably have to give IPIs their own irqchip so that they get their
> own eoi callback. Not sure that's worth it.
>

I was initially thinking of something like

        if (static_branch_likely(&supports_deactivate_key))
                gic_write_eoir(irqnr);
        else if (__get_intid_range(irqnr) != SGI_RANGE)
                isb();

which is not particularly pretty, so maybe we should just slap this to the
isb():

                /* Superfluous for SGIs, but who cares */

>          M.
