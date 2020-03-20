Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BEC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF20020663
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCTGQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:16:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12113 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgCTGQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:16:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C57286598A0FBBAB9AA;
        Fri, 20 Mar 2020 14:16:16 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 14:16:06 +0800
Subject: Re: [PATCH v4 0/6] implement KASLR for powerpc/fsl_booke/64
To:     Daniel Axtens <dja@axtens.net>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>, <oss@buserror.net>
CC:     <linux-kernel@vger.kernel.org>, <zhaohongjiang@huawei.com>
References: <20200306064033.3398-1-yanaijie@huawei.com>
 <87imizww4i.fsf@dja-thinkpad.axtens.net>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <6546b653-c7d6-41cf-3954-0587600127e3@huawei.com>
Date:   Fri, 20 Mar 2020 14:16:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <87imizww4i.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/20 11:19, Daniel Axtens 写道:
> Hi Jason,
> 
> I tried to compile this series and got the following error:
> 
> /home/dja/dev/linux/linux/arch/powerpc/mm/nohash/kaslr_booke.c: In function ‘kaslr_early_init’:
> /home/dja/dev/linux/linux/arch/powerpc/mm/nohash/kaslr_booke.c:357:33: error: ‘linear_sz’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    357 |  regions.pa_end = memstart_addr + linear_sz;
>        |                   ~~~~~~~~~~~~~~^~~~~~~~~~~
> /home/dja/dev/linux/linux/arch/powerpc/mm/nohash/kaslr_booke.c:317:21: note: ‘linear_sz’ was declared here
>    317 |  unsigned long ram, linear_sz;
>        |                     ^~~~~~~~~
> /home/dja/dev/linux/linux/arch/powerpc/mm/nohash/kaslr_booke.c:187:8: error: ‘ram’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    187 |  ret = parse_crashkernel(boot_command_line, size, &crash_size,
>        |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    188 |     &crash_base);
>        |     ~~~~~~~~~~~~
> /home/dja/dev/linux/linux/arch/powerpc/mm/nohash/kaslr_booke.c:317:16: note: ‘ram’ was declared here
>    317 |  unsigned long ram, linear_sz;
>        |                ^~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/dja/dev/linux/linux/scripts/Makefile.build:268: arch/powerpc/mm/nohash/kaslr_booke.o] Error 1
> make[3]: *** [/home/dja/dev/linux/linux/scripts/Makefile.build:505: arch/powerpc/mm/nohash] Error 2
> make[2]: *** [/home/dja/dev/linux/linux/scripts/Makefile.build:505: arch/powerpc/mm] Error 2
> make[2]: *** Waiting for unfinished jobs....
> 
> I have attached my .config file.
> 

Thanks Daniel,

My config had CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y enabled so I missed 
this warning. I will fix it.

Thanks again.

Jason

> I'm using
> powerpc64-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008
> 
> Regards,
> Daniel
> 
> 
> 
> 
>> This is a try to implement KASLR for Freescale BookE64 which is based on
>> my earlier implementation for Freescale BookE32:
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718&state=*
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
>> v3->v4:
>>    Do not define __kaslr_offset as a fixed symbol. Reference __run_at_load and
>>      __kaslr_offset by symbol instead of magic offsets.
>>    Use IS_ENABLED(CONFIG_PPC32) instead of #ifdef CONFIG_PPC32.
>>    Change kaslr-booke32 to kaslr-booke in index.rst
>>    Switch some instructions to 64-bit.
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
>>   Documentation/powerpc/index.rst               |  2 +-
>>   .../{kaslr-booke32.rst => kaslr-booke.rst}    | 35 +++++++-
>>   arch/powerpc/Kconfig                          |  2 +-
>>   arch/powerpc/kernel/exceptions-64e.S          | 23 +++++
>>   arch/powerpc/kernel/head_64.S                 | 13 +++
>>   arch/powerpc/kernel/setup_64.c                |  3 +
>>   arch/powerpc/mm/mmu_decl.h                    | 23 ++---
>>   arch/powerpc/mm/nohash/kaslr_booke.c          | 88 +++++++++++++------
>>   8 files changed, 144 insertions(+), 45 deletions(-)
>>   rename Documentation/powerpc/{kaslr-booke32.rst => kaslr-booke.rst} (59%)
>>
>> -- 
>> 2.17.2

