Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE18C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41A624697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 01:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBB3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 20:29:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbgCBB3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 20:29:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 74A3D27C3ECEAB96F35B;
        Mon,  2 Mar 2020 09:29:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 09:29:15 +0800
Subject: Re: [PATCH v7 1/4] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
To:     John Donnelly <john.p.donnelly@oracle.com>,
        James Morse <james.morse@arm.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-2-chenzhou10@huawei.com>
 <20191227055458.GA14893@dhcp-128-65.nay.redhat.com>
 <09d42854-461b-e85c-ba3f-0e1173dc95b5@huawei.com>
 <20191228093227.GA19720@dhcp-128-65.nay.redhat.com>
 <77c971a4-608f-ee35-40cb-77186a2ddbd1@arm.com>
 <08C19FFB-C6FC-4BB7-A1C2-67CE6B99D2AB@oracle.com>
 <73F5F438-0B79-418D-8AA7-B1164D10AA24@oracle.com>
CC:     kbuild test robot <lkp@intel.com>, <will@kernel.org>,
        <linux-doc@vger.kernel.org>, <catalin.marinas@arm.com>,
        <bhsharma@redhat.com>, <xiexiuqi@huawei.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <horms@verge.net.au>, <tglx@linutronix.de>,
        Dave Young <dyoung@redhat.com>, <mingo@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <f40d64d3-b433-670f-a8d7-73a66cb333b7@huawei.com>
Date:   Mon, 2 Mar 2020 09:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <73F5F438-0B79-418D-8AA7-B1164D10AA24@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/24 23:25, John Donnelly wrote:
> 
> 
>> On Jan 16, 2020, at 9:47 AM, John Donnelly <john.p.donnelly@oracle.com> wrote:
>>
>>
>>
>>> On Jan 16, 2020, at 9:17 AM, James Morse <james.morse@arm.com> wrote:
>>>
>>> Hi guys,
>>>
>>> On 28/12/2019 09:32, Dave Young wrote:
>>>> On 12/27/19 at 07:04pm, Chen Zhou wrote:
>>>>> On 2019/12/27 13:54, Dave Young wrote:
>>>>>> On 12/23/19 at 11:23pm, Chen Zhou wrote:
>>>>>>> In preparation for supporting reserve_crashkernel_low in arm64 as
>>>>>>> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
>>>>>>>
>>>>>>> Note, in arm64, we reserve low memory if and only if crashkernel=X,low
>>>>>>> is specified. Different with x86_64, don't set low memory automatically.
>>>>>>
>>>>>> Do you have any reason for the difference?  I'd expect we have same
>>>>>> logic if possible and remove some of the ifdefs.
>>>>>
>>>>> In x86_64, if we reserve crashkernel above 4G, then we call reserve_crashkernel_low()
>>>>> to reserve low memory.
>>>>>
>>>>> In arm64, to simplify, we call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
>>>>> and then relax the arm64_dma32_phys_limit if reserve_crashkernel_low() allocated something.
>>>>> In this case, if reserve crashkernel below 4G there will be 256M low memory set automatically
>>>>> and this needs extra considerations.
>>>
>>>> Sorry that I did not read the old thread details and thought that is
>>>> arch dependent.  But rethink about that, it would be better that we can
>>>> have same semantic about crashkernel parameters across arches.  If we
>>>> make them different then it causes confusion, especially for
>>>> distributions.
>>>
>>> Surely distros also want one crashkernel* string they can use on all platforms without
>>> having to detect the kernel version, platform or changeable memory layout...
>>>
>>>
>>>> OTOH, I thought if we reserve high memory then the low memory should be
>>>> needed.  There might be some exceptions, but I do not know the exact
>>>> one,
>>>
>>>> can we make the behavior same, and special case those systems which
>>>> do not need low memory reservation.
>>>
>>> Its tricky to work out which systems are the 'normal' ones.
>>>
>>> We don't have a fixed memory layout for arm64. Some systems have no memory below 4G.
>>> Others have no memory above 4G.
>>>
>>> Chen Zhou's machine has some memory below 4G, but its too precious to reserve a large
>>> chunk for kdump. Without any memory below 4G some of the drivers won't work.
>>>
>>> I don't see what distros can set as their default for all platforms if high/low are
>>> mutually exclusive with the 'crashkernel=' in use today. How did x86 navigate this, ... or
>>> was it so long ago?
>>>
>>> No one else has reported a problem with the existing placement logic, hence treating this
>>> 'low' thing as the 'in addition' special case.
>>
>>
>> Hi,
>>
>> I am seeing similar  Arm crash dump issues  on  5.4 kernels  where we need  rather large amount of crashkernel memory reserved that is not available below 4GB ( The maximum reserved size appears to be around 768M ) . When I pick memory range higher than 4GB , I see  adapters that fail to initialize :
>>
>>
>> There is no low-memory  <4G  memory for DMA ;     
>>
>> [   11.506792] kworker/0:14: page allocation failure: order:0, 
>> mode:0x104(GFP_DMA32|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0 
>> [   11.518793] CPU: 0 PID: 150 Comm: kworker/0:14 Not tainted 
>> 5.4.0-1948.3.el8uek.aarch64 #1 
>> [   11.526955] Hardware name: To be filled by O.E.M. Saber/Saber, BIOS 
>> 0ACKL025 01/18/2019 
>> [   11.534948] Workqueue: events work_for_cpu_fn 
>> [   11.539291] Call trace: 
>> [   11.541727]  dump_backtrace+0x0/0x18c 
>> [   11.545376]  show_stack+0x24/0x30 
>> [   11.548679]  dump_stack+0xbc/0xe0 
>> [   11.551982]  warn_alloc+0xf0/0x15c 
>> [   11.555370]  __alloc_pages_slowpath+0xb4c/0xb84 
>> [   11.559887]  __alloc_pages_nodemask+0x2d0/0x330 
>> [   11.564405]  alloc_pages_current+0x8c/0xf8 
>> [   11.568496]  ttm_bo_device_init+0x188/0x220 [ttm] 
>> [   11.573187]  drm_vram_mm_init+0x58/0x80 [drm_vram_helper] 
>> [   11.578572]  drm_vram_helper_alloc_mm+0x64/0xb0 [drm_vram_helper] 
>> [   11.584655]  ast_mm_init+0x38/0x80 [ast] 
>> [   11.588566]  ast_driver_load+0x474/0xa70 [ast] 
>> [   11.593029]  drm_dev_register+0x144/0x1c8 [drm] 
>> [   11.597573]  drm_get_pci_dev+0xa4/0x168 [drm] 
>> [   11.601919]  ast_pci_probe+0x8c/0x9c [ast] 
>> [   11.606004]  local_pci_probe+0x44/0x98 
>> [   11.609739]  work_for_cpu_fn+0x20/0x30 
>> [   11.613474]  process_one_work+0x1c4/0x41c 
>> [   11.617470]  worker_thread+0x150/0x4b0 
>> [   11.621206]  kthread+0x110/0x114 
>> [   11.624422]  ret_from_fork+0x10/0x18 
>>
>> This failure is related to a graphics adapter. 
>>
>> The more complex kdump configurations that use networking stack to NFS mount a filesystem to dump to , or use ssh to copy to another machine,  require more crashkernel memory reservations than perhaps the “default*” settings of  a minimal kdump that creates a minimal  vmcore to local storage in  /var/crash. If crashkernel is too small I get Out of Memory issues and the entire vmcore  process fails. 
>>
>> ( *default kdump setting I assume are a minimal vmcore to /var/crash using primary boot device where /root is located  ) 
>>
> Hi Chen,
> 
> 
> I was able to unit test these series of kernel  patches  applied to a 5.4.17 test kernel  along with the kexec CLI  change :
> 
> 0001-arm64-kdump-add-another-DT-property-to-crash-dump-ke.patch
> 
> Applied to :
> 
> kexec-tools-2.0.19-12.0.4.el8.src.rpm
> 
> And obtained a vmcore using this cmdline :
> 
> BOOT_IMAGE=(hd6,gpt2)/vmlinuz-5.4.17-4-uek6m_ol8-jpdonnel+ root=/dev/mapper/ol01-root ro crashkernel=2048M@35G crashkernel=250M,low rd.lvm.lv=ol01/root rd.lvm.lv=ol01/swap console=ttyS4 loglevel=7
> 
> Can you add :
> 
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> 
> 
> How can we  get these changes included into an rc kernel release  ?
> 
> Thanks,
> 
> John.

Hi all,

Friendly ping...

> 
> 
>>
>>
>>
>>>
>>>
>>>>> previous discusses:
>>>>> 	https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_6_5_670&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=jOAu1DTDpohsWszalfTCYx46eGF19TSWVLchN5yBPgk&s=gS9BLOkmj78lP5L7SP6_VLHwvP249uWKaE2R7N7sxgM&e= 
>>>>> 	https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_6_13_229&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=jOAu1DTDpohsWszalfTCYx46eGF19TSWVLchN5yBPgk&s=U1Nis29n3A7XSBzED53fiE4MDAv5NlxYp1UorvvBOOw&e= 
>>>>
>>>> Another concern from James:
>>>> "
>>>> With both crashk_low_res and crashk_res, we end up with two entries in /proc/iomem called
>>>> "Crash kernel". Because its sorted by address, and kexec-tools stops searching when it
>>>> find "Crash kernel", you are always going to get the kernel placed in the lower portion.
>>>> "
>>>>
>>>> The kexec-tools code is iterating all "Crash kernel" ranges and add them
>>>> in an array.  In X86 code, it uses the higher range to locate memory.
>>>
>>> Then my hurried reading of what the user-space code does was wrong!
>>>
>>> If kexec-tools places the kernel in the low region, there may not be enough memory left
>>> for whatever purpose it was reserved for. This was the motivation for giving it a
>>> different name.
>>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_kexec&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=jOAu1DTDpohsWszalfTCYx46eGF19TSWVLchN5yBPgk&s=bqp02iQDP_Ez-XvLIvj-IPHqbbZwMPlDgmEcG8vhXFE&e= 
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_kexec&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=t2fPg9D87F7D8jm0_3CG9yoiIKdRg4qc_thBw4bzMhc&m=whm9_BOrgAjJvBn0Ey_brHhFg2YMU_P0HF02dhgdgwU&s=vLar_m5JbicYwwuo6N84ZiBDGZUPM8bBLSPLQBtPZNY&e= 
> 
> 
> .
> 

