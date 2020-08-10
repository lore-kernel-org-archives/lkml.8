Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982522065D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHJD2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:28:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgHJD2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:28:34 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6375DE9F691D67B7F72E;
        Mon, 10 Aug 2020 11:28:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 10 Aug 2020
 11:28:24 +0800
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
To:     Dave Young <dyoung@redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
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
Message-ID: <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
Date:   Mon, 10 Aug 2020 11:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/8 18:02, Dave Young wrote:
> On 08/01/20 at 09:08pm, Chen Zhou wrote:
>> Now the behavior of crashkernel=X has been changed, which tries low
>> allocation in ZONE_DMA, and fall back to high allocation if it fails.
>>
>> If requized size X is too large and leads to very little free memory
>> in ZONE_DMA after low allocation, the system may not work well.
>> So add a threshold and go for high allocation directly if the required
>> size is too large. The threshold is set as the half of low memory.
>>
>> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
>> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
>> specified size low memory. For non-RPi4 platforms, change ZONE_DMA
>> memtioned above to ZONE_DMA32.
>>
>> So update the Documentation.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  Documentation/admin-guide/kdump/kdump.rst     | 21 ++++++++++++++++---
>>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
>>  2 files changed, 27 insertions(+), 5 deletions(-)
>>
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
>> +   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>> +   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from
>> +   specified start address X. Note that the start address of the kernel,
>> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>>  
>>  Load the Dump-capture Kernel
>>  ============================
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index fb95fad81c79..d1b6016850d6 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -722,6 +722,10 @@
>>  			[KNL, x86_64] select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>> +			[KNL, arm64] Try low allocation in ZONE_DMA, fall back
>> +			to high allocation if it fails when '@offset' hasn't been
>> +			specified. For non-RPi4 platforms, change ZONE_DMA to
>> +			ZONE_DMA32.
>>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>>  
>>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>> @@ -746,13 +750,16 @@
>>  			requires at least 64M+32K low memory, also enough extra
>>  			low memory is needed to make sure DMA buffers for 32-bit
>>  			devices won't run out. Kernel would try to allocate at
>> -			at least 256M below 4G automatically.
>> +			least 256M below 4G automatically.
>>  			This one let user to specify own low range under 4G
>>  			for second kernel instead.
>>  			0: to disable low allocation.
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>> -
>> +			[KNL, arm64] range under 4G.
>> +			This one let user to specify a low range in ZONE_DMA for
>> +			crash dump kernel. For non-RPi4 platforms, change ZONE_DMA
>> +			to ZONE_DMA32.
>>  	cryptomgr.notests
>>  			[KNL] Disable crypto self-tests
>>  
>> -- 
>> 2.20.1
>>
> Hi Chen,
>
> Previously I remember we talked about to use similar logic as X86, but I
> remember you mentioned on some arm64 platform there could be no low
> memory at all.  Is this not a problem now for the fallback?  Just be
> curious, thanks for the update, for the common part looks good.
Hi Dave,

Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
This is about the different implementation instead of no low memory in arm64.

On arm64 platform, if there is no low memory, system will boot fail.

Thanks,
Chen Zhou
>
> Acked-by: Dave Young <dyoung@redhat.com>
>
> Thanks
> Dave
>
>
> .
>

