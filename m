Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A18CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9DB20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHQFoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:44:44 -0400
Received: from foss.arm.com ([217.140.110.172]:47872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHQFol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:44:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4270630E;
        Sun, 16 Aug 2020 22:44:40 -0700 (PDT)
Received: from [10.163.65.199] (unknown [10.163.65.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55A73F71F;
        Sun, 16 Aug 2020 22:44:37 -0700 (PDT)
Subject: Re: [RFC V2 1/2] arm64/mm: Change THP helpers per generic memory
 semantics
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, mark.rutland@arm.com, ziy@nvidia.com,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1592226918-26378-1-git-send-email-anshuman.khandual@arm.com>
 <1592226918-26378-2-git-send-email-anshuman.khandual@arm.com>
 <20200702121135.GD22241@gaia> <48fd53ad-03a8-eb76-46a2-b65bd75a28d6@arm.com>
 <20200707174403.GB32331@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ebe2ba80-e7e9-740d-7cc4-68e89768e68e@arm.com>
Date:   Mon, 17 Aug 2020 11:13:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200707174403.GB32331@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 11:14 PM, Catalin Marinas wrote:
> On Mon, Jul 06, 2020 at 09:27:04AM +0530, Anshuman Khandual wrote:
>> On 07/02/2020 05:41 PM, Catalin Marinas wrote:
>>> On Mon, Jun 15, 2020 at 06:45:17PM +0530, Anshuman Khandual wrote:
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -353,15 +353,92 @@ static inline int pmd_protnone(pmd_t pmd)
>>>>  }
>>>>  #endif
>>>>  
>>>> +#define pmd_table(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) ==  PMD_TYPE_TABLE)
>>>> +#define pmd_sect(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) ==  PMD_TYPE_SECT)
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>  /*
>>>> - * THP definitions.
>>>> + * PMD Level Encoding (THP Enabled)
>>>> + *
>>>> + * 0b00 - Not valid	Not present	NA
>>>> + * 0b10 - Not valid	Present		Huge  (Splitting)
>>>> + * 0b01 - Valid		Present		Huge  (Mapped)
>>>> + * 0b11 - Valid		Present		Table (Mapped)
>>>>   */
>>>
>>> I wonder whether it would be easier to read if we add a dedicated
>>> PMD_SPLITTING bit, only when bit 0 is cleared. This bit can be high (say
>>> 59), it doesn't really matter as the entry is not valid.
>>
>> Could make (PMD[0b00] = 0b10) be represented as PMD_SPLITTING just for
>> better reading purpose. But if possible, IMHO it is efficient and less
>> vulnerable to use HW defined PTE attribute bit positions including SW
>> usable ones than the reserved bits, for a PMD state representation.
>>
>> Earlier proposal used PTE_SPECIAL (bit 56) instead. Using PMD_TABLE_BIT
>> helps save bit 56 for later. Thinking about it again, would not these
>> unused higher bits [59..63] create any problem ? For example while
>> enabling THP swapping without split via ARCH_WANTS_THP_SWAP or something
>> else later when these higher bits might be required. I am not sure, just
>> speculating.
> 
> The swap encoding goes to bit 57, so going higher shouldn't be an issue.
> 
>> But, do you see any particular problem with PMD_TABLE_BIT ?
> 
> No. Only that we have some precedent like PTE_PROT_NONE (bit 58) and
> wondering whether we could use a high bit as well here. If we can get
> them to overlap, it simplifies this patch further.
> 
>>> The only doubt I have is that pmd_mkinvalid() is used in other contexts
>>> when it's not necessarily splitting a pmd (search for the
>>> pmdp_invalidate() calls). So maybe a better name like PMD_PRESENT with a
>>> comment that pmd_to_page() is valid (i.e. no migration or swap entry).
>>> Feel free to suggest a better name.
>>
>> PMD_INVALID_PRESENT sounds better ?
> 
> No strong opinion either way. Yours is clearer.
> 
>>>> +static inline pmd_t pmd_mksplitting(pmd_t pmd)
>>>> +{
>>>> +	unsigned long val = pmd_val(pmd);
>>>>  
>>>> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> -#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>>>> +	return __pmd((val & ~PMD_TYPE_MASK) | PMD_TABLE_BIT);
>>>> +}
>>>> +
>>>> +static inline pmd_t pmd_clrsplitting(pmd_t pmd)
>>>> +{
>>>> +	unsigned long val = pmd_val(pmd);
>>>> +
>>>> +	return __pmd((val & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
>>>> +}
>>>> +
>>>> +static inline bool pmd_splitting(pmd_t pmd)
>>>> +{
>>>> +	unsigned long val = pmd_val(pmd);
>>>> +
>>>> +	if ((val & PMD_TYPE_MASK) == PMD_TABLE_BIT)
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static inline bool pmd_mapped(pmd_t pmd)
>>>> +{
>>>> +	return pmd_sect(pmd);
>>>> +}
>>>> +
>>>> +static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>>> +{
>>>> +	/*
>>>> +	 * Invalidation should not have been invoked on
>>>> +	 * a PMD table entry. Just warn here otherwise.
>>>> +	 */
>>>> +	WARN_ON(pmd_table(pmd));
>>>> +	return pmd_mksplitting(pmd);
>>>> +}
>>>
>>> And here we wouldn't need t worry about table checks.
>>
>> This is just a temporary sanity check validating the assumption
>> that a table entry would never be called with pmdp_invalidate().
>> This can be dropped later on if required.
> 
> You could use a VM_WARN_ON.
> 
>>>> +static inline int pmd_present(pmd_t pmd);
>>>> +
>>>> +static inline int pmd_trans_huge(pmd_t pmd)
>>>> +{
>>>> +	if (!pmd_present(pmd))
>>>> +		return 0;
>>>> +
>>>> +	if (!pmd_val(pmd))
>>>> +		return 0;
>>>> +
>>>> +	if (pmd_mapped(pmd))
>>>> +		return 1;
>>>> +
>>>> +	if (pmd_splitting(pmd))
>>>> +		return 1;
>>>> +	return 0;
>>>
>>> Doesn't your new pmd_present() already check for splitting? I think
>>
>> I actually meant pte_present() here instead, my bad.
>>
>>> checking for bit 0 and the new PMD_PRESENT. That would be similar to
>>> what we do with PTE_PROT_NONE. Actually, you could use the same bit for
>>> both.
>>
>> IIUC PROT NONE is supported at PMD level as well. Hence with valid bit
>> cleared, there is a chance for misinterpretation between pmd_protnone()
>> and pmd_splitting() if the same bit (PTE_PROT_NONE) is used.
> 
> We can indeed have a PROT_NONE pmd but does it matter? All you need is
> that pmdp_invalidate() returns the original (present pmd) and writes a
> value that is still pmd_present() while invalid. You never modify the
> new value again AFAICT (only the old one to rebuild the pmd).

But during the time when PMD entry remains invalidated but still present,
it will be identical to pmd_protnone() if we choose to use PROT_NONE bit
here to have pmd_present() return positive. Because invalidated PMD entry
is not necessarily a pmd_protnone() entry.

> 
> It is indeed a problem if set_pmd_at() clears the new
> PMD_INVALID_PRESENT bit but my understanding is that it doesn't need to
> (see below).
> 
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 990929c8837e..337519031115 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -22,6 +22,8 @@
>>>>  #include <linux/io.h>
>>>>  #include <linux/mm.h>
>>>>  #include <linux/vmalloc.h>
>>>> +#include <linux/swap.h>
>>>> +#include <linux/swapops.h>
>>>>  
>>>>  #include <asm/barrier.h>
>>>>  #include <asm/cputype.h>
>>>> @@ -1483,3 +1485,21 @@ static int __init prevent_bootmem_remove_init(void)
>>>>  }
>>>>  device_initcall(prevent_bootmem_remove_init);
>>>>  #endif
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>>> +		pmd_t *pmdp, pmd_t pmd)
>>>> +{
>>>> +	/*
>>>> +	 * PMD migration entries need to retain splitting PMD
>>>> +	 * representation created with pmdp_invalidate(). But
>>>> +	 * any non-migration entry which just might have been
>>>> +	 * invalidated previously, still need be a normal huge
>>>> +	 * page. Hence selectively clear splitting entries.
>>>> +	 */
>>>> +	if (!is_migration_entry(pmd_to_swp_entry(pmd)))
>>>> +		pmd = pmd_clrsplitting(pmd);
>>>> +
>>>> +	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
>>>> +}
>>>> +#endif
>>>
>>> So a pmdp_invalidate() returns the old pmd. Do we ever need to rebuild a
>>> pmd based on the actual bits in the new invalidated pmdp? Wondering how
>>> the table bit ends up here that we need to pmd_clrsplitting().
>>
>> Yes, a pmd is always rebuilt via set_pmd_at() with the old value as
>> returned from an earlier pmdp_invalidate() but which may have been
>> changed with standard page table entry transformations. Basically,
>> it will not be created afresh from the pfn and VMA flags.
> 
> My point is that pmdp_invalidate() is never called on an already invalid
> pmd. A valid pmd should never have the PMD_INVALID_PRESENT bit set.
> Therefore, set_pmd_at() does not need to clear any such bit as it wasn't
> in the old value returned by pmdp_invalidate().
> 
>> Any additional bit set in PMD via pmdp_invalidate() needs to be
>> cleared off in set_pmd_at(), unless it is a migration entry.
> 
> I'm not convinced we need to unless we nest pmdp_invalidate() calls
> (have you seen any evidence of this?).

You are right, set_pmd_at() does not need to clear that extra bit. As you
had suggested earlier, using bit 59 as PMD_PRESENT_INVALID here does work.
Will send out the next version soon.
