Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66921C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4820620707
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403772AbgFXLsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:48:19 -0400
Received: from foss.arm.com ([217.140.110.172]:38992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbgFXLsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:48:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE1AF31B;
        Wed, 24 Jun 2020 04:48:17 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700393F6CF;
        Wed, 24 Jun 2020 04:48:16 -0700 (PDT)
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     tuanphan@os.amperecomputing.com, john.garry@huawei.com,
        linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com,
        harb@amperecomputing.com, linux-arm-kernel@lists.infradead.org
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
Message-ID: <b7d056f7-3a3d-568d-ea6d-24bb30b4761b@arm.com>
Date:   Wed, 24 Jun 2020 12:48:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark,

On 2020-04-08 17:49, Robin Murphy wrote:
> IRQF_SHARED is dangerous, since it allows other agents to retarget the
> IRQ's affinity without migrating PMU contexts to match, breaking the way
> in which perf manages mutual exclusion for accessing events. Although
> this means it's not realistically possible to support PMU IRQs being
> shared with other drivers, we *can* handle sharing between multiple PMU
> instances with some explicit affinity bookkeeping and manual interrupt
> multiplexing.
> 
> RCU helps us handle interrupts efficiently without having to worry about
> fine-grained locking for relatively-theoretical race conditions with the
> probe/remove/CPU hotplug slow paths. The resulting machinery ends up
> looking largely generic, so it should be feasible to factor out with a
> "system PMU" base class for similar multi-instance drivers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> RFC because I don't have the means to test it, and if the general
> approach passes muster then I'd want to tackle the aforementioned
> factoring-out before merging anything anyway.

Any comments on whether it's worth pursuing this?

Robin.

>   drivers/perf/arm_smmuv3_pmu.c | 215 ++++++++++++++++++++++++----------
>   1 file changed, 152 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> index d704eccc548f..8daa7ac6e801 100644
> --- a/drivers/perf/arm_smmuv3_pmu.c
> +++ b/drivers/perf/arm_smmuv3_pmu.c
> @@ -47,8 +47,11 @@
>   #include <linux/kernel.h>
>   #include <linux/list.h>
>   #include <linux/msi.h>
> +#include <linux/mutex.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
> +#include <linux/rculist.h>
> +#include <linux/refcount.h>
>   #include <linux/smp.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
> @@ -98,13 +101,24 @@
>   
>   static int cpuhp_state_num;
>   
> -struct smmu_pmu {
> +static LIST_HEAD(smmu_pmu_affinities);
> +static DEFINE_MUTEX(smmu_pmu_affinity_lock);
> +
> +struct smmu_pmu_affinity {
>   	struct hlist_node node;
> +	struct list_head affinity_list;
> +	struct list_head instance_list;
> +	refcount_t refcount;
> +	unsigned int irq;
> +	unsigned int cpu;
> +};
> +
> +struct smmu_pmu {
>   	struct perf_event *events[SMMU_PMCG_MAX_COUNTERS];
>   	DECLARE_BITMAP(used_counters, SMMU_PMCG_MAX_COUNTERS);
>   	DECLARE_BITMAP(supported_events, SMMU_PMCG_ARCH_MAX_EVENTS);
> -	unsigned int irq;
> -	unsigned int on_cpu;
> +	struct smmu_pmu_affinity *affinity;
> +	struct list_head affinity_list;
>   	struct pmu pmu;
>   	unsigned int num_counters;
>   	struct device *dev;
> @@ -394,7 +408,7 @@ static int smmu_pmu_event_init(struct perf_event *event)
>   	 * Ensure all events are on the same cpu so all events are in the
>   	 * same cpu context, to avoid races on pmu_enable etc.
>   	 */
> -	event->cpu = smmu_pmu->on_cpu;
> +	event->cpu = smmu_pmu->affinity->cpu;
>   
>   	return 0;
>   }
> @@ -478,9 +492,10 @@ static ssize_t smmu_pmu_cpumask_show(struct device *dev,
>   				     struct device_attribute *attr,
>   				     char *buf)
>   {
> -	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct smmu_pmu_affinity *aff = to_smmu_pmu(pmu)->affinity;
>   
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(smmu_pmu->on_cpu));
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(aff->cpu));
>   }
>   
>   static struct device_attribute smmu_pmu_cpumask_attr =
> @@ -584,50 +599,140 @@ static const struct attribute_group *smmu_pmu_attr_grps[] = {
>   
>   static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>   {
> -	struct smmu_pmu *smmu_pmu;
> +	struct smmu_pmu_affinity *aff;
> +	struct smmu_pmu *pmu;
>   	unsigned int target;
>   
> -	smmu_pmu = hlist_entry_safe(node, struct smmu_pmu, node);
> -	if (cpu != smmu_pmu->on_cpu)
> +	aff = hlist_entry_safe(node, struct smmu_pmu_affinity, node);
> +	if (cpu != aff->cpu)
>   		return 0;
>   
>   	target = cpumask_any_but(cpu_online_mask, cpu);
>   	if (target >= nr_cpu_ids)
>   		return 0;
>   
> -	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> -	smmu_pmu->on_cpu = target;
> -	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq, cpumask_of(target)));
> +	/* We're only reading, but this isn't the place to be involving RCU */
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	list_for_each_entry(pmu, &aff->instance_list, affinity_list)
> +		perf_pmu_migrate_context(&pmu->pmu, aff->cpu, target);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	WARN_ON(irq_set_affinity_hint(aff->irq, cpumask_of(target)));
> +	aff->cpu = target;
>   
>   	return 0;
>   }
>   
>   static irqreturn_t smmu_pmu_handle_irq(int irq_num, void *data)
>   {
> -	struct smmu_pmu *smmu_pmu = data;
> -	u64 ovsr;
> -	unsigned int idx;
> +	struct smmu_pmu_affinity *aff = data;
> +	struct smmu_pmu *smmu_pmu;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(smmu_pmu, &aff->instance_list, affinity_list) {
> +		unsigned int idx;
> +		u64 ovsr = readq(smmu_pmu->reloc_base + SMMU_PMCG_OVSSET0);
>   
> -	ovsr = readq(smmu_pmu->reloc_base + SMMU_PMCG_OVSSET0);
> -	if (!ovsr)
> -		return IRQ_NONE;
> +		if (!ovsr)
> +			continue;
>   
> -	writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
> +		writeq(ovsr, smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
>   
> -	for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) {
> -		struct perf_event *event = smmu_pmu->events[idx];
> -		struct hw_perf_event *hwc;
> +		for_each_set_bit(idx, (unsigned long *)&ovsr, smmu_pmu->num_counters) {
> +			struct perf_event *event = smmu_pmu->events[idx];
>   
> -		if (WARN_ON_ONCE(!event))
> -			continue;
> +			if (WARN_ON_ONCE(!event))
> +				continue;
> +
> +			smmu_pmu_event_update(event);
> +			smmu_pmu_set_period(smmu_pmu, &event->hw);
> +		}
> +		ret = IRQ_HANDLED;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static struct smmu_pmu_affinity *__smmu_pmu_get_affinity(int irq)
> +{
> +	struct smmu_pmu_affinity *aff;
> +	int ret;
> +
> +	list_for_each_entry(aff, &smmu_pmu_affinities, affinity_list)
> +		if (aff->irq == irq && refcount_inc_not_zero(&aff->refcount))
> +			return aff;
> +
> +	aff = kzalloc(sizeof(*aff), GFP_KERNEL);
> +	if (!aff)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	aff->cpu = raw_smp_processor_id();
> +	refcount_set(&aff->refcount, 1);
> +
> +	ret = request_irq(irq, smmu_pmu_handle_irq,
> +			  IRQF_NOBALANCING | IRQF_NO_THREAD,
> +			  "smmuv3-pmu", aff);
> +	if (ret)
> +		goto out_free_aff;
> +
> +	ret = irq_set_affinity_hint(irq, cpumask_of(aff->cpu));
> +	if (ret)
> +		goto out_free_irq;
> +
> +	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &aff->node);
> +	if (ret)
> +		goto out_free_irq;
> +
> +	list_add(&aff->affinity_list, &smmu_pmu_affinities);
> +	return aff;
> +
> +out_free_irq:
> +	free_irq(irq, aff);
> +out_free_aff:
> +	kfree(aff);
> +	return ERR_PTR(ret);
> +}
> +
> +static int smmu_pmu_get_affinity(struct smmu_pmu *pmu, int irq)
> +{
> +	struct smmu_pmu_affinity *aff;
> +
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	aff = __smmu_pmu_get_affinity(irq);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	if (IS_ERR(aff))
> +		return PTR_ERR(aff);
> +
> +	pmu->affinity = aff;
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	list_add_rcu(&pmu->affinity_list, &aff->instance_list);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	return 0;
> +}
> +
> +static void smmu_pmu_put_affinity(struct smmu_pmu *pmu)
> +{
> +	struct smmu_pmu_affinity *aff = pmu->affinity;
>   
> -		smmu_pmu_event_update(event);
> -		hwc = &event->hw;
> +	mutex_lock(&smmu_pmu_affinity_lock);
> +	list_del_rcu(&pmu->affinity_list);
>   
> -		smmu_pmu_set_period(smmu_pmu, hwc);
> +	if (!refcount_dec_and_test(&aff->refcount)) {
> +		mutex_unlock(&smmu_pmu_affinity_lock);
> +		return;
>   	}
>   
> -	return IRQ_HANDLED;
> +	list_del(&aff->affinity_list);
> +	mutex_unlock(&smmu_pmu_affinity_lock);
> +
> +	free_irq(aff->irq, aff);
> +	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &aff->node);
> +	kfree(aff);
>   }
>   
>   static void smmu_pmu_free_msis(void *data)
> @@ -652,7 +757,7 @@ static void smmu_pmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>   		       pmu->reg_base + SMMU_PMCG_IRQ_CFG2);
>   }
>   
> -static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
> +static int smmu_pmu_setup_msi(struct smmu_pmu *pmu)
>   {
>   	struct msi_desc *desc;
>   	struct device *dev = pmu->dev;
> @@ -663,34 +768,34 @@ static void smmu_pmu_setup_msi(struct smmu_pmu *pmu)
>   
>   	/* MSI supported or not */
>   	if (!(readl(pmu->reg_base + SMMU_PMCG_CFGR) & SMMU_PMCG_CFGR_MSI))
> -		return;
> +		return 0;
>   
>   	ret = platform_msi_domain_alloc_irqs(dev, 1, smmu_pmu_write_msi_msg);
>   	if (ret) {
>   		dev_warn(dev, "failed to allocate MSIs\n");
> -		return;
> +		return ret;
>   	}
>   
>   	desc = first_msi_entry(dev);
>   	if (desc)
> -		pmu->irq = desc->irq;
> +		ret = desc->irq;
>   
>   	/* Add callback to free MSIs on teardown */
>   	devm_add_action(dev, smmu_pmu_free_msis, dev);
> +	return ret;
>   }
>   
>   static int smmu_pmu_setup_irq(struct smmu_pmu *pmu)
>   {
> -	unsigned long flags = IRQF_NOBALANCING | IRQF_SHARED | IRQF_NO_THREAD;
> -	int irq, ret = -ENXIO;
> +	int irq;
>   
> -	smmu_pmu_setup_msi(pmu);
> +	irq = smmu_pmu_setup_msi(pmu);
> +	if (irq <= 0)
> +		irq = platform_get_irq(to_platform_device(pmu->dev), 0);
> +	if (irq < 0)
> +		return irq;
>   
> -	irq = pmu->irq;
> -	if (irq)
> -		ret = devm_request_irq(pmu->dev, irq, smmu_pmu_handle_irq,
> -				       flags, "smmuv3-pmu", pmu);
> -	return ret;
> +	return smmu_pmu_get_affinity(pmu, irq);
>   }
>   
>   static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
> @@ -730,7 +835,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   	struct resource *res_0;
>   	u32 cfgr, reg_size;
>   	u64 ceid_64[2];
> -	int irq, err;
> +	int err;
>   	char *name;
>   	struct device *dev = &pdev->dev;
>   
> @@ -771,10 +876,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   		smmu_pmu->reloc_base = smmu_pmu->reg_base;
>   	}
>   
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq > 0)
> -		smmu_pmu->irq = irq;
> -
>   	ceid_64[0] = readq_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CEID0);
>   	ceid_64[1] = readq_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CEID1);
>   	bitmap_from_arr32(smmu_pmu->supported_events, (u32 *)ceid_64,
> @@ -789,12 +890,6 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   
>   	smmu_pmu_reset(smmu_pmu);
>   
> -	err = smmu_pmu_setup_irq(smmu_pmu);
> -	if (err) {
> -		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
> -		return err;
> -	}
> -
>   	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
>   			      (res_0->start) >> SMMU_PMCG_PA_SHIFT);
>   	if (!name) {
> @@ -804,16 +899,9 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   
>   	smmu_pmu_get_acpi_options(smmu_pmu);
>   
> -	/* Pick one CPU to be the preferred one to use */
> -	smmu_pmu->on_cpu = raw_smp_processor_id();
> -	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq,
> -				      cpumask_of(smmu_pmu->on_cpu)));
> -
> -	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> -					       &smmu_pmu->node);
> +	err = smmu_pmu_setup_irq(smmu_pmu);
>   	if (err) {
> -		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
> -			err, &res_0->start);
> +		dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0->start);
>   		return err;
>   	}
>   
> @@ -832,7 +920,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
>   	return 0;
>   
>   out_unregister:
> -	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +	smmu_pmu_put_affinity(smmu_pmu);
> +	synchronize_rcu();
>   	return err;
>   }
>   
> @@ -840,9 +929,9 @@ static int smmu_pmu_remove(struct platform_device *pdev)
>   {
>   	struct smmu_pmu *smmu_pmu = platform_get_drvdata(pdev);
>   
> +	smmu_pmu_put_affinity(smmu_pmu);
> +	/* perf will synchronise RCU before devres can free smmu_pmu */
>   	perf_pmu_unregister(&smmu_pmu->pmu);
> -	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> -
>   	return 0;
>   }
>   
> 
