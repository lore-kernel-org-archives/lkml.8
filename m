Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B0AC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC5B21927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBFWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:14:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:30453 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbgBFWOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:14:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 14:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,411,1574150400"; 
   d="scan'208";a="404626475"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2020 14:14:49 -0800
Date:   Fri, 7 Feb 2020 06:15:06 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200206221506.GA8863@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
 <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
 <20200206135016.GA25537@MiWiFi-R3L-srv>
 <87bb4563-481d-cce9-b916-50a098558210@redhat.com>
 <20200206140703.GB25537@MiWiFi-R3L-srv>
 <c63452a4-6a97-8995-0060-65c65adcad78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63452a4-6a97-8995-0060-65c65adcad78@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:37:40PM +0100, David Hildenbrand wrote:
>On 06.02.20 15:07, Baoquan He wrote:
>> On 02/06/20 at 02:55pm, David Hildenbrand wrote:
>>> On 06.02.20 14:50, Baoquan He wrote:
>>>> On 02/06/20 at 02:28pm, David Hildenbrand wrote:
>>>>> On 06.02.20 13:53, Wei Yang wrote:
>>>>>> When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
>>>>>> doesn't work before sparse_init_one_section() is called. This leads to a
>>>>>> crash when hotplug memory.
>>>>>>
>>>>>> We should use memmap as it did.
>>>>>>
>>>>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>>>> CC: Dan Williams <dan.j.williams@intel.com>
>>>>>> ---
>>>>>>  mm/sparse.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>>>> index 5a8599041a2a..2efb24ff8f96 100644
>>>>>> --- a/mm/sparse.c
>>>>>> +++ b/mm/sparse.c
>>>>>> @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>>>>>  	 * Poison uninitialized struct pages in order to catch invalid flags
>>>>>>  	 * combinations.
>>>>>>  	 */
>>>>>> -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
>>>>>> +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
>>>>>
>>>>> If you add sub-sections that don't fall onto the start of the section,
>>>>>
>>>>> pfn_to_page(start_pfn) != memmap
>>>>>
>>>>> and your patch would break that under SPARSEMEM_VMEMMAP if I am not wrong.
>>>>
>>>> It returns the pfn_to_page(pfn) from __populate_section_memmap() and
>>>> assign to memmap in vmemmap case, how come it breaks anything. Correct
>>>> me if I was wrong.
>>>
>>> I'm sorry, I can't follow :) Can you elaborate?
>>>
>>> Was your comment targeted at why the old code cannot be broken or why
>>> this patch cannot be broken?
>> 
>> Sorry for the confusion :-) the latter. I mean the returned memmap has been
>> at the pfn_to_page(start_pfn) in SPARSEMEM_VMEMMAP case.
>
>Yeah, at least for SPARSEMEM_VMEMMAP it is indeed right. Thanks :)
>
>
>Now, about SPARSEMEM:
>
>populate_section_memmap() does not care about nr_pages and will allocate
>a memmap for the whole section. So, whenever we add sub-sections to a
>section, we allocate a new memmap for the whole section. And we do
>overwrite the memmap pointer in our section. ( sparse_add_section() )
>
>That makes me assume that sub-section hot-add under SPARSEMEM is either
>
>a) never enabled and only works with SPARSEMEM_VMEMMAP
>b) horribly broken
>
>And I think a) applies (looking at pfn_section_valid()). Therefore, we
>don't have to care about sub-section hot-add specifics (and I would be
>broken already)

Yes, I am looking into this problem. Actually, there maybe another problem.

Just get my brain refreshed, need some time to dig into.

>
>Acked-by: David Hildenbrand <david@redhat.com>
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
