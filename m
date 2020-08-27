Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CFEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FB620738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgH0PKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:10:34 -0400
Received: from foss.arm.com ([217.140.110.172]:57320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgH0LtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:49:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6114C31B;
        Thu, 27 Aug 2020 03:54:39 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 220DF3F68F;
        Thu, 27 Aug 2020 03:54:36 -0700 (PDT)
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
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
 <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com>
Date:   Thu, 27 Aug 2020 11:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827103819.GE29264@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 11:38 AM, Catalin Marinas wrote:
> On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index cde127508e38..a17fefb0571b 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -172,6 +172,29 @@ alternative_else_nop_endif
>>  #endif
>>  	.endm
>>  
>> +	/* Note: tmp should always be a callee-saved register */
> 
> Why callee-saved? Do you preserve it anywhere here?
>

Aargh, this is an old comment, I forgot to remove it after the last refactor.
Thank you for pointing this out.

>> +	.macro mte_restore_gcr, el, tsk, tmp, tmp2
>> +#ifdef CONFIG_ARM64_MTE
>> +alternative_if_not ARM64_MTE
>> +	b	1f
>> +alternative_else_nop_endif
>> +	.if	\el == 0
>> +	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
>> +	.else
>> +	ldr_l	\tmp, gcr_kernel_excl
>> +	.endif
>> +	/*
>> +	 * Calculate and set the exclude mask preserving
>> +	 * the RRND (bit[16]) setting.
>> +	 */
>> +	mrs_s	\tmp2, SYS_GCR_EL1
>> +	bfi	\tmp2, \tmp, #0, #16
>> +	msr_s	SYS_GCR_EL1, \tmp2
>> +	isb
>> +1:
>> +#endif
>> +	.endm
>> +
>>  	.macro	kernel_entry, el, regsize = 64
>>  	.if	\regsize == 32
>>  	mov	w0, w0				// zero upper 32 bits of x0
>> @@ -209,6 +232,8 @@ alternative_else_nop_endif
>>  
>>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>>  
>> +	mte_restore_gcr 1, tsk, x22, x23
>> +
>>  	scs_load tsk, x20
>>  	.else
>>  	add	x21, sp, #S_FRAME_SIZE
>> @@ -386,6 +411,8 @@ alternative_else_nop_endif
>>  	/* No kernel C function calls after this as user keys are set. */
>>  	ptrauth_keys_install_user tsk, x0, x1, x2
>>  
>> +	mte_restore_gcr 0, tsk, x0, x1
>> +
>>  	apply_ssbd 0, x0, x1
>>  	.endif
>>  
>> @@ -957,6 +984,7 @@ SYM_FUNC_START(cpu_switch_to)
>>  	mov	sp, x9
>>  	msr	sp_el0, x1
>>  	ptrauth_keys_install_kernel x1, x8, x9, x10
>> +	mte_restore_gcr 1, x1, x8, x9
>>  	scs_save x0, x8
>>  	scs_load x1, x8
>>  	ret
> 
> Since we set GCR_EL1 on exception entry and return, why is this needed?
> We don't have a per-kernel thread GCR_EL1, it's global to all threads,
> so I think cpu_switch_to() should not be touched.
> 

I agree, we can remove it. We only require the kernel entry and the kernel exit
ones.

>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 7717ea9bc2a7..cfac7d02f032 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -18,10 +18,14 @@
>>  
>>  #include <asm/barrier.h>
>>  #include <asm/cpufeature.h>
>> +#include <asm/kasan.h>
>> +#include <asm/kprobes.h>
>>  #include <asm/mte.h>
>>  #include <asm/ptrace.h>
>>  #include <asm/sysreg.h>
>>  
>> +u64 gcr_kernel_excl __read_mostly;
> 
> Could we make this __ro_after_init?
>

Yes, it makes sense, it should be updated only once through mte_init_tags().

Something to consider though here is that this might not be the right approach
if in future we want to add stack tagging. In such a case we need to know the
kernel exclude mask before any C code is executed. Initializing the mask via
mte_init_tags() it is too late.

I was thinking to add a compilation define instead of having gcr_kernel_excl in
place. This might not work if the kernel excl mask is meant to change during the
execution.

Thoughts?

>> +
>>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>>  {
>>  	pte_t old_pte = READ_ONCE(*ptep);
>> @@ -115,6 +119,13 @@ void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>  	return ptr;
>>  }
>>  
>> +void mte_init_tags(u64 max_tag)
>> +{
>> +	u64 incl = ((1ULL << ((max_tag & MTE_TAG_MAX) + 1)) - 1);
> 
> I'd rather use GENMASK here, it is more readable.
> 

Agree, we can change it.

-- 
Regards,
Vincenzo
