Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA978C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835572078B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 03:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGGDvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 23:51:21 -0400
Received: from foss.arm.com ([217.140.110.172]:42876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGGDvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:51:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90E72C0A;
        Mon,  6 Jul 2020 20:51:19 -0700 (PDT)
Received: from [10.163.86.118] (unknown [10.163.86.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E34973F718;
        Mon,  6 Jul 2020 20:51:11 -0700 (PDT)
Subject: Re: [PATCH V4 1/3] mm/sparsemem: Enable vmem_altmap support in
 vmemmap_populate_basepages()
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     justin.he@arm.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1594004178-8861-1-git-send-email-anshuman.khandual@arm.com>
 <1594004178-8861-2-git-send-email-anshuman.khandual@arm.com>
 <eeeb44f9-bc0a-2c3d-8e8f-7e3d9e066c7e@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7ac5ff78-378c-37e2-444f-9f72844b8697@arm.com>
Date:   Tue, 7 Jul 2020 09:20:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <eeeb44f9-bc0a-2c3d-8e8f-7e3d9e066c7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/2020 02:33 PM, David Hildenbrand wrote:
>>  	return 0;
>> @@ -1505,7 +1505,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  	int err;
>>  
>>  	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>> -		err = vmemmap_populate_basepages(start, end, node);
>> +		err = vmemmap_populate_basepages(start, end, node, NULL);
>>  	else if (boot_cpu_has(X86_FEATURE_PSE))
>>  		err = vmemmap_populate_hugepages(start, end, node, altmap);
>>  	else if (altmap) {
> 
> It's somewhat weird that we don't allocate basepages from altmap on x86
> (both for sub-sections and without PSE). I wonder if we can simply
> unlock that with your change. Especially, also handle the
> !X86_FEATURE_PSE case below properly with an altmap.
> 
> a) all hw with PMEM has PSE - except special QEMU setups, so nobody
> cared to implement. For the sub-section special case, nobody cared about
> a handfull of memmap not ending up on the altmap. (but it's still wasted
> system memory IIRC).
> 
> b) the pagetable overhead for small pages is not-neglectable and might
> result in similar issues as solved by the switch to altmap on very huge
> PMEM (with small amount of system RAM).
> 
> I guess it is due to a).

Hmm, I assume these are some decisions that x86 platform will have to
make going forward in a subsequent patch as the third patch does for
the arm64 platform. But it is clearly beyond the scope of this patch
which never intended to change existing behavior on a given platform.

> 
> [...]
> 
>>  
>> -pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node)
>> +pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
>> +				       struct vmem_altmap *altmap)
>>  {
>>  	pte_t *pte = pte_offset_kernel(pmd, addr);
>>  	if (pte_none(*pte)) {
>>  		pte_t entry;
>> -		void *p = vmemmap_alloc_block_buf(PAGE_SIZE, node);
>> +		void *p;
>> +
>> +		if (altmap)
>> +			p = altmap_alloc_block_buf(PAGE_SIZE, altmap);
>> +		else
>> +			p = vmemmap_alloc_block_buf(PAGE_SIZE, node);
>>  		if (!p)
>>  			return NULL;
> 
> I was wondering if
> 
> if (altmap)
> 	p = altmap_alloc_block_buf(PAGE_SIZE, altmap);
> if (!p)
> 	p = vmemmap_alloc_block_buf(PAGE_SIZE, node);
> if (!p)
> 	return NULL
> 
> Would make sense. But I guess this isn't really relevant in practice,
> because the altmap is usually sized properly.
> 
> In general, LGTM.

Okay, I assume that no further changes are required here.
