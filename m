Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C65BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDDC20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ2nVyDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgG2NY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:24:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726981AbgG2NY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596029065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+6rKXaDig00lyfo9s/ybP+H50PWcqOHwLytlqkMNFQ=;
        b=iZ2nVyDqG6FJbbhQZ+Fwd+3H6L/dGyGNi6xMVqa1O9if7EmrEiOAUjM2ihI6B38aZZsOyb
        Gr5n8r7XVXCZq3YN4OW/9KPnaG8XPOd77+mYdkw4l7lh9k/ge9jSaIL15sNSK4DKKpITEr
        DIJRlYvXodyvBQDBsmitXLmWrv0XcCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-TKDYlOnqMN2Dbzl4Rd5ZAA-1; Wed, 29 Jul 2020 09:24:22 -0400
X-MC-Unique: TKDYlOnqMN2Dbzl4Rd5ZAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A3E102C7F2;
        Wed, 29 Jul 2020 13:24:20 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 385D75F7D8;
        Wed, 29 Jul 2020 13:24:14 +0000 (UTC)
Date:   Wed, 29 Jul 2020 21:24:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 3/6] mm/page_isolation: drop WARN_ON_ONCE() in
 set_migratetype_isolate()
Message-ID: <20200729132410.GG14854@MiWiFi-R3L-srv>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630142639.22770-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 at 04:26pm, David Hildenbrand wrote:
> Inside has_unmovable_pages(), we have a comment describing how unmovable
> data could end up in ZONE_MOVABLE - via "movable_core". Also, besides
					  ~~~ 'movablecore'
> checking if the first page in the pageblock is reserved, we don't
> perform any further checks in case of ZONE_MOVABLE.
> 
> In case of memory offlining, we set REPORT_FAILURE, properly
> dump_page() the page and handle the error gracefully.
> alloc_contig_pages() users currently never allocate from ZONE_MOVABLE.
> E.g., hugetlb uses alloc_contig_pages() for the allocation of gigantic
> pages only, which will never end up on the MOVABLE zone
> (see htlb_alloc_mask()).
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 553b49a34cf71..02a01bff6b219 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -58,16 +58,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  	if (!ret) {
>  		drain_all_pages(zone);
> -	} else {
> -		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -
> -		if ((isol_flags & REPORT_FAILURE) && unmovable)
> -			/*
> -			 * printk() with zone->lock held will likely trigger a
> -			 * lockdep splat, so defer it here.
> -			 */
> -			dump_page(unmovable, "unmovable page");
> -	}
> +	} else if ((isol_flags & REPORT_FAILURE) && unmovable)

This else if branch should be enclosed in brace?

> +		/*
> +		 * printk() with zone->lock held will likely trigger a
> +		 * lockdep splat, so defer it here.
> +		 */
> +		dump_page(unmovable, "unmovable page");
>  
>  	return ret;
>  }

Otherwise, the patch looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

