Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C7EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F1320663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHKFnRiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgG1Nsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:48:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730018AbgG1Nsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595944124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8WvcTzlaZOUusoNr92B8iYPaRM3BXRIbJcPYBAC7jk=;
        b=KHKFnRiMRrqV/rr1/EYKTAvtV7HXEqa9xtNy+4MjCIKd4V6YYXNOgie69wHeA1M+xaiJN9
        FptP02s2TrXHFbHjW/NwiZrGLI+wlWulWsUL+H++e32f29YNGVNg67G51ug+c6H+6mj3BB
        yOPsdWGWfjXHHNZiRoFj7wYoGKea+VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-GSqdVu7yP1iAC4jVWkZ1Jw-1; Tue, 28 Jul 2020 09:48:41 -0400
X-MC-Unique: GSqdVu7yP1iAC4jVWkZ1Jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B061879EC1;
        Tue, 28 Jul 2020 13:48:40 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BCFF712FA;
        Tue, 28 Jul 2020 13:48:31 +0000 (UTC)
Date:   Tue, 28 Jul 2020 21:48:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 1/6] mm/page_alloc: tweak comments in
 has_unmovable_pages()
Message-ID: <20200728134826.GC14854@MiWiFi-R3L-srv>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630142639.22770-2-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 at 04:26pm, David Hildenbrand wrote:
> Let's move the split comment regarding bootmem allocations and memory
> holes, especially in the context of ZONE_MOVABLE, to the PageReserved()
> check.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48eb0f1410d47..bd3ebf08f09b9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8207,14 +8207,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  	unsigned long iter = 0;
>  	unsigned long pfn = page_to_pfn(page);
>  
> -	/*
> -	 * TODO we could make this much more efficient by not checking every
> -	 * page in the range if we know all of them are in MOVABLE_ZONE and
> -	 * that the movable zone guarantees that pages are migratable but
> -	 * the later is not the case right now unfortunatelly. E.g. movablecore
> -	 * can still lead to having bootmem allocations in zone_movable.
> -	 */
> -
>  	if (is_migrate_cma_page(page)) {
>  		/*
>  		 * CMA allocations (alloc_contig_range) really need to mark
> @@ -8233,6 +8225,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  
>  		page = pfn_to_page(pfn + iter);
>  
> +		/*
> +		 * Both, bootmem allocations and memory holes are marked
> +		 * PG_reserved and are unmovable. We can even have unmovable
> +		 * allocations inside ZONE_MOVABLE, for example when
> +		 * specifying "movable_core".
                               ~~~~ should be 'movablecore', we don't
have kernel parameter 'movable_core'.

Otherwise, this looks good to me. Esp the code comment at below had been
added very long time ago and obsolete.

Reviewed-by: Baoquan He <bhe@redhat.com>

By the way, David, do you know what is the situation of having unmovable
allocations inside ZONE_MOVABLE when specifying 'movablecore'? I quickly
went through find_zone_movable_pfns_for_nodes(), but didn't get why.
Could you tell a little more detail about it?

Thanks
Baoquan

> +		 */
>  		if (PageReserved(page))
>  			return page;
>  
> @@ -8306,14 +8304,6 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 * it.  But now, memory offline itself doesn't call
>  		 * shrink_node_slabs() and it still to be fixed.
>  		 */
> -		/*
> -		 * If the page is not RAM, page_count()should be 0.
> -		 * we don't need more check. This is an _used_ not-movable page.
> -		 *
> -		 * The problematic thing here is PG_reserved pages. PG_reserved
> -		 * is set to both of a memory hole page and a _used_ kernel
> -		 * page at boot.
> -		 */
>  		return page;
>  	}
>  	return NULL;
> -- 
> 2.26.2
> 
> 

