Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F1AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBAC20789
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgFSE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:28:23 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43387 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFSE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:28:22 -0400
X-Originating-IP: 90.112.45.105
Received: from [192.168.1.14] (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 131AA20003;
        Fri, 19 Jun 2020 04:28:16 +0000 (UTC)
Subject: Re: [PATCH 2/2] riscv: Use PUD/PGDIR entries for linear mapping when
 possible
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20200603153608.30056-1-alex@ghiti.fr>
 <20200603153608.30056-3-alex@ghiti.fr>
 <CAOnJCU+JSuOGbOmZW-vqb-A_qR7CJc=qG16FbgOLWSm1vhJH1A@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <23529a84-44a0-3c45-f16d-5a7ee528610d@ghiti.fr>
Date:   Fri, 19 Jun 2020 00:28:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCU+JSuOGbOmZW-vqb-A_qR7CJc=qG16FbgOLWSm1vhJH1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

Le 6/18/20 à 8:47 PM, Atish Patra a écrit :
> On Wed, Jun 3, 2020 at 8:38 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Improve best_map_size so that PUD or PGDIR entries are used for linear
>> mapping when possible as it allows better TLB utilization.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   arch/riscv/mm/init.c | 45 +++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 9a5c97e091c1..d275f9f834cf 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -424,13 +424,29 @@ static void __init create_pgd_mapping(pgd_t *pgdp,
>>          create_pgd_next_mapping(nextp, va, pa, sz, prot);
>>   }
>>
>> -static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
>> +static bool is_map_size_ok(uintptr_t map_size, phys_addr_t base,
>> +                          uintptr_t base_virt, phys_addr_t size)
>>   {
>> -       /* Upgrade to PMD_SIZE mappings whenever possible */
>> -       if ((base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
>> -               return PAGE_SIZE;
>> +       return !((base & (map_size - 1)) || (base_virt & (map_size - 1)) ||
>> +                       (size < map_size));
>> +}
>> +
>> +static uintptr_t __init best_map_size(phys_addr_t base, uintptr_t base_virt,
>> +                                     phys_addr_t size)
>> +{
>> +#ifndef __PAGETABLE_PMD_FOLDED
>> +       if (is_map_size_ok(PGDIR_SIZE, base, base_virt, size))
>> +               return PGDIR_SIZE;
>> +
>> +       if (pgtable_l4_enabled)
>> +               if (is_map_size_ok(PUD_SIZE, base, base_virt, size))
>> +                       return PUD_SIZE;
>> +#endif
>> +
>> +       if (is_map_size_ok(PMD_SIZE, base, base_virt, size))
>> +               return PMD_SIZE;
>>
>> -       return PMD_SIZE;
>> +       return PAGE_SIZE;
>>   }
>>
>>   /*
>> @@ -576,7 +592,7 @@ void create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>>   asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>   {
>>          uintptr_t va, end_va;
>> -       uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
>> +       uintptr_t map_size;
>>
>>          load_pa = (uintptr_t)(&_start);
>>          load_sz = (uintptr_t)(&_end) - load_pa;
>> @@ -587,6 +603,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>
>>          kernel_virt_addr = KERNEL_VIRT_ADDR;
>>
>> +       map_size = best_map_size(load_pa, PAGE_OFFSET, MAX_EARLY_MAPPING_SIZE);
>>          va_pa_offset = PAGE_OFFSET - load_pa;
>>          va_kernel_pa_offset = kernel_virt_addr - load_pa;
>>          pfn_base = PFN_DOWN(load_pa);
>> @@ -700,6 +717,8 @@ static void __init setup_vm_final(void)
>>
>>          /* Map all memory banks */
>>          for_each_memblock(memory, reg) {
>> +               uintptr_t remaining_size;
>> +
>>                  start = reg->base;
>>                  end = start + reg->size;
>>
>> @@ -707,15 +726,19 @@ static void __init setup_vm_final(void)
>>                          break;
>>                  if (memblock_is_nomap(reg))
>>                          continue;
>> -               if (start <= __pa(PAGE_OFFSET) &&
>> -                   __pa(PAGE_OFFSET) < end)
>> -                       start = __pa(PAGE_OFFSET);
>>
>> -               map_size = best_map_size(start, end - start);
>> -               for (pa = start; pa < end; pa += map_size) {
>> +               pa = start;
>> +               remaining_size = reg->size;
>> +
>> +               while (remaining_size) {
>>                          va = (uintptr_t)__va(pa);
>> +                       map_size = best_map_size(pa, va, remaining_size);
>> +
>>                          create_pgd_mapping(swapper_pg_dir, va, pa,
>>                                             map_size, PAGE_KERNEL);
>> +
>> +                       pa += map_size;
>> +                       remaining_size -= map_size;
>>                  }
>>          }
>>
> This may not work in the RV32 with 2G memory  and if the map_size is
> determined to be a page size
> for the last memblock. Both pa & remaining_size will overflow and the
> loop will try to map memory from zero again.

I'm not sure I understand: if pa starts at 0x8000_0000 and size is 2G, 
then pa will overflow in the last iteration, but remaining_size will 
then be equal to 0 right ?

And by the way, I realize that this loop only handles sizes that are 
aligned on map_size.

Thanks,

Alex


>
>> --
>> 2.20.1
>>
>>
>
