Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B137206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgEUODx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:03:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgEUODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:03:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BDD0D6E;
        Thu, 21 May 2020 07:03:52 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48DC43F305;
        Thu, 21 May 2020 07:03:51 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-5-maz@kernel.org> <20200519222447.GJ1551@shell.armlinux.org.uk>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 04/11] ARM: Allow IPIs to be handled as normal interrupts
In-reply-to: <20200519222447.GJ1551@shell.armlinux.org.uk>
Date:   Thu, 21 May 2020 15:03:49 +0100
Message-ID: <jhjk115xu4a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/20 23:24, Russell King - ARM Linux admin wrote:
> On Tue, May 19, 2020 at 05:17:48PM +0100, Marc Zyngier wrote:
>> In order to deal with IPIs as normal interrupts, let's add
>> a new way to register them with the architecture code.
>>
>> set_smp_ipi_range() takes a range of interrupts, and allows
>> the arch code to request them as if the were normal interrupts.
>> A standard handler is then called by the core IRQ code to deal
>> with the IPI.
>>
>> This means that we don't need to call irq_enter/irq_exit, and
>> that we don't need to deal with set_irq_regs either. So let's
>> move the dispatcher into its own function, and leave handle_IPI()
>> as a compatibility function.
>>
>> On the sending side, let's make use of ipi_send_mask, which
>> already exists for this purpose.
>
> You say nothing about the nesting of irq_enter() and irq_exit()
> for scheduler_ipi().
>
> Given that lockdep introduced the requirement that hard IRQs can't
> be nested, are we sure that calling irq_exit() twice is safe?
>
> Looking at irqtime_account_irq(), it seems that will cause double-
> accounting of in-interrupt time, since we will increment
> irq_start_time by just over twice the the period spent handling
> the IPI.
>
> I think the rest of irq_exit() should be safe, but still, this
> behaviour should be documented at the very least, if not avoided.
>

x86 does the same (though IIUC only when tracing reschedule IPI's), and
MIPS has the same issue as it also uses generic IRQ IPI's - so although
it's not ideal, I think we can live with it.
