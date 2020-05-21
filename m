Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C9E20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgEUQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:11:53 -0400
Received: from foss.arm.com ([217.140.110.172]:49752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbgEUQLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:11:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0314CD6E;
        Thu, 21 May 2020 09:11:52 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5B263F68F;
        Thu, 21 May 2020 09:11:50 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-5-maz@kernel.org> <20200519222447.GJ1551@shell.armlinux.org.uk> <jhjk115xu4a.mognet@arm.com> <20200521151212.GT1551@shell.armlinux.org.uk>
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
Message-ID: <jhjh7w9xo7l.mognet@arm.com>
In-reply-to: <20200521151212.GT1551@shell.armlinux.org.uk>
Date:   Thu, 21 May 2020 17:11:44 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/05/20 16:12, Russell King - ARM Linux admin wrote:
> On Thu, May 21, 2020 at 03:03:49PM +0100, Valentin Schneider wrote:
>>
>> On 19/05/20 23:24, Russell King - ARM Linux admin wrote:
>> > On Tue, May 19, 2020 at 05:17:48PM +0100, Marc Zyngier wrote:
>> >> In order to deal with IPIs as normal interrupts, let's add
>> >> a new way to register them with the architecture code.
>> >>
>> >> set_smp_ipi_range() takes a range of interrupts, and allows
>> >> the arch code to request them as if the were normal interrupts.
>> >> A standard handler is then called by the core IRQ code to deal
>> >> with the IPI.
>> >>
>> >> This means that we don't need to call irq_enter/irq_exit, and
>> >> that we don't need to deal with set_irq_regs either. So let's
>> >> move the dispatcher into its own function, and leave handle_IPI()
>> >> as a compatibility function.
>> >>
>> >> On the sending side, let's make use of ipi_send_mask, which
>> >> already exists for this purpose.
>> >
>> > You say nothing about the nesting of irq_enter() and irq_exit()
>> > for scheduler_ipi().
>> >
>> > Given that lockdep introduced the requirement that hard IRQs can't
>> > be nested, are we sure that calling irq_exit() twice is safe?
>> >
>> > Looking at irqtime_account_irq(), it seems that will cause double-
>> > accounting of in-interrupt time, since we will increment
>> > irq_start_time by just over twice the the period spent handling
>> > the IPI.
>> >
>> > I think the rest of irq_exit() should be safe, but still, this
>> > behaviour should be documented at the very least, if not avoided.
>> >
>>
>> x86 does the same (though IIUC only when tracing reschedule IPI's),
>
> Right, so when the system is operating normally, then the accounting is
> correct.  When the reschedule path is being explicitly traced, then
> the accounting will be doubled for it.
>

Right, it's true that they are only affected when tracing.


That said, AFAICT the accounting nests correctly. Consider:

  irq_enter() @t0
    irq_enter() @t1
    ...
    irq_exit() @t2
  irq_exit() @t3

Entering irqtime_account_irq() at time t, we get something like:

  delta = t - irq_start_time;
  irq_start_time = t;

  if (hardirq_count())
          total += delta;

Since we go through the accounting on both irq_enter() and irq_exit(), we'd
have something like:

  irq_enter() @t0
    irq_start_time = t0

  irq_enter() @t1
    delta = t1 - t0
    irq_start_time = t1
    total += t1 - t0

  irq_exit() @t2
    delta = t2 - t1
    irq_start_time = t2
    total += t2 - t1

  irq_exit() @t3
    delta = t3 - t2
    irq_start_time = t3
    total += t3 - t2


So at the end we have incremented the total by

  t1-t0 + t2-t1 + t3-t2 = t3 - t0

IOW the duration of the outermost pair (... Unless I goofed up).

> What's being proposed for ARM is to always have this mis-accounting,
> where no mis-accounting was present before - and some of us (me) /do/
> enable IRQ accounting in our kernels as standard. So, you can take
> this as a kernel regression report from a user.
>
>> and MIPS has the same issue as it also uses generic IRQ IPI's - so
>> although it's not ideal, I think we can live with it.
>
> Yes, but is there anyone who cares about this for MIPS?
