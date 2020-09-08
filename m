Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB31C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31540206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIHKlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:41:55 -0400
Received: from foss.arm.com ([217.140.110.172]:51428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgIHK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C7531B;
        Tue,  8 Sep 2020 03:26:08 -0700 (PDT)
Received: from [10.163.71.211] (unknown [10.163.71.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8153F66E;
        Tue,  8 Sep 2020 03:26:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
To:     Ralph Campbell <rcampbell@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
 <20200903165631.GC31409@gaia>
 <5e148194-58c2-89c2-2cd8-9f2086f1e090@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <93ef8d6a-c86a-956b-5f06-5f2e67b6fd04@arm.com>
Date:   Tue, 8 Sep 2020 15:55:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5e148194-58c2-89c2-2cd8-9f2086f1e090@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2020 11:01 PM, Ralph Campbell wrote:
> 
> On 9/3/20 9:56 AM, Catalin Marinas wrote:
>> On Mon, Aug 17, 2020 at 02:49:43PM +0530, Anshuman Khandual wrote:
>>> pmd_present() and pmd_trans_huge() are expected to behave in the following
>>> manner during various phases of a given PMD. It is derived from a previous
>>> detailed discussion on this topic [1] and present THP documentation [2].
>>>
>>> pmd_present(pmd):
>>>
>>> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
>>> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
>>
>> The second bullet doesn't make much sense. If you have a pmd mapping of
>> some I/O memory, pmd_present() still returns true (as does
>> pte_present()).
>>
>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>>> index 4d867c6446c4..28792fdd9627 100644
>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>> @@ -19,6 +19,13 @@
>>>   #define PTE_DEVMAP        (_AT(pteval_t, 1) << 57)
>>>   #define PTE_PROT_NONE        (_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>>   +/*
>>> + * This help indicate that the entry is present i.e pmd_page()
>>
>> Nit: add another . after i.e
> 
> Another nit: "This help indicate" => "This helper indicates"
> 
> Maybe I should look at the series more. :-)

It is talking about the new PTE bit being used here not any
helper. Though the following replacement might be better.

s/This help indicate/This bit indicates/

/*
 * This help indicate that the entry is present i.e pmd_page()
 * still points to a valid huge page in memory even if the pmd
 * has been invalidated.
 */
#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
