Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28729C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DE32168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgBMDAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:00:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729546AbgBMDAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:00:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 794A93135E4076A8B01B;
        Thu, 13 Feb 2020 11:00:22 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 11:00:14 +0800
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <636f16fd-cc7b-ee2e-7496-c06bdc10c7af@huawei.com>
Date:   Thu, 13 Feb 2020 11:00:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206025825.22934-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, any comments or suggestions?

Thanks,
Jason

on 2020/2/6 10:58, Jason Yan wrote:
> This is a try to implement KASLR for Freescale BookE64 which is based on
> my earlier implementation for Freescale BookE32:
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718
> 
> The implementation for Freescale BookE64 is similar as BookE32. One
> difference is that Freescale BookE64 set up a TLB mapping of 1G during
> booting. Another difference is that ppc64 needs the kernel to be
> 64K-aligned. So we can randomize the kernel in this 1G mapping and make
> it 64K-aligned. This can save some code to creat another TLB map at
> early boot. The disadvantage is that we only have about 1G/64K = 16384
> slots to put the kernel in.
> 
>      KERNELBASE
> 
>            64K                     |--> kernel <--|
>             |                      |              |
>          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>          |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
>          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>          |                         |                        1G
>          |----->   offset    <-----|
> 
>                                kernstart_virt_addr
> 
> I'm not sure if the slot numbers is enough or the design has any
> defects. If you have some better ideas, I would be happy to hear that.
> 
> Thank you all.
> 
> v2->v3:
>    Fix build error when KASLR is disabled.
> v1->v2:
>    Add __kaslr_offset for the secondary cpu boot up.
> 
> Jason Yan (6):
>    powerpc/fsl_booke/kaslr: refactor kaslr_legal_offset() and
>      kaslr_early_init()
>    powerpc/fsl_booke/64: introduce reloc_kernel_entry() helper
>    powerpc/fsl_booke/64: implement KASLR for fsl_booke64
>    powerpc/fsl_booke/64: do not clear the BSS for the second pass
>    powerpc/fsl_booke/64: clear the original kernel if randomized
>    powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst
>      and add 64bit part
> 
>   .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 +++++++--
>   arch/powerpc/Kconfig                          |  2 +-
>   arch/powerpc/kernel/exceptions-64e.S          | 23 ++++++
>   arch/powerpc/kernel/head_64.S                 | 14 ++++
>   arch/powerpc/kernel/setup_64.c                |  4 +-
>   arch/powerpc/mm/mmu_decl.h                    | 19 ++---
>   arch/powerpc/mm/nohash/kaslr_booke.c          | 71 +++++++++++++------
>   7 files changed, 132 insertions(+), 36 deletions(-)
>   rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)
> 

