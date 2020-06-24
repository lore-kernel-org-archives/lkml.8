Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412CCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232082076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbgFXW1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:27:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51598 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388615AbgFXW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:27:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0dU02H_1593037636;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0dU02H_1593037636)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jun 2020 06:27:16 +0800
Date:   Thu, 25 Jun 2020 06:27:16 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        osalvador@suse.de, dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624222716.GC15016@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <20200623151828.GA31426@dhcp22.suse.cz>
 <57d8a558-dcb3-b318-8e38-6c016b050414@redhat.com>
 <20200624081324.GA12461@L-31X9LVDL-1304.local>
 <2b2b722a-58de-4c6e-a04e-dc3516b1b8ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2b722a-58de-4c6e-a04e-dc3516b1b8ab@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:41:18AM +0200, David Hildenbrand wrote:
>On 24.06.20 10:13, Wei Yang wrote:
>> On Wed, Jun 24, 2020 at 09:48:43AM +0200, David Hildenbrand wrote:
>>> On 23.06.20 17:18, Michal Hocko wrote:
>>>> On Tue 23-06-20 17:42:58, Wei Yang wrote:
>>>>> For early sections, we assumes its memmap will never be partially
>>>>> removed. But current behavior breaks this.
>>>>>
>>>>> Let's correct it.
>>>>>
>>>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>
>>>> Can a user trigger this or is this a theoretical bug?
>>>
>>> I tried to reproduce it, but somehow I get unexpected behavior.
>>> With a hacked QEMU I can get
>> 
>> David,
>> 
>> Thanks for your effort. Would you mind sharing your qemu command line, so that
>> I can have a try at my side?
>
>The following change to QEMU:
>
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index 51b3050d01..c6a78d83c0 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -1010,7 +1010,7 @@ void pc_memory_init(PCMachineState *pcms,
>         }
> 
>         machine->device_memory->base =
>-            ROUND_UP(0x100000000ULL + x86ms->above_4g_mem_size, 1 * GiB);
>+            0x100000000ULL + x86ms->above_4g_mem_size;
> 
>         if (pcmc->enforce_aligned_dimm) {
>             /* size device region assuming 1G page max alignment per slot */
>
>
>Then you can use the following QEMU cmdline:
>
>#! /bin/bash
>sudo x86_64-softmmu/qemu-system-x86_64 \
>    --enable-kvm \
>    -m 4160M,maxmem=20G,slots=1 \
>    -smp sockets=2,cores=16 \
>    -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
>    -machine pc,nvdimm \
>    -nographic \
>    -hda /home/dhildenb/git/Fedora-Cloud-Base-31-1.9.x86_64.qcow2 \
>    -nodefaults \
>    -net nic -net user \
>    -chardev stdio,nosignal,id=serial \
>    -device isa-serial,chardev=serial \
>    -chardev socket,id=monitor,path=/var/tmp/monitor,server,nowait \
>    -mon chardev=monitor,mode=readline \
>    -object memory-backend-ram,id=mem0,size=8G \
>    -device nvdimm,id=vm0,memdev=mem0,node=0,addr=0x144000000,label-size=128k
>
>
>> 
>>>
>>> $ cat /proc/iomem
>>> [...]
>>> 100000000-143ffffff : System RAM
>>> 144000000-343dfffff : Persistent Memory
>>>  144000000-1441fffff : namespace0.0
>>>  144200000-144ffffff : dax0.0
>>>
>>> After
>>> $ ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M
>>>
>>> I get
>>>
>>> $ cat /proc/iomem
>>> [...]
>>> 100000000-143ffffff : System RAM
>>> 144000000-343dfffff : Persistent Memory
>>>  144000000-1441fffff : namespace0.0
>>>  144200000-144ffffff : dax0.0
>>>
>> 
>> The memory layout seems not changed.
>
>Yeah, sorry, int he first example, dax0.0 should be missing (on a fresh
>QEMU instance instead of after a reboot).
>
>> 
>>> I can trigger remove+re-add via 
>>> $ ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M
>> 
>> Do we need to change the mode to force the reconfig?
>
>No, that's sufficient.
>
>> 
>>>
>>> So we clearly have an overlap between System RAM and dax0.0 within a section.
>>> However, I never get early_section() to trigger in
>>> section_activate()/section_deactivate() ? That's unexpected
>>>
>>>
>>> Definitely something seems to go wrong after the first "ndctl create-namespace".
>>> Using a random page walker:
>>>
>>> [root@localhost ~]# ./page-types 
>> 
>> What is this page-types?
>> 
>>> [  387.019229] general protection fault, probably for non-canonical address 0xfdfdfdfdfdfdfdfc: 0000 [#1] SMP NOPTI
>>> [  387.020172] CPU: 17 PID: 1314 Comm: page-types Kdump: loaded Tainted: G        W         5.8.0-rc2 #20
>>> [  387.021015] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
>>> [  387.022056] RIP: 0010:stable_page_flags+0x27/0x3f0
>>> [  387.022519] Code: 00 00 00 66 66 66 66 90 48 85 ff 0f 84 d2 03 00 00 41 54 55 48 89 fd 53 48 8b 57 08 48 8b 1f 48f
>>> [  387.024291] RSP: 0018:ffff9f8781057e58 EFLAGS: 00010202
>>> [  387.024775] RAX: fdfdfdfdfdfdfdfc RBX: fdfdfdfdfdfdfdfd RCX: 00007ffc4f4f1f78
>>> [  387.025423] RDX: 0000000000000001 RSI: 0000002000000000 RDI: ffffc590c5100000
>>> [  387.026052] RBP: ffffc590c5100000 R08: 0000000000000001 R09: 0000000000000000
>>> [  387.026696] R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffc4f4f1f80
>>> [  387.027324] R13: 0000000000040000 R14: 00007ffc4f4d1f80 R15: ffffffffa1577ee0
>>> [  387.027974] FS:  00007f91a0f9c580(0000) GS:ffff888b3f7c0000(0000) knlGS:0000000000000000
>>> [  387.028699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  387.029223] CR2: 0000000000449b00 CR3: 000000007a7fc000 CR4: 00000000000006e0
>>> [  387.029864] Call Trace:
>>> [  387.030108]  kpageflags_read+0xcc/0x160
>>> [  387.030473]  proc_reg_read+0x53/0x80
>>> [  387.030809]  vfs_read+0x9d/0x150
>>> [  387.031114]  ksys_pread64+0x65/0xa0
>>> [  387.031449]  do_syscall_64+0x4d/0x90
>>> [  387.031783]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>It's a tool located in Linux tools/vm/page-types.
>
>
>So with two printk's, I can spot:
>
>[   24.185558] section_deactivate(): depopulate_section_memmap
>[   24.202689] pmem0: detected capacity change from 0 to 16777216
>[   24.229747] section_activate(): early_section, not populating memmap
>[   24.229777] memmap_init_zone_device initialised 3584 pages in 0ms
>
>But nothing actually breaks .... because *drummroll* we use huge pages in the vmemmap,
>so the partial depopulate will not actually depopulate anything here. Huge page is 2M,
>the memmap of 128MB sections is exactly 2MB == one hugepages. Trying to depopulate a
>fraction (e.g., 16MB) of that won't do anything.
>

Thanks David. I miss some knowledge here about the vmemmap and 2MB. Would you
minding pointing me the location which affects this behavior? I don't see how
depopulate_section_memmap would be affect by this.

>
>Now, forcing a CPU without hugepages - PSE (QEMU: "-cpu host,pse=off)", I can trigger
>via  ndctl create-namespace --force --reconfig=namespace0.0 --mode=devdax --size=16M
>
>[   18.044973] pmem0: detected capacity change from 0 to 16777216
>[   18.073813] BUG: unable to handle page fault for address: ffffec73c51000b4
>[   18.076236] #PF: supervisor write access in kernel mode
>[   18.077211] #PF: error_code(0x0002) - not-present page
>[   18.077943] PGD 81ff8067 P4D 81ff8067 PUD 81ff7067 PMD 1437cb067 PTE 0
>[   18.078551] Oops: 0002 [#1] SMP NOPTI
>[   18.078915] CPU: 16 PID: 1348 Comm: ndctl Kdump: loaded Tainted: G        W         5.8.0-rc2+ #24
>[   18.079718] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
>[   18.080750] RIP: 0010:memmap_init_zone+0x154/0x1c2
>[   18.081213] Code: 77 16 f6 40 10 02 74 10 48 03 48 08 48 89 cb 48 c1 eb 0c e9 3a ff ff ff 48 89 df 48 c1 e7 06 48f
>[   18.082902] RSP: 0018:ffffbdc7011a39b0 EFLAGS: 00010282
>[   18.083395] RAX: ffffec73c5100088 RBX: 0000000000144002 RCX: 0000000000144000
>[   18.084057] RDX: 0000000000000004 RSI: 007ffe0000000000 RDI: ffffec73c5100080
>[   18.084704] RBP: 027ffe0000000000 R08: 0000000000000001 R09: ffff9f8d38f6d708
>[   18.085369] R10: ffffec73c0000000 R11: 0000000000000000 R12: 0000000000000004
>[   18.086020] R13: 0000000000000001 R14: 0000000000144200 R15: 0000000000000000
>[   18.086670] FS:  00007efe6b65d780(0000) GS:ffff9f8d3f780000(0000) knlGS:0000000000000000
>[   18.087417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   18.087965] CR2: ffffec73c51000b4 CR3: 000000007d718000 CR4: 0000000000340ee0
>[   18.088623] Call Trace:
>[   18.088884]  move_pfn_range_to_zone+0x128/0x150
>[   18.089313]  memremap_pages+0x4e4/0x5a0
>[   18.089681]  devm_memremap_pages+0x1e/0x60
>[   18.090081]  dev_dax_probe+0x69/0x160 [device_dax]
>[   18.090533]  really_probe+0x298/0x3c0
>[   18.090896]  driver_probe_device+0xe1/0x150
>[   18.091303]  ? driver_allows_async_probing+0x50/0x50
>[   18.091780]  bus_for_each_drv+0x7e/0xc0
>[   18.092154]  __device_attach+0xdf/0x160
>[   18.092527]  bus_probe_device+0x8e/0xa0
>[   18.092916]  device_add+0x3b9/0x740
>[   18.093258]  __devm_create_dev_dax+0x127/0x1c0
>[   18.093686]  __dax_pmem_probe+0x1f2/0x219 [dax_pmem_core]
>[   18.094200]  dax_pmem_probe+0xc/0x1b [dax_pmem]
>[   18.094632]  nvdimm_bus_probe+0x69/0x1c0 [libnvdimm]
>[   18.095109]  really_probe+0x147/0x3c0
>[   18.095470]  driver_probe_device+0xe1/0x150
>[   18.095883]  device_driver_attach+0x53/0x60
>[   18.096289]  bind_store+0xd1/0x110
>[   18.096627]  kernfs_fop_write+0xce/0x1b0
>[   18.097017]  vfs_write+0xb6/0x1a0
>[   18.097350]  ksys_write+0x5f/0xe0
>[   18.097681]  do_syscall_64+0x4d/0x90
>[   18.098041]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>

I would put this into changelog.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
