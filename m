Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D005FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A045620714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g892IlMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgG0MkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:40:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgG0MkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:40:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RCbhws028798;
        Mon, 27 Jul 2020 12:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FfM4KKHfjBkfVK/lRybelXnsf46/KJO3h87IaW1y+nM=;
 b=g892IlMdJ8ghyUa9io6PGFi1bEl76KrtF8BhDG7PInZcNlvb+Bxo65p6pEB5JegLtYjp
 c5nJO3tvVj79m5lPhhLSezZP7IW7BWOs8Ud1l0tAVLwREk+1F3uXIaYkkl9HOnYkh7ku
 Pec6zTjpEwZepxNfsM9kAOd2zLqxi2pFu9imVrwLuKZihmEo3AMiUhP8hxkV86CYQIe6
 ZUuBM2WAAxSc+dQp+NYHtLf9Tz/XL1xNMaHAi1OnGtNZqDNQu3g38kupSw6hwkBFYdhX
 3m8rx9e0xdx7jUWECfl7jq2r+vgWpiKLhKpRnqa6NVrdwgAlYC4ESRWZ7dFHHst6Hsnm Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1j1898-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 12:39:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RCdJgf143866;
        Mon, 27 Jul 2020 12:39:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32hu5qkxg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 12:39:19 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RCcuxc031528;
        Mon, 27 Jul 2020 12:38:56 GMT
Received: from [192.168.1.126] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 05:38:55 -0700
Subject: Re: [PATCH v10 0/5] support reserving crashkernel above 4G on arm64
 kdump
To:     chenzhou <chenzhou10@huawei.com>,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        RuiRui Yang <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        nsaenzjulienne@suse.de, Jonathan Corbet <corbet@lwn.net>,
        Simon Horman <horms@verge.net.au>, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <CACi5LpP+kFLv97guJ126xKk4_mfy2nFMp36KnDiXxPZ1ya2jPg@mail.gmail.com>
 <989e3b4f-4827-bb0f-5c3d-d9669c081c88@huawei.com>
From:   John Donnelly <john.p.donnelly@oracle.com>
Message-ID: <17ea287c-4821-48c3-0443-a81ee3df996a@oracle.com>
Date:   Mon, 27 Jul 2020 07:38:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <989e3b4f-4827-bb0f-5c3d-d9669c081c88@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/20 3:38 AM, chenzhou wrote:
> Hi Bhupesh,
>
>
> On 2020/7/3 15:26, Bhupesh Sharma wrote:
>> Hi Chen,
>>
>> On Fri, Jul 3, 2020 at 9:24 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>
>>> There are following issues in arm64 kdump:
>>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
>>> when there is no enough low memory.
>>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
>>> in this case, if swiotlb or DMA buffers are required, crash dump kernel
>>> will boot failure because there is no low memory available for allocation.
>>> 3. commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32") broken
>>> the arm64 kdump. If the memory reserved for crash dump kernel falled in
>>> ZONE_DMA32, the devices in crash dump kernel need to use ZONE_DMA will alloc
>>> fail.
>>>
>>> To solve these issues, introduce crashkernel=X,low to reserve specified
>>> size low memory.
>>> Crashkernel=X tries to reserve memory for the crash dump kernel under
>>> 4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
>>> size low memory for crash kdump kernel devices firstly and then reserve
>>> memory above 4G.
>>>
>>> When crashkernel is reserved above 4G in memory and crashkernel=X,low
>>> is specified simultaneously, kernel should reserve specified size low memory
>>> for crash dump kernel devices. So there may be two crash kernel regions, one
>>> is below 4G, the other is above 4G.
>>> In order to distinct from the high region and make no effect to the use of
>>> kexec-tools, rename the low region as "Crash kernel (low)", and pass the
>>> low region by reusing DT property "linux,usable-memory-range". We made the low
>>> memory region as the last range of "linux,usable-memory-range" to keep
>>> compatibility with existing user-space and older kdump kernels.
>>>
>>> Besides, we need to modify kexec-tools:
>>> arm64: support more than one crash kernel regions(see [1])
>>>
>>> Another update is document about DT property 'linux,usable-memory-range':
>>> schemas: update 'linux,usable-memory-range' node schema(see [2])
>>>
>>> The previous changes and discussions can be retrieved from:
>>>
>>> Changes since [v9]
>>> - Patch 1 add Acked-by from Dave.
>>> - Update patch 5 according to Dave's comments.
>>> - Update chosen schema.
>>>
>>> Changes since [v8]
>>> - Reuse DT property "linux,usable-memory-range".
>>> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
>>> memory region.
>>> - Fix kdump broken with ZONE_DMA reintroduced.
>>> - Update chosen schema.
>>>
>>> Changes since [v7]
>>> - Move x86 CRASH_ALIGN to 2M
>>> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
>>> - Update Documentation/devicetree/bindings/chosen.txt.
>>> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
>>> suggested by Arnd.
>>> - Add Tested-by from Jhon and pk.
>>>
>>> Changes since [v6]
>>> - Fix build errors reported by kbuild test robot.
>>>
>>> Changes since [v5]
>>> - Move reserve_crashkernel_low() into kernel/crash_core.c.
>>> - Delete crashkernel=X,high.
>>> - Modify crashkernel=X,low.
>>> If crashkernel=X,low is specified simultaneously, reserve spcified size low
>>> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
>>> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
>>> pass to crash dump kernel by DT property "linux,low-memory-range".
>>> - Update Documentation/admin-guide/kdump/kdump.rst.
>>>
>>> Changes since [v4]
>>> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>>
>>> Changes since [v3]
>>> - Add memblock_cap_memory_ranges back for multiple ranges.
>>> - Fix some compiling warnings.
>>>
>>> Changes since [v2]
>>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>>> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
>>> patch.
>>>
>>> Changes since [v1]:
>>> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>>> in fdt_enforce_memory_region().
>>> There are at most two crash kernel regions, for two crash kernel regions
>>> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>>> and then remove the memory range in the middle.
>>>
>>> [1]: https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-June/020737.html__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su4V80IBu$
>>> [2]: https://urldefense.com/v3/__https://github.com/robherring/dt-schema/pull/19__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su3Exu3Pr$
>>> [v1]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/2/1174__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su_RTeG6n$
>>> [v2]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/86__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su3HI0hvE$
>>> [v3]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/9/306__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su-DmOkg5$
>>> [v4]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/4/15/273__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-SuykJijY2$
>>> [v5]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/5/6/1360__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su2YHe5UX$
>>> [v6]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/8/30/142__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su9HL5p7k$
>>> [v7]: https://urldefense.com/v3/__https://lkml.org/lkml/2019/12/23/411__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su_mHOJs0$
>>> [v8]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/5/21/213__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su7UYMTZJ$
>>> [v9]: https://urldefense.com/v3/__https://lkml.org/lkml/2020/6/28/73__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Suxcd0E6t$
>>>
>>> Chen Zhou (5):
>>>    x86: kdump: move reserve_crashkernel_low() into crash_core.c
>>>    arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>>>    arm64: kdump: add memory for devices by DT property
>>>      linux,usable-memory-range
>>>    arm64: kdump: fix kdump broken with ZONE_DMA reintroduced
>>>    kdump: update Documentation about crashkernel on arm64
>>>
>>>   Documentation/admin-guide/kdump/kdump.rst     | 14 ++-
>>>   .../admin-guide/kernel-parameters.txt         | 17 +++-
>>>   arch/arm64/kernel/setup.c                     |  8 +-
>>>   arch/arm64/mm/init.c                          | 74 ++++++++++++---
>>>   arch/x86/kernel/setup.c                       | 66 ++------------
>>>   include/linux/crash_core.h                    |  3 +
>>>   include/linux/kexec.h                         |  2 -
>>>   kernel/crash_core.c                           | 90 +++++++++++++++++++
>>>   kernel/kexec_core.c                           | 17 ----
>>>   9 files changed, 197 insertions(+), 94 deletions(-)
>>>
>>> --
>>> 2.20.1
>> Thanks for the v10.
>>
>> 1. Seems this series is still broken on arm64 boards like ampere and
>> ThunderX2 (marvell) because of the ZONE_DMA32 related OOM seen while
>> booting kdump kernel.
>> Here are details about my environment:
>>
>> - Latest upstream Linus master branch (5.8.0-rc3) + your v10 patches.
>> - Latest upstream kexec-tools + your v4 patch.
>>
>> # dmesg | grep -i crash
>> [    0.000000] crashkernel reserved: 0x00000000ca000000 -
>> 0x00000000ea000000 (512 MB)
>> [    0.000000] Kernel command line:
>> BOOT_IMAGE=(hd13,gpt2)/vmlinuz-5.8.0-rc3+
>> root=/dev/mapper/rhel_hpe--apache--cn99xx--09-root ro
>> rd.lvm.lv=rhel_hpe-apache-cn99xx-09/root
>> rd.lvm.lv=rhel_hpe-apache-cn99xx-09/swap crashkernel=512M
>> [   58.917523]     crashkernel=512M
>>
>> 2. Here is the OOM crash seen while booting the kdump kernel:
>>
>> [    0.244724] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
>> [    0.251859] Unable to handle kernel NULL pointer dereference at
>> virtual address 0000000000000188
>> [    0.260737] Mem abort info:
>> [    0.263553]   ESR = 0x96000006
>> [    0.266632]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [    0.271994]   SET = 0, FnV = 0
>> [    0.275074]   EA = 0, S1PTW = 0
>> [    0.278239] Data abort info:
>> [    0.281141]   ISV = 0, ISS = 0x00000006
>> [    0.285010]   CM = 0, WnR = 0
>> [    0.288001] [0000000000000188] user address but active_mm is swapper
>> [    0.294420] Internal error: Oops: 96000006 [#1] SMP
>> [    0.299344] Modules linked in:
>> [    0.302424] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3+ #8
>> [    0.308753] Hardware name: HPE Apollo 70             /C01_APACHE_MB
>>          , BIOS L50_5.13_1.11 06/18/2019
>> [    0.318599] pstate: 00400009 (nzcv daif +PAN -UAO BTYPE=--)
>> [    0.324228] pc : mem_cgroup_get_nr_swap_pages+0x2c/0x60
>> [    0.329506] lr : shrink_lruvec+0x404/0x4f8
>> [    0.333638] sp : fffffe0012b8f840
>> [    0.336979] x29: fffffe0012b8f840 x28: fffffe00116b3000
>> [    0.342343] x27: fffffe0012b8fb00 x26: 0000000000000020
>> [    0.347707] x25: 0000000000000000 x24: fffffc0069fffe28
>> [    0.353070] x23: 0000000000000000 x22: 0000000000000000
>> [    0.358433] x21: 000000000000003c x20: fffffe0012b8fa98
>> [    0.363796] x19: 0000000000000000 x18: 0000000000000010
>> [    0.369159] x17: 00000000bd8afee8 x16: 000000001260aa76
>> [    0.374523] x15: ffffffffffffffff x14: fffffe00116b3988
>> [    0.379886] x13: fffffe0092b8faa7 x12: fffffe0012b8faaf
>> [    0.385248] x11: fffffe00116f1000 x10: fffffe0012b8fa30
>> [    0.390612] x9 : fffffe0010244ebc x8 : 0000000000000000
>> [    0.395975] x7 : 0000000000000020 x6 : 00000000ffff8ae3
>> [    0.401338] x5 : 0000000000000000 x4 : fffffc004da89000
>> [    0.406701] x3 : 0000000000000000 x2 : 0000000000000000
>> [    0.412064] x1 : fffffe00116bf000 x0 : 0000000000000000
>> [    0.417427] Call trace:
>> [    0.419891]  mem_cgroup_get_nr_swap_pages+0x2c/0x60
>> [    0.424815]  shrink_node+0x1a8/0x688
>> [    0.428420]  do_try_to_free_pages+0xe8/0x448
>> [    0.432729]  try_to_free_pages+0x110/0x230
>> [    0.436863]  __alloc_pages_slowpath.constprop.106+0x2b8/0xb48
>> [    0.442666]  __alloc_pages_nodemask+0x2ac/0x2f8
>> [    0.447239]  alloc_page_interleave+0x20/0x90
>> [    0.451548]  alloc_pages_current+0xdc/0xf8
>> [    0.455681]  atomic_pool_expand+0x60/0x210
>> [    0.459817]  __dma_atomic_pool_init+0x50/0xa4
>> [    0.464214]  dma_atomic_pool_init+0xac/0x158
>> [    0.468522]  do_one_initcall+0x50/0x218
>> [    0.472393]  kernel_init_freeable+0x22c/0x2d0
>> [    0.476792]  kernel_init+0x18/0x110
>> [    0.480310]  ret_from_fork+0x10/0x18
>> [    0.483918] Code: 350001e3 d503201f f9450024 1400000a (f940c401)
>> [    0.490074] ---[ end trace e5a9147af159e580 ]---
>> [    0.494734] Kernel panic - not syncing: Fatal exception
>> [    0.500010] Rebooting in 10 seconds..
>>
>> 3. Did you test your patch with a simple crashkernel=512M command line
>> (without using the crashkernel hi/lo or crashkernel=X@Y format)?
>>
>> Anyway, since this implementation still needs rework, we can go ahead
>> with the arrangement of limiting the crashkernel allocation in
>> ZONE_DMA range (as I suggested in another patch series
>> <https://urldefense.com/v3/__http://lists.infradead.org/pipermail/kexec/2020-July/020777.html__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su56QERe_$ >) in
>> the meanwhile. to ensure the upstream kernel can still support kdump
>> on arm64 boards where it was working before the ZONE_DMA32 changes
>> were introduced for arm64.
>>
>> Please let me know your views,
> Thanks for your test and sharing your views. I have no questions about the 1 and 2 you mentioned.
>
> I charity the issue in my patch 4 and suggest to use the parameter like
> "crashkernel=X crashkernel=Y,low" if CONFIG_ZONE_DMA is enabled.
> I also document this in doc in patch 5.
>
> I choose to address the issue based on the  "reserving crashkernel above 4G",
> because we just need to adjust the low memory limit instead of limiting the
> whole crahshkernel to ZONE_DMA.
> details: https://urldefense.com/v3/__https://lkml.org/lkml/2020/7/3/64__;!!GqivPVa7Brio!LQeROomdhNOjTVFcQP6pLxDm9nhbEsY3vqZMI7NHeDU_VnCaN7iw2DJ84x-Su1vtGdek$
>
> But you are right, arm64 kdump is broken for long time, including the issue you addressed
> "Append new variables to vmcoreinfo (TCR_EL1.T1SZ for arm64 and MAX_PHYSMEM_BITS for all archs)".
>
> I agree with you to make it work as soon as possible.
>
> Ping James, Will,
> any other comments about this patch series?
>
> Thanks,
> Chen Zhou
>

Hi  James and Will,


   This patch set has been in review for over a year, since May of 2019. 
   What is holding up getting this accepted ?



