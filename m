Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:56830
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728150AbgCKIy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:54:59 -0400
Subject: Re: [PATCH] soc: fsl: dpio: register dpio irq handlers after dpio
 create
To: Li Yang <leoyang.li@nxp.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Grigore Popescu <grigore.popescu@nxp.com>
References: <20200310120719.2480-1-laurentiu.tudor@nxp.com>
 <CADRPPNT4diVa3gYv=t174=vmZZ3qRX2QmtXto9hLEnjQvv5SwQ@mail.gmail.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <4f61005e-356f-c5f8-83f8-cc741cd89d82@nxp.com>
Date: Wed, 11 Mar 2020 10:53:44 +0200
In-Reply-To: <CADRPPNT4diVa3gYv=t174=vmZZ3qRX2QmtXto9hLEnjQvv5SwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311085344.qFZGO9c0VFkG2sPeE_4bgaSPrxaN8Z0OAHqo_b8-kjc@z>



On 10.03.2020 22:30, Li Yang wrote:
> On Tue, Mar 10, 2020 at 7:09 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>>
>> From: Grigore Popescu <grigore.popescu@nxp.com>
>>
>> The dpio irqs must be registered when you can actually
>> receive interrupts, ie when the dpios are created.
>> Kernel goes through NULL pointer dereference errors
>> followed by kernel panic [1] because the dpio irqs are
>> enabled before the dpio is created.
>>
>> [1]
>> Unable to handle kernel NULL pointer dereference at virtual address 0040
>> fsl_mc_dpio dpio.14: probed
>> fsl_mc_dpio dpio.13: Adding to iommu group 11
>>    ISV = 0, ISS = 0x00000004
>> Unable to handle kernel NULL pointer dereference at virtual address 0040
>> Mem abort info:
>>    ESR = 0x96000004
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>> Data abort info:
>>    ISV = 0, ISS = 0x00000004
>>    CM = 0, WnR = 0
>> [0000000000000040] user address but active_mm is swapper
>> Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 2 PID: 151 Comm: kworker/2:1 Not tainted 5.6.0-rc4-next-20200304 #1
>> Hardware name: NXP Layerscape LX2160ARDB (DT)
>> Workqueue: events deferred_probe_work_func
>> pstate: 00000085 (nzcv daIf -PAN -UAO)
>> pc : dpaa2_io_irq+0x18/0xe0
>> lr : dpio_irq_handler+0x1c/0x28
>> sp : ffff800010013e20
>> x29: ffff800010013e20 x28: ffff0026d9b4c140
>> x27: ffffa1d38a142018 x26: ffff0026d2953400
>> x25: ffffa1d38a142018 x24: ffffa1d38a7ba1d8
>> x23: ffff800010013f24 x22: 0000000000000000
>> x21: 0000000000000072 x20: ffff0026d2953400
>> x19: ffff0026d2a68b80 x18: 0000000000000001
>> x17: 000000002fb37f3d x16: 0000000035eafadd
>> x15: ffff0026d9b4c5b8 x14: ffffffffffffffff
>> x13: ff00000000000000 x12: 0000000000000038
>> x11: 0101010101010101 x10: 0000000000000040
>> x9 : ffffa1d388db11e4 x8 : ffffa1d38a7e40f0
>> x7 : ffff0026da414f38 x6 : 0000000000000000
>> x5 : ffff0026da414d80 x4 : ffff5e5353d0c000
>> x3 : ffff800010013f60 x2 : ffffa1d388db11c8
>> x1 : ffff0026d2a67c00 x0 : 0000000000000000
>> Call trace:
>>   dpaa2_io_irq+0x18/0xe0
>>   dpio_irq_handler+0x1c/0x28
>>   __handle_irq_event_percpu+0x78/0x2c0
>>   handle_irq_event_percpu+0x38/0x90
>>   handle_irq_event+0x4c/0xd0
>>   handle_fasteoi_irq+0xbc/0x168
>>   generic_handle_irq+0x2c/0x40
>>   __handle_domain_irq+0x68/0xc0
>>   gic_handle_irq+0x64/0x150
>>   el1_irq+0xb8/0x180
>>   _raw_spin_unlock_irqrestore+0x14/0x48
>>   irq_set_affinity_hint+0x6c/0xa0
>>   dpaa2_dpio_probe+0x2a4/0x518
>>   fsl_mc_driver_probe+0x28/0x70
>>   really_probe+0xdc/0x320
>>   driver_probe_device+0x5c/0xf0
>>   __device_attach_driver+0x88/0xc0
>>   bus_for_each_drv+0x7c/0xc8
>>   __device_attach+0xe4/0x140
>>   device_initial_probe+0x18/0x20
>>   bus_probe_device+0x98/0xa0
>>   device_add+0x41c/0x758
>>   fsl_mc_device_add+0x184/0x530
>>   dprc_scan_objects+0x280/0x370
>>   dprc_probe+0x124/0x3b0
>>   fsl_mc_driver_probe+0x28/0x70
>>   really_probe+0xdc/0x320
>>   driver_probe_device+0x5c/0xf0
>>   __device_attach_driver+0x88/0xc0
>>   bus_for_each_drv+0x7c/0xc8
>>   __device_attach+0xe4/0x140
>>   device_initial_probe+0x18/0x20
>>   bus_probe_device+0x98/0xa0
>>   deferred_probe_work_func+0x74/0xa8
>>   process_one_work+0x1c8/0x470
>>   worker_thread+0x1f8/0x428
>>   kthread+0x124/0x128
>>   ret_from_fork+0x10/0x18
>> Code: a9bc7bfd 910003fd a9025bf5 a90363f7 (f9402015)
>> ---[ end trace 38298e1a29e7a570 ]---
>> Kernel panic - not syncing: Fatal exception in interrupt
>> SMP: stopping secondary CPUs
>> Mem abort info:
>>    ESR = 0x96000004
>>    CM = 0, WnR = 0
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>> [0000000000000040] user address but active_mm is swapper
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>> Data abort info:
>>    ISV = 0, ISS = 0x00000004
>>    CM = 0, WnR = 0
>> [0000000000000040] user address but active_mm is swapper
>> SMP: failed to stop secondary CPUs 0-2
>> Kernel Offset: 0x21d378600000 from 0xffff800010000000
>> PHYS_OFFSET: 0xffffe92180000000
>> CPU features: 0x10002,21806008
>> Memory Limit: none
>> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Signed-off-by: Grigore Popescu <grigore.popescu@nxp.com>
> 
> Applied for fix.  Thanks.  Does this fix apply to stable kernels?

It sure does, good point.

---
Best Regards, Laurentiu

>> ---
>>   drivers/soc/fsl/dpio/dpio-driver.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
>> index 70014ecce2a7..7b642c330977 100644
>> --- a/drivers/soc/fsl/dpio/dpio-driver.c
>> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
>> @@ -233,10 +233,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>                  goto err_allocate_irqs;
>>          }
>>
>> -       err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
>> -       if (err)
>> -               goto err_register_dpio_irq;
>> -
>>          priv->io = dpaa2_io_create(&desc, dev);
>>          if (!priv->io) {
>>                  dev_err(dev, "dpaa2_io_create failed\n");
>> @@ -244,6 +240,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>>                  goto err_dpaa2_io_create;
>>          }
>>
>> +       err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
>> +       if (err)
>> +               goto err_register_dpio_irq;
>> +
>>          dev_info(dev, "probed\n");
>>          dev_dbg(dev, "   receives_notifications = %d\n",
>>                  desc.receives_notifications);
>> --
>> 2.17.1
>>

