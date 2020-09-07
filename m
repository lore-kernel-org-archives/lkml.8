Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E36BC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AAC208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIGIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:12:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37580 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgIGILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:11:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BlLZg2H9Mz9v0xg;
        Mon,  7 Sep 2020 10:11:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QumHwXbMT3sE; Mon,  7 Sep 2020 10:11:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BlLZf6Z4mz9v0xb;
        Mon,  7 Sep 2020 10:11:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DFDE98B77F;
        Mon,  7 Sep 2020 10:11:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fm4wLaGXinXK; Mon,  7 Sep 2020 10:11:11 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 812A08B787;
        Mon,  7 Sep 2020 10:11:11 +0200 (CEST)
Subject: Re: [PATCH -next] powerpc/book3s64: fix link error with
 CONFIG_PPC_RADIX_MMU=n
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200905112548.3265530-1-yangyingliang@huawei.com>
 <39a976b8-896c-e878-bac7-50bbf3ccbc4f@csgroup.eu>
 <af37c513-6232-c35c-33e3-f6d8d82c8175@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <88101db4-a1bb-6a6d-521e-84dcec8b44d0@csgroup.eu>
Date:   Mon, 7 Sep 2020 10:11:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <af37c513-6232-c35c-33e3-f6d8d82c8175@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/09/2020 à 03:51, Yang Yingliang a écrit :
> 
> On 2020/9/6 14:50, Christophe Leroy wrote:
>>
>>
>> Le 05/09/2020 à 13:25, Yang Yingliang a écrit :
>>> Fix link error when CONFIG_PPC_RADIX_MMU is disabled:
>>> powerpc64-linux-gnu-ld: 
>>> arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference 
>>> to `mmu_pid_bits'
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   arch/powerpc/mm/book3s64/mmu_context.c | 4 ++++
>>
>> In your commit log, you are just mentionning 
>> arch/powerpc/platforms/pseries/lpar.o, which is right.
>>
>> You shouldn't need to modify arch/powerpc/mm/book3s64/mmu_context.c at 
>> all, see below.
>>
>>>   arch/powerpc/platforms/pseries/lpar.c  | 2 ++
>>>   2 files changed, 6 insertions(+)
>>>
>>> diff --git a/arch/powerpc/mm/book3s64/mmu_context.c 
>>> b/arch/powerpc/mm/book3s64/mmu_context.c
>>> index 0ba30b8b935b..a8e292cd88f0 100644
>>> --- a/arch/powerpc/mm/book3s64/mmu_context.c
>>> +++ b/arch/powerpc/mm/book3s64/mmu_context.c
>>> @@ -152,6 +152,7 @@ void hash__setup_new_exec(void)
>>>     static int radix__init_new_context(struct mm_struct *mm)
>>>   {
>>> +#ifdef CONFIG_PPC_RADIX_MMU
>>
>> This shouldn't be required. radix__init_new_context() is only called 
>> when radix_enabled() returns true.
>> As it is a static function, when it is not called it gets optimised 
>> away, so you will never get an undefined reference to `mmu_pid_bits` 
>> there.
> powerpc64-linux-gnu-ld: 
> arch/powerpc/mm/book3s64/mmu_context.o:(.toc+0x0): undefined reference 
> to `mmu_pid_bits'
> powerpc64-linux-gnu-ld: 
> arch/powerpc/mm/book3s64/mmu_context.o:(.toc+0x8): undefined reference 
> to `mmu_base_pid'
> 
> 
> mmu_context.c is always compiled, it uses mmu_pid_bits and mmu_base_pid.

Yes, mmu_context.c is always compiled, but as I explained, 
radix__init_new_context() is defined as 'static' so it is optimised out 
when radix_enabled() returns false because there is no caller in that case.

I just made the test with ppc64_defconfig + CONFIG_PPC_RADIX_MMU=n (GCC 8.1)

The only failure I got was on lpar.c, which I fixed by enclosing the 
entire radix_init_pseries() in an #ifdef.

Once this is fixed, the build is OK, without any modification to 
mmu_context.c

powerpc64-linux-objdump -x arch/powerpc/mm/book3s64/mmu_context.o shows 
only the following objects in the .toc:

RELOCATION RECORDS FOR [.toc]:
OFFSET           TYPE              VALUE
0000000000000000 R_PPC64_ADDR64    kmalloc_caches
0000000000000008 R_PPC64_ADDR64    vmemmap
0000000000000010 R_PPC64_ADDR64    __pmd_frag_nr
0000000000000018 R_PPC64_ADDR64    __pmd_frag_size_shift

mmu_pid_bits and mmu_base_pid are not part of the undefined objetcs:

0000000000000000         *UND*	0000000000000000 vmemmap
0000000000000000         *UND*	0000000000000000 .mm_iommu_init
0000000000000000         *UND*	0000000000000000 __pmd_frag_nr
0000000000000000         *UND*	0000000000000000 .ida_alloc_range
0000000000000000         *UND*	0000000000000000 .slb_setup_new_exec
0000000000000000         *UND*	0000000000000000 mmu_feature_keys
0000000000000000         *UND*	0000000000000000 .memset
0000000000000000         *UND*	0000000000000000 .memcpy
0000000000000000         *UND*	0000000000000000 .slice_init_new_context_exec
0000000000000000         *UND*	0000000000000000 ._mcount
0000000000000000         *UND*	0000000000000000 .__free_pages
0000000000000000         *UND*	0000000000000000 __pmd_frag_size_shift
0000000000000000         *UND*	0000000000000000 .slice_setup_new_exec
0000000000000000         *UND*	0000000000000000 .ida_free
0000000000000000         *UND*	0000000000000000 .pte_frag_destroy
0000000000000000         *UND*	0000000000000000 .kfree
0000000000000000         *UND*	0000000000000000 .pkey_mm_init
0000000000000000         *UND*	0000000000000000 .kmem_cache_alloc_trace
0000000000000000         *UND*	0000000000000000 .__warn_printk
0000000000000000         *UND*	0000000000000000 _mcount
0000000000000000         *UND*	0000000000000000 kmalloc_caches

Christophe
