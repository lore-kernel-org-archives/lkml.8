Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C1C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C52223D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgDTODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:03:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:38394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgDTODV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:03:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 63091ABD7;
        Mon, 20 Apr 2020 14:03:18 +0000 (UTC)
Subject: Re: [patch 05/15] x86/tlb: Move __flush_tlb() out of line
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200419203137.214111265@linutronix.de>
 <20200419203336.134117165@linutronix.de>
 <5857df01-abeb-c6cd-8e92-64eb365dc835@amd.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fab4e80a-3df2-a177-c5fe-1ab995953727@suse.com>
Date:   Mon, 20 Apr 2020 16:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5857df01-abeb-c6cd-8e92-64eb365dc835@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.20 15:48, Tom Lendacky wrote:
> On 4/19/20 3:31 PM, Thomas Gleixner wrote:
>> cpu_tlbstate is exported because various TLB related functions need 
>> access
>> to it, but cpu_tlbstate is sensitive information which should only be
>> accessed by well contained kernel functions and not be directly 
>> exposed to
>> modules.
>>
>> The various TLB flush functions need access to cpu_tlbstate. As a first
>> step move __flush_tlb() out of line and hide the native function. The
>> latter can be static when CONFIG_PARAVIRT is disabled.
>>
>> Consolidate the name space while at it and remove the pointless extra
>> wrapper in the paravirt code.
>>
>> No functional change.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/include/asm/paravirt.h    |    4 +++-
>>   arch/x86/include/asm/tlbflush.h    |   29 +++++------------------------
>>   arch/x86/kernel/cpu/mtrr/generic.c |    4 ++--
>>   arch/x86/kernel/paravirt.c         |    7 +------
>>   arch/x86/mm/mem_encrypt.c          |    2 +-
>>   arch/x86/mm/tlb.c                  |   33 
>> ++++++++++++++++++++++++++++++++-
>>   arch/x86/platform/uv/tlb_uv.c      |    2 +-
>>   7 files changed, 45 insertions(+), 36 deletions(-)
>>
>> --- a/arch/x86/include/asm/paravirt.h
>> +++ b/arch/x86/include/asm/paravirt.h
>> @@ -47,7 +47,9 @@ static inline void slow_down_io(void)
>>   #endif
>>   }
>> -static inline void __flush_tlb(void)
>> +void native_flush_tlb_local(void);
>> +
>> +static inline void __flush_tlb_local(void)
>>   {
>>       PVOP_VCALL0(mmu.flush_tlb_user);
>>   }
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -140,12 +140,13 @@ static inline unsigned long build_cr3_no
>>       return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
>>   }
>> +void flush_tlb_local(void);
>> +
>>   #ifdef CONFIG_PARAVIRT
>>   #include <asm/paravirt.h>
>>   #else
>> -#define __flush_tlb() __native_flush_tlb()
>> -#define __flush_tlb_global() __native_flush_tlb_global()
>> -#define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
>> +#define __flush_tlb_global()        __native_flush_tlb_global()
>> +#define __flush_tlb_one_user(addr)    __native_flush_tlb_one_user(addr)
>>   #endif
>>   struct tlb_context {
>> @@ -371,24 +372,6 @@ static inline void invalidate_user_asid(
>>   }
>>   /*
>> - * flush the entire current user mapping
>> - */
>> -static inline void __native_flush_tlb(void)
>> -{
>> -    /*
>> -     * Preemption or interrupts must be disabled to protect the access
>> -     * to the per CPU variable and to prevent being preempted between
>> -     * read_cr3() and write_cr3().
>> -     */
>> -    WARN_ON_ONCE(preemptible());
>> -
>> -    invalidate_user_asid(this_cpu_read(cpu_tlbstate.loaded_mm_asid));
>> -
>> -    /* If current->mm == NULL then the read_cr3() "borrows" an mm */
>> -    native_write_cr3(__native_read_cr3());
>> -}
>> -
>> -/*
>>    * flush everything
>>    */
>>   static inline void __native_flush_tlb_global(void)
>> @@ -461,7 +444,7 @@ static inline void __flush_tlb_all(void)
>>           /*
>>            * !PGE -> !PCID (setup_pcid()), thus every flush is total.
>>            */
>> -        __flush_tlb();
>> +        flush_tlb_local();
>>       }
>>   }
>> @@ -537,8 +520,6 @@ struct flush_tlb_info {
>>       bool            freed_tables;
>>   };
>> -#define local_flush_tlb() __flush_tlb()
>> -
>>   #define flush_tlb_mm(mm)                        \
>>           flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
>> --- a/arch/x86/kernel/cpu/mtrr/generic.c
>> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
>> @@ -761,7 +761,7 @@ static void prepare_set(void) __acquires
>>       /* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
>>       count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>> -    __flush_tlb();
>> +    flush_tlb_local();
>>       /* Save MTRR state */
>>       rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>> @@ -778,7 +778,7 @@ static void post_set(void) __releases(se
>>   {
>>       /* Flush TLBs (no need to flush caches - they are disabled) */
>>       count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
>> -    __flush_tlb();
>> +    flush_tlb_local();
>>       /* Intel (P6) standard MTRRs */
>>       mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -160,11 +160,6 @@ unsigned paravirt_patch_insns(void *insn
>>       return insn_len;
>>   }
>> -static void native_flush_tlb(void)
>> -{
>> -    __native_flush_tlb();
>> -}
>> -
>>   /*
>>    * Global pages have to be flushed a bit differently. Not a real
>>    * performance problem because this does not happen often.
>> @@ -359,7 +354,7 @@ struct paravirt_patch_template pv_ops =
>>   #endif /* CONFIG_PARAVIRT_XXL */
>>       /* Mmu ops. */
>> -    .mmu.flush_tlb_user    = native_flush_tlb,
>> +    .mmu.flush_tlb_user    = native_flush_tlb_local,
>>       .mmu.flush_tlb_kernel    = native_flush_tlb_global,
>>       .mmu.flush_tlb_one_user    = native_flush_tlb_one_user,
>>       .mmu.flush_tlb_others    = native_flush_tlb_others,
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -134,7 +134,7 @@ static void __init __sme_early_map_unmap
>>           size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
>>       } while (size);
>> -    __native_flush_tlb();
>> +    flush_tlb_local();
> 
> This invoked __native_flush_tlb() because of how early it is called and 
> the paravirt ops support isn't set up yet, resulting in a crash if not 
> invoking the native version directly. So this needs a "native" version 
> of the tlb flush to invoke.

I don't think this is still true. With my rework of pvops to have all
functions in one struct which is initialized statically initially
everything should work from the time the kernel is mapped.

In case it doesn't there is something very wrong IMO.


Juergen
