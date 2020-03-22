Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0762C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 01:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D2F20776
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 01:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgCVBAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 21:00:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCVBAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 21:00:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B3131B;
        Sat, 21 Mar 2020 18:00:42 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8DE63F305;
        Sat, 21 Mar 2020 18:00:38 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Make pud_present() check _PAGE_PROTNONE and
 _PAGE_PSE as well
To:     John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
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
 <2e7a04cf-80cb-58c1-7344-2f8422ed7d31@arm.com>
 <082aae4a-b190-7b54-eda9-0bbc28c8a6b3@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0a3ac234-303c-26b7-abb7-de42025b3e0d@arm.com>
Date:   Sun, 22 Mar 2020 06:30:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <082aae4a-b190-7b54-eda9-0bbc28c8a6b3@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/21/2020 01:20 AM, John Hubbard wrote:
> On 3/20/20 6:22 AM, Anshuman Khandual wrote:
> ...
>>>> +Cc: Kirill A. Shutemov <kirill@shutemov.name>
>>>> +Cc: Dan Williams <dan.j.williams@intel.com>
>>>
>>> Or we can just drop the pud_mknotpresent(). There's no users AFAICS and
>>> only x86 provides it.
> 
> +1
> 
>>
>> Yes that will be an option but IMHO fixing pud_present() here might be
>> a better choice because,
>>
>> (1) pud_mknotpresent() with fixed pud_present() might be required later
> 
> 
> It might. Or it might not. Let's wait until it's actually used, and see.
> Dead code is an avoidable expense (adds size, space on the screen, email
> traffic and other wasted time), so let's avoid it here.


Sure, will resend with pud_mknotpresent() dropped.

> 
> 
>> (2) PMD & PUD will be exact same (THP is supported on either level)
>>
>> Nonetheless, I am happy to go either way.
>>
> 
> 
> thanks,
