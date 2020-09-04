Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BE320748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgIDGji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:39:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgIDGjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:39:37 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D6B3E21013686CF35EC2;
        Fri,  4 Sep 2020 14:39:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 14:39:23 +0800
Subject: Re: [PATCH v11 3/5] arm64: kdump: reimplement crashkernel=X
To:     Dave Young <dyoung@redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-4-chenzhou10@huawei.com> <20200902170910.GB16673@gaia>
 <f33a0ce6-552e-2f1a-e720-4f7124f15d1e@huawei.com>
 <20200904030424.GA11384@dhcp-128-65.nay.redhat.com>
 <20200904031014.GA11869@dhcp-128-65.nay.redhat.com>
 <f4e0a246-0ca5-474b-8f39-c8299851d2b8@huawei.com>
 <20200904041633.GB11869@dhcp-128-65.nay.redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bhe@redhat.com>, <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <886c91a3-6729-e534-4d9d-b807c5584892@huawei.com>
Date:   Fri, 4 Sep 2020 14:39:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200904041633.GB11869@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/4 12:16, Dave Young wrote:
> On 09/04/20 at 12:02pm, chenzhou wrote:
>>
>> On 2020/9/4 11:10, Dave Young wrote:
>>> On 09/04/20 at 11:04am, Dave Young wrote:
>>>> On 09/03/20 at 07:26pm, chenzhou wrote:
>>>>> Hi Catalin,
>>>>>
>>>>>
>>>>> On 2020/9/3 1:09, Catalin Marinas wrote:
>>>>>> On Sat, Aug 01, 2020 at 09:08:54PM +0800, Chen Zhou wrote:
>>>>>>> There are following issues in arm64 kdump:
>>>>>>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>>>>>>> will fail when there is no enough low memory.
>>>>>>> 2. If reserving crashkernel above 4G, in this case, crash dump
>>>>>>> kernel will boot failure because there is no low memory available
>>>>>>> for allocation.
>>>>>>> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
>>>>>>> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
>>>>>>> the devices in crash dump kernel need to use ZONE_DMA will alloc
>>>>>>> fail.
>>>>>>>
>>>>>>> To solve these issues, change the behavior of crashkernel=X.
>>>>>>> crashkernel=X tries low allocation in ZONE_DMA, and fall back to
>>>>>>> high allocation if it fails.
>>>>>>>
>>>>>>> If requized size X is too large and leads to very little free memory
>>>>>>> in ZONE_DMA after low allocation, the system may not work normally.
>>>>>>> So add a threshold and go for high allocation directly if the required
>>>>>>> size is too large. The value of threshold is set as the half of
>>>>>>> the low memory.
>>>>>>>
>>>>>>> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
>>>>>>> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
>>>>>>> specified size low memory.
>>>>>> Except for the threshold to keep zone ZONE_DMA memory,
>>>>>> reserve_crashkernel() looks very close to the x86 version. Shall we try
>>>>>> to make this generic as well? In the first instance, you could avoid the
>>>>>> threshold check if it takes an explicit ",high" option.
>>>>> Ok, i will try to do this.
>>>>>
>>>>> I look into the function reserve_crashkernel() of x86 and found the start address is
>>>>> CRASH_ALIGN in function memblock_find_in_range(), which is different with arm64.
>>>>>
>>>>> I don't figure out why is CRASH_ALIGN in x86, is there any specific reason?
>>>> Hmm, took another look at the option CONFIG_PHYSICAL_ALIGN
>>>> config PHYSICAL_ALIGN
>>>>         hex "Alignment value to which kernel should be aligned"
>>>>         default "0x200000"
>>>>         range 0x2000 0x1000000 if X86_32
>>>>         range 0x200000 0x1000000 if X86_64
>>>>
>>>> According to above, I think the 16M should come from the largest value
>>>> But the default value is 2M,  with smaller value reservation can have
>>>> more chance to succeed.
>>>>
>>>> It seems we still need arch specific CRASH_ALIGN, but the initial
>>>> version you added the #ifdef for different arches, can you move the
>>>> macro to arch specific headers?
>>> And just keep the x86 align value as is, I can try to change the x86
>>> value later to CONFIG_PHYSICAL_ALIGN, in this way this series can be
>>> cleaner.
>> Ok. I have no question about the value of macro CRASH_ALIGN,
>> instead the lower bound of memblock_find_in_range().
>>
>> For x86, in reserve_crashkernel()，restrict the lower bound of the range to CRASH_ALIGN,
>>     ...
>>     crash_base = memblock_find_in_range(CRASH_ALIGN,
>>                                                 CRASH_ADDR_LOW_MAX,
>>                                                 crash_size, CRASH_ALIGN);
>>     ...
>>    
>> in reserve_crashkernel_low()，with no this restriction.
>>     ...
>>     low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
>>     ...
>>
>> How about all making memblock_find_in_range() search from the start of memory?
>> If it is ok, i will do like this in the generic version.
> I feel starting with CRASH_ALIGN sounds better, can you just search from
> CRASH_ALIGN in generic version?
ok.
>
> Thanks
> Dave
>
>
> .
>


