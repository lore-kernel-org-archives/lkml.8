Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88AC18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAAC21739
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSvjJy/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCIJAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgCIJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583744448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Ol0a10fhXS7pBH4kUfBRUpwmxg7Xm0ZhyzgQDM9wbok=;
        b=fSvjJy/V50helgmqLpVbEhfQt0apeKQjxWQhdOWjV2ehpvD1d9gcHbqZ6psyQZjN4Yc+A6
        7xFbvAsg3nnjt3XMaYSo2f0ghbtywtqJVhhW7y8V+7p1QRC4u/+yqIaYGaWHxabQSoTfzi
        LTM2DBmuXSkYoQBcWeKMB/eSKOG+2bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189--AK_XTlCO_ushKVhLG7THA-1; Mon, 09 Mar 2020 05:00:44 -0400
X-MC-Unique: -AK_XTlCO_ushKVhLG7THA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B82B78010E7;
        Mon,  9 Mar 2020 09:00:42 +0000 (UTC)
Received: from [10.36.118.32] (unknown [10.36.118.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 467B362667;
        Mon,  9 Mar 2020 09:00:39 +0000 (UTC)
Subject: Re: [PATCH v3 4/7] mm/sparse.c: only use subsection map in VMEMMAP
 case
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-5-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <b62c23fe-e137-db65-8818-2b8f5013ef74@redhat.com>
Date:   Mon, 9 Mar 2020 10:00:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307084229.28251-5-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.20 09:42, Baoquan He wrote:
> Currently, to support subsection aligned memory region adding for pmem,
> subsection map is added to track which subsection is present.
> 
> However, config ZONE_DEVICE depends on SPARSEMEM_VMEMMAP. It means
> subsection map only makes sense when SPARSEMEM_VMEMMAP enabled. For the
> classic sparse, subsection map is meaningless and confusing.
> 
> About the classic sparse which doesn't support subsection hotplug, Dan
> said it's more because the effort and maintenance burden outweighs the
> benefit. Besides, the current 64 bit ARCHes all enable
> SPARSEMEM_VMEMMAP_ENABLE by default.
> 
> Combining the above reasons, no need to provide subsection map and the
> relevant handling for the classic sparse. Handle it with this patch.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/sparse.c            | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 42b77d3b68e8..f3f264826423 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1143,7 +1143,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
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
> index d9dcd58d5c1d..2142045ab5c5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -209,6 +209,7 @@ static inline unsigned long first_present_section_nr(void)
>  	return next_present_section_nr(-1);
>  }
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  static void subsection_mask_set(unsigned long *map, unsigned long pfn,
>  		unsigned long nr_pages)
>  {
> @@ -243,6 +244,11 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  		nr_pages -= pfns;
>  	}
>  }
> +#else
> +void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
> +{
> +}
> +#endif
>  
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
> @@ -726,6 +732,7 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  {
>  	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
> @@ -753,6 +760,17 @@ static bool is_subsection_map_empty(struct mem_section *ms)
>  	return bitmap_empty(&ms->usage->subsection_map[0],
>  			    SUBSECTIONS_PER_SECTION);
>  }
> +#else
> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return 0;
> +}
> +
> +static bool is_subsection_map_empty(struct mem_section *ms)
> +{
> +	return true;
> +}
> +#endif
>  
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
> @@ -809,6 +827,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		ms->section_mem_map = (unsigned long)NULL;
>  }
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  {
>  	struct mem_section *ms = __pfn_to_section(pfn);
> @@ -830,6 +849,12 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  
>  	return rc;
>  }
> +#else
> +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  		unsigned long nr_pages, struct vmem_altmap *altmap)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

