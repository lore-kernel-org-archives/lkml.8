Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91966C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECCD22BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgH0K3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:29:48 -0400
Received: from foss.arm.com ([217.140.110.172]:56368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH0K3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:29:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198D7101E;
        Thu, 27 Aug 2020 03:29:47 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33C03F66B;
        Thu, 27 Aug 2020 03:29:43 -0700 (PDT)
Subject: Re: [PATCH 20/35] arm64: mte: Add in-kernel MTE helpers
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1597425745.git.andreyknvl@google.com>
 <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
 <20200827093808.GB29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <588f3812-c9d0-8dbe-fce2-1ea89f558bd2@arm.com>
Date:   Thu, 27 Aug 2020 11:31:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827093808.GB29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 8/27/20 10:38 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:02PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
>> index 1c99fcadb58c..733be1cb5c95 100644
>> --- a/arch/arm64/include/asm/mte.h
>> +++ b/arch/arm64/include/asm/mte.h
>> @@ -5,14 +5,19 @@
>>  #ifndef __ASM_MTE_H
>>  #define __ASM_MTE_H
>>  
>> -#define MTE_GRANULE_SIZE	UL(16)
>> +#include <asm/mte_asm.h>
> 
> So the reason for this move is to include it in asm/cache.h. Fine by
> me but...
> 
>>  #define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
>>  #define MTE_TAG_SHIFT		56
>>  #define MTE_TAG_SIZE		4
>> +#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
>> +#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)
> 
> ... I'd rather move all these definitions in a file with a more
> meaningful name like mte-def.h. The _asm implies being meant for .S
> files inclusion which isn't the case.
> 

mte-asm.h was originally called mte_helper.h hence it made sense to have these
defines here. But I agree with your proposal it makes things more readable and
it is in line with the rest of the arm64 code (e.g. page-def.h).

We should as well update the commit message accordingly.

>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index eb39504e390a..e2d708b4583d 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -72,6 +74,47 @@ int memcmp_pages(struct page *page1, struct page *page2)
>>  	return ret;
>>  }
>>  
>> +u8 mte_get_mem_tag(void *addr)
>> +{
>> +	if (system_supports_mte())
>> +		addr = mte_assign_valid_ptr_tag(addr);
> 
> The mte_assign_valid_ptr_tag() is slightly misleading. All it does is
> read the allocation tag from memory.
> 
> I also think this should be inline asm, possibly using alternatives.
> It's just an LDG instruction (and it saves us from having to invent a
> better function name).
> 

Yes, I agree, I implemented this code in the early days and never got around to
refactor it.

>> +
>> +	return 0xF0 | mte_get_ptr_tag(addr);
>> +}
>> +
>> +u8 mte_get_random_tag(void)
>> +{
>> +	u8 tag = 0xF;
>> +
>> +	if (system_supports_mte())
>> +		tag = mte_get_ptr_tag(mte_assign_random_ptr_tag(NULL));
> 
> Another alternative inline asm with an IRG instruction.
> 

As per above.

>> +
>> +	return 0xF0 | tag;
>> +}
>> +
>> +void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>> +{
>> +	void *ptr = addr;
>> +
>> +	if ((!system_supports_mte()) || (size == 0))
>> +		return addr;
>> +
>> +	tag = 0xF0 | (tag & 0xF);
>> +	ptr = (void *)__tag_set(ptr, tag);
>> +	size = ALIGN(size, MTE_GRANULE_SIZE);
> 
> I think aligning the size is dangerous. Can we instead turn it into a
> WARN_ON if not already aligned? At a quick look, the callers of
> kasan_{un,}poison_memory() already align the size.
> 

The size here is used only for tagging purposes and if we want to tag a
subgranule amount of memory we end up tagging the granule anyway. Why do you
think it can be dangerous?

Anyway I agree on the fact that is seems redundant, a WARN_ON here should be
sufficient.

>> +
>> +	mte_assign_mem_tag_range(ptr, size);
>> +
>> +	/*
>> +	 * mte_assign_mem_tag_range() can be invoked in a multi-threaded
>> +	 * context, ensure that tags are written in memory before the
>> +	 * reference is used.
>> +	 */
>> +	smp_wmb();
>> +
>> +	return ptr;
> 
> I'm not sure I understand the barrier here. It ensures the relative
> ordering of memory (or tag) accesses on a CPU as observed by other CPUs.
> While the first access here is setting the tag, I can't see what other
> access on _this_ CPU it is ordered with.
> 

You are right it can be removed. I was just overthinking here.

>> +}
>> +
>>  static void update_sctlr_el1_tcf0(u64 tcf0)
>>  {
>>  	/* ISB required for the kernel uaccess routines */
>> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
>> index 03ca6d8b8670..8c743540e32c 100644
>> --- a/arch/arm64/lib/mte.S
>> +++ b/arch/arm64/lib/mte.S
>> @@ -149,3 +149,44 @@ SYM_FUNC_START(mte_restore_page_tags)
>>  
>>  	ret
>>  SYM_FUNC_END(mte_restore_page_tags)
>> +
>> +/*
>> + * Assign pointer tag based on the allocation tag
>> + *   x0 - source pointer
>> + * Returns:
>> + *   x0 - pointer with the correct tag to access memory
>> + */
>> +SYM_FUNC_START(mte_assign_valid_ptr_tag)
>> +	ldg	x0, [x0]
>> +	ret
>> +SYM_FUNC_END(mte_assign_valid_ptr_tag)
>> +
>> +/*
>> + * Assign random pointer tag
>> + *   x0 - source pointer
>> + * Returns:
>> + *   x0 - pointer with a random tag
>> + */
>> +SYM_FUNC_START(mte_assign_random_ptr_tag)
>> +	irg	x0, x0
>> +	ret
>> +SYM_FUNC_END(mte_assign_random_ptr_tag)
> 
> As I said above, these two can be inline asm.
> 

Agreed.

>> +
>> +/*
>> + * Assign allocation tags for a region of memory based on the pointer tag
>> + *   x0 - source pointer
>> + *   x1 - size
>> + *
>> + * Note: size is expected to be MTE_GRANULE_SIZE aligned
>> + */
>> +SYM_FUNC_START(mte_assign_mem_tag_range)
>> +	/* if (src == NULL) return; */
>> +	cbz	x0, 2f
>> +	/* if (size == 0) return; */
> 
> You could skip the cbz here and just document that the size should be
> non-zero and aligned. The caller already takes care of this check.
>

I would prefer to keep the check here, unless there is a valid reason, since
allocate(0) is a viable option hence tag(x, 0) should be as well. The caller
takes care of it in one place, today, but I do not know where the API will be
used in future.

>> +	cbz	x1, 2f
>> +1:	stg	x0, [x0]
>> +	add	x0, x0, #MTE_GRANULE_SIZE
>> +	sub	x1, x1, #MTE_GRANULE_SIZE
>> +	cbnz	x1, 1b
>> +2:	ret
>> +SYM_FUNC_END(mte_assign_mem_tag_range)
> 

-- 
Regards,
Vincenzo
