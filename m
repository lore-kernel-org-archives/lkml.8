Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3751CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B35C204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgGCGcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:32:33 -0400
Received: from foss.arm.com ([217.140.110.172]:54846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCGcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:32:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD9431B;
        Thu,  2 Jul 2020 23:32:32 -0700 (PDT)
Received: from [10.163.85.168] (unknown [10.163.85.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20083F73C;
        Thu,  2 Jul 2020 23:32:27 -0700 (PDT)
Subject: Re: [PATCH V3 (RESEND) 2/3] mm/sparsemem: Enable vmem_altmap support
 in vmemmap_alloc_block_buf()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1592442930-9380-1-git-send-email-anshuman.khandual@arm.com>
 <1592442930-9380-3-git-send-email-anshuman.khandual@arm.com>
 <20200702140752.GF22241@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ef468b16-ca28-7d5d-c5fc-eb2e31de5e03@arm.com>
Date:   Fri, 3 Jul 2020 12:02:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200702140752.GF22241@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2020 07:37 PM, Catalin Marinas wrote:
> On Thu, Jun 18, 2020 at 06:45:29AM +0530, Anshuman Khandual wrote:
>> There are many instances where vmemap allocation is often switched between
>> regular memory and device memory just based on whether altmap is available
>> or not. vmemmap_alloc_block_buf() is used in various platforms to allocate
>> vmemmap mappings. Lets also enable it to handle altmap based device memory
>> allocation along with existing regular memory allocations. This will help
>> in avoiding the altmap based allocation switch in many places.
>>
>> While here also implement a regular memory allocation fallback mechanism
>> when the first preferred device memory allocation fails. This will ensure
>> preserving the existing semantics on powerpc platform. To summarize there
>> are three different methods to call vmemmap_alloc_block_buf().
>>
>> (., NULL,   false) /* Allocate from system RAM */
>> (., altmap, false) /* Allocate from altmap without any fallback */
>> (., altmap, true)  /* Allocate from altmap with fallback (system RAM) */
> [...]
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index bc73abf0bc25..01e25b56eccb 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -225,12 +225,12 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  		 * fall back to system memory if the altmap allocation fail.
>>  		 */
>>  		if (altmap && !altmap_cross_boundary(altmap, start, page_size)) {
>> -			p = altmap_alloc_block_buf(page_size, altmap);
>> -			if (!p)
>> -				pr_debug("altmap block allocation failed, falling back to system memory");
>> +			p = vmemmap_alloc_block_buf(page_size, node,
>> +						    altmap, true);
>> +		} else {
>> +			p = vmemmap_alloc_block_buf(page_size, node,
>> +						    NULL, false);
>>  		}
>> -		if (!p)
>> -			p = vmemmap_alloc_block_buf(page_size, node);
>>  		if (!p)
>>  			return -ENOMEM;
> 
> Is the fallback argument actually necessary. It may be cleaner to just
> leave the code as is with the choice between altmap and NULL. If an arch
> needs a fallback (only powerpc), they have the fallback in place
> already. I don't see the powerpc code any better after this change.
> 
> I'm fine with the altmap argument though.

Okay. Will drop 'fallback' from vmemmap_alloc_block_buf() and update the
callers. There will also be a single change in the subsequent patch i.e
vmemmap_alloc_block_buf(PMD_SIZE, node, altmap).
