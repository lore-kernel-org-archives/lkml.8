Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC2C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7D22084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBZISq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:18:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbgBZISp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:18:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4AFED4A428E75A358071;
        Wed, 26 Feb 2020 16:18:37 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 16:18:29 +0800
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
To:     Daniel Axtens <dja@axtens.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
 <87tv3drf79.fsf@dja-thinkpad.axtens.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
Date:   Wed, 26 Feb 2020 16:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <87tv3drf79.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

ÔÚ 2020/2/26 15:16, Daniel Axtens Ð´µÀ:
> Hi Jason,
> 
>> This is a try to implement KASLR for Freescale BookE64 which is based on
>> my earlier implementation for Freescale BookE32:
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718
>>
>> The implementation for Freescale BookE64 is similar as BookE32. One
>> difference is that Freescale BookE64 set up a TLB mapping of 1G during
>> booting. Another difference is that ppc64 needs the kernel to be
>> 64K-aligned. So we can randomize the kernel in this 1G mapping and make
>> it 64K-aligned. This can save some code to creat another TLB map at
>> early boot. The disadvantage is that we only have about 1G/64K = 16384
>> slots to put the kernel in.
>>
>>      KERNELBASE
>>
>>            64K                     |--> kernel <--|
>>             |                      |              |
>>          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>>          |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
>>          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>>          |                         |                        1G
>>          |----->   offset    <-----|
>>
>>                                kernstart_virt_addr
>>
>> I'm not sure if the slot numbers is enough or the design has any
>> defects. If you have some better ideas, I would be happy to hear that.
>>
>> Thank you all.
>>
> 
> Are you making any attempt to hide kernel address leaks in this series?

Yes.

> I've just been looking at the stackdump code just now, and it directly
> prints link registers and stack pointers, which is probably enough to
> determine the kernel base address:
> 
>                    SPs:               LRs:             %pS pointer
> [    0.424506] [c0000000de403970] [c000000001fc0458] dump_stack+0xfc/0x154 (unreliable)
> [    0.424593] [c0000000de4039c0] [c000000000267eec] panic+0x258/0x5ac
> [    0.424659] [c0000000de403a60] [c0000000024d7a00] mount_block_root+0x634/0x7c0
> [    0.424734] [c0000000de403be0] [c0000000024d8100] prepare_namespace+0x1ec/0x23c
> [    0.424811] [c0000000de403c60] [c0000000024d7010] kernel_init_freeable+0x804/0x880
> 
> git grep \\\"REG\\\" arch/powerpc shows a few other uses like this, all
> in process.c or in xmon.
> 

Thanks for reminding this.

> Maybe replacing the REG format string in KASLR mode would be sufficient?
> 

Most archs have removed the address printing when dumping stack. Do we 
really have to print this?

If we have to do this, maybe we can use "%pK" so that they will be 
hidden from unprivileged users.

Thanks,
Jason

> Regards,
> Daniel
> 
> 
>> v2->v3:
>>    Fix build error when KASLR is disabled.
>> v1->v2:
>>    Add __kaslr_offset for the secondary cpu boot up.
>>
>> Jason Yan (6):
>>    powerpc/fsl_booke/kaslr: refactor kaslr_legal_offset() and
>>      kaslr_early_init()
>>    powerpc/fsl_booke/64: introduce reloc_kernel_entry() helper
>>    powerpc/fsl_booke/64: implement KASLR for fsl_booke64
>>    powerpc/fsl_booke/64: do not clear the BSS for the second pass
>>    powerpc/fsl_booke/64: clear the original kernel if randomized
>>    powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst
>>      and add 64bit part
>>
>>   .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 +++++++--
>>   arch/powerpc/Kconfig                          |  2 +-
>>   arch/powerpc/kernel/exceptions-64e.S          | 23 ++++++
>>   arch/powerpc/kernel/head_64.S                 | 14 ++++
>>   arch/powerpc/kernel/setup_64.c                |  4 +-
>>   arch/powerpc/mm/mmu_decl.h                    | 19 ++---
>>   arch/powerpc/mm/nohash/kaslr_booke.c          | 71 +++++++++++++------
>>   7 files changed, 132 insertions(+), 36 deletions(-)
>>   rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)
>>
>> -- 
>> 2.17.2
> 
> .
> 

