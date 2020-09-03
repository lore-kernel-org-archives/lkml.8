Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17432C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF13920775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgICMEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:04:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbgICL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:56:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 491F1DC3B52B4ED5FE93;
        Thu,  3 Sep 2020 19:56:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Sep 2020
 19:56:10 +0800
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com> <20200902171341.GC16673@gaia>
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
Message-ID: <84bb1cbb-c19e-9006-07b5-044eac5ecd4f@huawei.com>
Date:   Thu, 3 Sep 2020 19:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200902171341.GC16673@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/3 1:13, Catalin Marinas wrote:
> On Sat, Aug 01, 2020 at 09:08:56PM +0800, Chen Zhou wrote:
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 2da65fef2a1c..4b58f97351d5 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -299,7 +299,15 @@ Boot into System Kernel
>>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>>  
>> -   On x86 and x86_64, use "crashkernel=64M@16M".
>> +   On x86 use "crashkernel=64M@16M".
>> +
>> +   On x86_64, use "crashkernel=X" to select a region under 4G first, and
>> +   fall back to reserve region above 4G.
>> +   We can also use "crashkernel=X,high" to select a region above 4G, which
>> +   also tries to allocate at least 256M below 4G automatically and
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from specified
>> +   start address X.
>>  
>>     On ppc64, use "crashkernel=128M@32M".
>>  
>> @@ -316,8 +324,15 @@ Boot into System Kernel
>>     kernel will automatically locate the crash kernel image within the
>>     first 512MB of RAM if X is not given.
>>  
>> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
>> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
>> +   On arm64, use "crashkernel=X" to try low allocation in ZONE_DMA, and
>> +   fall back to high allocation if it fails. And go for high allocation
>> +   directly if the required size is too large. If crash_base is outside
> I wouldn't mention crash_base in the admin guide. That's an
> implementation detail really and admins are not supposed to read the
> source code to make sense of the documentation. ZONE_DMA is also a
> kernel internal, so you'd need to define what it is for arm64. At least
> the DMA and DMA32 zones are printed during kernel boot.
Ok, i will fix this in next version.
>
>> +   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from
>> +   specified start address X. Note that the start address of the kernel,
>> +   X if explicitly specified, must be aligned to 2MiB (0x200000).


