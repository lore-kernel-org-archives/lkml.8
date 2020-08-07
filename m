Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E30CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F364020866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQWCHvoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHGMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgHGMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=296+lukApwRPV8vPK5a6NC0pHfpgoiEagcn/e5yk+s0=;
        b=iQWCHvoLfJezZ9UeyYI95gG/5tKrnSuu68xt4eItkvuGpGkYa5Y8EZvQz66fKB9Xpsgoj7
        oboS9COTHiiHvP5clGvNu81P3UDY+M+T6R41RIFhRQeqPbtVA7uaVcCqBPH8/O5LP0QGvi
        OSE2mrMvJ30Mnr6rgpZybhZIldvs1U0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-A30rxyusO0SwCDL4p0jwDw-1; Fri, 07 Aug 2020 08:54:29 -0400
X-MC-Unique: A30rxyusO0SwCDL4p0jwDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 702BB101C8AC;
        Fri,  7 Aug 2020 12:54:28 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6EB960BE2;
        Fri,  7 Aug 2020 12:54:27 +0000 (UTC)
Date:   Fri, 7 Aug 2020 20:54:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] mm/hugetlb: count file_region to be added when
 regions_needed != NULL
Message-ID: <20200807125425.GO14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-5-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-5-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> There are only two cases of function add_reservation_in_range()
> 
>     * count file_region and return the number in regions_needed
>     * do the real list operation without counting
> 
> This means it is not necessary to have two parameters to classify these
> two cases.
> 
> Just use regions_needed to separate them.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Nice clean up.

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  mm/hugetlb.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 929256c130f9..d775e514eb2e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -321,16 +321,17 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  	}
>  }
>  
> -/* Must be called with resv->lock held. Calling this with count_only == true
> - * will count the number of pages to be added but will not modify the linked
> - * list. If regions_needed != NULL and count_only == true, then regions_needed
> - * will indicate the number of file_regions needed in the cache to carry out to
> - * add the regions for this range.
> +/*
> + * Must be called with resv->lock held.
> + *
> + * Calling this with regions_needed != NULL will count the number of pages
> + * to be added but will not modify the linked list. And regions_needed will
> + * indicate the number of file_regions needed in the cache to carry out to add
> + * the regions for this range.
>   */
>  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  				     struct hugetlb_cgroup *h_cg,
> -				     struct hstate *h, long *regions_needed,
> -				     bool count_only)
> +				     struct hstate *h, long *regions_needed)
>  {
>  	long add = 0;
>  	struct list_head *head = &resv->regions;
> @@ -366,14 +367,14 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  		 */
>  		if (rg->from > last_accounted_offset) {
>  			add += rg->from - last_accounted_offset;
> -			if (!count_only) {
> +			if (!regions_needed) {
>  				nrg = get_file_region_entry_from_cache(
>  					resv, last_accounted_offset, rg->from);
>  				record_hugetlb_cgroup_uncharge_info(h_cg, h,
>  								    resv, nrg);
>  				list_add(&nrg->link, rg->link.prev);
>  				coalesce_file_region(resv, nrg);
> -			} else if (regions_needed)
> +			} else
>  				*regions_needed += 1;
>  		}
>  
> @@ -385,13 +386,13 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  	 */
>  	if (last_accounted_offset < t) {
>  		add += t - last_accounted_offset;
> -		if (!count_only) {
> +		if (!regions_needed) {
>  			nrg = get_file_region_entry_from_cache(
>  				resv, last_accounted_offset, t);
>  			record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
>  			list_add(&nrg->link, rg->link.prev);
>  			coalesce_file_region(resv, nrg);
> -		} else if (regions_needed)
> +		} else
>  			*regions_needed += 1;
>  	}
>  
> @@ -484,8 +485,8 @@ static long region_add(struct resv_map *resv, long f, long t,
>  retry:
>  
>  	/* Count how many regions are actually needed to execute this add. */
> -	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
> -				 true);
> +	add_reservation_in_range(resv, f, t, NULL, NULL,
> +				 &actual_regions_needed);
>  
>  	/*
>  	 * Check for sufficient descriptors in the cache to accommodate
> @@ -513,7 +514,7 @@ static long region_add(struct resv_map *resv, long f, long t,
>  		goto retry;
>  	}
>  
> -	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);
> +	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL);
>  
>  	resv->adds_in_progress -= in_regions_needed;
>  
> @@ -549,9 +550,9 @@ static long region_chg(struct resv_map *resv, long f, long t,
>  
>  	spin_lock(&resv->lock);
>  
> -	/* Count how many hugepages in this range are NOT respresented. */
> +	/* Count how many hugepages in this range are NOT represented. */
>  	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
> -				       out_regions_needed, true);
> +				       out_regions_needed);
>  
>  	if (*out_regions_needed == 0)
>  		*out_regions_needed = 1;
> -- 
> 2.20.1 (Apple Git-117)
> 
> 

