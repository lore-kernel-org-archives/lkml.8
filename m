Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65376C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4BD206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440136AbgDNMkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:40:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440125AbgDNMkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:40:06 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 00FCB62405C43A7BFF93;
        Tue, 14 Apr 2020 20:40:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.49) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 20:39:54 +0800
Subject: Re: [PATCH] arm64: panic on synchronous external abort in kernel
 context
To:     James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <tglx@linutronix.de>,
        <tanxiaofei@huawei.com>, <wangxiongfeng2@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200410015245.23230-1-xiexiuqi@huawei.com>
 <20200414105923.GA2486@C02TD0UTHF1T.local>
 <adc93578-5cfc-09c3-0b88-b265e310ef97@arm.com>
From:   Xie XiuQi <xiexiuqi@huawei.com>
Message-ID: <21997719-c521-c39a-f521-54feae16fc45@huawei.com>
Date:   Tue, 14 Apr 2020 20:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <adc93578-5cfc-09c3-0b88-b265e310ef97@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.49]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2020/4/14 20:16, James Morse wrote:
> Hi Xie,
> 
> On 14/04/2020 11:59, Mark Rutland wrote:
>> On Fri, Apr 10, 2020 at 09:52:45AM +0800, Xie XiuQi wrote:
>>> We should panic even panic_on_oops is not set, when we can't recover
>>> from synchronous external abort in kernel context.
> 
> Hmm, fault-from-kernel-context doesn't mean the fault affects the kernel. If the kernel is
> reading or writing from user-space memory for a syscall, its the user-space memory that is
> affected. This thread can't make progress, so we kill it.
> If its a kernel thread or we were in irq context, we panic().
> 
> I don't think you really want all faults that happen as a result of a kernel access to be
> fatal!

Yes, you're right. I just want to fix a hung up when ras error inject testing.

panic_on_oops is not set in the kernel image for testing. When receiving a sea in kernel
context, the PE trap in do_exit(), and can't return any more.

I analyze the source code, the call trace might like this:
   do_mem_abort
     -> arm64_notify_die
        -> die                    # kernel context, call die() directly;
           -> do_exit             # kernel process context, call do_exit(SIGSEGV);
              -> do_task_dead()   # call do_task_dead(), and hung up this core;

> 
> [...]
> 
>> What exactly are you trying to catch here? If you are seeing a problem
>> in practice, can you please share your log from a crash?
> 
> Yes please!
> 

crash log:

NOTICE:  [TotemRasIntCpuNodeEri]:[1879L]
NOTICE:  [RasEriInterrupt]:[173L]NodeTYP2Status = 0x0
[  387.740609] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 9
[  387.748837] {1}[Hardware Error]: event severity: recoverable
[  387.754470] {1}[Hardware Error]:  Error 0, type: recoverable
[  387.760103] {1}[Hardware Error]:   section_type: ARM processor error
[  387.766425] {1}[Hardware Error]:   MIDR: 0x00000000481fd010
[  387.771972] {1}[Hardware Error]:   Multiprocessor Affinity Register (MPIDR): 0x0000000081080000
[  387.780628] {1}[Hardware Error]:   error affinity level: 0
[  387.786088] {1}[Hardware Error]:   running state: 0x1
[  387.791115] {1}[Hardware Error]:   Power State Coordination Interface state: 0
[  387.798301] {1}[Hardware Error]:   Error info structure 0:
[  387.803761] {1}[Hardware Error]:   num errors: 1
[  387.808356] {1}[Hardware Error]:    error_type: 0, cache error
[  387.814160] {1}[Hardware Error]:    error_info: 0x0000000024400017
[  387.820311] {1}[Hardware Error]:     transaction type: Instruction
[  387.826461] {1}[Hardware Error]:     operation type: Generic error (type cannot be determined)
[  387.835031] {1}[Hardware Error]:     cache level: 1
[  387.839878] {1}[Hardware Error]:     the error has been corrected
[  387.845942] {1}[Hardware Error]:    physical fault address: 0x00000027caf50770
[  387.853162] Internal error: synchronous external abort: 96000610 [#1] PREEMPT SMP
[  387.860611] Modules linked in: l1l2_inject(O) vfio_iommu_type1 vfio_pci vfio_virqfd vfio ib_ipoib ib_umad rpcrdma ib_iser libiscsi scsi_transport_iscsi hns_roce_hw_v2 crct10dif_ce ses hns3 hclge hnae3 hisi_trng_v2 rng_core hisi_zip hisi_sec2 hisi_hpre hisi_qm uacce hisi_sas_v3_hw hisi_sas_main libsas scsi_transport_sas
[  387.888725] CPU: 0 PID: 940 Comm: kworker/0:3 Kdump: loaded Tainted: G           O      5.5.0-rc4-g5993cbe #1
[  387.898592] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2 CS V3.B210.01 03/12/2020
[
 Message from  387.907429] Workqueue: events error_inject [l1l2_inject]
[  387.914098] pstate: 80c00009 (Nzcv daif +PAN +UAO)
 s[yslogd@localho  387.918867] pc : lsu_inj_ue+0x58/0x70 [l1l2_inject]
[  387.925103] lr : error_inject+0x64/0xb0 [l1l2_inject]
[  387.930132] sp : ffff800020af3d90
[  387.933435] x29: ffff800020af3d90 x28: 0000000000000000
st[ at Mar 30 11:  387.938723] x27: ffff0027dae6e838 x26: ffff80001178bcc8
[  387.945391] x25: 0000000000000000 x24: ffffa2c77162e090
[  387.950680] x23: 0000000000000000 x22: ffff2027d7c33d40
33[:55 ...
 ker  387.955968] x21: ffff2027d7c37a00 x20: ffff0027d679c000
[  387.962636] x19: ffffa2c77162e088 x18: 0000000020cbf59a
ne[l:Internal err  387.967924] x17: 000000000000000e x16: ffffa2c7b812bc98
[  387.974592] x15: 0000000000000001 x14: 0000000000000000
[  387.979880] x13: ffff2027cf75a780 x12: ffffa2c7b8299c18
or[: synchronous   387.985168] x11: 0000000000000000 x10: 00000000000009f0
[  387.991836] x9 : ffff800020af3d50 x8 : fefefefefefefeff
ex[ternal abort:   387.997124] x7 : 0000000000000000 x6 : 001d4ed88e000000
[  388.003792] x5 : 000073746e657665 x4 : 0000080110f81381
[  388.009080] x3 : 000000000000002f x2 : 807fffffffffffff
96[000610 [#1] PR  388.014369] x1 : ffffa2c77162c518 x0 : 0000000000000081
[  388.021037] Call trace:
EEMPT SMP
[  388.023475]  lsu_inj_ue+0x58/0x70 [l1l2_inject]
[  388.029019]  error_inject+0x64/0xb0 [l1l2_inject]
[  388.033707]  process_one_work+0x158/0x4b8
[  388.037699]  worker_thread+0x50/0x498
[  388.041348]  kthread+0xfc/0x128
[  388.044480]  ret_from_fork+0x10/0x1c
[  388.048042] Code: b2790000 d519f780 f9800020 d5033f9f (58001001)
[  388.054109] ---[ end trace 39d51c21b0e42ba6 ]---

core 0 hung up at here.

> 
> I suspect you want to make memory_failure() smarter about faults that affect the kernel
> text or data. If so, please do it in memory_failure() where it benefits all architectures,
> and all methods of reporting errors.
> (we may need a 'synchronous' hint to memory_failure(), it expects everything to be
> asynchronous).
> 
> If its not memory, we should extend the RAS handling to know what this error is, and that
> it is fatal. (e.g. PE state is infected)
> 
> 
> Thanks,
> 
> James
> .
> 

