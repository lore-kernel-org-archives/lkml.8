Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B72AC2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7882E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 00:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgBJAgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:36:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:24790 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgBJAgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 19:36:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 16:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="scan'208";a="232948849"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 09 Feb 2020 16:36:21 -0800
Date:   Mon, 10 Feb 2020 08:36:39 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct
 instead of virtual address to pfn
Message-ID: <20200210003639.GD7326@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209135015.GX8965@MiWiFi-R3L-srv>
 <A25CC0EC-73A0-426D-93A0-DD9DDC43800F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A25CC0EC-73A0-426D-93A0-DD9DDC43800F@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 03:14:28PM +0100, David Hildenbrand wrote:
>
>
>> Am 09.02.2020 um 14:50 schrieb Baoquan He <bhe@redhat.com>:
>> 
>> ﻿On 02/07/20 at 11:26am, Wei Yang wrote:
>>>> On Thu, Feb 06, 2020 at 06:19:46PM -0800, Dan Williams wrote:
>>>> On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>>>> 
>>>>> memmap should be the physical address to page struct instead of virtual
>>>>> address to pfn.
>>>>> 
>>>>> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid at
>>>>> this point.
>>>>> 
>>>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>>> CC: Dan Williams <dan.j.williams@intel.com>
>>>>> ---
>>>>> mm/sparse.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>>> index b5da121bdd6e..56816f653588 100644
>>>>> --- a/mm/sparse.c
>>>>> +++ b/mm/sparse.c
>>>>> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>>>>        /* Align memmap to section boundary in the subsection case */
>>>>>        if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>>>>>                section_nr_to_pfn(section_nr) != start_pfn)
>>>>> -               memmap = pfn_to_kaddr(section_nr_to_pfn(section_nr));
>>>>> +               memmap = pfn_to_page(section_nr_to_pfn(section_nr));
>>>> 
>>>> Yes, this looks obviously correct. This might be tripping up
>>>> makedumpfile. Do you see any practical effects of this bug? The kernel
>>>> mostly avoids ->section_mem_map in the vmemmap case and in the
>>>> !vmemmap case section_nr_to_pfn(section_nr) should always equal
>>>> start_pfn.
>>> 
>>> I took another look into the code. Looks there is no practical effect after
>>> this. Because in the vmemmap case, we don't need ->section_mem_map to retrieve
>>> the real memmap.
>>> 
>>> But leave a inconsistent data in section_mem_map is not a good practice.
>> 
>> Yeah, it does has no pratical effect. I tried to create sub-section
>> alighed namespace, then trigger crash, makedumpfile isn't impacted.
>> Because pmem memory is only added, but not onlined. We don't report it
>> to kdump, makedumpfile will ignore it.
>> 
>> I think it's worth fixing it to encode a correct memmap address. We
>> don't know if in the future this will break anything.
>
>We can have system memory and devmem overlap within a section (which is still buggy and to be fixed in other regard - e.g., pfn_to_online_page() does not work correctly).
>
>E.g., 64 mb of (boot) system memory in a section. Then you can hot-add devmem that spans the remaining 64 mb of that section.
>
>So some of that memory will be kdumped - and should be fixed if broken.
>
>Cheers

Thanks for the explanation, I will add this in the changelog.

>
>
>> 
>> Thanks
>> Baoquan

-- 
Wei Yang
Help you, Help me
