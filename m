Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14616C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8CA2333C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFTDzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:55:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFTDzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:55:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1D6AD24E770376062A29;
        Sat, 20 Jun 2020 11:54:58 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.90) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 11:54:48 +0800
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document
 linux,low-memory-range for arm64 kdump
To:     James Morse <james.morse@arm.com>, Rob Herring <robh@kernel.org>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-6-chenzhou10@huawei.com>
 <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
 <a419602e-6a85-ca35-39de-b3c26d433199@huawei.com>
 <20200526211800.GA352001@bogus>
 <ff7c9f68-b578-3a1a-0815-e61c6f87bc4e@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        <John.p.donnelly@oracle.com>, <pkushwaha@marvell.com>,
        "Simon Horman" <horms@verge.net.au>,
        Hanjun Guo <guohanjun@huawei.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>,
        "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>,
        Bhupesh Sharma <bhsharma@redhat.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <5339140e-41ee-ab20-0a3b-fcf7da82796b@huawei.com>
Date:   Sat, 20 Jun 2020 11:54:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ff7c9f68-b578-3a1a-0815-e61c6f87bc4e@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Rob,


On 2020/5/30 0:11, James Morse wrote:
> Hi guys,
>
> On 26/05/2020 22:18, Rob Herring wrote:
>> On Fri, May 22, 2020 at 11:24:11AM +0800, chenzhou wrote:
>>> On 2020/5/21 21:29, Rob Herring wrote:
>>>> On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>>>>> Add documentation for DT property used by arm64 kdump:
>>>>> linux,low-memory-range.
>>>>> "linux,low-memory-range" is an another memory region used for crash
>>>>> dump kernel devices.
>>>>> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
>>>>> index 45e79172a646..bfe6fb6976e6 100644
>>>>> --- a/Documentation/devicetree/bindings/chosen.txt
>>>>> +++ b/Documentation/devicetree/bindings/chosen.txt
>>>>> +linux,low-memory-range
>>>>> +----------------------
>>>>> +This property (arm64 only) holds a base address and size, describing a
>>>>> +limited region below 4G. Similar to "linux,usable-memory-range", it is
>>>>> +an another memory range which may be considered available for use by the
>>>>> +kernel.
>>>> Why can't you just add a range to "linux,usable-memory-range"? It
>>>> shouldn't be hard to figure out which part is below 4G.
>>> The comments from James:
>>> Won't this break if your kdump kernel doesn't know what the extra parameters are?
>>> Or if it expects two ranges, but only gets one? These DT properties should be treated as
>>> ABI between kernel versions, we can't really change it like this.
>>>
>>> I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
>>> think the simplest thing to do is to add an 'linux,low-memory-range' that we
>>> memblock_add() after memblock_cap_memory_range() has been called.
>>> If its missing, or the new kernel doesn't know what its for, everything keeps working.
>>
>> I don't think there's a compatibility issue here though. The current 
>> kernel doesn't care if the property is longer than 1 base+size. It only 
>> checks if the size is less than 1 base+size.
> Aha! I missed that.
>
>
>> And yes, we can rely on 
>> that implementation detail. It's only an ABI if an existing user 
>> notices.
>>
>> Now, if the low memory is listed first, then an older kdump kernel 
>> would get a different memory range. If that's a problem, then define 
>> that low memory goes last. 
> This first entry would need to be the 'crashkernel' range where the kdump kernel is
> placed, otherwise an older kernel won't boot. The rest can be optional extras, as long as
> we are tolerant of it being missing...
How about like this:

1. The low memory region remained as "Crash kernel (low)".
2. Userspace will find "Crash kernel" and "Crash kernel (low)" region in /proc/iomem,
and add "Crash kernel (low)" as the last range of property "linux,usable-memory-range".

Thanks,
Chen Zhou
>
> I'll try and look at the rest of this series on Monday,
>
>
> Thanks,
>
> James
>
> .
>


