Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550DAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B422206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgEVIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 04:07:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42336 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728152AbgEVIHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 04:07:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 03A2323164A41ED81F03;
        Fri, 22 May 2020 16:07:20 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 May 2020
 16:07:15 +0800
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
To:     Will Deacon <will@kernel.org>, <lorenzo.pieralisi@arm.com>
CC:     <rjw@rjwysocki.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
References: <20200521100952.GA5360@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ad521a36-c080-f761-e91b-dc38b8af08ee@huawei.com>
Date:   Fri, 22 May 2020 16:07:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200521100952.GA5360@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/5/21 18:09, Will Deacon wrote:
> Hi folks,
> 
> I just tried booting the arm64 for-kernelci branch under QEMU (version
> 4.2.50 (v4.2.0-779-g4354edb6dcc7)) with UBSAN enabled, and I see a couple
> of NULL pointer dereferences reported at boot. I think they're both GIC
> related (log below). I don't see a panic with UBSAN disabled, so something's
> fishy here.
> 
> Please can you take a look when you get a chance? I haven't had time to see
> if this is a regression or not, but I don't think it's particularly serious
> as I have all sorts of horrible stuff enabled in my .config, since I'm
> trying to chase down another bug:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/plain/arch/arm64/configs/fuzzing.config?h=fuzzing/arm64-kernelci-20200519&id=c149cf6a51aa4f72d53fc681c6661094e93ef660
> 
> (on top of defconfig)
> 
> CONFIG_FAIL_PAGE_ALLOC may be to blame.

I enabled UBSAN and CONFIG_FAIL_PAGE_ALLOC on top of defconfig,
testing against the for-kernelci branch on the D06 board, I
can see some UBSAN warnings from megaraid_sas driver [0], but not
from any other subsystem including ACPI, I will try all your
configs above to see if I can get more warnings.

Thanks
Hanjun

[0]:
[   18.244272] 
================================================================================
[   18.252673] UBSAN: array-index-out-of-bounds in 
drivers/scsi/megaraid/megaraid_sas_fp.c:104:32
[   18.261244] index 1 is out of range for type 'MR_LD_SPAN_MAP [1]'
[   18.267313] CPU: 0 PID: 656 Comm: kworker/0:1 Not tainted 
5.7.0-rc6-1-14703-gf4582661223d-dirty #20
[   18.276314] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V3.B210.01 03/12/2020
[   18.285151] Workqueue: events work_for_cpu_fn
[   18.289488] Call trace:
[   18.291925]  dump_backtrace+0x0/0x248
[   18.295572]  show_stack+0x18/0x28
[   18.298873]  dump_stack+0xc0/0x10c
[   18.302261]  ubsan_epilogue+0x10/0x58
[   18.305905]  __ubsan_handle_out_of_bounds+0x8c/0xa8
[   18.310763]  mr_update_load_balance_params+0x118/0x120
[   18.315877]  MR_ValidateMapInfo+0x300/0xb00
[   18.320040]  megasas_get_map_info+0x134/0x1f8
[   18.324377]  megasas_init_adapter_fusion+0xba8/0x10a0
[   18.329403]  megasas_probe_one+0x6e0/0x1b70
[   18.333569]  local_pci_probe+0x40/0xb0
[   18.337299]  work_for_cpu_fn+0x1c/0x30
[   18.341031]  process_one_work+0x1f8/0x378
[   18.345022]  worker_thread+0x21c/0x4c0
[   18.348753]  kthread+0x150/0x158
[   18.351967]  ret_from_fork+0x10/0x18
[   18.355529] 
================================================================================

[   18.592274] 
================================================================================
[   18.600672] UBSAN: array-index-out-of-bounds in 
drivers/scsi/megaraid/megaraid_sas_fp.c:141:9
[   18.609155] index 1 is out of range for type 'MR_LD_SPAN_MAP [1]'
[   18.615221] CPU: 0 PID: 656 Comm: kworker/0:1 Not tainted 
5.7.0-rc6-1-14703-gf4582661223d-dirty #20
[   18.624222] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
2280-V2 CS V3.B210.01 03/12/2020
[   18.633050] Workqueue: events work_for_cpu_fn
[   18.637387] Call trace:
[   18.639822]  dump_backtrace+0x0/0x248
[   18.643467]  show_stack+0x18/0x28
[   18.646767]  dump_stack+0xc0/0x10c
[   18.650152]  ubsan_epilogue+0x10/0x58
[   18.653796]  __ubsan_handle_out_of_bounds+0x8c/0xa8
[   18.658652]  MR_GetLDTgtId+0x58/0x60
[   18.662211]  megasas_sync_map_info+0xd0/0x1c0
[   18.666547]  megasas_init_adapter_fusion+0xd60/0x10a0
[   18.671574]  megasas_probe_one+0x6e0/0x1b70
[   18.675736]  local_pci_probe+0x40/0xb0
[   18.679466]  work_for_cpu_fn+0x1c/0x30
[   18.683197]  process_one_work+0x1f8/0x378
[   18.687188]  worker_thread+0x21c/0x4c0
[   18.690920]  kthread+0x150/0x158
[   18.694123]  ret_from_fork+0x10/0x18
[   18.697683] 
================================================================================

