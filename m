Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A44C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942B920733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJXQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:16:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:47537 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJXQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:16:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 15:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,426,1574150400"; 
   d="scan'208";a="227328311"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 15:16:05 -0800
Date:   Tue, 11 Feb 2020 07:16:23 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v2] mm/sparsemem: get address to page struct instead of
 address to pfn
Message-ID: <20200210231623.GC32495@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200210005048.10437-1-richardw.yang@linux.intel.com>
 <90742479-cbb1-4ea9-c20c-53a1df34b806@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90742479-cbb1-4ea9-c20c-53a1df34b806@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:00:47AM +0100, David Hildenbrand wrote:
>On 10.02.20 01:50, Wei Yang wrote:
>> memmap should be the address to page struct instead of address to pfn.
>> 
>
>"mm/sparsemem: fix wrong address in ms->section_mem_map with sub-sections
>
>We want to store the address of the memmap, not the address of the first
>pfn.
>
>E.g., we can have both (boot) system memory and devmem residing in a
>single section. Once we hot-add the devmem part, the address stored in
>ms->section_mem_map would be wrong, and kdump would not be able to
>dump the right memory.
>"
>
>? See below
>
>> As mentioned by David, if system memory and devmem sit within a
>> section, the mismatch address would lead kdump to dump unexpected
>> memory.
>> 
>> Since sub-section only works for SPARSEMEM_VMEMMAP, pfn_to_page() is
>> valid to get the page struct address at this point.
>> 
>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: Dan Williams <dan.j.williams@intel.com>
>> CC: David Hildenbrand <david@redhat.com>
>> CC: Baoquan He <bhe@redhat.com>
>> 
>> ---
>> v2:
>>   * adjust comment to mention the mismatch data would affect kdump
>> 
>> ---
>>  mm/sparse.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index 586d85662978..4862ec2cfbc0 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -887,7 +887,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>  
>>  	/* Align memmap to section boundary in the subsection case */
>>  	if (section_nr_to_pfn(section_nr) != start_pfn)
>> -		memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>> +		memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>
>I think this whole code should be reworked.
>
>Callee returns a pointer. Caller: Nah, I know it better.
>
>Just nasty.
>
>
>Can we do something like this instead:
>
>
>diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>index 200aef686722..c5091feef29e 100644
>--- a/mm/sparse-vmemmap.c
>+++ b/mm/sparse-vmemmap.c
>@@ -266,5 +266,5 @@ struct page * __meminit
>__populate_section_memmap(unsigned long pfn,
>        if (vmemmap_populate(start, end, nid, altmap))
>                return NULL;
>
>-       return pfn_to_page(pfn);
>+       return pfn_to_page(SECTION_ALIGN_DOWN(pfn));
> }
>diff --git a/mm/sparse.c b/mm/sparse.c
>index c184b69460b7..21902d7931e4 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -788,6 +788,10 @@ static void section_deactivate(unsigned long pfn,
>unsigned long nr_pages,
>                depopulate_section_memmap(pfn, nr_pages, altmap);
> }
>
>+/*
>+ * Returns the memmap of the first pfn of the section (not of
>+ * sub-sections).
>+ */
> static struct page * __meminit section_activate(int nid, unsigned long pfn,
>                unsigned long nr_pages, struct vmem_altmap *altmap)
> {
>@@ -882,9 +886,6 @@ int __meminit sparse_add_section(int nid, unsigned
>long start_pfn,
>        set_section_nid(section_nr, nid);
>        section_mark_present(ms);
>
>-       /* Align memmap to section boundary in the subsection case */
>-       if (section_nr_to_pfn(section_nr) != start_pfn)
>-               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>        sparse_init_one_section(ms, section_nr, memmap, ms->usage, 0);
>
>        return 0;
>
>
>Untested, of course :)

I think you get some point. As you mentioned in the following reply, we need
to adjust poisoning after this change.

This looks like a trade off between two options. I don't have a strong
preference.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
