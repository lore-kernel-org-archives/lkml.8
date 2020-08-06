Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05966206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgHFRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgHFQdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:33:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00621ABE4;
        Thu,  6 Aug 2020 13:35:34 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] mm/page_isolation: cleanup
 set_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20200730093416.36210-1-david@redhat.com>
 <20200730093416.36210-5-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <74a25986-87cb-7ab6-e7a9-0c2aefcabe4a@suse.cz>
Date:   Thu, 6 Aug 2020 15:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730093416.36210-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 11:34 AM, David Hildenbrand wrote:
> Let's clean it up a bit, simplifying error handling and getting rid of
> the label.

Nit: the label was already removed by patch 1/6?

> Reviewed-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index d099aac479601..e65fe5d770849 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -17,12 +17,9 @@
>  
>  static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>  {
> -	struct page *unmovable = NULL;
> -	struct zone *zone;
> +	struct zone *zone = page_zone(page);
> +	struct page *unmovable;
>  	unsigned long flags;
> -	int ret = -EBUSY;
> -
> -	zone = page_zone(page);
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  
> @@ -51,13 +48,13 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  									NULL);
>  
>  		__mod_zone_freepage_state(zone, -nr_pages, mt);
> -		ret = 0;
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +		drain_all_pages(zone);
> +		return 0;
>  	}
>  
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret) {
> -		drain_all_pages(zone);
> -	} else if ((isol_flags & REPORT_FAILURE) && unmovable) {
> +	if (isol_flags & REPORT_FAILURE) {
>  		/*
>  		 * printk() with zone->lock held will likely trigger a
>  		 * lockdep splat, so defer it here.
> @@ -65,7 +62,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  		dump_page(unmovable, "unmovable page");
>  	}
>  
> -	return ret;
> +	return -EBUSY;
>  }
>  
>  static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> 

