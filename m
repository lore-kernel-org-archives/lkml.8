Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FECC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81862206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiihVkXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgBKOoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:44:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727728AbgBKOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581432242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=uAHcU0DLzxQXBYpa77rH82yGh62uKXEZw79Lk5hu0z0=;
        b=ZiihVkXKJvCd/TP3MjqabpHuzhgXsSUQ3pUQy5pZzt6TdUEtFb8DKN1rWWICQPR4bFDfBe
        gSihG/Af7ALNr59cwhKaSFg9EK0i7/XloBOdbteL7AUVXwl8WLh811yVpm5Z1CXmOvqaVG
        YngZY43Ut//kChdo1+d0TU4AfheenE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-XsXpp8QIP--4OvJ2Pf6YDg-1; Tue, 11 Feb 2020 09:43:57 -0500
X-MC-Unique: XsXpp8QIP--4OvJ2Pf6YDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70B15A0CC1;
        Tue, 11 Feb 2020 14:43:56 +0000 (UTC)
Received: from [10.36.117.14] (ovpn-117-14.ams2.redhat.com [10.36.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C485A5DA7B;
        Tue, 11 Feb 2020 14:43:54 +0000 (UTC)
Subject: Re: [PATCH 3/7] mm/sparse.c: only use subsection map in VMEMMAP case
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-4-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <be1625c4-6875-cfba-9894-f9c148cfe4e7@redhat.com>
Date:   Tue, 11 Feb 2020 15:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200209104826.3385-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.20 11:48, Baoquan He wrote:
> Currently, subsection map is used when SPARSEMEM is enabled, including
> VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
> and misleading. Let's adjust code to only allow subsection map being
> used in SPARSEMEM|VMEMMAP case.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/mmzone.h |   2 +
>  mm/sparse.c            | 231 ++++++++++++++++++++++-------------------
>  2 files changed, 124 insertions(+), 109 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..fc0de3a9a51e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
>  #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
>  
>  struct mem_section_usage {
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> +#endif
>  	/* See declaration of similar field in struct zone */
>  	unsigned long pageblock_flags[0];
>  };
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 696f6b9f706e..cf55d272d0a9 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -209,41 +209,6 @@ static inline unsigned long first_present_section_nr(void)
>  	return next_present_section_nr(-1);
>  }
>  
> -static void subsection_mask_set(unsigned long *map, unsigned long pfn,
> -		unsigned long nr_pages)
> -{
> -	int idx = subsection_map_index(pfn);
> -	int end = subsection_map_index(pfn + nr_pages - 1);
> -
> -	bitmap_set(map, idx, end - idx + 1);
> -}
> -
> -void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> -{
> -	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
> -
> -	if (!nr_pages)
> -		return;
> -
> -	for (nr = start_sec; nr <= end_sec; nr++) {
> -		struct mem_section *ms;
> -		unsigned long pfns;
> -
> -		pfns = min(nr_pages, PAGES_PER_SECTION
> -				- (pfn & ~PAGE_SECTION_MASK));
> -		ms = __nr_to_section(nr);
> -		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
> -
> -		pr_debug("%s: sec: %lu pfns: %lu set(%d, %d)\n", __func__, nr,
> -				pfns, subsection_map_index(pfn),
> -				subsection_map_index(pfn + pfns - 1));
> -
> -		pfn += pfns;
> -		nr_pages -= pfns;
> -	}
> -}
> -
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
>  {
> @@ -432,12 +397,134 @@ static unsigned long __init section_map_size(void)
>  	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
>  }
>  
> +static void subsection_mask_set(unsigned long *map, unsigned long pfn,
> +		unsigned long nr_pages)
> +{
> +	int idx = subsection_map_index(pfn);
> +	int end = subsection_map_index(pfn + nr_pages - 1);
> +
> +	bitmap_set(map, idx, end - idx + 1);
> +}
> +
> +void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> +	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
> +
> +	if (!nr_pages)
> +		return;
> +
> +	for (nr = start_sec; nr <= end_sec; nr++) {
> +		struct mem_section *ms;
> +		unsigned long pfns;
> +
> +		pfns = min(nr_pages, PAGES_PER_SECTION
> +				- (pfn & ~PAGE_SECTION_MASK));
> +		ms = __nr_to_section(nr);
> +		subsection_mask_set(ms->usage->subsection_map, pfn, pfns);
> +
> +		pr_debug("%s: sec: %lu pfns: %lu set(%d, %d)\n", __func__, nr,
> +				pfns, subsection_map_index(pfn),
> +				subsection_map_index(pfn + pfns - 1));
> +
> +		pfn += pfns;
> +		nr_pages -= pfns;
> +	}
> +}
> +
> +/**
> + * clear_subsection_map - Clear subsection map of one memory region
> + *
> + * @pfn - start pfn of the memory range
> + * @nr_pages - number of pfns to add in the region
> + *
> + * This is only intended for hotplug, and clear the related subsection
> + * map inside one section.
> + *
> + * Return:
> + * * -EINVAL	- Section already deactived.
> + * * 0		- Subsection map is emptied.
> + * * 1		- Subsection map is not empty.
> + */
> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> +	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +	unsigned long *subsection_map = ms->usage
> +		? &ms->usage->subsection_map[0] : NULL;
> +
> +	subsection_mask_set(map, pfn, nr_pages);
> +	if (subsection_map)
> +		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> +
> +	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> +				"section already deactivated (%#lx + %ld)\n",
> +				pfn, nr_pages))
> +		return -EINVAL;
> +
> +	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> +
> +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/**
> + * fill_subsection_map - fill subsection map of a memory region
> + * @pfn - start pfn of the memory range
> + * @nr_pages - number of pfns to add in the region
> + *
> + * This clears the related subsection map inside one section, and only
> + * intended for hotplug.
> + *
> + * Return:
> + * * 0		- On success.
> + * * -EINVAL	- Invalid memory region.
> + * * -EEXIST	- Subsection map has been set.
> + */
> +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> +	unsigned long *subsection_map;
> +	int rc = 0;
> +
> +	subsection_mask_set(map, pfn, nr_pages);
> +
> +	subsection_map = &ms->usage->subsection_map[0];
> +
> +	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> +		rc = -EINVAL;
> +	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> +		rc = -EEXIST;
> +	else
> +		bitmap_or(subsection_map, map, subsection_map,
> +				SUBSECTIONS_PER_SECTION);
> +
> +	return rc;
> +}
> +
>  #else
>  static unsigned long __init section_map_size(void)
>  {
>  	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>  }
>  
> +void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +}
> +
> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return 0;
> +}
> +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return 0;
> +}
> +
>  struct page __init *__populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
> @@ -726,45 +813,6 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
> -/**
> - * clear_subsection_map - Clear subsection map of one memory region
> - *
> - * @pfn - start pfn of the memory range
> - * @nr_pages - number of pfns to add in the region
> - *
> - * This is only intended for hotplug, and clear the related subsection
> - * map inside one section.
> - *
> - * Return:
> - * * -EINVAL	- Section already deactived.
> - * * 0		- Subsection map is emptied.
> - * * 1		- Subsection map is not empty.
> - */
> -static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> -{
> -	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> -	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
> -	struct mem_section *ms = __pfn_to_section(pfn);
> -	unsigned long *subsection_map = ms->usage
> -		? &ms->usage->subsection_map[0] : NULL;
> -
> -	subsection_mask_set(map, pfn, nr_pages);
> -	if (subsection_map)
> -		bitmap_and(tmp, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -
> -	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
> -				"section already deactivated (%#lx + %ld)\n",
> -				pfn, nr_pages))
> -		return -EINVAL;
> -
> -	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -
> -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> -		return 0;
> -
> -	return 1;
> -}
> -
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
>  {
> @@ -818,41 +866,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		depopulate_section_memmap(pfn, nr_pages, altmap);
>  }
>  
> -/**
> - * fill_subsection_map - fill subsection map of a memory region
> - * @pfn - start pfn of the memory range
> - * @nr_pages - number of pfns to add in the region
> - *
> - * This clears the related subsection map inside one section, and only
> - * intended for hotplug.
> - *
> - * Return:
> - * * 0		- On success.
> - * * -EINVAL	- Invalid memory region.
> - * * -EEXIST	- Subsection map has been set.
> - */
> -static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> -{
> -	struct mem_section *ms = __pfn_to_section(pfn);
> -	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> -	unsigned long *subsection_map;
> -	int rc = 0;
> -
> -	subsection_mask_set(map, pfn, nr_pages);
> -
> -	subsection_map = &ms->usage->subsection_map[0];
> -
> -	if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> -		rc = -EINVAL;
> -	else if (bitmap_intersects(map, subsection_map, SUBSECTIONS_PER_SECTION))
> -		rc = -EEXIST;
> -	else
> -		bitmap_or(subsection_map, map, subsection_map,
> -				SUBSECTIONS_PER_SECTION);
> -
> -	return rc;
> -}
> -
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
>  {
> 

I'd prefer adding more ifdefs to avoid heavy code movement. Would make
it much easier to review :)

-- 
Thanks,

David / dhildenb

