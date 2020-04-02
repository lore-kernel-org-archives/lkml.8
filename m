Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA2CC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050C8212CC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT+pqZBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389664AbgDBQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:04:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54212 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389510AbgDBQEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585843439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=LC1IhDGMwOoCs1ATU0smmtXiTC7wJag/6mmsKHxnpiI=;
        b=JT+pqZBCc7YJROtc6UaiGpLsyeykPmfZGXmXDntMMU2clHcgXXZ5VJyRGgOcQEkoACeuBo
        sFkwk5PPeZtiFN4z0TA5sNdFYc2SYPLbNz+WHiQNvF9SfUlzJAJq0a54uBiTn8Dx535s8G
        U08OE9cXSGSp3dCneK3gg8krBTTwgqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-eCl0v7XiM9SgJSiEucJ0BQ-1; Thu, 02 Apr 2020 12:03:57 -0400
X-MC-Unique: eCl0v7XiM9SgJSiEucJ0BQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2958F18A8C80;
        Thu,  2 Apr 2020 16:03:56 +0000 (UTC)
Received: from [10.36.114.29] (ovpn-114-29.ams2.redhat.com [10.36.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0646910002D0;
        Thu,  2 Apr 2020 16:03:54 +0000 (UTC)
Subject: Re: [PATVH v1 RESEND] mm: remove unused
 free_bootmem_with_active_regions
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
References: <20200402143455.5145-1-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <482901b3-f114-a34a-799a-866138ea9ad6@redhat.com>
Date:   Thu, 2 Apr 2020 18:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402143455.5145-1-bhe@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.04.20 16:34, Baoquan He wrote:
> Since commit 397dc00e249ec64e10 ("mips: sgi-ip27: switch from DISCONTIGMEM
> to SPARSEMEM"), the last caller of free_bootmem_with_active_regions() was
> gone. Now no user calls it any more.
> 
> Let's remove it.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> RESEND:
>   To add linux-mm to CC list.
> 
>  include/linux/mm.h |  4 ----
>  mm/page_alloc.c    | 25 -------------------------
>  2 files changed, 29 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1cd8b8f8534d..9c093f7c751d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2363,8 +2363,6 @@ static inline unsigned long get_num_physpages(void)
>   * 	memblock_add_node(base, size, nid)
>   * free_area_init_nodes(max_zone_pfns);
>   *
> - * free_bootmem_with_active_regions() calls free_bootmem_node() for each
> - * registered physical page range.  Similarly
>   * sparse_memory_present_with_active_regions() calls memory_present() for
>   * each range when SPARSEMEM is enabled.
>   *
> @@ -2380,8 +2378,6 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>  extern void get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn);
>  extern unsigned long find_min_pfn_with_active_regions(void);
> -extern void free_bootmem_with_active_regions(int nid,
> -						unsigned long max_low_pfn);
>  extern void sparse_memory_present_with_active_regions(int nid);
>  
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 138a56c0f48f..2892ebeaa6c9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6356,31 +6356,6 @@ int __meminit __early_pfn_to_nid(unsigned long pfn,
>  }
>  #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
>  
> -/**
> - * free_bootmem_with_active_regions - Call memblock_free_early_nid for each active range
> - * @nid: The node to free memory on. If MAX_NUMNODES, all nodes are freed.
> - * @max_low_pfn: The highest PFN that will be passed to memblock_free_early_nid
> - *
> - * If an architecture guarantees that all ranges registered contain no holes
> - * and may be freed, this this function may be used instead of calling
> - * memblock_free_early_nid() manually.
> - */
> -void __init free_bootmem_with_active_regions(int nid, unsigned long max_low_pfn)
> -{
> -	unsigned long start_pfn, end_pfn;
> -	int i, this_nid;
> -
> -	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, &this_nid) {
> -		start_pfn = min(start_pfn, max_low_pfn);
> -		end_pfn = min(end_pfn, max_low_pfn);
> -
> -		if (start_pfn < end_pfn)
> -			memblock_free_early_nid(PFN_PHYS(start_pfn),
> -					(end_pfn - start_pfn) << PAGE_SHIFT,
> -					this_nid);
> -	}
> -}
> -
>  /**
>   * sparse_memory_present_with_active_regions - Call memory_present for each active range
>   * @nid: The node to call memory_present for. If MAX_NUMNODES, all nodes will be used.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

