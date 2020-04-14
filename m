Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B81D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407029AbgDNIKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:10:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406964AbgDNIJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:09:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0FED587026F4E7C56769;
        Tue, 14 Apr 2020 16:09:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 16:09:37 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Disallow setting affinity for virtual
 SGIs
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Nianyao Tang <tangnianyao@huawei.com>
References: <20200411091032.661-1-yuzenghui@huawei.com>
 <86pnces6kn.wl-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <e0c86d66-e8d4-99ba-917f-c6ba75181e03@huawei.com>
Date:   Tue, 14 Apr 2020 16:09:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <86pnces6kn.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/4/11 17:41, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On Sat, 11 Apr 2020 10:10:32 +0100,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> Running a guest on the GICv4.1-implemented board, we will get the
>> following warning:
>>
>> [   59.062120] genirq: irq_chip GICv4.1-sgi did not update eff. affinity mask of irq 46
>>
>> It may be caused by irqbalance (or other userspace tools) which tries to
>> change the affinity of virtual SGIs on the host. One way to "fix" it is
>> to update the effective_affinity value in irq_set_affinity callback. But
>> as the comment above says, "There is no notion of affinity for virtual
>> SGIs, at least not on the host", doing so only makes things confusing.
>>
>> Given the vSGIs are private to the specified vPE, changing the affinity
>> on host is actually meaningless and achieves nothing. Let's just forbid
>> it.
>>
>> Reported-by: Nianyao Tang <tangnianyao@huawei.com>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> Hi Marc,
>>
>> This just restores the behavior of your v5 [*]. I wonder that what's the
>> reason to change it to 'return IRQ_SET_MASK_OK' in v6? What I've missed
>> here?
>>
>> [*] https://lore.kernel.org/kvm/20200304203330.4967-9-maz@kernel.org/
> 
> Not allowing the affinity move results in the kernel screaming when
> playing with CPU hotplug (it really wants to move the interrupt
> around). Which is why I dropped the -EINVAL, therefore introducing
> another bug. I fixed it with this patch[1], which I was planning to
> post after -rc1.

I didn't realize the CPU hotplug case. Please take your approach to
fix it. (As mentioned, this was also one way I planned to fix it.)

> 
> Let me know what you think

TBH, I'm not very familiar with the IRQ core behavior on CPU hotplug.
I will read further and comment on your formal patch (please cc me),
but now spinning on some other things...


Thanks,
Zenghui

