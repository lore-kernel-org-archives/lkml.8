Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F39C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FF020C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgIHKS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:18:59 -0400
Received: from foss.arm.com ([217.140.110.172]:51340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgIHKSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:18:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B616631B;
        Tue,  8 Sep 2020 03:18:43 -0700 (PDT)
Received: from [10.163.71.211] (unknown [10.163.71.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B453F66E;
        Tue,  8 Sep 2020 03:18:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
 <20200903165631.GC31409@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b29e2bda-3299-e69f-90cf-1c9bd59a219d@arm.com>
Date:   Tue, 8 Sep 2020 15:48:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200903165631.GC31409@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2020 10:26 PM, Catalin Marinas wrote:
> On Mon, Aug 17, 2020 at 02:49:43PM +0530, Anshuman Khandual wrote:
>> pmd_present() and pmd_trans_huge() are expected to behave in the following
>> manner during various phases of a given PMD. It is derived from a previous
>> detailed discussion on this topic [1] and present THP documentation [2].
>>
>> pmd_present(pmd):
>>
>> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
>> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
> 
> The second bullet doesn't make much sense. If you have a pmd mapping of
> some I/O memory, pmd_present() still returns true (as does
> pte_present()).

Derived this from an earlier discussion (https://lkml.org/lkml/2018/10/17/231)
but current representation here might not be accurate.

Would this be any better ?

pmd_present(pmd):

- Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
- Returns false if pmd refers to a migration or swap entry

> 
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index 4d867c6446c4..28792fdd9627 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -19,6 +19,13 @@
>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>>  #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>  
>> +/*
>> + * This help indicate that the entry is present i.e pmd_page()
> 
> Nit: add another . after i.e

Will fix.

> 
>> + * still points to a valid huge page in memory even if the pmd
>> + * has been invalidated.
>> + */
>> +#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <asm/cpufeature.h>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index d5d3fbe73953..7aa69cace784 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -145,6 +145,18 @@ static inline pte_t set_pte_bit(pte_t pte, pgprot_t prot)
>>  	return pte;
>>  }
>>  
>> +static inline pmd_t clr_pmd_bit(pmd_t pmd, pgprot_t prot)
>> +{
>> +	pmd_val(pmd) &= ~pgprot_val(prot);
>> +	return pmd;
>> +}
> 
> Could you use clear_pmd_bit (instead of clr) for consistency with
> clear_pte_bit()?

Sure, will do.

> 
> It would be good if the mm folk can do a sanity check on the assumptions
> about pmd_present/pmdp_invalidate/pmd_trans_huge.
> 
> The patch looks fine to me otherwise, feel free to add:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
