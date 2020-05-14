Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D980F206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgENMGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:06:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbgENMGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:06:39 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EA559415B56C1C9A6CF1;
        Thu, 14 May 2020 13:06:37 +0100 (IST)
Received: from [127.0.0.1] (10.47.3.198) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 14 May
 2020 13:06:36 +0100
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Jason Cooper <jason@lakedaemon.net>,
        chenxiang <chenxiang66@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200316115433.9017-1-maz@kernel.org>
 <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
 <80b673a7-1097-c5fa-82c0-1056baa5309d@huawei.com>
 <f2971d1c-50f8-bf5a-8b16-8d84a631b0ba@huawei.com>
Message-ID: <7c05b08b-2edc-7f97-0175-898e9772673e@huawei.com>
Date:   Thu, 14 May 2020 13:05:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <f2971d1c-50f8-bf5a-8b16-8d84a631b0ba@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.3.198]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> +       its_inc_lpi_count(d, cpu);
> +
>          return IRQ_SET_MASK_OK_DONE;
>   }
> 
> Results look ok:
>      nvme.use_threaded_interrupts=1    =0*
> Before    950K IOPs            1000K IOPs
> After    1100K IOPs            1150K IOPs
> 
> * as mentioned before, this is quite unstable and causes lockups. JFYI, 
> there was an attempt to fix this:
> 
> https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/
> 

Hi Marc,

Just wondering if we can try to get this series over the line?

So I tested the patches on v5.7-rc5, and get similar performance 
improvement to above.

I did apply a couple of patches, below, to remedy the issues I 
experienced for my D06CS.

Thanks,
John


---->8


[PATCH 1/2] irqchip/gic-v3-its: Don't double account for target CPU
  assignment

In its_set_affinity(), when a managed irq is already assigned to a CPU,
we may needlessly reassign the irq to another CPU.

This is because when selecting the target CPU, being the least loaded 
CPU in the mask, we account of that irq still being assigned to a CPU;
thereby we may unfairly select another CPU.

Modify this behaviour to pre-decrement the current target CPU LPI count
when finding the least loaded CPU.

Alternatively we may be able to just bail out early when the current 
target CPU already falls within the requested mask.

---
  drivers/irqchip/irq-gic-v3-its.c | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index 73f5c12..2b18feb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1636,6 +1636,8 @@ static int its_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,
  	if (irqd_is_forwarded_to_vcpu(d))
  		return -EINVAL;

+	its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
+
  	if (!force)
  		cpu = its_select_cpu(d, mask_val);
  	else
@@ -1646,14 +1648,14 @@ static int its_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,

  	/* don't set the affinity when the target cpu is same as current one */
  	if (cpu != its_dev->event_map.col_map[id]) {
-		its_inc_lpi_count(d, cpu);
-		its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
  		target_col = &its_dev->its->collections[cpu];
  		its_send_movi(its_dev, target_col, id);
  		its_dev->event_map.col_map[id] = cpu;
  		irq_data_update_effective_affinity(d, cpumask_of(cpu));
  	}

+	its_inc_lpi_count(d, cpu);
+
  	return IRQ_SET_MASK_OK_DONE;
  }

---


[PATCH 2/2] irqchip/gic-v3-its: Handle no overlap of non-managed irq
  affinity mask

In selecting the target CPU for a non-managed interrupt, we may select a
target CPU outside the requested affinity mask.

This is because there may be no overlap of the ITS node mask and the
requested CPU affinity mask. The requested affinity mask may be coming 
from userspace or some drivers which try to set irq affinity, see [0].

In this case, just ignore the ITS node cpumask. This is a deviation from
what Thomas described. Having said that, I am not sure if the interrupt 
is ever bound to a node for us.

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/hisilicon/hisi_uncore_pmu.c#n417

---
  drivers/irqchip/irq-gic-v3-its.c | 4 ----
  1 file changed, 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index 2b18feb..12d5d4b4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1584,10 +1584,6 @@ static int its_select_cpu(struct irq_data *d,
  			cpumask_and(tmpmask, cpumask_of_node(node), aff_mask);
  			cpumask_and(tmpmask, tmpmask, cpu_online_mask);

-			/* If that doesn't work, try the nodemask itself */
-			if (cpumask_empty(tmpmask))
-				cpumask_and(tmpmask, cpumask_of_node(node), cpu_online_mask);
-
  			cpu = cpumask_pick_least_loaded(d, tmpmask);
  			if (cpu < nr_cpu_ids)
  				goto out;
