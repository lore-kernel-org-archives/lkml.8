Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CF1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C514207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgH0JiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgH0JiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:38:14 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6333020738;
        Thu, 27 Aug 2020 09:38:11 +0000 (UTC)
Date:   Thu, 27 Aug 2020 10:38:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
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
Subject: Re: [PATCH 20/35] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200827093808.GB29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:27:02PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 1c99fcadb58c..733be1cb5c95 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -5,14 +5,19 @@
>  #ifndef __ASM_MTE_H
>  #define __ASM_MTE_H
>  
> -#define MTE_GRANULE_SIZE	UL(16)
> +#include <asm/mte_asm.h>

So the reason for this move is to include it in asm/cache.h. Fine by
me but...

>  #define MTE_GRANULE_MASK	(~(MTE_GRANULE_SIZE - 1))
>  #define MTE_TAG_SHIFT		56
>  #define MTE_TAG_SIZE		4
> +#define MTE_TAG_MASK		GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> +#define MTE_TAG_MAX		(MTE_TAG_MASK >> MTE_TAG_SHIFT)

... I'd rather move all these definitions in a file with a more
meaningful name like mte-def.h. The _asm implies being meant for .S
files inclusion which isn't the case.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index eb39504e390a..e2d708b4583d 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -72,6 +74,47 @@ int memcmp_pages(struct page *page1, struct page *page2)
>  	return ret;
>  }
>  
> +u8 mte_get_mem_tag(void *addr)
> +{
> +	if (system_supports_mte())
> +		addr = mte_assign_valid_ptr_tag(addr);

The mte_assign_valid_ptr_tag() is slightly misleading. All it does is
read the allocation tag from memory.

I also think this should be inline asm, possibly using alternatives.
It's just an LDG instruction (and it saves us from having to invent a
better function name).

> +
> +	return 0xF0 | mte_get_ptr_tag(addr);
> +}
> +
> +u8 mte_get_random_tag(void)
> +{
> +	u8 tag = 0xF;
> +
> +	if (system_supports_mte())
> +		tag = mte_get_ptr_tag(mte_assign_random_ptr_tag(NULL));

Another alternative inline asm with an IRG instruction.

> +
> +	return 0xF0 | tag;
> +}
> +
> +void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> +{
> +	void *ptr = addr;
> +
> +	if ((!system_supports_mte()) || (size == 0))
> +		return addr;
> +
> +	tag = 0xF0 | (tag & 0xF);
> +	ptr = (void *)__tag_set(ptr, tag);
> +	size = ALIGN(size, MTE_GRANULE_SIZE);

I think aligning the size is dangerous. Can we instead turn it into a
WARN_ON if not already aligned? At a quick look, the callers of
kasan_{un,}poison_memory() already align the size.

> +
> +	mte_assign_mem_tag_range(ptr, size);
> +
> +	/*
> +	 * mte_assign_mem_tag_range() can be invoked in a multi-threaded
> +	 * context, ensure that tags are written in memory before the
> +	 * reference is used.
> +	 */
> +	smp_wmb();
> +
> +	return ptr;

I'm not sure I understand the barrier here. It ensures the relative
ordering of memory (or tag) accesses on a CPU as observed by other CPUs.
While the first access here is setting the tag, I can't see what other
access on _this_ CPU it is ordered with.

> +}
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>  	/* ISB required for the kernel uaccess routines */
> diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> index 03ca6d8b8670..8c743540e32c 100644
> --- a/arch/arm64/lib/mte.S
> +++ b/arch/arm64/lib/mte.S
> @@ -149,3 +149,44 @@ SYM_FUNC_START(mte_restore_page_tags)
>  
>  	ret
>  SYM_FUNC_END(mte_restore_page_tags)
> +
> +/*
> + * Assign pointer tag based on the allocation tag
> + *   x0 - source pointer
> + * Returns:
> + *   x0 - pointer with the correct tag to access memory
> + */
> +SYM_FUNC_START(mte_assign_valid_ptr_tag)
> +	ldg	x0, [x0]
> +	ret
> +SYM_FUNC_END(mte_assign_valid_ptr_tag)
> +
> +/*
> + * Assign random pointer tag
> + *   x0 - source pointer
> + * Returns:
> + *   x0 - pointer with a random tag
> + */
> +SYM_FUNC_START(mte_assign_random_ptr_tag)
> +	irg	x0, x0
> +	ret
> +SYM_FUNC_END(mte_assign_random_ptr_tag)

As I said above, these two can be inline asm.

> +
> +/*
> + * Assign allocation tags for a region of memory based on the pointer tag
> + *   x0 - source pointer
> + *   x1 - size
> + *
> + * Note: size is expected to be MTE_GRANULE_SIZE aligned
> + */
> +SYM_FUNC_START(mte_assign_mem_tag_range)
> +	/* if (src == NULL) return; */
> +	cbz	x0, 2f
> +	/* if (size == 0) return; */

You could skip the cbz here and just document that the size should be
non-zero and aligned. The caller already takes care of this check.

> +	cbz	x1, 2f
> +1:	stg	x0, [x0]
> +	add	x0, x0, #MTE_GRANULE_SIZE
> +	sub	x1, x1, #MTE_GRANULE_SIZE
> +	cbnz	x1, 1b
> +2:	ret
> +SYM_FUNC_END(mte_assign_mem_tag_range)

-- 
Catalin
