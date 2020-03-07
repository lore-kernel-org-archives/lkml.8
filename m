Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FDC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4122070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGLGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 06:06:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgCGLGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:06:42 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1335413F9D459FCCC85D;
        Sat,  7 Mar 2020 19:06:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 7 Mar 2020
 19:06:29 +0800
Subject: Re: [PATCH v7 2/4] arm64: kdump: reserve crashkenel above 4G for
 crash dump kernel
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-3-chenzhou10@huawei.com>
 <CAJ2QiJ+SQ1orriXJWyhKDcDL9s4Vh5+HQHhWFOKPVmijGpMGvw@mail.gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, <dyoung@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, <xiexiuqi@huawei.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <horms@verge.net.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <0c00f14a-15ca-44db-7f82-00f15ddd3c88@huawei.com>
Date:   Sat, 7 Mar 2020 19:06:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ2QiJ+SQ1orriXJWyhKDcDL9s4Vh5+HQHhWFOKPVmijGpMGvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/5 18:13, Prabhakar Kushwaha wrote:
> On Mon, Dec 23, 2019 at 8:57 PM Chen Zhou <chenzhou10@huawei.com> wrote:
>>
>> Crashkernel=X tries to reserve memory for the crash dump kernel under
>> 4G. If crashkernel=X,low is specified simultaneously, reserve spcified
>> size low memory for crash kdump kernel devices firstly and then reserve
>> memory above 4G.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/arm64/kernel/setup.c |  8 +++++++-
>>  arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
>>  2 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 56f6645..04d1c87 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
>>                     kernel_data.end <= res->end)
>>                         request_resource(res, &kernel_data);
>>  #ifdef CONFIG_KEXEC_CORE
>> -               /* Userspace will find "Crash kernel" region in /proc/iomem. */
>> +               /*
>> +                * Userspace will find "Crash kernel" region in /proc/iomem.
>> +                * Note: the low region is renamed as Crash kernel (low).
>> +                */
>> +               if (crashk_low_res.end && crashk_low_res.start >= res->start &&
>> +                               crashk_low_res.end <= res->end)
>> +                       request_resource(res, &crashk_low_res);
>>                 if (crashk_res.end && crashk_res.start >= res->start &&
>>                     crashk_res.end <= res->end)
>>                         request_resource(res, &crashk_res);
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index b65dffd..0d7afd5 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -80,6 +80,7 @@ static void __init reserve_crashkernel(void)
>>  {
>>         unsigned long long crash_base, crash_size;
>>         int ret;
>> +       phys_addr_t crash_max = arm64_dma32_phys_limit;
>>
>>         ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>                                 &crash_size, &crash_base);
>> @@ -87,12 +88,38 @@ static void __init reserve_crashkernel(void)
>>         if (ret || !crash_size)
>>                 return;
>>
>> +       ret = reserve_crashkernel_low();
>> +       if (!ret && crashk_low_res.end) {
>> +               /*
>> +                * If crashkernel=X,low specified, there may be two regions,
>> +                * we need to make some changes as follows:
>> +                *
>> +                * 1. rename the low region as "Crash kernel (low)"
>> +                * In order to distinct from the high region and make no effect
>> +                * to the use of existing kexec-tools, rename the low region as
>> +                * "Crash kernel (low)".
>> +                *
>> +                * 2. change the upper bound for crash memory
>> +                * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
>> +                *
>> +                * 3. mark the low region as "nomap"
>> +                * The low region is intended to be used for crash dump kernel
>> +                * devices, just mark the low region as "nomap" simply.
>> +                */
>> +               const char *rename = "Crash kernel (low)";
>> +
>> +               crashk_low_res.name = rename;
>> +               crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
>> +               memblock_mark_nomap(crashk_low_res.start,
>> +                                   resource_size(&crashk_low_res));
>> +       }
>> +
>>         crash_size = PAGE_ALIGN(crash_size);
>>
>>         if (crash_base == 0) {
>>                 /* Current arm64 boot protocol requires 2MB alignment */
>> -               crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
>> -                               crash_size, SZ_2M);
>> +               crash_base = memblock_find_in_range(0, crash_max, crash_size,
>> +                               SZ_2M);
>>                 if (crash_base == 0) {
>>                         pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>                                 crash_size);
>> --
> 
> I tested this patch series on ARM64-ThunderX2 with no issue with
> bootargs crashkenel=X@Y crashkernel=250M,low
> 
> $ dmesg | grep crash
> [    0.000000] crashkernel reserved: 0x0000000b81200000 -
> 0x0000000c81200000 (4096 MB)
> [    0.000000] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
> root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro
> crashkernel=4G@0xb81200000 crashkernel=250M,low nowatchdog earlycon
> [   29.310209]     crashkernel=250M,low
> 
> $  kexec -p -i /boot/vmlinuz-`uname -r`
> --initrd=/boot/initrd.img-`uname -r` --reuse-cmdline
> $ echo 1 > /proc/sys/kernel/sysrq ; echo c > /proc/sysrq-trigger
> 
> But when i tried with crashkernel=4G crashkernel=250M,low as bootargs.
> Kernel is not able to allocate memory.
> [    0.000000] cannot allocate crashkernel (size:0x100000000)
> [    0.000000] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
> root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro crashkernel=4G
> crashkernel=250M,low nowatchdog
> [   29.332081]     crashkernel=250M,low
> 
> does crashkernel=X@Y mandatory to get allocated beyond 4G?
> am I missing something?

I can't reproduce the problem in my environment, can you test with other size,
such as "crashkernel=1G crashkernel=250M,low", see if there is the same issue.

Besides, crashkernel=X@Y isn't mandatory to get allocated beyond 4G,
can you show the whole file /proc/iomem.

Thanks,
Chen Zhou

> 
> --pk
> 
> .
> 

