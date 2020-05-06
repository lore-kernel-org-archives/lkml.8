Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A4C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4136206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgEFKWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:22:20 -0400
Received: from foss.arm.com ([217.140.110.172]:33016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgEFKWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:22:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 239E730E;
        Wed,  6 May 2020 03:22:15 -0700 (PDT)
Received: from [10.163.71.196] (unknown [10.163.71.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9A7E3F71F;
        Wed,  6 May 2020 03:22:12 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588745534-24418-1-git-send-email-anshuman.khandual@arm.com>
 <1588745534-24418-2-git-send-email-anshuman.khandual@arm.com>
 <20200506074315.GD7021@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <14911279-f800-a781-a4fd-de43215aa909@arm.com>
Date:   Wed, 6 May 2020 15:51:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200506074315.GD7021@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2020 01:13 PM, Will Deacon wrote:
> On Wed, May 06, 2020 at 11:42:12AM +0530, Anshuman Khandual wrote:
>> Platform specific huge_ptep_get() is required only when fetching the huge
>> PTE involves more than just dereferencing the page table pointer. This is
>> not the case on arm64 platform. Hence huge_ptep_pte() can be dropped along
>> with it's __HAVE_ARCH_HUGE_PTEP_GET subscription.
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
>>  1 file changed, 6 deletions(-)
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
> 
> Hmm, I'm nervous about dropping the READ_ONCE() here. We added them after
> running into page-table issues with THP [1] and it's really important to
> use them consistently to avoid hitting that again.
> 
> If the generic code used READ_ONCE(), I'd be happy to switch to it.

Sure, will add READ_ONCE() in the generic huge_ptep_get(). AFAICS it should
not cause any problem for other platforms (but let me know otherwise).

> 
> Will
> 
> [1] https://lore.kernel.org/lkml/1506527369-19535-1-git-send-email-will.deacon@arm.com/
> 
