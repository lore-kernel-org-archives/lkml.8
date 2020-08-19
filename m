Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3396AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195982067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgHSM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:59:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbgHSM7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B15BFAE17;
        Wed, 19 Aug 2020 12:59:28 +0000 (UTC)
Date:   Wed, 19 Aug 2020 14:58:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 06/11] mm/memory_hotplug: drop nr_isolate_pageblock in
 offline_pages()
Message-ID: <20200819125850.GK5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-7-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:52, David Hildenbrand wrote:
> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages() and we only support to online/offline full sections.
> Both, sections and pageblocks are a power of two in size, and sections
> always span full pageblocks.
> 
> We can directly calculate the number of isolated pageblocks from nr_pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 50aa5df696e9d..098361fcb4504 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1460,10 +1460,10 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	const unsigned long end_pfn = start_pfn + nr_pages;
>  	unsigned long pfn, system_ram_pages = 0;
> -	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
>  	struct zone *zone;
>  	struct memory_notify arg;
> +	int ret, node;
>  	char *reason;
>  
>  	/* We can only offline full sections (e.g., SECTION_IS_ONLINE) */
> @@ -1507,7 +1507,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  		reason = "failure to isolate range";
>  		goto failed_removal;
>  	}
> -	nr_isolate_pageblock = ret;
>  
>  	arg.start_pfn = start_pfn;
>  	arg.nr_pages = nr_pages;
> @@ -1569,7 +1568,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  	 * pageblocks zone counter here.
>  	 */
>  	spin_lock_irqsave(&zone->lock, flags);
> -	zone->nr_isolate_pageblock -= nr_isolate_pageblock;
> +	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	/* removal success */
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
