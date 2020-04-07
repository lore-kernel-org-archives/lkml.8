Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9FAC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B09C206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgDGFPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:15:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54099 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgDGFPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:15:08 -0400
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5AEB0240006;
        Tue,  7 Apr 2020 05:15:05 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [RFC PATCH 7/7] riscv: Explicit comment about user virtual
 address space size
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-85bee1c4-d1ea-4370-8940-2e35c5eb6d4b@palmerdabbelt-glaptop1>
Message-ID: <29eb893f-1432-e75a-cf4a-7b97037dc50b@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:15:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-85bee1c4-d1ea-4370-8940-2e35c5eb6d4b@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 11:53 AM, Palmer Dabbelt wrote:
> On Sun, 22 Mar 2020 04:00:28 PDT (-0700), alex@ghiti.fr wrote:
>> Define precisely the size of the user accessible virtual space size
>> for sv32/39/48 mmu types and explain why the whole virtual address
>> space is split into 2 equal chunks between kernel and user space.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/include/asm/pgtable.h | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h 
>> b/arch/riscv/include/asm/pgtable.h
>> index 06361db3f486..be117a0b4ea1 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -456,8 +456,15 @@ static inline int ptep_clear_flush_young(struct 
>> vm_area_struct *vma,
>>  #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>>
>>  /*
>> - * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
>> - * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>> + * Task size is:
>> + * -     0x9fc00000 (~2.5GB) for RV32.
>> + * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
>> + * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
>> + *
>> + * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
>> + * Instruction Set Manual Volume II: Privileged Architecture" states 
>> that
>> + * "load and store effective addresses, which are 64bits, must have bits
>> + * 63–48 all equal to bit 47, or else a page-fault exception will 
>> occur."
>>   */
>>  #ifdef CONFIG_64BIT
>>  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks,

Alex
