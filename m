Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C74C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5181D206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDGFMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:12:35 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:3363 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgDGFMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:12:35 -0400
X-Originating-IP: 2.7.45.25
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BE671240004;
        Tue,  7 Apr 2020 05:12:31 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [RFC PATCH 2/7] riscv: Allow to dynamically define VA_BITS
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-1f8477e3-7cb4-454f-b443-8cf032325385@palmerdabbelt-glaptop1>
Message-ID: <8922d36f-1b4e-0575-33e7-197e3f0b3817@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:12:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-1f8477e3-7cb4-454f-b443-8cf032325385@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/20 11:17 AM, Palmer Dabbelt wrote:
> On Sun, 22 Mar 2020 04:00:23 PDT (-0700), alex@ghiti.fr wrote:
>> With 4-level page table folding at runtime, we don't know at compile time
>> the size of the virtual address space so we must set VA_BITS dynamically
>> so that sparsemem reserves the right amount of memory for struct pages.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/Kconfig                 | 10 ----------
>>  arch/riscv/include/asm/pgtable.h   | 10 +++++++++-
>>  arch/riscv/include/asm/sparsemem.h |  2 +-
>>  3 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index f5f3d474504d..8e4b1cbcf2c2 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -99,16 +99,6 @@ config ZONE_DMA32
>>      bool
>>      default y if 64BIT
>>
>> -config VA_BITS
>> -    int
>> -    default 32 if 32BIT
>> -    default 39 if 64BIT
>> -
>> -config PA_BITS
>> -    int
>> -    default 34 if 32BIT
>> -    default 56 if 64BIT
>> -
>>  config PAGE_OFFSET
>>      hex
>>      default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>> diff --git a/arch/riscv/include/asm/pgtable.h 
>> b/arch/riscv/include/asm/pgtable.h
>> index 185ffe3723ec..dce401eed1d3 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -26,6 +26,14 @@
>>  #endif /* CONFIG_64BIT */
>>
>>  #ifdef CONFIG_MMU
>> +#ifdef CONFIG_64BIT
>> +#define VA_BITS        39
>> +#define PA_BITS        56
>> +#else
>> +#define VA_BITS        32
>> +#define PA_BITS        34
> 
> We've moved to 32-bit physical addresses on rv32 in Linux.  The mismatch 
> was
> causing too many issues in generic code.

Ok I missed this one, thanks.

> 
>> +#endif
>> +
>>  /* Number of entries in the page global directory */
>>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>>  /* Number of entries in the page table */
>> @@ -108,7 +116,7 @@ extern pgd_t swapper_pg_dir[];
>>   * position vmemmap directly below the VMALLOC region.
>>   */
>>  #define VMEMMAP_SHIFT \
>> -    (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>> +    (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>>  #define VMEMMAP_SIZE    BIT(VMEMMAP_SHIFT)
>>  #define VMEMMAP_END    (VMALLOC_START - 1)
>>  #define VMEMMAP_START    (VMALLOC_START - VMEMMAP_SIZE)
>> diff --git a/arch/riscv/include/asm/sparsemem.h 
>> b/arch/riscv/include/asm/sparsemem.h
>> index 45a7018a8118..f08d72155bc8 100644
>> --- a/arch/riscv/include/asm/sparsemem.h
>> +++ b/arch/riscv/include/asm/sparsemem.h
>> @@ -4,7 +4,7 @@
>>  #define _ASM_RISCV_SPARSEMEM_H
>>
>>  #ifdef CONFIG_SPARSEMEM
>> -#define MAX_PHYSMEM_BITS    CONFIG_PA_BITS
>> +#define MAX_PHYSMEM_BITS    PA_BITS
>>  #define SECTION_SIZE_BITS    27
>>  #endif /* CONFIG_SPARSEMEM */
> 
> Aside from the 32-bit PA issue:
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks,

Alex
