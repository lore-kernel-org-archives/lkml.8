Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE61C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236352074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irLV6gPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbgDBOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:15:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33513 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbgDBOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/NnxDdtgwEZ+TVZ4jXBlyAA2S9VMCI2rhhiMlOf0fUc=;
        b=irLV6gPmYoGhxKMhlmwTWrdX/Pxj4FOIIcBCZjs7tvGVmtGAQuEkLXxpwg6kjLQqAvYhOw
        k7GBQyIa7qm6bcni2eNsaUP33o9K0coXpZp+JB4N+jRwt9Vf4JxbBtvM3pXE0fOLIrX6J7
        uKMssbLcc6sgpUeIiSuInU9/S/maqHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-fcOVqN60NGWHY3Ez7Cuocg-1; Thu, 02 Apr 2020 10:15:45 -0400
X-MC-Unique: fcOVqN60NGWHY3Ez7Cuocg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ADB6101FC6A;
        Thu,  2 Apr 2020 14:15:44 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84BD35C64E;
        Thu,  2 Apr 2020 14:15:43 +0000 (UTC)
Date:   Thu, 2 Apr 2020 22:15:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
Subject: Re: [PATCH] mm: remove unused free_bootmem_with_active_regions
Message-ID: <20200402141540.GM2402@MiWiFi-R3L-srv>
References: <20200402135233.3253-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402135233.3253-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/20 at 09:52pm, Baoquan He wrote:
> In commit 397dc00e249ec64e10 ("mips: sgi-ip27: switch from DISCONTIGMEM
> to SPARSEMEM"), the last caller was gone. Now no user calls
> function free_bootmem_with_active_regions() any more.
> 
> Let's remove it.

Sorry, Andrew. Seems the linux-mm was not added into CC successfully. I
will repost one to add linux-mm.

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
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
> -- 
> 2.17.2
> 

