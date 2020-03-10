Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B32FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5324684
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:33:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2541 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbgCJLdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:33:20 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E8C052F534DAE641E791;
        Tue, 10 Mar 2020 11:33:18 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 11:33:18 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 11:33:18 +0000
Subject: Re: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across
 CPUs
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "Ming Lei" <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20200119190554.1002-1-maz@kernel.org>
 <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com>
 <afb60c5f9a176470449a83126db326a9@kernel.org>
 <83eb55b0-2f2d-3335-85cf-6d7ed379b3c7@huawei.com>
 <7dc37b35d8ec6c78e75969d8c6c2d2e9@kernel.org>
 <87h80q2aoc.fsf@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e65af3fd-e7c8-bd9b-75ff-f2d990338221@huawei.com>
Date:   Tue, 10 Mar 2020 11:33:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87h80q2aoc.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2020 19:24, Thomas Gleixner wrote:
> Marc,
> 
> Marc Zyngier <maz@kernel.org> writes:
>> We're stuck between a rock and a hard place here:
>>
>> (1) We place all interrupts on the least loaded CPU that matches
>>       the affinity -> results in performance issues on some funky
>>       HW (like D05's SAS controller).
>>
>> (2) We place managed interrupts on the least loaded CPU that matches
>>       the affinity -> we have artificial load on NUMA boundaries, and
>>       reduced spread of overlapping managed interrupts.
>>
>> (3) We don't account for non-managed LPIs, and we run the risk of
>>       unpredictable performance because we don't really know where
>>       the *other* interrupts are.
>>
>> My personal preference would be to go for (1), as in my original post.
>> I find (3) the least appealing, because we don't track things anymore.
>> (2) feels like "the least of all evils", as it is a decent performance
>> gain, seems to give predictable performance, and doesn't regress lesser
>> systems...
>>
>> I'm definitely open to suggestions here.
> 
> The way x86 does it and that's mostly ok except for some really broken
> setups is:
> 
> 1) Non-managed interrupts:
> 
>     If the interrupt is bound to a node, then we try to find a target
> 
>       I)  in the intersection of affinity mask and node mask.
> 
>       II) in the nodemask itself
> 
>           Yes we ignore affinity mask there because that's pretty much
>           the same as if the given affinity does not contain an online
>           CPU.
> 
>       If all of that fails then we try the nodeless mode
> 
>     If the interrupt is not bound to a node, then we try to find a target
> 
>       I)  in the intersection of affinity mask and online mask.
> 
>       II) in the onlinemask itself
> 
>    Each step searches for the CPU in the searched mask which has the
>    least number of total interrupts assigned.
> 
> 2) Managed interrupts
> 
>    For managed interrupts we just search in the intersection of assigned
>    mask and online CPUs for the CPU with the least number of managed
>    interrupts.
> 
>    If no CPU is online then the interrupt is shutdown anyway, so no
>    fallback required.
> 
> Don't know whether that's something you can map to ARM64, but I assume
> the principle of trying to enforce NUMA locality plus balancing the
> number of interrupts makes sense in general.
> 

Hi Marc,

I was wondering if there is anything we can do to progress this patch?

Apart from being a good change in itself, I need to do some SMMU testing 
for nextgen product development and I would like to include this patch, 
most preferably from mainline.

Cheers,
John
