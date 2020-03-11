Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0C3C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0C220873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgCKJDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:03:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgCKJDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:03:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CFB36B2B86B8CAE8920D;
        Wed, 11 Mar 2020 17:02:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 Mar
 2020 17:02:11 +0800
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200224135837.k54ke4ppca26ibec@core.my.home>
 <20200224140349.74yagjdwewmclx4v@core.my.home>
 <20200224143149.au6hvmmfw4ajsq2g@core.my.home>
 <39712bf4-210b-d7b6-cbb1-eb57585d991a@huawei.com>
 <20200225120814.gjm4dby24cs22lux@core.my.home>
 <20200225122706.d6pngz62iwyowhym@core.my.home>
 <72d28eba-53b9-b6f4-01a5-45b2352f4285@huawei.com>
 <20200226121143.uag224cqzqossvlv@core.my.home>
 <20200226180557.le2fr66fyuvrqker@core.my.home>
 <7b62f506-f737-9fb2-6e8e-4b1c454f03b2@huawei.com>
 <20200306120203.2p34ezryzxb2jeuk@core.my.home>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0ce08d13-ca00-2823-94eb-8274c332a8ef@huawei.com>
Date:   Wed, 11 Mar 2020 17:02:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200306120203.2p34ezryzxb2jeuk@core.my.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the delay.

On 2020/3/6 20:02, Ondřej Jirman wrote:
> Hello,
> 
> On Thu, Feb 27, 2020 at 10:01:50AM +0800, Chao Yu wrote:
>> On 2020/2/27 2:05, Ondřej Jirman wrote:
>>>
>>> No issue after 7h uptime either. So I guess this patch solved it for some
>>> reason.
>>
>> I hope so as well, I will send a formal patch for this.
> 
> So I had it happen again, even with the patches. This time in f2fs_rename2:

Oops, it looks previous fix patch just cover the root cause... :(

Did this issue still happen frequently? If it is, would you please apply patch
that prints log during down/up semaphore.

And once we revert compression support patch, this issue will disappear, right?

Btw, did you try other hardware which is not Arm v7?

Thanks,

> 
> regards,
> 	o.
> 
>  INFO: task ldconfig:620 blocked for more than 122 seconds.
>       Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> ldconfig        D    0   620    441 0x00000001
> Backtrace: 
> [<c0913190>] (__schedule) from [<c0913834>] (schedule+0x78/0xf4)
>  r10:e587a000 r9:00000000 r8:e587bd80 r7:ee687eb8 r6:00000002 r5:e587a000
>  r4:ee8c8000
> [<c09137bc>] (schedule) from [<c017ec6c>] (rwsem_down_write_slowpath+0x24c/0x4c0)
>  r5:00000001 r4:ee687ea8
> [<c017ea20>] (rwsem_down_write_slowpath) from [<c091652c>] (down_write+0x6c/0x70)
>  r10:ee687d08 r9:e5131170 r8:ee0f0000 r7:ee687ea8 r6:e587be10 r5:ee685740
>  r4:ee687ea8
> [<c09164c0>] (down_write) from [<c04149ac>] (f2fs_rename2+0x1a0/0x1114)
>  r5:ee685740 r4:ee685740
> [<c041480c>] (f2fs_rename2) from [<c02ea5a8>] (vfs_rename+0x434/0x838)
>  r10:c041480c r9:e5131170 r8:ee687d08 r7:ee685740 r6:eed21440 r5:00000000
>  r4:eecb82a8
> [<c02ea174>] (vfs_rename) from [<c02ed764>] (do_renameat2+0x310/0x494)
>  r10:eea4c000 r9:00000000 r8:e587bf50 r7:eed21440 r6:00000000 r5:ffffffd9
>  r4:eea4d000
> [<c02ed454>] (do_renameat2) from [<c02eec20>] (sys_rename+0x34/0x3c)
>  r10:00000026 r9:e587a000 r8:c0101204 r7:00000026 r6:00007458 r5:000dac90
>  r4:00000003
> [<c02eebec>] (sys_rename) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0xe587bfa8 to 0xe587bff0)
> bfa0:                   00000003 000dac90 000dac90 be9e1540 0000c7d5 00000000
> bfc0: 00000003 000dac90 00007458 00000026 0000c7d5 00000001 000cd60c be9e1534
> bfe0: 00000025 be9e14cc 00014120 0001fd00
> NMI backtrace for cpu 3
> CPU: 3 PID: 53 Comm: khungtaskd Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:600b0013 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0901a5c>] (nmi_cpu_backtrace+0x98/0xcc)
>  r7:00000000 r6:00000003 r5:00000000 r4:00000003
> [<c09019c4>] (nmi_cpu_backtrace) from [<c0901b84>] (nmi_trigger_cpumask_backtrace+0xf4/0x138)
>  r5:c0e08498 r4:c010ea5c
> [<c0901a90>] (nmi_trigger_cpumask_backtrace) from [<c0110334>] (arch_trigger_cpumask_backtrace+0x20/0x24)
>  r7:0008908a r6:c0e08c50 r5:00007f84 r4:ef19b674
> [<c0110314>] (arch_trigger_cpumask_backtrace) from [<c01de160>] (watchdog+0x334/0x540)
> [<c01dde2c>] (watchdog) from [<c01564f4>] (kthread+0x144/0x170)
>  r10:ef0f7e60 r9:ef3a64dc r8:00000000 r7:ee85c000 r6:00000000 r5:ee806040
>  r4:ef3a64c0
> [<c01563b0>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xee85dfb0 to 0xee85dff8)
> dfa0:                                     00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01563b0
>  r4:ee806040
> Sending NMI from CPU 3 to CPUs 0-2,4-7:
> NMI backtrace for cpu 2
> CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60030013
> sp : ef135f68  ip : ef135f78  fp : ef135f74
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000002  r4 : ef134000
> r3 : c011ab00  r2 : ef672d70  r1 : 0004ea3c  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6d87406a  DAC: 00000051
> CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60030193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:ef135f18 r4:00000002
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:ef135f18 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef134000 r8:ef135f18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef135f18 to 0xef135f60)
> 5f00:                                                       00000000 0004ea3c
> 5f20: ef672d70 c011ab00 ef134000 00000002 c0e04e64 c0e04ea4 c0d82830 00000000
> 5f40: 00000000 ef135f74 ef135f78 ef135f68 c0109844 c0109848 60030013 ffffffff
>  r9:ef134000 r8:c0d82830 r7:ef135f4c r6:ffffffff r5:60030013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000002
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> NMI backtrace for cpu 1
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60000013
> sp : ef133f68  ip : ef133f78  fp : ef133f74
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000001  r4 : ef132000
> r3 : c011ab00  r2 : ef65ed70  r1 : 0004ed5c  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6de3806a  DAC: 00000051
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:ef133f18 r4:00000001
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:ef133f18 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef132000 r8:ef133f18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef133f18 to 0xef133f60)
> 3f00:                                                       00000000 0004ed5c
> 3f20: ef65ed70 c011ab00 ef132000 00000001 c0e04e64 c0e04ea4 c0d82830 00000000
> 3f40: 00000000 ef133f74 ef133f78 ef133f68 c0109844 c0109848 60000013 ffffffff
>  r9:ef132000 r8:c0d82830 r7:ef133f4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000001
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> NMI backtrace for cpu 0
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60000013
> sp : c0e01f08  ip : c0e01f18  fp : c0e01f14
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000000  r4 : c0e00000
> r3 : c011ab00  r2 : ef64ad70  r1 : 002da988  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6cbc406a  DAC: 00000051
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:c0e01eb8 r4:00000000
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:c0e01eb8 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:c0e00000 r8:c0e01eb8 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xc0e01eb8 to 0xc0e01f00)
> 1ea0:                                                       00000000 002da988
> 1ec0: ef64ad70 c011ab00 c0e00000 00000000 c0e04e64 c0e04ea4 c0d82830 00000000
> 1ee0: 00000000 c0e01f14 c0e01f18 c0e01f08 c0109844 c0109848 60000013 ffffffff
>  r9:c0e00000 r8:c0d82830 r7:c0e01eec r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:c0d47f38 r9:efffcd40 r8:00000089 r7:c0ead210 r6:00000000 r5:c0d47f38
>  r4:000000d1
> [<c0165c7c>] (cpu_startup_entry) from [<c091245c>] (rest_init+0xb4/0xbc)
> [<c09123a8>] (rest_init) from [<c0d00c78>] (arch_call_rest_init+0x18/0x1c)
>  r5:c0d47f38 r4:c0ead1c0
> [<c0d00c60>] (arch_call_rest_init) from [<c0d013e8>] (start_kernel+0x6f4/0x714)
> [<c0d00cf4>] (start_kernel) from [<00000000>] (0x0)
> NMI backtrace for cpu 5
> CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60000013
> sp : ef13bf68  ip : ef13bf78  fp : ef13bf74
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000005  r4 : ef13a000
> r3 : c011ab00  r2 : ef6aed70  r1 : 00064604  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6dd8806a  DAC: 00000051
> CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:ef13bf18 r4:00000005
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:ef13bf18 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef13a000 r8:ef13bf18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef13bf18 to 0xef13bf60)
> bf00:                                                       00000000 00064604
> bf20: ef6aed70 c011ab00 ef13a000 00000005 c0e04e64 c0e04ea4 c0d82830 00000000
> bf40: 00000000 ef13bf74 ef13bf78 ef13bf68 c0109844 c0109848 60000013 ffffffff
>  r9:ef13a000 r8:c0d82830 r7:ef13bf4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000005
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> NMI backtrace for cpu 4
> CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60000013
> sp : ef139f68  ip : ef139f78  fp : ef139f74
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000004  r4 : ef138000
> r3 : c011ab00  r2 : ef69ad70  r1 : 0007c518  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6def806a  DAC: 00000051
> CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:ef139f18 r4:00000004
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:ef139f18 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef138000 r8:ef139f18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef139f18 to 0xef139f60)
> 9f00:                                                       00000000 0007c518
> 9f20: ef69ad70 c011ab00 ef138000 00000004 c0e04e64 c0e04ea4 c0d82830 00000000
> 9f40: 00000000 ef139f74 ef139f78 ef139f68 c0109844 c0109848 60000013 ffffffff
>  r9:ef138000 r8:c0d82830 r7:ef139f4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000004
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> NMI backtrace for cpu 7
> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60000013
> sp : ef13ff68  ip : ef13ff78  fp : ef13ff74
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000007  r4 : ef13e000
> r3 : c011ab00  r2 : ef6d6d70  r1 : 00028058  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6c5e006a  DAC: 00000051
> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:ef13ff18 r4:00000007
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:ef13ff18 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef13e000 r8:ef13ff18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef13ff18 to 0xef13ff60)
> ff00:                                                       00000000 00028058
> ff20: ef6d6d70 c011ab00 ef13e000 00000007 c0e04e64 c0e04ea4 c0d82830 00000000
> ff40: 00000000 ef13ff74 ef13ff78 ef13ff68 c0109844 c0109848 60000013 ffffffff
>  r9:ef13e000 r8:c0d82830 r7:ef13ff4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000007
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> NMI backtrace for cpu 6
> CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> PC is at arch_cpu_idle+0x48/0x4c
> LR is at arch_cpu_idle+0x44/0x4c
> pc : [<c0109848>]    lr : [<c0109844>]    psr: 60010013
> sp : ef13df68  ip : ef13df78  fp : ef13df74
> r10: 00000000  r9 : 00000000  r8 : c0d82830
> r7 : c0e04ea4  r6 : c0e04e64  r5 : 00000006  r4 : ef13c000
> r3 : c011ab00  r2 : ef6c2d70  r1 : 00081da8  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 6565006a  DAC: 00000051
> CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60010193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0109ae0>] (show_regs+0x1c/0x20)
>  r7:00000000 r6:00000007 r5:ef13df18 r4:00000006
> [<c0109ac4>] (show_regs) from [<c0901a8c>] (nmi_cpu_backtrace+0xc8/0xcc)
> [<c09019c4>] (nmi_cpu_backtrace) from [<c010fca8>] (handle_IPI+0x64/0x37c)
>  r5:ef13df18 r4:c0d83110
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef13c000 r8:ef13df18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef13df18 to 0xef13df60)
> df00:                                                       00000000 00081da8
> df20: ef6c2d70 c011ab00 ef13c000 00000006 c0e04e64 c0e04ea4 c0d82830 00000000
> df40: 00000000 ef13df74 ef13df78 ef13df68 c0109844 c0109848 60010013 ffffffff
>  r9:ef13c000 r8:c0d82830 r7:ef13df4c r6:ffffffff r5:60010013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000006
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> Kernel panic - not syncing: hung_task: blocked tasks
> CPU: 3 PID: 53 Comm: khungtaskd Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:0008908a r6:600b0093 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c0131fcc>] (panic+0x108/0x310)
>  r7:0008908a r6:c0e08c50 r5:00000000 r4:c0eadbc8
> [<c0131ec4>] (panic) from [<c01de16c>] (watchdog+0x340/0x540)
>  r3:c0f0dd60 r2:00000001 r1:00000000 r0:c0b49e00
>  r7:0008908a
> [<c01dde2c>] (watchdog) from [<c01564f4>] (kthread+0x144/0x170)
>  r10:ef0f7e60 r9:ef3a64dc r8:00000000 r7:ee85c000 r6:00000000 r5:ee806040
>  r4:ef3a64c0
> [<c01563b0>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xee85dfb0 to 0xee85dff8)
> dfa0:                                     00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01563b0
>  r4:ee806040
> CPU1: stopping
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef132000 r8:ef133f18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef133f18 to 0xef133f60)
> 3f00:                                                       00000000 000509b4
> 3f20: ef65ed70 c011ab00 ef132000 00000001 c0e04e64 c0e04ea4 c0d82830 00000000
> 3f40: 00000000 ef133f74 ef133f78 ef133f68 c0109844 c0109848 60000013 ffffffff
>  r9:ef132000 r8:c0d82830 r7:ef133f4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000001
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> CPU2: stopping
> CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60030193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef134000 r8:ef135f18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef135f18 to 0xef135f60)
> 5f00:                                                       00000000 0004f168
> 5f20: ef672d70 c011ab00 ef134000 00000002 c0e04e64 c0e04ea4 c0d82830 00000000
> 5f40: 00000000 ef135f74 ef135f78 ef135f68 c0109844 c0109848 60030013 ffffffff
>  r9:ef134000 r8:c0d82830 r7:ef135f4c r6:ffffffff r5:60030013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000002
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> CPU4: stopping
> CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef138000 r8:ef139f18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef139f18 to 0xef139f60)
> 9f00:                                                       00000000 0007c528
> 9f20: ef69ad70 c011ab00 ef138000 00000004 c0e04e64 c0e04ea4 c0d82830 00000000
> 9f40: 00000000 ef139f74 ef139f78 ef139f68 c0109844 c0109848 60000013 ffffffff
>  r9:ef138000 r8:c0d82830 r7:ef139f4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000004
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> CPU5: stopping
> CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef13a000 r8:ef13bf18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef13bf18 to 0xef13bf60)
> bf00:                                                       00000000 00064644
> bf20: ef6aed70 c011ab00 ef13a000 00000005 c0e04e64 c0e04ea4 c0d82830 00000000
> bf40: 00000000 ef13bf74 ef13bf78 ef13bf68 c0109844 c0109848 60000013 ffffffff
>  r9:ef13a000 r8:c0d82830 r7:ef13bf4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000005
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> CPU6: stopping
> CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60010193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef13c000 r8:ef13df18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef13df18 to 0xef13df60)
> df00:                                                       00000000 00081fa8
> df20: ef6c2d70 c011ab00 ef13c000 00000006 c0e04e64 c0e04ea4 c0d82830 00000000
> df40: 00000000 ef13df74 ef13df78 ef13df68 c0109844 c0109848 60010013 ffffffff
>  r9:ef13c000 r8:c0d82830 r7:ef13df4c r6:ffffffff r5:60010013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000006
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> CPU7: stopping
> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:ef13e000 r8:ef13ff18 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xef13ff18 to 0xef13ff60)
> ff00:                                                       00000000 00028068
> ff20: ef6d6d70 c011ab00 ef13e000 00000007 c0e04e64 c0e04ea4 c0d82830 00000000
> ff40: 00000000 ef13ff74 ef13ff78 ef13ff68 c0109844 c0109848 60000013 ffffffff
>  r9:ef13e000 r8:c0d82830 r7:ef13ff4c r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:00000000 r9:410fc075 r8:4000406a r7:c0ead5c0 r6:10c0387d r5:00000007
>  r4:0000008d
> [<c0165c7c>] (cpu_startup_entry) from [<c010f4c0>] (secondary_start_kernel+0x158/0x164)
> [<c010f368>] (secondary_start_kernel) from [<4010280c>] (0x4010280c)
>  r5:00000051 r4:6f12806a
> CPU0: stopping
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc3-00469-g44d686977effa #48
> Hardware name: Allwinner A83t board
> Backtrace: 
> [<c010db14>] (dump_backtrace) from [<c010de98>] (show_stack+0x20/0x24)
>  r7:00000000 r6:60000193 r5:00000000 r4:c0e9ab90
> [<c010de78>] (show_stack) from [<c08fabbc>] (dump_stack+0x98/0xac)
> [<c08fab24>] (dump_stack) from [<c010ff88>] (handle_IPI+0x344/0x37c)
>  r7:00000000 r6:00000004 r5:c0e05358 r4:c0ead5b0
> [<c010fc44>] (handle_IPI) from [<c01023d0>] (gic_handle_irq+0x84/0x88)
>  r10:00000000 r9:c0e00000 r8:c0e01eb8 r7:f0803000 r6:f0802000 r5:f080200c
>  r4:c0e0565c r3:c0109844
> [<c010234c>] (gic_handle_irq) from [<c0101acc>] (__irq_svc+0x6c/0x90)
> Exception stack(0xc0e01eb8 to 0xc0e01f00)
> 1ea0:                                                       00000000 002dadd8
> 1ec0: ef64ad70 c011ab00 c0e00000 00000000 c0e04e64 c0e04ea4 c0d82830 00000000
> 1ee0: 00000000 c0e01f14 c0e01f18 c0e01f08 c0109844 c0109848 60000013 ffffffff
>  r9:c0e00000 r8:c0d82830 r7:c0e01eec r6:ffffffff r5:60000013 r4:c0109848
> [<c0109800>] (arch_cpu_idle) from [<c0918444>] (default_idle_call+0x30/0x3c)
> [<c0918414>] (default_idle_call) from [<c016595c>] (do_idle+0x218/0x290)
> [<c0165744>] (do_idle) from [<c0165ca4>] (cpu_startup_entry+0x28/0x2c)
>  r10:c0d47f38 r9:efffcd40 r8:00000089 r7:c0ead210 r6:00000000 r5:c0d47f38
>  r4:000000d1
> [<c0165c7c>] (cpu_startup_entry) from [<c091245c>] (rest_init+0xb4/0xbc)
> [<c09123a8>] (rest_init) from [<c0d00c78>] (arch_call_rest_init+0x18/0x1c)
>  r5:c0d47f38 r4:c0ead1c0
> [<c0d00c60>] (arch_call_rest_init) from [<c0d013e8>] (start_kernel+0x6f4/0x714)
> [<c0d00cf4>] (start_kernel) from [<00000000>] (0x0)
> Rebooting in 3 seconds..
> DRAM: 1024 MiB
> Trying to boot from MMC1
> 
> .
> 
