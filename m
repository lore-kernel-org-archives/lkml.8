Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D2DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF11720738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHVJdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:33:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgHVJdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:33:51 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08303A10FBACB14A5A30
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 17:33:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.157) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 17:33:40 +0800
Subject: Re: [PATCH] genirq/proc: Show percpu irq affinity
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <fcb0ae13-95b0-37d3-c1f9-44727e0f2ce8@huawei.com>
 <874kp754s6.fsf@nanos.tec.linutronix.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <aa537126-4646-08e2-6bea-833f71b20ade@huawei.com>
Date:   Sat, 22 Aug 2020 17:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <874kp754s6.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/13 16:27, Thomas Gleixner wrote:
> Yunfeng Ye <yeyunfeng@huawei.com> writes:
> 
>> When the "affinity=" cmdline parameter is configured,
> 
> There is no such parameter.
> 
>> the interrupt affinity displayed in the proc directory does not match
>> with that of the the percu interrupt, and the percu interrupt uses
>> desc->percu_affinity.
> 
> And when the non-existing parameter is not on the command line then
> irq->affinity is showing the correct value magically?
> 
> Definitely not: It's unconditionally showing irq->affinity and that is
> pretty unlikely to match irq->percpu_affinity in any case.
> 
Sorry，it is "irqaffinity=" cmdline parameter. it will set irq_default_affinity
mask. if the interrupt is not the managed irq, the irq_desc will use
irq_default_affinity as default affinity.

For example, the cmdline "irqaffinity=0,1,126,127" on the 128 cores system：

[root@localhost ~]# cat /proc/irq/4/smp_affinity_list
0-1,126-127

The irq 4 is "arch_timer" interrupt, which is a percpu interrupt.

So is it necessary to show the percpu irq affinity correct?

thanks.

>> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
>> index 32c071d7bc03..b9d0fa87b4b4 100644
>> --- a/kernel/irq/proc.c
>> +++ b/kernel/irq/proc.c
>> @@ -52,6 +52,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
>>  	case AFFINITY:
>>  	case AFFINITY_LIST:
>>  		mask = desc->irq_common_data.affinity;
>> +		if (irqd_is_per_cpu(&desc->irq_data))
>> +			mask = desc->percpu_affinity;
> 
> This breaks all architecture which mark interrupts as per CPU without
> using the partition mechanism resulting in a NULL pointer dereference.
> 
Yes, it is a problem.

> Thanks,
> 
>         tglx
> 
> .
> 

