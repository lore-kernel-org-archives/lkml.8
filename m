Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B941DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D642070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:16:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgEOQQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:16:11 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id EE34CF91752B055297BB;
        Fri, 15 May 2020 17:16:08 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 15 May
 2020 17:16:07 +0100
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>,
        luojiaxing <luojiaxing@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200316115433.9017-1-maz@kernel.org>
 <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
 <80b673a7-1097-c5fa-82c0-1056baa5309d@huawei.com>
 <f2971d1c-50f8-bf5a-8b16-8d84a631b0ba@huawei.com>
 <7c05b08b-2edc-7f97-0175-898e9772673e@huawei.com>
 <668f819c8747104814245cd6faebdd9a@kernel.org>
 <a22aaa72-4f5f-40d4-33e0-0aff8b65fdc2@huawei.com>
 <c37d8b15f09c6c933e39b81f39fcb827@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <17dd20ba-075d-33d1-e16a-417924b2956a@huawei.com>
Date:   Fri, 15 May 2020 17:15:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c37d8b15f09c6c933e39b81f39fcb827@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.1.24]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 16:37, Marc Zyngier wrote:

Hi Marc,

>>>
>>
>> It's not just userspace. Some drivers call irq_set_affinity{_hint}}()
>> also, with a non-overlapping affinity mask.
>>
>> We could just error these requests, but some drivers rely on this
>> behavior. Consider the uncore driver I mentioned above, which WARNs
>> when the affinity setting fails. So it tries to set the affinity with
>> the cpumask of the cluster associated with the device, but with D06's
>> ITS config, below, there may be no overlap.
> 
> Does this PMU use the ITS? That's a pretty odd setup.
> 

Yes, I think so. Our old friend, mbigen...

> So this is a case where the device has an implicit affinity that
> isn't that of the ITS. Huhu...
> 
>>>
>>> What you are advocating for is a strict adherence to the provided
>>> mask, and it doesn't seem to be what other architectures are providing.
>>> I consider the userspace-provided affinity as a hint more that anything
>>> else, as in this case the kernel does know better (routing the interrupt
>>> to a foreign node might be costly, or even impossible, see the TX1
>>> erratum).
>>
>> Right
>>
>>>
>>>   From what I remember of the earlier discussion, you saw an issue on
>>> a system with two sockets and a single ITS, with the node mask limited
>>> to the first socket. Is that correct?
>>
>> A bit more complicated: 2 sockets, 2 NUMA nodes per socket, and ITS
>> config as follows:
>> D06ES  1x ITS with proximity node #0
>>
>> root@(none)$ dmesg | grep ITS
>> [ 0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>>
>>
>> D06CS
>> 2x ITS with proximity node #0, #2
>>
>> estuary:/$ dmesg | grep ITS
>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>> [    0.000000] SRAT: PXM 2 -> ITS 1 -> Node 2
>>
>> It complicates things.
>>
>> We could add extra intelligence to record if an node has an ITS
>> associated. In the case of that not being true, we would fallback on
>> the requested affin only (for case of no overlap). It gets a bit more
>> messy then.
> 
> It looks like part of the problem is that we can't reliably describe
> an ITS affine to multiple NUMA nodes... If we could describe that, then
> the above situation wouldn't occur (we'd say that ITS-0 covers both
> nodes 0 and 1). But I can't find a way to express this with SRAT and
> _PXM. Also, SRAT describes the affinity of the ITS with memory, and not
> with the CPUs... It is all a bit fsck'd. :-(

Yeah.

We could try to deal with those excluded CPUs, not within an ITS node 
cpumask, by trying to find the "closest" ITS, and expanding the cpumask 
of that ITS to cover those. Not sure if it's worth it.

But this sort of problem has always cropped up, with no clear way to 
describe our topology exactly.

> 
> I guess I'll apply your change for now with a comment explaining the
> situation.
> 

Cheers,
John
