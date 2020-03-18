Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD2C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7120780
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCRTAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:00:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbgCRTAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:00:44 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2DBE48E3E47C5998BBDF;
        Wed, 18 Mar 2020 19:00:42 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Mar 2020 19:00:41 +0000
Received: from [127.0.0.1] (10.210.167.248) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 18 Mar
 2020 19:00:40 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>
CC:     Jason Cooper <jason@lakedaemon.net>,
        luojiaxing <luojiaxing@huawei.com>,
        <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
 <d3a6435b-bc1f-e518-6461-2ebff72bbc59@huawei.com>
 <d74f9cb3df708335a56aec62963aa281@kernel.org>
 <894aabcc-9676-3945-7a62-70fb930fd8a5@huawei.com>
 <a24fad17d178209d35bbcb9f270c84ff@kernel.org>
Message-ID: <a5132a5f-efe8-4305-07dd-d120b51b1360@huawei.com>
Date:   Wed, 18 Mar 2020 19:00:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a24fad17d178209d35bbcb9f270c84ff@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.167.248]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

>> And for some reason fancied cpu62.
> 
> Hmmm. OK. I'm surprised that irqbalance dries to set a range of CPUs, 
> instead of
> a particular CPU though.

It does seem strange. But also quite consistent. I will check again on that.

>>>
>>> But it has the mask for CPUs that are best suited for this interrupt,
>>> right?
>>> If I understand the topology of your machine, it has an ITS per 64 CPUs,
>>> and
>>> this device is connected to the ITS that serves the second socket.
>>
>> No, this one (D06ES) has a single ITS:
>>
>> john@ubuntu:~/kernel-dev$ dmesg | grep ITS
>> [    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
>> [    0.000000] ITS [mem 0x202100000-0x20211ffff]
>> [    0.000000] ITS@0x0000000202100000: Using ITS number 0
>> [    0.000000] ITS@0x0000000202100000: allocated 8192 Devices
>> @23ea9f0000 (indirect, esz 8, psz 16K, shr 1)
>> [    0.000000] ITS@0x0000000202100000: allocated 2048 Virtual CPUs
>> @23ea9d8000 (indirect, esz 16, psz 4K, shr 1)
>> [    0.000000] ITS@0x0000000202100000: allocated 256 Interrupt
>> Collections @23ea9d3000 (flat, esz 16, psz 4K, shr 1)
>> [    0.000000] ITS: Using DirectLPI for VPE invalidation
>> [    0.000000] ITS: Enabling GICv4 support
>> [    0.044034] Platform MSI: ITS@0x202100000 domain created
>> [    0.044042] PCI/MSI: ITS@0x202100000 domain created
> 
> There's something I'm missing here. If there's a single ITS in the system,
> node affinity must cover the whole system, not half of it.
> 
>> D06CS has 2x ITS, as you may know :)
>>
>> And, FWIW, the device is on the 2nd socket, numa node #2.
> 
> You've lost me. Single ITS, but two sockets?

Yeah, right, so I think that a single ITS is used due to some HW bug in 
the ES chip, fixed in the CS chip.

And some more background on the D05, D06ES, D06CS topology:

Even though the system is 2x socket, we model as 4x NUMA nodes, i.e. 2x 
nodes per socket. This is because each node has an associated memory 
controller in the socket, i.e. 2x memory controllers per socket. As 
such, for this D06ES system, a NUMA node is 24 cores.

I will be the first to admit that it does make things more complicated. 
Even more especially (and arguably broken) when we need to assign a 
proximity domain to devices in either socket, considering they are 
equidistant from either memory controller/CPU cluster in that socket.

> 
>>
>> So the cpu mask of node #0 (where the ITS lives) is 0-23. So no
>> intersection with what userspace requested.
>>
>>>>     if (cpu < 0 || cpu >= nr_cpu_ids)
>>>>         return -EINVAL;
>>>>
>>>>     if (cpu != its_dev->event_map.col_map[id]) {
>>>>         its_inc_lpi_count(d, cpu);
>>>>         its_dec_lpi_count(d, its_dev->event_map.col_map[id]);
>>>>         target_col = &its_dev->its->collections[cpu];
>>>>         its_send_movi(its_dev, target_col, id);
>>>>         its_dev->event_map.col_map[id] = cpu;
>>>>         irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>>>     }
>>>>
>>>> So cpu may not be a member of mask_val. Hence the inconsistency of the
>>>> affinity list and effective affinity. We could just drop the AND of
>>>> the ITS node mask in its_select_cpu().
>>>
>>> That would be a departure from the algorithm Thomas proposed, which made
>>> a lot of sense in my opinion. What its_select_cpu() does in this case is
>>> probably the best that can be achieved from a latency perspective,
>>> as it keeps the interrupt local to the socket that generated it.
>>
>> We seem to be following what Thomas described for a non-managed
>> interrupt bound to a node. But is this interrupt bound to the node?
> 
> If the ITS advertizes affinity to a node (through SRAT, for example),
> we should use that. And that's what we have in this patch.

Right, but my system is incompatible. Reason being, SRAT says ITS is 
NUMA node #0 (I think choosing node #0 over #1 may be just arbitrary), 
and the cpu mask for NUMA node #0 is 0-23, as above. And I figure even 
for D06CS with 2x ITS, again, is incompatible for the same reason.

So your expectation for a single ITS system would be that the NUMA node 
cpu mask for the ITS would cover all cpus. Sadly, it doesn't here...

Much appreciated,
John
