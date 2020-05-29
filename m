Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09095C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E597F21475
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgE2QLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:11:13 -0400
Received: from foss.arm.com ([217.140.110.172]:38950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2QLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:11:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56EAD55D;
        Fri, 29 May 2020 09:11:11 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB1183F718;
        Fri, 29 May 2020 09:11:08 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document
 linux,low-memory-range for arm64 kdump
To:     Rob Herring <robh@kernel.org>, chenzhou <chenzhou10@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        John.p.donnelly@oracle.com, pkushwaha@marvell.com,
        Simon Horman <horms@verge.net.au>,
        Hanjun Guo <guohanjun@huawei.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-6-chenzhou10@huawei.com>
 <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
 <a419602e-6a85-ca35-39de-b3c26d433199@huawei.com>
 <20200526211800.GA352001@bogus>
From:   James Morse <james.morse@arm.com>
Message-ID: <ff7c9f68-b578-3a1a-0815-e61c6f87bc4e@arm.com>
Date:   Fri, 29 May 2020 17:11:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200526211800.GA352001@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 26/05/2020 22:18, Rob Herring wrote:
> On Fri, May 22, 2020 at 11:24:11AM +0800, chenzhou wrote:
>> On 2020/5/21 21:29, Rob Herring wrote:
>>> On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>>>> Add documentation for DT property used by arm64 kdump:
>>>> linux,low-memory-range.
>>>> "linux,low-memory-range" is an another memory region used for crash
>>>> dump kernel devices.

>>>> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
>>>> index 45e79172a646..bfe6fb6976e6 100644
>>>> --- a/Documentation/devicetree/bindings/chosen.txt
>>>> +++ b/Documentation/devicetree/bindings/chosen.txt

>>>> +linux,low-memory-range
>>>> +----------------------
>>>> +This property (arm64 only) holds a base address and size, describing a
>>>> +limited region below 4G. Similar to "linux,usable-memory-range", it is
>>>> +an another memory range which may be considered available for use by the
>>>> +kernel.

>>> Why can't you just add a range to "linux,usable-memory-range"? It
>>> shouldn't be hard to figure out which part is below 4G.

>> The comments from James:
>> Won't this break if your kdump kernel doesn't know what the extra parameters are?
>> Or if it expects two ranges, but only gets one? These DT properties should be treated as
>> ABI between kernel versions, we can't really change it like this.
>>
>> I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
>> think the simplest thing to do is to add an 'linux,low-memory-range' that we
>> memblock_add() after memblock_cap_memory_range() has been called.
>> If its missing, or the new kernel doesn't know what its for, everything keeps working.
> 
> 
> I don't think there's a compatibility issue here though. The current 
> kernel doesn't care if the property is longer than 1 base+size. It only 
> checks if the size is less than 1 base+size.

Aha! I missed that.


> And yes, we can rely on 
> that implementation detail. It's only an ABI if an existing user 
> notices.
> 
> Now, if the low memory is listed first, then an older kdump kernel 
> would get a different memory range. If that's a problem, then define 
> that low memory goes last. 

This first entry would need to be the 'crashkernel' range where the kdump kernel is
placed, otherwise an older kernel won't boot. The rest can be optional extras, as long as
we are tolerant of it being missing...

I'll try and look at the rest of this series on Monday,


Thanks,

James
