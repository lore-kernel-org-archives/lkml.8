Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA86EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95AB2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593512148;
	bh=AnrGPXZ0L3XFWcwycTfoFtiR62BIC4cXUJGTL2T6Ymk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nZe9LyggYv+e6clouaAlFuflVllUXpVpaKMcktE9ucs9Bc8Uke36ZrDGol33n5sim
	 7moH/G361z/vSlbKTKt1MPhHKWevGbplhctx2eImZDK43xE7CQUwqsHillqM8bFDpc
	 +9C+T0gnH+HU9OxAWQi/p08tgo8r10/DoBN+n62E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgF3KPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731155AbgF3KPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:15:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 310812073E;
        Tue, 30 Jun 2020 10:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593512144;
        bh=AnrGPXZ0L3XFWcwycTfoFtiR62BIC4cXUJGTL2T6Ymk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=poSpxfVsPFzdrIYdiHqRbaXPpyDLpWpyCa/T+q7RuCj//1Y90s/jNdAltWjoJqTv5
         xU3qD4C0ZpR+CUSfhDjWssLQ3KHLbtjZGOx2lOH60RKvc23lPiTTD9CCbrkIX/bqvw
         2YKqpUMLl4yxpzXAH3qYmxrRyes8clDAaQsKJYc4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqDIk-007i3h-O9; Tue, 30 Jun 2020 11:15:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Jun 2020 11:15:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
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
Subject: Re: [PATCH v2 06/17] irqchip/gic-v3: Configure SGIs as standard
 interrupts
In-Reply-To: <jhjimffgfyt.mognet@arm.com>
References: <20200624195811.435857-1-maz@kernel.org>
 <20200624195811.435857-7-maz@kernel.org> <jhjimffgfyt.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <f9502c41d941e56ffcc30c51f2d23ab9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 19:25, Valentin Schneider wrote:
> On 24/06/20 20:58, Marc Zyngier wrote:
>> Change the way we deal with GICv3 SGIs by turning them into proper
>> IRQs, and calling into the arch code to register the interrupt range
>> instead of a callback.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 81 
>> +++++++++++++++++++-----------------
>>  1 file changed, 43 insertions(+), 38 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>> b/drivers/irqchip/irq-gic-v3.c
>> index 19b294ed48ba..d275e9b9533d 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -36,6 +36,8 @@
>>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>>  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
>> 
>> +#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
>> +
> 
> Nit: this piqued my interest but ended up being just a define shuffle; 
> As a
> member of the git speleologists' guild, I'd be overjoyed with having a
> small notion of that in the changelog.

Fair enough.

> 
>>  struct redist_region {
>>       void __iomem		*redist_base;
>>       phys_addr_t		phys_base;
>> @@ -657,38 +659,14 @@ static asmlinkage void __exception_irq_entry 
>> gic_handle_irq(struct pt_regs *regs
>>       if ((irqnr >= 1020 && irqnr <= 1023))
>>               return;
>> 
>> -	/* Treat anything but SGIs in a uniform way */
>> -	if (likely(irqnr > 15)) {
>> -		int err;
>> -
>> -		if (static_branch_likely(&supports_deactivate_key))
>> -			gic_write_eoir(irqnr);
>> -		else
>> -			isb();
>> -
>> -		err = handle_domain_irq(gic_data.domain, irqnr, regs);
>> -		if (err) {
>> -			WARN_ONCE(true, "Unexpected interrupt received!\n");
>> -			gic_deactivate_unhandled(irqnr);
>> -		}
>> -		return;
>> -	}
>> -	if (irqnr < 16) {
>> +	if (static_branch_likely(&supports_deactivate_key))
>>               gic_write_eoir(irqnr);
>> -		if (static_branch_likely(&supports_deactivate_key))
>> -			gic_write_dir(irqnr);
>> -#ifdef CONFIG_SMP
>> -		/*
>> -		 * Unlike GICv2, we don't need an smp_rmb() here.
>> -		 * The control dependency from gic_read_iar to
>> -		 * the ISB in gic_write_eoir is enough to ensure
>> -		 * that any shared data read by handle_IPI will
>> -		 * be read after the ACK.
>> -		 */
> 
> Isn't that still relevant?

It is. It is just that there is no really good place to put it.
I may end-up just leaving it where it is.

> Also, while staring at this it dawned on me that IPI's don't need the
> eoimode=0 isb(): due to how the IPI flow-handler is structured, we'll 
> get a
> gic_eoi_irq() just before calling into the irqaction. Dunno how much we
> care about it.

That's interesting. This ISB is a leftover from the loop we had before
the pseudo-NMI code, where we had to make sure the write to EOIR was
ordered with the read from IAR.

Given that we have an exception return right after the interrupt
handling, I *think* we could get rid of it (but that would need
mode checking on broken systems such as TX1...).  I don't think
this is specific to IPIs though.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
