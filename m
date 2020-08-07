Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD77BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B992E221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQqahLF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHGNJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:09:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53254 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgHGNJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596805777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mev5185ldyIV+fC/Brbo/2YSYslUv44q6prbV1qxumY=;
        b=ZQqahLF+puqQhalaY2AkPTnzxKbiGGIYOs9kQhDMl46m4Q7b8w33w47yi1MKXndc8kGDbJ
        rrF0pOkZvAL7A0SfzwxiScT2cTo6HbhLAU2cLIQJcH2rWpnNYmSS2aPnapMRRr07ZCql44
        U8/3KXcJ4TaChS9X7o7WgOIc0SX9ck8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-hfkVj4HsM0KOQwUF7ngvig-1; Fri, 07 Aug 2020 09:09:36 -0400
X-MC-Unique: hfkVj4HsM0KOQwUF7ngvig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDF46800685;
        Fri,  7 Aug 2020 13:09:34 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29C20100239B;
        Fri,  7 Aug 2020 13:09:33 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:09:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/hugetlb: return non-isolated page in the loop
 instead of break and check
Message-ID: <20200807130931.GS14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-9-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-9-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> Function dequeue_huge_page_node_exact() iterates the free list and
> return the first non-isolated one.
> 
> Instead of break and check the loop variant, we could return in the loop
> directly. This could reduce some redundant check.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b8e844911b5a..9473eb6800e9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1035,20 +1035,18 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  {
>  	struct page *page;
>  
> -	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
> -		if (!PageHWPoison(page))
> -			break;

I don't see how it can reduce redundant check, just two different
styles.

> -	/*
> -	 * if 'non-isolated free hugepage' not found on the list,
> -	 * the allocation fails.

But the above code comment seems stale, it checks HWPoision page
directly, but not the old isolated page checking.

> -	 */
> -	if (&h->hugepage_freelists[nid] == &page->lru)
> -		return NULL;
> -	list_move(&page->lru, &h->hugepage_activelist);
> -	set_page_refcounted(page);
> -	h->free_huge_pages--;
> -	h->free_huge_pages_node[nid]--;
> -	return page;
> +	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> +		if (PageHWPoison(page))
> +			continue;
> +
> +		list_move(&page->lru, &h->hugepage_activelist);
> +		set_page_refcounted(page);
> +		h->free_huge_pages--;
> +		h->free_huge_pages_node[nid]--;
> +		return page;
> +	}
> +
> +	return NULL;
>  }
>  
>  static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
> -- 
> 2.20.1 (Apple Git-117)
> 
> 

