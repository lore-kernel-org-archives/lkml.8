Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DF9C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D75206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgEKECv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:02:51 -0400
Received: from foss.arm.com ([217.140.110.172]:50664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgEKECu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:02:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F047D6E;
        Sun, 10 May 2020 21:02:49 -0700 (PDT)
Received: from [10.163.72.179] (unknown [10.163.72.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1448C3F71E;
        Sun, 10 May 2020 21:02:46 -0700 (PDT)
Subject: Re: [PATCH V3 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
 <1588907271-11920-2-git-send-email-anshuman.khandual@arm.com>
 <7db44202-0d21-d8fb-6998-0210508a488a@oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <19ffbe33-3a42-6d90-6c48-19645a898383@arm.com>
Date:   Mon, 11 May 2020 09:32:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7db44202-0d21-d8fb-6998-0210508a488a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2020 03:39 AM, Mike Kravetz wrote:
> On 5/7/20 8:07 PM, Anshuman Khandual wrote:
>> Platform specific huge_ptep_get() is required only when fetching the huge
>> PTE involves more than just dereferencing the page table pointer. This is
>> not the case on arm64 platform. Hence huge_ptep_pte() can be dropped along
>> with it's __HAVE_ARCH_HUGE_PTEP_GET subscription. Before that, it updates
>> the generic huge_ptep_get() with READ_ONCE() which will prevent known page
>> table issues with THP on arm64.
>>
>> https://lore.kernel.org/r/1506527369-19535-1-git-send-email-will.deacon@arm.com/
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/hugetlb.h | 6 ------
>>  include/asm-generic/hugetlb.h    | 2 +-
>>  2 files changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index 2eb6c234d594..b88878ddc88b 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -17,12 +17,6 @@
>>  extern bool arch_hugetlb_migration_supported(struct hstate *h);
>>  #endif
>>  
>> -#define __HAVE_ARCH_HUGE_PTEP_GET
>> -static inline pte_t huge_ptep_get(pte_t *ptep)
>> -{
>> -	return READ_ONCE(*ptep);
>> -}
>> -
>>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>>  					 unsigned long addr, unsigned long len)
>>  {
>> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
>> index 822f433ac95c..40f85decc2ee 100644
>> --- a/include/asm-generic/hugetlb.h
>> +++ b/include/asm-generic/hugetlb.h
>> @@ -122,7 +122,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>>  #ifndef __HAVE_ARCH_HUGE_PTEP_GET
>>  static inline pte_t huge_ptep_get(pte_t *ptep)
>>  {
>> -	return *ptep;
>> +	return READ_ONCE(*ptep);
>>  }
>>  #endif
> 
> I know you made this change in response to Will's comment.  And, since
> changes were made to consistently use READ_ONCE in arm64 code, it makes
> sense for that architecture.
> 
> However, with this change to generic code, you introduce READ_ONCE to
> other architectures where it was not used before.  Could this possibly
> introduce inconsistencies in their use of READ_ONCE?  To be honest, I
> am not very good at identifying any possible issues this could cause.
> However, it does seem possible.

Could you please give some more details. Is there any particular problem
which might be caused by this new READ_ONCE() here, that you you are
concerned about. READ_ONCE() is already getting used in multiple places
in core MM which can not be configured out (like mm/gup.c). It is getting
used in core HugeTLB (mm/hugetlb.c) as well. AFAICS, there is no standard
for using READ_ONCE() while walking page tables entries. We have examples
in core MM for both ways.

> 
> Will was nervous about dropping this from arm64.  I'm just a little nervous
> about adding it to other architectures.
> 
AFAICS, __HAVE_ARCH_HUGE_PTEP_GET should be used on a platform only when
a HugeTLB entry could not constructed by dereferencing a page table entry
as in the case with ARM (32 bit). Using READ_ONCE() while dereferencing is
really not a special case that will need __HAVE_ARCH_HUGE_PTEP_GET. Moving
READ_ONCE() into generic definition solves the problem while also taking
care of a known problem on arm64. IMHO, it seems like the right thing to
do unless there is another problem that pops up some where else because of
READ_ONCE().
