Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71CAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6621120786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgICPUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:20:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728513AbgICL1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:27:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4F8BB9C923A5A99C2CA7;
        Thu,  3 Sep 2020 19:26:39 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Sep 2020
 19:26:28 +0800
Subject: Re: [PATCH v11 3/5] arm64: kdump: reimplement crashkernel=X
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-4-chenzhou10@huawei.com> <20200902170910.GB16673@gaia>
CC:     <will@kernel.org>, <james.morse@arm.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dyoung@redhat.com>, <bhe@redhat.com>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <f33a0ce6-552e-2f1a-e720-4f7124f15d1e@huawei.com>
Date:   Thu, 3 Sep 2020 19:26:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200902170910.GB16673@gaia>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,


On 2020/9/3 1:09, Catalin Marinas wrote:
> On Sat, Aug 01, 2020 at 09:08:54PM +0800, Chen Zhou wrote:
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
>> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
>> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
>> the devices in crash dump kernel need to use ZONE_DMA will alloc
>> fail.
>>
>> To solve these issues, change the behavior of crashkernel=X.
>> crashkernel=X tries low allocation in ZONE_DMA, and fall back to
>> high allocation if it fails.
>>
>> If requized size X is too large and leads to very little free memory
>> in ZONE_DMA after low allocation, the system may not work normally.
>> So add a threshold and go for high allocation directly if the required
>> size is too large. The value of threshold is set as the half of
>> the low memory.
>>
>> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
>> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
>> specified size low memory.
> Except for the threshold to keep zone ZONE_DMA memory,
> reserve_crashkernel() looks very close to the x86 version. Shall we try
> to make this generic as well? In the first instance, you could avoid the
> threshold check if it takes an explicit ",high" option.
Ok, i will try to do this.

I look into the function reserve_crashkernel() of x86 and found the start address is
CRASH_ALIGN in function memblock_find_in_range(), which is different with arm64.

I don't figure out why is CRASH_ALIGN in x86, is there any specific reason?

Thanks,
Chen Zhou


