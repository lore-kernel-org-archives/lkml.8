Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D9C2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3232121D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgIJJ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:29:02 -0400
Received: from foss.arm.com ([217.140.110.172]:58960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgIJJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:28:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60584101E;
        Thu, 10 Sep 2020 02:28:57 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C4ED3F68F;
        Thu, 10 Sep 2020 02:28:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64/mm: Use CONT_SHIFT to define CONT_PTE_SHIFT
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
References: <20200908071931.47767-1-gshan@redhat.com>
 <20200908071931.47767-2-gshan@redhat.com>
 <459d0f64-fea9-a060-91a5-17a37834fb1b@arm.com>
 <283283a2-f516-6890-ae25-101d2b1b46a2@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <966505a6-16f6-8129-804b-fcf890429fb8@arm.com>
Date:   Thu, 10 Sep 2020 14:58:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <283283a2-f516-6890-ae25-101d2b1b46a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2020 02:01 PM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 9/10/20 4:17 PM, Anshuman Khandual wrote:
>> On 09/08/2020 12:49 PM, Gavin Shan wrote:
>>> The macro CONT_PTE_SHIFT actually depends on CONT_SHIFT, which has
>>> been defined in page-def.h, based on CONFIG_ARM64_CONT_SHIFT. Lets
>>> reflect the dependency.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/include/asm/pgtable-hwdef.h | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>>> index 8a399e666837..0bd9469f4323 100644
>>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>>> @@ -81,14 +81,12 @@
>>>   /*
>>>    * Contiguous page definitions.
>>>    */
>>> +#define CONT_PTE_SHIFT        (CONT_SHIFT + PAGE_SHIFT)
>>>   #ifdef CONFIG_ARM64_64K_PAGES
>>> -#define CONT_PTE_SHIFT        (5 + PAGE_SHIFT)
>>>   #define CONT_PMD_SHIFT        (5 + PMD_SHIFT)
>>>   #elif defined(CONFIG_ARM64_16K_PAGES)
>>> -#define CONT_PTE_SHIFT        (7 + PAGE_SHIFT)
>>>   #define CONT_PMD_SHIFT        (5 + PMD_SHIFT)
>>>   #else
>>> -#define CONT_PTE_SHIFT        (4 + PAGE_SHIFT)
>>>   #define CONT_PMD_SHIFT        (4 + PMD_SHIFT)
>>>   #endif
>> Could not a similar CONT_PMD be created from a new CONFIG_ARM64_CONT_PMD
>> config option, which would help unify CONT_PMD_SHIFT here as well ?
>>
> 
> I was thinking of it, to have CONFIG_ARM64_CONT_PMD and defined the
> following macros in arch/arm64/include/asm/page-def.h:
> 
>    #define CONT_PMD_SHIFT    CONFIG_ARM64_CONT_PMD_SHIFT
>    #define CONT_PMD_SIZE        (_AC(1, UL) << (CONT_PMD_SHIFT + PMD_SHIFT)
>    #define CONT_PMD_MASK        (~(CONT_PMD_SIZE - 1))
> 
> PMD_SHIFT is variable because PMD could be folded into PUD or PGD,
> depending on the kernel configuration. PMD_SHIFT is declared

Even CONT_PMD_SHIFT via the new CONFIG_ARM64_CONT_PMD_SHIFT will
be a variable as well depending on page size.

> in arch/arm64/include/asm/pgtable-types.h, which isn't supposed
> to be included in "page-def.h".

Are there build failures if <pgtable-types.h> is included from <page-def.h> ?

> 
> So the peroper way to handle this might be drop the continuous page
> macros in page-def.h and introduce the following ones into pgtable-hwdef.h.
> I will post v2 to do this if it sounds good to you.

Sure, go ahead if that builds. But unifying both these macros seems cleaner.

> 
>    #define CONT_PTE_SHIFT         (CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
>    #define CONT_PMD_SHIFT         (CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
> 
> Thanks,
> Gavin
> 
>
