Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA709C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984EA20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHSJLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:11:12 -0400
Received: from foss.arm.com ([217.140.110.172]:59086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgHSJLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:11:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1655B31B;
        Wed, 19 Aug 2020 02:11:10 -0700 (PDT)
Received: from [10.163.66.190] (unknown [10.163.66.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468913F6CF;
        Wed, 19 Aug 2020 02:11:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
 <20200818101301.000027ef@Huawei.com>
 <8db455b6-8fe5-b552-119f-4abab0cc8501@arm.com>
 <20200818132625.00003d05@Huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f05c86f4-7bd7-89d1-6e11-6664bd375654@arm.com>
Date:   Wed, 19 Aug 2020 14:40:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818132625.00003d05@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/18/2020 05:56 PM, Jonathan Cameron wrote:
> On Tue, 18 Aug 2020 15:11:58 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> On 08/18/2020 02:43 PM, Jonathan Cameron wrote:
>>> On Mon, 17 Aug 2020 14:49:43 +0530
>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>   
>>>> pmd_present() and pmd_trans_huge() are expected to behave in the following
>>>> manner during various phases of a given PMD. It is derived from a previous
>>>> detailed discussion on this topic [1] and present THP documentation [2].
>>>>
>>>> pmd_present(pmd):
>>>>
>>>> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
>>>> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
>>>>
>>>> pmd_trans_huge(pmd):
>>>>
>>>> - Returns true if pmd refers to system RAM and is a trans huge mapping
>>>>
>>>> -------------------------------------------------------------------------
>>>> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
>>>> -------------------------------------------------------------------------
>>>> |	Mapped		|	Yes		|	Yes		|
>>>> -------------------------------------------------------------------------
>>>> |	Splitting	|	Yes		|	Yes		|
>>>> -------------------------------------------------------------------------
>>>> |	Migration/Swap	|	No		|	No		|
>>>> -------------------------------------------------------------------------
>>>>
>>>> The problem:
>>>>
>>>> PMD is first invalidated with pmdp_invalidate() before it's splitting. This
>>>> invalidation clears PMD_SECT_VALID as below.
>>>>
>>>> PMD Split -> pmdp_invalidate() -> pmd_mkinvalid -> Clears PMD_SECT_VALID
>>>>
>>>> Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
>>>> on the PMD entry. It will need another bit apart from PMD_SECT_VALID to re-
>>>> affirm pmd_present() as true during the THP split process. To comply with
>>>> above mentioned semantics, pmd_trans_huge() should also check pmd_present()
>>>> first before testing presence of an actual transparent huge mapping.
>>>>
>>>> The solution:
>>>>
>>>> Ideally PMD_TYPE_SECT should have been used here instead. But it shares the
>>>> bit position with PMD_SECT_VALID which is used for THP invalidation. Hence
>>>> it will not be there for pmd_present() check after pmdp_invalidate().
>>>>
>>>> A new software defined PMD_PRESENT_INVALID (bit 59) can be set on the PMD
>>>> entry during invalidation which can help pmd_present() return true and in
>>>> recognizing the fact that it still points to memory.
>>>>
>>>> This bit is transient. During the split process it will be overridden by a
>>>> page table page representing normal pages in place of erstwhile huge page.
>>>> Other pmdp_invalidate() callers always write a fresh PMD value on the entry
>>>> overriding this transient PMD_PRESENT_INVALID bit, which makes it safe.
>>>>
>>>> [1]: https://lkml.org/lkml/2018/10/17/231
>>>> [2]: https://www.kernel.org/doc/Documentation/vm/transhuge.txt  
>>>
>>> Hi Anshuman,
>>>
>>> One query on this.  From my reading of the ARM ARM, bit 59 is not
>>> an ignored bit.  The exact requirements for hardware to be using
>>> it are a bit complex though.
>>>
>>> It 'might' be safe to use it for this, but if so can we have a comment
>>> explaining why.  Also more than possible I'm misunderstanding things!   
>>
>> We are using this bit 59 only when the entry is not active from MMU
>> perspective i.e PMD_SECT_VALID is clear.
>>
> 
> Understood. I guess we ran out of bits that were always ignored so had
> to start using ones that are ignored in this particular state.

Right, there are no more available SW PTE bits.

#define PTE_DIRTY               (_AT(pteval_t, 1) << 55)
#define PTE_SPECIAL             (_AT(pteval_t, 1) << 56)
#define PTE_DEVMAP              (_AT(pteval_t, 1) << 57)
#define PTE_PROT_NONE           (_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */

Earlier I had proposed using PTE_SPECIAL at PMD level for this purpose.
But Catalin prefers these unused bits as the entry is anyway invalid
and which also leaves aside PTE_SPECIAL at mapped PMD for later use.
There is already one comment near PMD_PRESENT_INVALID definition which
explains this situation.

+/*
+ * This help indicate that the entry is present i.e pmd_page()
+ * still points to a valid huge page in memory even if the pmd
+ * has been invalidated.
+ */
+#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
