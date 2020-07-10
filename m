Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C7FC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1E32078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgGJRIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:08:09 -0400
Received: from foss.arm.com ([217.140.110.172]:57792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgGJRIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:08:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DB8231B;
        Fri, 10 Jul 2020 10:08:08 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969463F8F8;
        Fri, 10 Jul 2020 10:08:07 -0700 (PDT)
References: <20200710145642.28978-1-valentin.schneider@arm.com> <87tuyfxria.wl-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [RFC PATCH] irqchip/gic: Implement irq_chip->irq_retrigger()
In-reply-to: <87tuyfxria.wl-maz@kernel.org>
Date:   Fri, 10 Jul 2020 18:08:01 +0100
Message-ID: <jhjr1tjl2mm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/07/20 17:29, Marc Zyngier wrote:
> On Fri, 10 Jul 2020 15:56:42 +0100,
> Valentin Schneider <valentin.schneider@arm.com> wrote:

[...]

>> Implement irq_chip.irq_retrigger() for both GICs.
>
> Although I am very grateful for the whole documentation, I'd rather
> have a slightly more condensed changelog that documents the
> implementation of the retrigger callback! ;-)
>

Hah, indeed! I was relatively unsure about that whole thing, hence why I
sent it as RFC with a wall of text attached. I'll probably strip out the
GIC doc snippets for the "actual" changelog, and talk about the *contents*
of the patch some more.

>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 7 +++++++
>>  drivers/irqchip/irq-gic.c    | 6 ++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index cc46bc2d634b..c025e8b51464 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -1207,6 +1207,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>  #define gic_smp_init()		do { } while(0)
>>  #endif
>>
>> +static int gic_retrigger(struct irq_data *data)
>> +{
>> +	return gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
>
> If I'm not mistaken, check_irq_resend() requires a non-zero return
> value if the retrigger has succeeded. So something like
>
>       return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
>
> would be more appropriate.
>

Aye, you're right. And while we're at it, we probably still don't want to
fallback to irq_sw_resend() if the retrigger fails, so we should add some
irqd_set_handle_enforce_irqctx() somewhere in the GICs or plainly deselect
CONFIG_HARDIRQS_SW_RESEND.

I'm not very familiar with LPIs just yet, but seeing as they too use
handle_fasteoi_irq() and can't get retriggered, I'd rather play it safe.


This brings me to another point: while this boots just
fine, I didn't get to test out IRQs marked with IRQS_PENDING. IIUC
enable_irq_wake() should give me a decent trail - I see serial_core making
use of it. I'll go give suspend a try.

> Otherwise, looks good.
>

Thanks for having a look!

> Thanks,
>
>       M.
