Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B407C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F23E20776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgDALdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:33:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732150AbgDALdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:33:42 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BB3D35B8AFF02906AFFA;
        Wed,  1 Apr 2020 12:33:40 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.170) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 12:33:39 +0100
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
Message-ID: <f2971d1c-50f8-bf5a-8b16-8d84a631b0ba@huawei.com>
Date:   Wed, 1 Apr 2020 12:33:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <80b673a7-1097-c5fa-82c0-1056baa5309d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.170]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> But I would also like to report some other unexpected behaviour for 
> managed interrupts in this series - I'll reply directly to the specific 
> patch for that.
> 

So I made this change:

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index 9199fb53c75c..ebbfc8d44d35 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1539,6 +1539,8 @@ static int its_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,
         if (irqd_is_forwarded_to_vcpu(d))
                 return -EINVAL;

+       its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
+
         if (!force)
                 cpu = its_select_cpu(d, mask_val);
         else
@@ -1549,14 +1551,14 @@ static int its_set_affinity(struct irq_data *d, 
const struct cpumask *mask_val,

         /* don't set the affinity when the target cpu is same as 
current one */
         if (cpu != its_dev->event_map.col_map[id]) {
-               its_inc_lpi_count(d, cpu);
-               its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
                 target_col = &its_dev->its->collections[cpu];
                 its_send_movi(its_dev, target_col, id);
                 its_dev->event_map.col_map[id] = cpu;
                 irq_data_update_effective_affinity(d, cpumask_of(cpu));
         }

+       its_inc_lpi_count(d, cpu);
+
         return IRQ_SET_MASK_OK_DONE;
  }

Results look ok:
	nvme.use_threaded_interrupts=1	=0*
Before	950K IOPs			1000K IOPs
After	1100K IOPs			1150K IOPs

* as mentioned before, this is quite unstable and causes lockups. JFYI, 
there was an attempt to fix this:

https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/

Thanks,
John

