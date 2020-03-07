Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F2EC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E82067C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCGCQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:16:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45496 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbgCGCQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:16:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 867D2FA63ADB9645A20A;
        Sat,  7 Mar 2020 10:16:46 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Mar 2020
 10:16:36 +0800
Subject: Re: [PATCH] kretprobe: check re-registration of the same kretprobe
 earlier
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, "chengjian (D)" <cj.chengjian@huawei.com>,
        <bobo.shaobowang@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>
References: <1583487306-81985-1-git-send-email-cj.chengjian@huawei.com>
 <20200307002115.b96be2310cc553a922e1ba31@kernel.org>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <9b122a6f-f5fa-3eb4-4fd7-f101b8aec205@huawei.com>
Date:   Sat, 7 Mar 2020 10:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307002115.b96be2310cc553a922e1ba31@kernel.org>
Content-Type: multipart/mixed;
        boundary="------------14EB139332A20789D3A96912"
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------14EB139332A20789D3A96912
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 2020/3/6 23:21, Masami Hiramatsu wrote:
> Hi Cheng,
>
> On Fri, 6 Mar 2020 17:35:06 +0800
> Cheng Jian <cj.chengjian@huawei.com> wrote:
>
>> Our system encountered a use-after-free when re-register a
>> same kretprobe. it access the hlist node in rp->free_instances
>> which has been released already.
>>
>> Prevent re-registration has been implemented for kprobe before,
>> but it's too late for kretprobe. We must check the re-registration
>> before re-initializing the kretprobe, otherwise it will destroy the
>> data and struct of the kretprobe registered, it can lead to memory
>> leak and use-after-free.
> I couldn't get how it cause use-after-free, but it causes memory leak.
> Anyway, if we can help to find a wrong usage, it might be good.
>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> BTW, I think we should use WARN_ON() for this error, because this
> means the caller is completely buggy.
>
> Thank you,

Hi Masami

When we try to re-register the same kretprobe, the register_kprobe() 
return failed and try to free_rp_inst

     register_kretprobe()

         raw_spin_lock_init(&rp->lock);
         INIT_HLIST_HEAD(&rp->free_instances);    # re-init

         inst = kmalloc(sizeof(struct kretprobe_instance) + 
p->data_size, GFP_KERNEL); # re-alloc

         ret = register_kprobe(&rp->kp);  # failed

         free_rp_inst(rp);   # free all the free_instances

at the same time, the kretprobe registed handle(trigger), it tries to 
access the free_instances.

Since we broke the rp->lock and free_instances when re-registering, we 
are accessing the newly

allocated free_instances and it's being released.

pre_handler_kretprobe

     ri = hlist_entry(rp->free_instances.first, struct 
kretprobe_instance, hlist); # access the new free_instances. BOOM!!!

     hlist_del(&ri->hlist); #BOOM!!!


And the problem here is destructive, it destroyed all the data of the 
previously registered kretprobe,
it can lead to a system crash, memory leak, use-after-free and even some 
other unexpected behavior.

We have a testcase for it, and I put it in the attachment.


test on ARM64 QEMU

use-after-free call trace：

[ 39.852002] BUG: KASAN: use-after-free in 
pre_handler_kretprobe+0x678/0x6b8 [107/7017]
[ 39.852460] Read of size 8 at addr ffff00002fb35408 by task 
DTS202001190821/251
[ 39.852801]
[ 39.854101] CPU: 6 PID: 251 Comm: DTS202001190821 Tainted: G OE 
5.6.0-rc4+ #8
[ 39.854610] Hardware name: linux,dummy-virt (DT)
[ 39.855316] Call trace:
[ 39.855520] dump_backtrace+0x0/0x390
[ 39.855758] show_stack+0x24/0x30
[ 39.855969] dump_stack+0x118/0x170
[ 39.856179] print_address_description.isra.10+0x74/0x3c0
[ 39.856451] __kasan_report+0x128/0x1d8
[ 39.856660] kasan_report+0xc/0x18
[ 39.856858] __asan_report_load8_noabort+0x18/0x20
[ 39.857132] pre_handler_kretprobe+0x678/0x6b8
[ 39.857377] kprobe_breakpoint_handler+0x108/0x580
[ 39.857622] call_break_hook+0x10c/0x1a0
[ 39.858201] brk_handler+0x28/0x88
[ 39.858503] do_debug_exception+0x138/0x2a8
[ 39.858723] el1_dbg+0x24/0x88
[ 39.858907] el1_sync_handler+0xb4/0x178
[ 39.859120] el1_sync+0x7c/0x100
[ 39.859309] _do_fork+0x0/0x8f8
[ 39.859494] el0_svc_common.constprop.2+0x11c/0x428
[ 39.859735] do_el0_svc+0x4c/0xe8
[ 39.859924] el0_svc+0x20/0x78
[ 39.860109] el0_sync_handler+0x104/0x380
[ 39.860322] el0_sync+0x140/0x180
[ 39.860644]
[ 39.860895] Allocated by task 399:
[ 39.861245] save_stack+0x28/0xc8
[ 39.861474] __kasan_kmalloc.isra.10+0xbc/0xd8
[ 39.861709] kasan_kmalloc+0xc/0x18
[ 39.862371] __kmalloc+0x128/0x2a8
[ 39.862561] register_kretprobe+0x1b0/0x868
[ 39.863834] kretprobe_init+0x8c/0x1000 [testKretprobe_007_1]
[ 39.864215] do_one_initcall+0xbc/0x4b0
[ 39.864471] do_init_module+0x194/0x580
[ 39.864730] load_module+0x4110/0x5870
[ 39.864966] __do_sys_init_module+0x264/0x390
[ 39.865268] __arm64_sys_init_module+0x70/0xa0
[ 39.865541] el0_svc_common.constprop.2+0x11c/0x428
[ 39.866287] do_el0_svc+0x4c/0xe8
[ 39.866522] el0_svc+0x20/0x78
[ 39.866746] el0_sync_handler+0x104/0x380
[ 39.867013] el0_sync+0x140/0x180
[ 39.867325]
[ 39.867486] Freed by task 399:
[ 39.867713] save_stack+0x28/0xc8
[ 39.867948] __kasan_slab_free+0x118/0x180
[ 39.868216] kasan_slab_free+0x10/0x18
[ 39.868470] kfree+0x1a0/0x2e0
[ 39.868691] register_kretprobe+0x598/0x868
[ 39.868986] kretprobe_init+0x8c/0x1000 [testKretprobe_007_1]
[ 39.869370] do_one_initcall+0xbc/0x4b0
[ 39.869637] do_init_module+0x194/0x580
[ 39.870332] load_module+0x4110/0x5870
[ 39.870590] __do_sys_init_module+0x264/0x390
[ 39.870877] __arm64_sys_init_module+0x70/0xa0
[ 39.871168] el0_svc_common.constprop.2+0x11c/0x428
[ 39.871471] do_el0_svc+0x4c/0xe8
[ 39.871705] el0_svc+0x20/0x78
[ 39.871925] el0_sync_handler+0x104/0x380
[ 39.872194] el0_sync+0x140/0x180
[ 39.872421]
[ 39.872592] The buggy address belongs to the object at ffff00002fb35400
[ 39.872592] which belongs to the cache kmalloc-128 of size 128
[ 39.873369] The buggy address is located 8 bytes inside of
[ 39.873369] 128-byte region [ffff00002fb35400, ffff00002fb35480)
[ 39.874572] The buggy address belongs to the page:
[ 39.875295] page:fffffe00009ecd00 refcount:1 mapcount:0 
mapping:ffff00003200fc00 index:0x0 compound_mapcount: 0
[ 39.876782] flags: 0x7fffe0000010200(slab|head)
[ 39.877561] raw: 07fffe0000010200 dead000000000100 dead000000000122 
ffff00003200fc00
[ 39.878554] raw: 0000000000000000 0000000000200020 00000001ffffffff 
0000000000000000
[ 39.879064] page dumped because: kasan: bad access detected
[ 39.879493]
[ 39.879669] Memory state around the buggy address:
[ 39.880300] ffff00002fb35300: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc 
fc fc
[ 39.880772] ffff00002fb35380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc
[ 39.881249] >ffff00002fb35400: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb [29/7017]
[ 39.881738]
[ 39.882415] ffff00002fb35480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc
[ 39.882836] ffff00002fb35500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb
[ 39.883300] 
==================================================================
[ 39.883761] Disabling lock debugging due to kernel taint



also with Oops

[ 39.884522] Unable to handle kernel paging request at virtual address 
fbd5400000000024
[ 39.885133] Mem abort info:
[ 39.885377] ESR = 0x96000004
[ 39.886105] EC = 0x25: DABT (current EL), IL = 32 bits
[ 39.886507] SET = 0, FnV = 0
[ 39.886725] EA = 0, S1PTW = 0
[ 39.886950] Data abort info:
[ 39.887180] ISV = 0, ISS = 0x00000004
[ 39.887430] CM = 0, WnR = 0
[ 39.887755] [fbd5400000000024] address between user and kernel address 
ranges
[ 39.888991] Internal error: Oops: 96000004 [#1] SMP
[ 39.890666] Dumping ftrace buffer:
[ 39.892131] (ftrace buffer empty)
[ 39.892724] Modules linked in: testKretprobe_007_1(OE+)
[ 39.893690] CPU: 6 PID: 251 Comm: DTS202001190821 Tainted: G B OE 
5.6.0-rc4+ #8
[ 39.894802] Hardware name: linux,dummy-virt (DT)
[ 39.895197] pstate: 600003c5 (nZCv DAIF -PAN -UAO)
[ 39.895558] pc : pre_handler_kretprobe+0x130/0x6b8
[ 39.895880] lr : pre_handler_kretprobe+0x678/0x6b8
[ 39.896181] sp : ffff00002feef9b0
[ 39.896439] x29: ffff00002feef9b0 x28: 1fffe00005f66a81
[ 39.896845] x27: ffff00002fb34900 x26: 1fffe00005f66a80
[ 39.897214] x25: ffffa0000a442728 x24: 00000000000003
[ 39.897555] x23: ffff00002feefbd0 x22: ffff00002fb35408
[ 39.898279] x21: ffffa0000a442730 x20: ffff00002fb35400
[ 39.898619] x19: ffffa0000a442680 x18: 0000000000000000
[ 39.898955] x17: 0000000000000000 x16: 0000000000000000
[ 39.899290] x15: 0000000000000007 x14: 0000000000000003
[ 39.899624] x13: 0000000000000000 x12: 1ffff4000283803c
[ 39.899961] x11: ffff94000283803c x10: dfffa00000000000
[ 39.900362] x9 : ffff94000283803d x8 : 0000000000000001
[ 39.900700] x7 : ffffa000141c01e7 x6 : ffff94000283803d
[ 39.901032] x5 : ffff94000283803d x4 : ffff94000283803d
[ 39.901389] x3 : ffffa0001016bc3c x2 : 1bd5a00000000024
[ 39.901725] x1 : dead000000000122 x0 : dfffa00000000000
[ 39.902600] Call trace:
[ 39.902864] pre_handler_kretprobe+0x130/0x6b8
[ 39.903177] kprobe_breakpoint_handler+0x108/0x580
[ 39.903492] call_break_hook+0x10c/0x1a0
[ 39.903757] brk_handler+0x28/0x88
[ 39.904004] do_debug_exception+0x138/0x2a8
[ 39.904274] el1_dbg+0x24/0x88
[ 39.904494] el1_sync_handler+0xb4/0x178
[ 39.904756] el1_sync+0x7c/0x100
[ 39.904984] _do_fork+0x0/0x8f8
[ 39.905235] el0_svc_common.constprop.2+0x11c/0x428
[ 39.905553] do_el0_svc+0x4c/0xe8
[ 39.906016] el0_svc+0x20/0x78
[ 39.906435] el0_sync_handler+0x104/0x380
[ 39.906707] el0_sync+0x140/0x180
[ 39.907140] Code: f9400681 d2d40000 f2fbffe0 d343fc22 (38e06840)
[ 39.909096] ---[ end trace 9df6bc2e51e22a6c ]---
[ 39.910142] Kernel panic - not syncing: Fatal exception
[ 39.910992] SMP: stopping secondary CPUs
[ 39.912097] Dumping ftrace buffer:
[ 39.912348] (ftrace buffer empty)
[ 39.912722] Kernel Offset: disabled
[ 39.913317] CPU features: 0x10002,20006000
[ 39.913630] Memory Limit: none
[ 39.914612] ---[ end Kernel panic - not syncing: Fatal exception ]---


Thanks

----Cheng Jian


--------------14EB139332A20789D3A96912
Content-Type: application/gzip; name="testcase.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="testcase.tar.gz"

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
hX8BnZYKYABQAAA=
--------------14EB139332A20789D3A96912--
