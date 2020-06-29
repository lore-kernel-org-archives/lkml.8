Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85303C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E3E206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466525;
	bh=aUlW1jN73vdOSZpkpkucX5DY39QfgpzaB4OVxaLyNwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=okW6n+74KGxTD63sV1CXmLeldkOYz9EB+2n0aeI4ZK5yRGrI50O1DyfmZ60kCavjN
	 ZY6Nf8WHr/aPpvFCHeEH/lwARkgJV6BuvyGcHYMk3uhewJKf//mIVJib/PThkX3bSE
	 AIkeyakj35aafTWMgvL4CSVYK326IPutX3N4QBTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391312AbgF2VfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgF2Skv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CCC23341;
        Mon, 29 Jun 2020 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593423463;
        bh=aUlW1jN73vdOSZpkpkucX5DY39QfgpzaB4OVxaLyNwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fQhAJAY2GQWzjXCHbIzBM0WcizWlyLgsusUesRD5/mJLqWfstu9qc2Z4O5NWMc3AI
         xWohK04BBHDh0YjLNX+w47tv7DpEXNO4+hLXXkD3QEmjwCPtmLCKy0Dqu1JhGBVGtA
         Uayx7idGwLNExpoi3uR2z6+tmpozhbSFMRLNUGhk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jpqEP-007I8r-Eo; Mon, 29 Jun 2020 10:37:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Jun 2020 10:37:41 +0100
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
Subject: Re: [PATCH v2 04/17] ARM: Allow IPIs to be handled as normal
 interrupts
In-Reply-To: <jhjk0zvgfz7.mognet@arm.com>
References: <20200624195811.435857-1-maz@kernel.org>
 <20200624195811.435857-5-maz@kernel.org> <jhjk0zvgfz7.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <abca3a7e3f019b0f07ab2ec42894001b@kernel.org>
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
> On 24/06/20 20:57, Marc Zyngier wrote:
>> @@ -696,9 +696,76 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
>> 
>>       if ((unsigned)ipinr < NR_IPI)
>>               trace_ipi_exit_rcuidle(ipi_types[ipinr]);
>> +}
>> +
>> +/* Legacy version, should go away once all irqchips have been 
>> converted */
>> +void handle_IPI(int ipinr, struct pt_regs *regs)
>> +{
>> +	struct pt_regs *old_regs = set_irq_regs(regs);
>> +
>> +	irq_enter();
>> +	do_handle_IPI(ipinr);
>> +	irq_exit();
>> +
>>       set_irq_regs(old_regs);
>>  }
>> 
>> +static irqreturn_t ipi_handler(int irq, void *data)
>> +{
>> +	do_handle_IPI(irq - ipi_irq_base);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void ipi_send(const struct cpumask *target, unsigned int ipi)
>> +{
>> +	__ipi_send_mask(ipi_desc[ipi], target);
>> +}
>> +
>> +static void ipi_setup(int cpu)
>> +{
>> +	if (ipi_irq_base) {
>> +		int i;
>> +
>> +		for (i = 0; i < nr_ipi; i++)
>> +			enable_percpu_irq(ipi_irq_base + i, 0);
>> +	}
>> +}
>> +
>> +static void ipi_teardown(int cpu)
>> +{
>> +	if (ipi_irq_base) {
>> +		int i;
>> +
>> +		for (i = 0; i < nr_ipi; i++)
>> +			disable_percpu_irq(ipi_irq_base + i);
>> +	}
>> +}
>> +
>> +void __init set_smp_ipi_range(int ipi_base, int n)
>> +{
>> +	int i;
>> +
>> +	WARN_ON(n < MAX_IPI);
>> +	nr_ipi = min(n, MAX_IPI);
> 
> 
> I got confused by that backtrace thing and NR_IPI vs MAX_IPI.
> I think I got it now : we don't want to call trace_ipi_raise() for
> IPI_CPU_BACKTRACE *but* we still need to alloc the desc and route it
> through the generic IPI layers.

Indeed, and I didn't want to have a bizarre "+ 1" hanging about.

> The only difference I can tell is that now we will get some trace 
> events
> for it via the handler entry/exit tracepoints - that shouldn't cause 
> any
> issue.

I hope so. I don't see how you can avoid all tracepoints anyway (if that
was the intention).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
