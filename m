Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2C7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C0E20756
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589635850;
	bh=PwRB1E7WBwQxVNyw66zIhErDW9p/iRr+zpHERrFU4n0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PTqjJqQ7d5pk8ybPbwtOMRR6+HZXR7K4aJyKLsC3cs6kF3gLVxNPpJ7VIDnItL4Q8
	 k8EZdfMRgo29+kQLYuLATD8ZMoDXOHOo0NZsdmVioE212VL+AVVXG1CMIn0qv1N/tA
	 mbkVz2yZbk/mGxyGBJUUk5KaTvv2yqdCsymcG70U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEPNat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 09:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgEPNat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 09:30:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C306B206D8;
        Sat, 16 May 2020 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589635847;
        bh=PwRB1E7WBwQxVNyw66zIhErDW9p/iRr+zpHERrFU4n0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IZxx/P8MIzqxYDJ0ENMGposfK8eIoCqj6tBgpob3pD7lEi+3CRuojeNapWv8UZS7G
         QvVP8oXtodq5Ddhr2LoYkd/spKC4gR9v26GOLjnFUkfYfCOfG9DA8eTGf+PO61RMva
         yt0w+nnBa+pmHnCCMjoN5obmukbJzciExVYQ3xWo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZwtq-00CpFj-5o; Sat, 16 May 2020 14:30:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 14:30:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] irqchip/sifive-plic: Setup cpuhp once after current
 handler is present
In-Reply-To: <DM6PR04MB62012DBAF3FAA7A264094C418DBA0@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-2-anup.patel@wdc.com>
 <d4e0dcceecad49e71ffe785f8950981d@kernel.org>
 <DM6PR04MB62012DBAF3FAA7A264094C418DBA0@DM6PR04MB6201.namprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0be23fcd363998ddd527eceb308f592c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Anup.Patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, Atish.Patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-16 13:52, Anup Patel wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@kernel.org>
>> Sent: 16 May 2020 17:42
>> To: Anup Patel <Anup.Patel@wdc.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Paul Walmsley
>> <paul.walmsley@sifive.com>; Thomas Gleixner <tglx@linutronix.de>; 
>> Jason
>> Cooper <jason@lakedaemon.net>; Atish Patra <Atish.Patra@wdc.com>; 
>> Alistair
>> Francis <Alistair.Francis@wdc.com>; Anup Patel <anup@brainfault.org>; 
>> linux-
>> riscv@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/4] irqchip/sifive-plic: Setup cpuhp once after 
>> current
>> handler is present
>> 
>> Hi Anup,
>> 
>> On 2020-05-16 07:38, Anup Patel wrote:
>> > For multiple PLIC instances, the plic_init() is called once for each
>> > PLIC instance. Due to this we have two issues:
>> > 1. cpuhp_setup_state() is called multiple times 2. plic_starting_cpu()
>> > can crash for boot CPU if cpuhp_setup_state()
>> >    is called before boot CPU PLIC handler is available.
>> >
>> > This patch fixes both above issues.
>> >
>> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> > ---
>> >  drivers/irqchip/irq-sifive-plic.c | 14 ++++++++++++--
>> >  1 file changed, 12 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/irq-sifive-plic.c
>> > b/drivers/irqchip/irq-sifive-plic.c
>> > index 822e074c0600..7dc23edb3267 100644
>> > --- a/drivers/irqchip/irq-sifive-plic.c
>> > +++ b/drivers/irqchip/irq-sifive-plic.c
>> > @@ -76,6 +76,7 @@ struct plic_handler {
>> >  	void __iomem		*enable_base;
>> >  	struct plic_priv	*priv;
>> >  };
>> > +static bool plic_cpuhp_setup_done;
>> >  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>> >
>> >  static inline void plic_toggle(struct plic_handler *handler, @@
>> > -282,6 +283,7 @@ static int __init plic_init(struct device_node *node,
>> >  	int error = 0, nr_contexts, nr_handlers = 0, i;
>> >  	u32 nr_irqs;
>> >  	struct plic_priv *priv;
>> > +	struct plic_handler *handler;
>> >
>> >  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> >  	if (!priv)
>> > @@ -310,7 +312,6 @@ static int __init plic_init(struct device_node
>> > *node,
>> >
>> >  	for (i = 0; i < nr_contexts; i++) {
>> >  		struct of_phandle_args parent;
>> > -		struct plic_handler *handler;
>> >  		irq_hw_number_t hwirq;
>> >  		int cpu, hartid;
>> >
>> > @@ -364,9 +365,18 @@ static int __init plic_init(struct device_node
>> > *node,
>> >  		nr_handlers++;
>> >  	}
>> >
>> > -	cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>> > +	/*
>> > +	 * We can have multiple PLIC instances so setup cpuhp state only
>> > +	 * when context handler for current/boot CPU is present.
>> > +	 */
>> > +	handler = this_cpu_ptr(&plic_handlers);
>> > +	if (handler->present && !plic_cpuhp_setup_done) {
>> 
>> If there is no context handler for the boot CPU, the system is doomed, 
>> right? It
>> isn't able to get any interrupt, and you don't register the hotplug 
>> notifier that
>> could allow secondary CPUs to boot.
>> 
>> So what is the point? It feels like you should just give up here.
>> 
>> Also, the boot CPU is always CPU 0. So checking that you only register 
>> the
>> hotplug notifier from CPU 0 should be enough.
> 
> The boot CPU is not fixed in RISC-V, the logical id of the boot CPU 
> will always
> be zero but physical id (or HART id) can be something totally 
> different.

So on riscv, smp_processor_id() can return a non-zero value on the
the boot CPU? Interesting... :-/

> 
> On RISC-V NUMA system, we will have a separate PLIC in each NUMA node.
> 
> Let's say we have a system with 2 NUMA nodes, each NUMA node having
> 4 CPUs (or 4 HARTs).  In this case, the DTB passed to Linux will have 
> two PLIC
> DT nodes where each PLIC device targets only 4 CPUs (or 4 HARTs). The
> plic_init() functions will setup handlers for only 4 CPUs (or 4 HARTs). 
> In other
> words, plic_init() for "PLIC0" will setup handler for HART id 0 to 3 
> and
> plic_init() for "PLIC1" will setup handler for HART id 4 to 7. Now, any 
> CPU
> can be boot CPU so it is possible that CPU with HART id 4 is boot CPU 
> and
> when plic_init() is first called for "PLIC0" the handler for HART id 4 
> is not
> setup because it will be setup later when plic_init() is called for 
> "PLIC1".
> This cause plic_starting_cpu() to crash when plic_init() is called for 
> "PLIC0".
> 
> I hope above example helps understanding the issue.

It does, thanks. This pseudo NUMA thing really is a terrible hack...

> 
> I encounter this issue randomly when booting Linux on QEMU RISC-V
> with multiple NUMA nodes.

Then why don't you defer the probing of the PLIC you can't initialize
from this CPU? If you're on CPU4-7, only initialize the PLIC that
matters to you, and not the the others. It would certainly make a lot
more sense, and be more robust.

         M.
-- 
Jazz is not dead. It just smells funny...
