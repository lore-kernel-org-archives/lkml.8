Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F56C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEAA204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgG3IWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:22:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbgG3IWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:22:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 398DC6D23F6138F8A5E6;
        Thu, 30 Jul 2020 16:22:48 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 16:22:38 +0800
Subject: Re: [PATCH v10 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-5-chenzhou10@huawei.com> <20200727173014.GL13938@gaia>
 <dd40f6ee-d5bd-1798-e7d6-1fb8ae91dc8b@huawei.com>
 <20200729115851.GC5524@gaia>
 <217004f5-dd8e-d04c-038b-c88b132d5495@huawei.com>
 <20200729152028.GE5524@gaia>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <will@kernel.org>, <james.morse@arm.com>,
        <robh+dt@kernel.org>, <arnd@arndb.de>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <10e223dc-9314-920f-c208-65a31819d1b7@huawei.com>
Date:   Thu, 30 Jul 2020 16:22:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200729152028.GE5524@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,


On 2020/7/29 23:20, Catalin Marinas wrote:
> On Wed, Jul 29, 2020 at 10:14:32PM +0800, chenzhou wrote:
>> On 2020/7/29 19:58, Catalin Marinas wrote:
>>> On Wed, Jul 29, 2020 at 11:52:39AM +0800, chenzhou wrote:
>>>> How about like this:
>>>> 1. For ZONE_DMA issue, use Bhupesh's solution, keep the crashkernel=
>>>>    behaviour to ZONE_DMA allocations.
>>>> 2. For this patch series, make the reserve_crashkernel_low() to
>>>>    ZONE_DMA allocations.
>>> So you mean rebasing your series on top of Bhupesh's? I guess you can
>>> combine the two, I really don't care which way as long as we fix both
>>> issues and agree on the crashkernel= semantics. I think with some tweaks
>>> we can go with your series alone.
>>>
>>> IIUC from the x86 code (especially the part you #ifdef'ed out for
>>> arm64), if ",low" is not passed (so just standard crashkernel=X), it
>>> still allocates sufficient low memory for the swiotlb in ZONE_DMA. The
>>> rest can go in a high region. Why can't we do something similar on
>>> arm64? Of course, you can keep the ",low" argument for explicit
>>> allocation but I don't want to mandate it.
>> It is a good idea to combine the two.
>>
>> For parameter crashkernel=X, we do like this:
>> 1. allocate some low memory in ZONE_DMA(or ZONE_DMA32 if CONFIG_ZONE_DMA=n)
>> 2. allocate X size memory in a high region
>>
>> ",low" argument can be used to specify the low memory.
>>
>> Do i understand correctly?
> Yes, although we could follow the x86 approach:
>
> 1. Try low (ZONE_DMA for arm64) allocation, fallback to high allocation
>    if it fails.
>
> 2. If crash_base is outside ZONE_DMA, call reserve_crashkernel_low()
>    which either honours the ,low option or allocates some small amount
>    in ZONE_DMA.
>
> If at some point we have platforms failing step 2, we'll look at
> changing ZONE_DMA to the full 4GB on non-RPi4 platforms.
>
> It looks to me like x86 ignores the ,low option if the first step
> managed to get some low memory. Shall we do the same on arm64?
Yes, we could do like this.
>
>>> So with an implicit ZONE_DMA allocation similar to the x86 one, we
>>> probably don't need Bhupesh's series at all. In addition, we can limit
>>> crashkernel= to the first 4G with a fall-back to high like x86 (not sure
>>> if memblock_find_in_range() is guaranteed to search in ascending order).
>>> I don't think we need an explicit ",high" annotation.
>>>
>>> So with the above, just a crashkernel=1G gives you at least 256MB in
>>> ZONE_DMA followed by the rest anywhere, with a preference for
>>> ZONE_DMA32. This way we can also keep the reserve_crashkernel_low()
>>> mostly intact from x86 (less #ifdef's).
>> Yes. We can let crashkernel=X  try to reserve low memory and fall back to use high memory
>> if failing to find a low range.
> The only question is whether we need to preserve some more ZONE_DMA on
> the current system. If for example we pass a crashkernel=512M and some
> cma=, we may end up with very little free memory in ZONE_DMA. That's
> mostly an issue for RPi4 since other platforms would work with
> ZONE_DMA32. We could add a threshold and go for high allocation directly
> if the required size is too large.
Ok.  I will think about the threshold in the next version and make the value be 1/2 or 1/3 of the ZONE_DMA.
>
>> About the function reserve_crashkernel_low(), if we put it in arch/arm64, there is some common
>> code with x86_64. Some suggestions about this?
> If we can use this function almost intact, just move it in a common
> place. But if it gets sprinkled with #ifdef CONFIG_ARM64, I'd rather
> duplicate it. I'd still prefer to move it to a common place if possible.
>
> You can go a step further and also move the x86 reserve_crashkernel() to
> common code. I don't think there a significant difference between arm64
> and x86 here. You'd have to define arch-specific specific
> CRASH_ADDR_LOW_MAX etc.
I will take these into account and send the next version recently.
>
> Also patches moving code should not have any functional change. The
> CRASH_ALIGN change from 16M to 2M on x86 should be a separate patch as
> it needs to be acked by the x86 maintainers (IIRC, Ingo only acked the
> function move if there was no functional change; CRASH_ALIGN is used for
> the start address, not just alignment, on x86).
>
Thanks,
Chen Zhou

