Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F942C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11912076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCTNXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:23:06 -0400
Received: from foss.arm.com ([217.140.110.172]:48920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgCTNXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:23:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 098CC7FA;
        Fri, 20 Mar 2020 06:23:05 -0700 (PDT)
Received: from [10.163.1.20] (unknown [10.163.1.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 849693F85E;
        Fri, 20 Mar 2020 06:23:01 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Make pud_present() check _PAGE_PROTNONE and
 _PAGE_PSE as well
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
References: <1584507679-11976-1-git-send-email-anshuman.khandual@arm.com>
 <c03165c8-6d44-49c2-2dad-a85759200718@arm.com>
 <20200320114741.c62iolt2yzltnscf@box>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2e7a04cf-80cb-58c1-7344-2f8422ed7d31@arm.com>
Date:   Fri, 20 Mar 2020 18:52:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200320114741.c62iolt2yzltnscf@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2020 05:17 PM, Kirill A. Shutemov wrote:
> On Fri, Mar 20, 2020 at 08:53:16AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 03/18/2020 10:31 AM, Anshuman Khandual wrote:
>>> pud_present() should also check _PAGE_PROTNONE and _PAGE_PSE bits like in
>>> case pmd_present(). This makes a PUD entry test positive for pud_present()
>>> after getting invalidated with pud_mknotpresent(), hence standardizing the
>>> semantics with PMD helpers.
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: x86@kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Even though pud_mknotpresent() is not used any where currently, there is
>>> a discrepancy between PMD and PUD.
>>>
>>> WARN_ON(!pud_present(pud_mknotpresent(pud_mkhuge(pud)))) -> Fail
>>> WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd)))) -> Pass
>>>
>>> Though pud_mknotpresent() currently clears _PAGE_PROTNONE, pud_present()
>>> does not check it. This change fixes both inconsistencies.
>>>
>>> This has been build and boot tested on x86.
>>
>> Adding Kirill and Dan.
>>
>> +Cc: Kirill A. Shutemov <kirill@shutemov.name>
>> +Cc: Dan Williams <dan.j.williams@intel.com>
> 
> Or we can just drop the pud_mknotpresent(). There's no users AFAICS and
> only x86 provides it.

Yes that will be an option but IMHO fixing pud_present() here might be
a better choice because,

(1) pud_mknotpresent() with fixed pud_present() might be required later
(2) PMD & PUD will be exact same (THP is supported on either level)

Nonetheless, I am happy to go either way.
