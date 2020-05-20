Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5E7207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589970290;
	bh=GheeTGjiLe1IPOBp+w8GYrlAmjgEw0f7bU9jylZPl5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k8yraAg4ffDusSJgYTMOf5n8kIdkgg6kMj+rh034+uz9H1rHSe+E/0pQ1T4tfqUTt
	 wTKwB96N2tQPtXBis1+D5GTJosl9SrSU8IC1ivCWAgvB7XgFMrXEK6raPaBtSgoT24
	 yYjogktMh2FSCvbpO1Y1Hzp2O9/sUkUWkQ+RnppA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgETKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:24:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DEE207C4;
        Wed, 20 May 2020 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589970288;
        bh=GheeTGjiLe1IPOBp+w8GYrlAmjgEw0f7bU9jylZPl5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lkfh1JWV+lM6xWtB1S3oQkp5KEoCJ4sjMPQcGNDWULlg9Eatu8LoykJol9EFB2z/P
         FHHyivjSNKYu73etNcNUUORmFHhx9BITpQ3GksrsppuHaYbGF1k6nAVntit2NO+F2P
         L9Pho1QBB1OEyzl4jQbOOkwWQotNwjMhFybRjehA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jbLu1-00DtCe-Ub; Wed, 20 May 2020 11:24:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 May 2020 11:24:45 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com
Subject: Re: [PATCH 06/11] irqchip/gic-v3: Configure SGIs as standard
 interrupts
In-Reply-To: <CAFA6WYNfZKpQMTX8qP0eFHwyzJK4HK8z59G3OVLN8h0Uuc7P7w@mail.gmail.com>
References: <20200519161755.209565-1-maz@kernel.org>
 <20200519161755.209565-7-maz@kernel.org>
 <CAFA6WYNfZKpQMTX8qP0eFHwyzJK4HK8z59G3OVLN8h0Uuc7P7w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <93b0ddc83439f24d30db9ea77c831ae6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On 2020-05-20 10:52, Sumit Garg wrote:
> Hi Marc,
> 
> On Tue, 19 May 2020 at 21:48, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> Change the way we deal with GICv3 SGIs by turning them into proper
>> IRQs, and calling into the arch code to register the interrupt range
>> instead of a callback.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 91 
>> +++++++++++++++++++++---------------
>>  1 file changed, 53 insertions(+), 38 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>> b/drivers/irqchip/irq-gic-v3.c
>> index 23d7c87da407..d57289057b75 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -36,6 +36,9 @@
>>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996    (1ULL << 0)
>>  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539  (1ULL << 1)
>> 
>> +#define GIC_IRQ_TYPE_PARTITION (GIC_IRQ_TYPE_LPI + 1)
>> +#define GIC_IRQ_TYPE_SGI       (GIC_IRQ_TYPE_LPI + 2)
>> +
>>  struct redist_region {
>>         void __iomem            *redist_base;
>>         phys_addr_t             phys_base;
>> @@ -657,38 +660,14 @@ static asmlinkage void __exception_irq_entry 
>> gic_handle_irq(struct pt_regs *regs
>>         if ((irqnr >= 1020 && irqnr <= 1023))
>>                 return;
>> 
>> -       /* Treat anything but SGIs in a uniform way */
>> -       if (likely(irqnr > 15)) {
>> -               int err;
>> -
>> -               if (static_branch_likely(&supports_deactivate_key))
>> -                       gic_write_eoir(irqnr);
>> -               else
>> -                       isb();
>> -
>> -               err = handle_domain_irq(gic_data.domain, irqnr, regs);
>> -               if (err) {
>> -                       WARN_ONCE(true, "Unexpected interrupt 
>> received!\n");
>> -                       gic_deactivate_unhandled(irqnr);
>> -               }
>> -               return;
>> -       }
>> -       if (irqnr < 16) {
>> +       if (static_branch_likely(&supports_deactivate_key))
>>                 gic_write_eoir(irqnr);
>> -               if (static_branch_likely(&supports_deactivate_key))
>> -                       gic_write_dir(irqnr);
>> -#ifdef CONFIG_SMP
>> -               /*
>> -                * Unlike GICv2, we don't need an smp_rmb() here.
>> -                * The control dependency from gic_read_iar to
>> -                * the ISB in gic_write_eoir is enough to ensure
>> -                * that any shared data read by handle_IPI will
>> -                * be read after the ACK.
>> -                */
>> -               handle_IPI(irqnr, regs);
>> -#else
>> -               WARN_ONCE(true, "Unexpected SGI received!\n");
>> -#endif
>> +       else
>> +               isb();
>> +
>> +       if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
>> +               WARN_ONCE(true, "Unexpected interrupt received!\n");
>> +               gic_deactivate_unhandled(irqnr);
>>         }
>>  }
>> 
>> @@ -1136,11 +1115,11 @@ static void gic_send_sgi(u64 cluster_id, u16 
>> tlist, unsigned int irq)
>>         gic_write_sgi1r(val);
>>  }
>> 
>> -static void gic_raise_softirq(const struct cpumask *mask, unsigned 
>> int irq)
>> +static void gic_ipi_send_mask(struct irq_data *d, const struct 
>> cpumask *mask)
>>  {
>>         int cpu;
>> 
>> -       if (WARN_ON(irq >= 16))
>> +       if (WARN_ON(d->hwirq >= 16))
>>                 return;
>> 
>>         /*
>> @@ -1154,7 +1133,7 @@ static void gic_raise_softirq(const struct 
>> cpumask *mask, unsigned int irq)
>>                 u16 tlist;
>> 
>>                 tlist = gic_compute_target_list(&cpu, mask, 
>> cluster_id);
>> -               gic_send_sgi(cluster_id, tlist, irq);
>> +               gic_send_sgi(cluster_id, tlist, d->hwirq);
>>         }
>> 
>>         /* Force the above writes to ICC_SGI1R_EL1 to be executed */
>> @@ -1163,10 +1142,36 @@ static void gic_raise_softirq(const struct 
>> cpumask *mask, unsigned int irq)
>> 
>>  static void gic_smp_init(void)
>>  {
>> -       set_smp_cross_call(gic_raise_softirq);
>> +       struct irq_fwspec sgi_fwspec = {
>> +               .fwnode         = gic_data.fwnode,
>> +       };
>> +       int base_sgi;
>> +
>>         cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
>>                                   "irqchip/arm/gicv3:starting",
>>                                   gic_starting_cpu, NULL);
>> +
>> +       if (is_of_node(gic_data.fwnode)) {
>> +               /* DT */
>> +               sgi_fwspec.param_count = 3;
>> +               sgi_fwspec.param[0] = GIC_IRQ_TYPE_SGI;
>> +               sgi_fwspec.param[1] = 0;
>> +               sgi_fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
>> +       } else {
>> +               /* ACPI */
>> +               sgi_fwspec.param_count = 2;
>> +               sgi_fwspec.param[0] = 0;
>> +               sgi_fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
>> +       }
>> +
>> +       /* Register all 8 non-secure SGIs */
>> +       base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
>> +                                          NUMA_NO_NODE, &sgi_fwspec,
>> +                                          false, NULL);
>> +       if (WARN_ON(base_sgi <= 0))
>> +               return;
>> +
>> +       set_smp_ipi_range(base_sgi, 8);
>>  }
>> 
>>  static int gic_set_affinity(struct irq_data *d, const struct cpumask 
>> *mask_val,
>> @@ -1215,6 +1220,7 @@ static int gic_set_affinity(struct irq_data *d, 
>> const struct cpumask *mask_val,
>>  }
>>  #else
>>  #define gic_set_affinity       NULL
>> +#define gic_ipi_send_mask      NULL
>>  #define gic_smp_init()         do { } while(0)
>>  #endif
>> 
>> @@ -1257,6 +1263,7 @@ static struct irq_chip gic_chip = {
>>         .irq_set_irqchip_state  = gic_irq_set_irqchip_state,
>>         .irq_nmi_setup          = gic_irq_nmi_setup,
>>         .irq_nmi_teardown       = gic_irq_nmi_teardown,
>> +       .ipi_send_mask          = gic_ipi_send_mask,
>>         .flags                  = IRQCHIP_SET_TYPE_MASKED |
>>                                   IRQCHIP_SKIP_SET_WAKE |
>>                                   IRQCHIP_MASK_ON_SUSPEND,
> 
> It looks like you missed to update "struct irq_chip gic_eoimode1_chip"
> with similar change as follows:
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 2a09634..ceef63b 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1291,6 +1291,7 @@ static struct irq_chip gic_eoimode1_chip = {
>         .irq_set_vcpu_affinity  = gic_irq_set_vcpu_affinity,
>         .irq_nmi_setup          = gic_irq_nmi_setup,
>         .irq_nmi_teardown       = gic_irq_nmi_teardown,
> +       .ipi_send_mask          = gic_ipi_send_mask,
>         .flags                  = IRQCHIP_SET_TYPE_MASKED |
>                                   IRQCHIP_SKIP_SET_WAKE |
>                                   IRQCHIP_MASK_ON_SUSPEND,
> 
> After incorporating this change, your patch-set works fine on my
> Developerbox machine.

Huh, well spotted. As I said, it has only been tested as guests,
hence not hitting this path. Time to throw it at the bigger stuff.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
