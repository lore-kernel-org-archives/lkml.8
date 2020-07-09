Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A0E207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGIKll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:41:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgGIKll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:41:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F7F6C72AA6B11270FA7;
        Thu,  9 Jul 2020 18:41:38 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 18:41:30 +0800
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Subject: [REPORT] possible circular locking dependency when booting a VM on
 arm64 host
CC:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <wanghaibin.wang@huawei.com>
Message-ID: <7225eba7-6e5e-ec7e-953b-d1fef0b1775b@huawei.com>
Date:   Thu, 9 Jul 2020 18:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I had seen the following lockdep splat when booting a guest on my
Kunpeng 920 with GICv4 enabled. I can also trigger the same splat
on v5.5 so it should already exist in the kernel for a while. I'm
not sure what the exact problem is and hope someone can have a look!


Thanks,
Zenghui

[  103.855511] ======================================================
[  103.861664] WARNING: possible circular locking dependency detected
[  103.867817] 5.8.0-rc4+ #35 Tainted: G        W
[  103.872932] ------------------------------------------------------
[  103.879083] CPU 2/KVM/20515 is trying to acquire lock:
[  103.884200] ffff202fcd5865b0 (&irq_desc_lock_class){-.-.}-{2:2}, at: 
__irq_get_desc_lock+0x60/0xa0
[  103.893127]
                but task is already holding lock:
[  103.898933] ffff202fcfd07f58 (&rq->lock){-.-.}-{2:2}, at: 
__schedule+0x114/0x8b8
[  103.906301]
                which lock already depends on the new lock.

[  103.914441]
                the existing dependency chain (in reverse order) is:
[  103.921888]
                -> #3 (&rq->lock){-.-.}-{2:2}:
[  103.927438]        _raw_spin_lock+0x54/0x70
[  103.931605]        task_fork_fair+0x48/0x150
[  103.935860]        sched_fork+0x100/0x268
[  103.939856]        copy_process+0x628/0x1868
[  103.944106]        _do_fork+0x74/0x710
[  103.947840]        kernel_thread+0x78/0xa0
[  103.951917]        rest_init+0x30/0x270
[  103.955742]        arch_call_rest_init+0x14/0x1c
[  103.960339]        start_kernel+0x534/0x568
[  103.964503]
                -> #2 (&p->pi_lock){-.-.}-{2:2}:
[  103.970224]        _raw_spin_lock_irqsave+0x70/0x98
[  103.975080]        try_to_wake_up+0x5c/0x5b0
[  103.979330]        wake_up_process+0x28/0x38
[  103.983581]        create_worker+0x128/0x1b8
[  103.987834]        workqueue_init+0x308/0x3bc
[  103.992172]        kernel_init_freeable+0x180/0x33c
[  103.997027]        kernel_init+0x18/0x118
[  104.001020]        ret_from_fork+0x10/0x18
[  104.005097]
                -> #1 (&pool->lock){-.-.}-{2:2}:
[  104.010817]        _raw_spin_lock+0x54/0x70
[  104.014983]        __queue_work+0x120/0x6e8
[  104.019146]        queue_work_on+0xa0/0xd8
[  104.023225]        irq_set_affinity_locked+0xa8/0x178
[  104.028253]        __irq_set_affinity+0x5c/0x90
[  104.032762]        irq_set_affinity_hint+0x74/0xb0
[  104.037540]        hns3_nic_init_irq+0xe0/0x210 [hns3]
[  104.042655]        hns3_client_init+0x2d8/0x4e0 [hns3]
[  104.047779]        hclge_init_client_instance+0xf0/0x3a8 [hclge]
[  104.053760]        hnae3_init_client_instance.part.3+0x30/0x68 [hnae3]
[  104.060257]        hnae3_register_ae_dev+0x100/0x1f0 [hnae3]
[  104.065892]        hns3_probe+0x60/0xa8 [hns3]
[  104.070319]        local_pci_probe+0x44/0x98
[  104.074573]        work_for_cpu_fn+0x20/0x30
[  104.078823]        process_one_work+0x258/0x618
[  104.083333]        worker_thread+0x1c0/0x438
[  104.087585]        kthread+0x120/0x128
[  104.091318]        ret_from_fork+0x10/0x18
[  104.095394]
                -> #0 (&irq_desc_lock_class){-.-.}-{2:2}:
[  104.101895]        __lock_acquire+0x11bc/0x1530
[  104.106406]        lock_acquire+0x100/0x3f8
[  104.110570]        _raw_spin_lock_irqsave+0x70/0x98
[  104.115426]        __irq_get_desc_lock+0x60/0xa0
[  104.120021]        irq_set_vcpu_affinity+0x48/0xc8
[  104.124793]        its_make_vpe_non_resident+0x6c/0xc0
[  104.129910]        vgic_v4_put+0x64/0x70
[  104.133815]        vgic_v3_put+0x28/0x100
[  104.137806]        kvm_vgic_put+0x3c/0x60
[  104.141801]        kvm_arch_vcpu_put+0x38/0x58
[  104.146228]        kvm_sched_out+0x38/0x58
[  104.150306]        __schedule+0x554/0x8b8
[  104.154298]        schedule+0x50/0xe0
[  104.157946]        kvm_arch_vcpu_ioctl_run+0x644/0x9e8
[  104.163063]        kvm_vcpu_ioctl+0x4b4/0x918
[  104.167403]        ksys_ioctl+0xb4/0xd0
[  104.171222]        __arm64_sys_ioctl+0x28/0xc8
[  104.175647]        el0_svc_common.constprop.2+0x74/0x138
[  104.180935]        do_el0_svc+0x34/0xa0
[  104.184755]        el0_sync_handler+0xec/0x128
[  104.189179]        el0_sync+0x140/0x180
[  104.192997]
                other info that might help us debug this:

[  104.200962] Chain exists of:
                  &irq_desc_lock_class --> &p->pi_lock --> &rq->lock

[  104.211261]  Possible unsafe locking scenario:

[  104.217152]        CPU0                    CPU1
[  104.221660]        ----                    ----
[  104.226170]   lock(&rq->lock);
[  104.229210]                                lock(&p->pi_lock);
[  104.234930]                                lock(&rq->lock);
[  104.240474]   lock(&irq_desc_lock_class);
[  104.244465]
                 *** DEADLOCK ***

[  104.250356] 2 locks held by CPU 2/KVM/20515:
[  104.254606]  #0: ffff202fa95680c8 (&vcpu->mutex){+.+.}-{3:3}, at: 
kvm_vcpu_ioctl+0x80/0x918
[  104.262921]  #1: ffff202fcfd07f58 (&rq->lock){-.-.}-{2:2}, at: 
__schedule+0x114/0x8b8
[  104.270717]
                stack backtrace:
[  104.275057] CPU: 73 PID: 20515 Comm: CPU 2/KVM Kdump: loaded Tainted: 
G        W         5.8.0-rc4+ #35
[  104.284404] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 
1.05 09/18/2019
[  104.291851] Call trace:
[  104.294289]  dump_backtrace+0x0/0x218
[  104.297935]  show_stack+0x2c/0x38
[  104.301235]  dump_stack+0xf0/0x168
[  104.304622]  print_circular_bug.isra.39+0x22c/0x280
[  104.309476]  check_noncircular+0x158/0x1c8
[  104.313555]  __lock_acquire+0x11bc/0x1530
[  104.317545]  lock_acquire+0x100/0x3f8
[  104.321190]  _raw_spin_lock_irqsave+0x70/0x98
[  104.325529]  __irq_get_desc_lock+0x60/0xa0
[  104.329606]  irq_set_vcpu_affinity+0x48/0xc8
[  104.333858]  its_make_vpe_non_resident+0x6c/0xc0
[  104.338454]  vgic_v4_put+0x64/0x70
[  104.341840]  vgic_v3_put+0x28/0x100
[  104.345314]  kvm_vgic_put+0x3c/0x60
[  104.348789]  kvm_arch_vcpu_put+0x38/0x58
[  104.352694]  kvm_sched_out+0x38/0x58
[  104.356256]  __schedule+0x554/0x8b8
[  104.359730]  schedule+0x50/0xe0
[  104.362859]  kvm_arch_vcpu_ioctl_run+0x644/0x9e8
[  104.367457]  kvm_vcpu_ioctl+0x4b4/0x918
[  104.371277]  ksys_ioctl+0xb4/0xd0
[  104.374577]  __arm64_sys_ioctl+0x28/0xc8
[  104.378482]  el0_svc_common.constprop.2+0x74/0x138
[  104.383250]  do_el0_svc+0x34/0xa0
[  104.386552]  el0_sync_handler+0xec/0x128
[  104.390458]  el0_sync+0x140/0x180
