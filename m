Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704EC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32DF206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDGFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:12:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44873 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgDGFMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:12:18 -0400
X-Originating-IP: 2.7.45.25
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BDA4920007;
        Tue,  7 Apr 2020 05:12:15 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [RFC PATCH 1/7] riscv: Get rid of compile time logic with
 MAX_EARLY_MAPPING_SIZE
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     anup@brainfault.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <mhng-ee39eb13-2567-479e-b0f4-5d23dff8496c@palmerdabbelt-glaptop1>
Message-ID: <befad912-5fab-897c-48d6-9a703a6b4240@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:12:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-ee39eb13-2567-479e-b0f4-5d23dff8496c@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 11:17 AM, Palmer Dabbelt wrote:
> On Sun, 22 Mar 2020 04:00:22 PDT (-0700), alex@ghiti.fr wrote:
>> There is no need to compare at compile time MAX_EARLY_MAPPING_SIZE value
>> with PGDIR_SIZE since MAX_EARLY_MAPPING_SIZE is set to 128MB which is 
>> less
>> than PGDIR_SIZE that is equal to 1GB: that allows to simplify early_pmd
>> definition.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/mm/init.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 238bd0033c3f..18bbb426848e 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -247,13 +247,7 @@ static void __init create_pte_mapping(pte_t *ptep,
>>
>>  pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>>  pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> -
>> -#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
>> -#define NUM_EARLY_PMDS        1UL
>> -#else
>> -#define NUM_EARLY_PMDS        (1UL + MAX_EARLY_MAPPING_SIZE / 
>> PGDIR_SIZE)
>> -#endif
>> -pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata 
>> __aligned(PAGE_SIZE);
>> +pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>>
>>  static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>>  {
>> @@ -267,14 +261,12 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
>>
>>  static phys_addr_t __init alloc_pmd(uintptr_t va)
>>  {
>> -    uintptr_t pmd_num;
>> -
>>      if (mmu_enabled)
>>          return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>
>> -    pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
>> -    BUG_ON(pmd_num >= NUM_EARLY_PMDS);
>> -    return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
>> +    BUG_ON((va - PAGE_OFFSET) >> PGDIR_SHIFT);
>> +
>> +    return (uintptr_t)early_pmd;
>>  }
>>
>>  static void __init create_pmd_mapping(pmd_t *pmdp,
> 
> My specific worry here was that allyesconfig kernels are quite large, 
> and that
> dropping the code to handle large kernels would make it even harder to boot
> them.  That said, I can't actually get one to boot so I'm happy to just 
> push
> that off until later and drop the code we can't practically use.
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> Thanks!
> 

Thanks,

Alex
