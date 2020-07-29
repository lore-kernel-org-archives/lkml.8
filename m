Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88865C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A50A20829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgG2OOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:14:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbgG2OOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:14:45 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 53FFB2D61C162CC64CB8;
        Wed, 29 Jul 2020 22:14:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 22:14:33 +0800
Subject: Re: [PATCH v10 4/5] arm64: kdump: fix kdump broken with ZONE_DMA
 reintroduced
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-5-chenzhou10@huawei.com> <20200727173014.GL13938@gaia>
 <dd40f6ee-d5bd-1798-e7d6-1fb8ae91dc8b@huawei.com>
 <20200729115851.GC5524@gaia>
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
Message-ID: <217004f5-dd8e-d04c-038b-c88b132d5495@huawei.com>
Date:   Wed, 29 Jul 2020 22:14:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200729115851.GC5524@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 2020/7/29 19:58, Catalin Marinas wrote:
> Hi Chen,
>
> On Wed, Jul 29, 2020 at 11:52:39AM +0800, chenzhou wrote:
>> On 2020/7/28 1:30, Catalin Marinas wrote:
>>> Anyway, there are two series solving slightly different issues with
>>> kdump reservations:
>>>
>>> 1. This series which relaxes the crashkernel= allocation to go anywhere
>>>    in the accessible space while having a dedicated crashkernel=X,low
>>>    option for ZONE_DMA.
>>>
>>> 2. Bhupesh's series [1] forcing crashkernel=X allocations only from
>>>    ZONE_DMA.
>>>
>>> For RPi4 support, we limited ZONE_DMA allocations to the 1st GB.
>>> Existing crashkernel= uses may no longer work, depending on where the
>>> allocation falls. Option (2) above is a quick fix assuming that the
>>> crashkernel reservation is small enough. What's a typical crashkernel
>>> option here? That series is probably more prone to reservation failures.
>>>
>>> Option (1), i.e. this series, doesn't solve the problem raised by
>>> Bhupesh unless one uses the crashkernel=X,low argument. It can actually
>>> make it worse even for ZONE_DMA32 since the allocation can go above 4G
>>> (assuming that we change the ZONE_DMA configuration to only limit it to
>>> 1GB on RPi4).
>>>
>>> I'm more inclined to keep the crashkernel= behaviour to ZONE_DMA
>>> allocations. If this is too small for typical kdump, we can look into
>>> expanding ZONE_DMA to 4G on non-RPi4 hardware (we had patches on the
>>> list). In addition, if Chen thinks allocations above 4G are still needed
>>> or if RPi4 needs a sufficiently large crashkernel=, I'd rather have a
>>> ",high" option to explicitly require such access.
>> Thanks for your reply and exhaustive explanation.
>>
>> In our ARM servers, we need to to reserve a large chunk for kdump(512M
>> or 1G), there is no enough low memory. So we proposed this patch
>> series "support reserving crashkernel above 4G on arm64 kdump" In
>> April 2019.
> Trying to go through the discussions last year, hopefully things get
> clearer.
>
> So prior to the ZONE_DMA change, you still couldn't reserve 1G in the
> first 4GB? It shouldn't be sparsely populated during early boot.
Yes, we prior to the ZONE_DMA change, you still couldn't reserve 1G/512M in the first 4GB.
The memory reported by the bios may be splitted by some "reserved" entries.
Like this:
...
2f126000-2fbfffff : reserved
2fc00000-396affff : System RAM
  30de8000-30de9fff : reserved
  30dec000-30decfff : reserved
  30df2000-30df2fff : reserved
  30e20000-30e4ffff : reserved
  39620000-3968ffff : reserved
396b0000-3974ffff : reserved
39750000-397affff : System RAM
397b0000-398fffff : reserved
39900000-3990ffff : System RAM
  39900000-3990ffff : reserved
...
>
>> I introduce parameters "crashkernel=X,[high,low]" as x86_64 does in earlier versions.
>> Suggested by James, to simplify, we call reserve_crashkernel_low() at the beginning of
>> reserve_crashkernel() and then relax the arm64_dma32_phys_limit if reserve_crashkernel_low()
>> allocated something.
>> That is, just the parameter "crashkernel=X,low" is ok and i deleted "crashkernel=X,high".
> The problem I see is that with your patches we diverge from x86
> behaviour (and the arm64 behaviour prior to the ZONE_DMA reduction) as
> we now require that crashkernel=X,low is always passed if you want
> something in ZONE_DMA (and you do want, otherwise the crashdump kernel
> fails to boot).
>
> My main requirement is that crashkernel=X, without any suffix, still
> works which I don't think is guaranteed with your patches (well,
> ignoring RPi4 ZONE_DMA). Bhupesh's series is a quick fix but doesn't
> solve your large allocation requirements (that may have worked prior to
> the ZONE_DMA change).
The main purpose of this series is to solve the large allocation requirements.
Before the DMA_ZONE, both the original crashkernel=X and large allocation with my  patches
work well.

With the DMA_ZONE, both the original crashkernel=X and large allocation with my  patches
may fail to boot. Both need to think about the DMA_ZONE.

>
>> After the ZONE_DMA introduced in December 2019, the issue occurred as
>> you said above. In fact, we didn't have RPi4 machine.
> You don't even need to have a RPi4 machine, ZONE_DMA has been set to 1GB
> unconditionally. And while we could move it back to 4GB on non-RPi4
> hardware, I'd rather have a solution that fixes kdump for RPi4 as well.
>
>> Originally, i suggested to fix this based on this patch series and
>> used the dedicated option.
>>
>> According to your clarify, for typical kdump, there are other
>> solutions. In this case, "keep the crashkernel= behaviour to ZONE_DMA
>> allocations" looks much better.
>>
>> How about like this:
>> 1. For ZONE_DMA issue, use Bhupesh's solution, keep the crashkernel=
>>    behaviour to ZONE_DMA allocations.
>> 2. For this patch series, make the reserve_crashkernel_low() to
>>    ZONE_DMA allocations.
> So you mean rebasing your series on top of Bhupesh's? I guess you can
> combine the two, I really don't care which way as long as we fix both
> issues and agree on the crashkernel= semantics. I think with some tweaks
> we can go with your series alone.
>
> IIUC from the x86 code (especially the part you #ifdef'ed out for
> arm64), if ",low" is not passed (so just standard crashkernel=X), it
> still allocates sufficient low memory for the swiotlb in ZONE_DMA. The
> rest can go in a high region. Why can't we do something similar on
> arm64? Of course, you can keep the ",low" argument for explicit
> allocation but I don't want to mandate it.
It is a good idea to combine the two.

For parameter crashkernel=X, we do like this:
1. allocate some low memory in ZONE_DMA(or ZONE_DMA32 if CONFIG_ZONE_DMA=n)
2. allocate X size memory in a high region

",low" argument can be used to specify the low memory.

Do i understand correctly?
>
> So with an implicit ZONE_DMA allocation similar to the x86 one, we
> probably don't need Bhupesh's series at all. In addition, we can limit
> crashkernel= to the first 4G with a fall-back to high like x86 (not sure
> if memblock_find_in_range() is guaranteed to search in ascending order).
> I don't think we need an explicit ",high" annotation.
>
> So with the above, just a crashkernel=1G gives you at least 256MB in
> ZONE_DMA followed by the rest anywhere, with a preference for
> ZONE_DMA32. This way we can also keep the reserve_crashkernel_low()
> mostly intact from x86 (less #ifdef's).
>
> Do I miss anything?
Yes. We can let crashkernel=X  try to reserve low memory and fall back to use high memory
if failing to find a low range.

About the function reserve_crashkernel_low(), if we put it in arch/arm64, there is some common
code with x86_64. Some suggestions about this?

Thanks,
Chen Zhou
>


