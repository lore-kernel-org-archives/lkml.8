Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD818C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FEF2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGPIPG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:15:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgGPIPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:15:04 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 335E35F8ECBBA684FFF9;
        Thu, 16 Jul 2020 16:15:02 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 16 Jul 2020 16:15:01 +0800
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 16 Jul 2020 16:14:59 +0800
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007;
 Thu, 16 Jul 2020 09:14:57 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, yuzenghui <yuzenghui@huawei.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: RE: [REPORT] possible circular locking dependency when booting a VM
 on arm64 host
Thread-Topic: [REPORT] possible circular locking dependency when booting a VM
 on arm64 host
Thread-Index: AQHWVd2KjX+gRVf/zUS8x8KvRiYF2qkIx/6AgAAPrCCAAQtKIA==
Date:   Thu, 16 Jul 2020 08:14:57 +0000
Message-ID: <9c5087015361434bb1ccb93276c235bc@huawei.com>
References: <7225eba7-6e5e-ec7e-953b-d1fef0b1775b@huawei.com>
 <99e001bba70216d9e9a54a786791cb92@kernel.org> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.68.220]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Salil Mehta
> Sent: Thursday, July 16, 2020 1:53 AM
> To: 'Marc Zyngier' <maz@kernel.org>; yuzenghui <yuzenghui@huawei.com>
> 
> > From: Marc Zyngier [mailto:maz@kernel.org]
> > Sent: Wednesday, July 15, 2020 5:09 PM
> > To: yuzenghui <yuzenghui@huawei.com>
> >
> > Hi Zenghui,
> >
> > On 2020-07-09 11:41, Zenghui Yu wrote:
> > > Hi All,
> > >
> > > I had seen the following lockdep splat when booting a guest on my
> > > Kunpeng 920 with GICv4 enabled. I can also trigger the same splat
> > > on v5.5 so it should already exist in the kernel for a while. I'm
> > > not sure what the exact problem is and hope someone can have a look!
> >
> > I can't manage to trigger this splat on my D05, despite running guests
> > with GICv4 enabled. A couple of questions below:
> 
> 
> Sorry I forgot to update but I did try on Friday and I could not manage
> to trigger it on D06/Kunpeng920 either. I used 5.8.0-rc4.
> 
> 
> > > Thanks,
> > > Zenghui
> > >
> > > [  103.855511] ======================================================
> > > [  103.861664] WARNING: possible circular locking dependency detected
> > > [  103.867817] 5.8.0-rc4+ #35 Tainted: G        W
> > > [  103.872932] ------------------------------------------------------
> > > [  103.879083] CPU 2/KVM/20515 is trying to acquire lock:
> > > [  103.884200] ffff202fcd5865b0 (&irq_desc_lock_class){-.-.}-{2:2},
> > > at: __irq_get_desc_lock+0x60/0xa0
> > > [  103.893127]
> > >                but task is already holding lock:
> > > [  103.898933] ffff202fcfd07f58 (&rq->lock){-.-.}-{2:2}, at:
> > > __schedule+0x114/0x8b8
> > > [  103.906301]
> > >                which lock already depends on the new lock.
> > >
> > > [  103.914441]
> > >                the existing dependency chain (in reverse order) is:
> > > [  103.921888]
> > >                -> #3 (&rq->lock){-.-.}-{2:2}:
> > > [  103.927438]        _raw_spin_lock+0x54/0x70
> > > [  103.931605]        task_fork_fair+0x48/0x150
> > > [  103.935860]        sched_fork+0x100/0x268
> > > [  103.939856]        copy_process+0x628/0x1868
> > > [  103.944106]        _do_fork+0x74/0x710
> > > [  103.947840]        kernel_thread+0x78/0xa0
> > > [  103.951917]        rest_init+0x30/0x270
> > > [  103.955742]        arch_call_rest_init+0x14/0x1c
> > > [  103.960339]        start_kernel+0x534/0x568
> > > [  103.964503]
> > >                -> #2 (&p->pi_lock){-.-.}-{2:2}:
> > > [  103.970224]        _raw_spin_lock_irqsave+0x70/0x98
> > > [  103.975080]        try_to_wake_up+0x5c/0x5b0
> > > [  103.979330]        wake_up_process+0x28/0x38
> > > [  103.983581]        create_worker+0x128/0x1b8
> > > [  103.987834]        workqueue_init+0x308/0x3bc
> > > [  103.992172]        kernel_init_freeable+0x180/0x33c
> > > [  103.997027]        kernel_init+0x18/0x118
> > > [  104.001020]        ret_from_fork+0x10/0x18
> > > [  104.005097]
> > >                -> #1 (&pool->lock){-.-.}-{2:2}:
> > > [  104.010817]        _raw_spin_lock+0x54/0x70
> > > [  104.014983]        __queue_work+0x120/0x6e8
> > > [  104.019146]        queue_work_on+0xa0/0xd8
> > > [  104.023225]        irq_set_affinity_locked+0xa8/0x178
> > > [  104.028253]        __irq_set_affinity+0x5c/0x90
> > > [  104.032762]        irq_set_affinity_hint+0x74/0xb0
> > > [  104.037540]        hns3_nic_init_irq+0xe0/0x210 [hns3]
> > > [  104.042655]        hns3_client_init+0x2d8/0x4e0 [hns3]
> > > [  104.047779]        hclge_init_client_instance+0xf0/0x3a8 [hclge]
> > > [  104.053760]        hnae3_init_client_instance.part.3+0x30/0x68
> > > [hnae3]
> > > [  104.060257]        hnae3_register_ae_dev+0x100/0x1f0 [hnae3]
> > > [  104.065892]        hns3_probe+0x60/0xa8 [hns3]
> >
> > Are you performing some kind of PCIe hot-plug here? Or is that done
> > at boot only? It seems to help triggering the splat.
> 
> 
> I am not sure how you can do that since HNS3 is integrated NIC so
> physical hot-plug is definitely ruled out. local_pci_probe()
> should also get called when we insert the hns3_enet module which
> eventually initializes the driver.

Or perhaps you meant below?

echo 1 > /sys/bus/pci/devices/xxxx/xx.x/remove
echo 1 > /sys/bus/pci/devices/rescan

Above is not being used I did confirm this with Zenghui earlier.

 

