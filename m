Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7904BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599182065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGGJr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:47:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgGGJr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:47:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E5D1AC2D;
        Tue,  7 Jul 2020 09:47:25 +0000 (UTC)
Date:   Tue, 7 Jul 2020 11:47:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBba3RocmVhZA==?= =?utf-8?Q?=5D?= a90477f0c9:
 WARNING:at_kernel/kthread.c:#kthread_queue_work
Message-ID: <20200707094724.GD4087@alley>
References: <20200706093822.GC3874@shao2-debian>
 <BYAPR11MB263209A68F3804CC4436AB50FF690@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB263209A68F3804CC4436AB50FF690@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-07-06 10:17:31, Zhang, Qiang wrote:
> Hi , Petr Mladek
> There some question for "Work could not be queued when worker being destroyed" patch,
> 
> when in "spi_init_queue" func :
> "kthread_init_worker(&ctlr->kworker);     (worker->task = NULL)
>  ctlr->kworker_task = kthread_run(kthread_worker_fn, &ctlr->kworker,
>                                          "%s", dev_name(&ctlr->dev)); "

I see. I have missed that there are some kthread_worker users that
start the worker this way. They rely on the fact that
worker->task is set also by kthread_worker_fn.

The proper solution is to start the worker using either
kthread_create_worker() or kthread_create_worker_on_cpu().
They set worker->task immediately.

It means that more work is needed:

1. Convert all users that start the kthread_worker via
   kthread_worker_fn to use either kthread_create_worker()
   or kthread_create_worker_on_cpu().

2. Remove kthread_worker_fn declaration from include/linux/kthread.h
   to prevent starting the worker the temporary way.

   In the same patch, also the assignment to worker->task and
   the FIXME might get removed from kthread_worker_fn().


3. Finally, it should be safe to add the WARN_ON() into
   queuing_blocked().

Best Regards,
Petr

> 
>  in "spi_start_queue" func:
>  "kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);"
> 
>  Becasue the kthread_worker_fn is not begin running,  if queue work to worker,
>  the "!worker->task" = true, trigger WARN.
> 
>  Are Need to add judgment " test_bit(KTHREAD_SHOULD_STOP,  &to_kthread(current)->flags) && WARN_ON(!worker->task)" in queuing_blocked func ?
> 
>  Zhang Qiang
> 
>  
> 
> 
> ________________________________________
> 发件人: kernel test robot <rong.a.chen@intel.com>
> 发送时间: 2020年7月6日 17:38
> 收件人: Zhang, Qiang
> 抄送: lkp@lists.01.org
> 主题: [kthread] a90477f0c9: WARNING:at_kernel/kthread.c:#kthread_queue_work
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: a90477f0c956621eb0dd69f0abfb6066ad8fbef7 ("kthread: work could not be queued when worker being destroyed")
> https://github.com/hnaz/linux-mm master
> 
> in testcase: trinity
> with following parameters:
> 
>         runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | 85c6127e06 | a90477f0c9 |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 6          | 0          |
> | boot_failures                                   | 0          | 30         |
> | WARNING:at_kernel/kthread.c:#kthread_queue_work | 0          | 30         |
> | EIP:kthread_queue_work                          | 0          | 30         |
> | BUG:kernel_hang_in_test_stage                   | 0          | 2          |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [    5.554282] WARNING: CPU: 0 PID: 1 at kernel/kthread.c:817 kthread_queue_work+0xf8/0x120
> [    5.556204] Modules linked in:
> [    5.556204] CPU: 0 PID: 1 Comm: swapper Tainted: G S                5.8.0-rc3-00014-ga90477f0c9566 #1
> [    5.556204] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [    5.556204] EIP: kthread_queue_work+0xf8/0x120
> [    5.556204] Code: 00 59 e9 67 ff ff ff 8d 76 00 8b 4e 10 85 c9 75 a6 8d 4b 28 89 f2 89 d8 bf 01 00 00 00 e8 f0 f5 ff ff eb 93 8d b6 00 00 00 00 <0f> 0b 6a 00 31 c9 ba 01 00 00 00 b8 08 6c 64 c3 e8 f3 04 0b 00 5b
> [    5.556204] EAX: 00000000 EBX: eeff538c ECX: 00000000 EDX: 00000001
> [    5.556204] ESI: eeff53d0 EDI: 00000000 EBP: f5edde70 ESP: f5edde5c
> [    5.556204] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
> [    5.556204] CR0: 80050033 CR2: b7eda844 CR3: 038ae000 CR4: 000406d0
> [    5.556204] Call Trace:
> [    5.556204]  spi_start_queue+0x50/0x70
> [    5.556204]  spi_register_controller+0x642/0xa80
> [    5.556204]  ? kobject_get+0x54/0xf0
> [    5.556204]  ? parport_pc_platform_probe+0x10/0x10
> [    5.556204]  spi_bitbang_start+0x2f/0x70
> [    5.556204]  ? parport_pc_platform_probe+0x10/0x10
> [    5.556204]  butterfly_attach+0x164/0x2c0
> [    5.556204]  ? driver_detach+0x30/0x30
> [    5.556204]  port_check+0x1c/0x30
> [    5.556204]  bus_for_each_dev+0x5a/0x90
> [    5.556204]  __parport_register_driver+0x76/0xa0
> [    5.556204]  ? driver_detach+0x30/0x30
> [    5.556204]  ? spi_engine_driver_init+0x16/0x16
> [    5.556204]  butterfly_init+0x19/0x1b
> [    5.556204]  do_one_initcall+0x79/0x310
> [    5.556204]  ? parse_args+0x70/0x420
> [    5.556204]  ? rcu_read_lock_sched_held+0x2f/0x50
> [    5.556204]  ? trace_initcall_level+0x95/0xc7
> [    5.556204]  ? kernel_init_freeable+0x129/0x19f
> [    5.556204]  kernel_init_freeable+0x148/0x19f
> [    5.556204]  ? rest_init+0x100/0x100
> [    5.556204]  kernel_init+0xd/0xf0
> [    5.556204]  ret_from_fork+0x1c/0x28
> [    5.556204] irq event stamp: 8620410
> [    5.556204] hardirqs last  enabled at (8620409): [<c2675daa>] _raw_spin_unlock_irqrestore+0x2a/0x50
> [    5.556204] hardirqs last disabled at (8620410): [<c2675bb4>] _raw_spin_lock_irqsave+0x14/0x40
> [    5.556204] softirqs last  enabled at (8620262): [<c2677900>] __do_softirq+0x2e0/0x480
> [    5.556204] softirqs last disabled at (8620249): [<c1023cf5>] call_on_stack+0x45/0x50
> [    5.556204] ---[ end trace 184061a442b5fd6f ]---
> 
> 
> To reproduce:
> 
>         # build kernel
>         cd linux
>         cp config-5.8.0-rc3-00014-ga90477f0c9566 .config
>         make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
