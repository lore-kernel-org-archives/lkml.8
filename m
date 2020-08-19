Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60019C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5192075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHSMX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHSMXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21BD4AEC4;
        Wed, 19 Aug 2020 12:23:50 +0000 (UTC)
Date:   Wed, 19 Aug 2020 14:23:22 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 01/11] mm/memory_hotplug: inline __offline_pages()
 into offline_pages()
Message-ID: <20200819122322.GE5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:47, David Hildenbrand wrote:
> There is only a single user, offline_pages(). Let's inline, to make
> it look more similar to online_pages().
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
>  mm/memory_hotplug.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7f62d69660e06..c781d386d87f9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1473,11 +1473,10 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  	return 0;
>  }
>  
> -static int __ref __offline_pages(unsigned long start_pfn,
> -		  unsigned long end_pfn)
> +int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  {
> -	unsigned long pfn, nr_pages = 0;
> -	unsigned long offlined_pages = 0;
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
>  	int ret, node, nr_isolate_pageblock;
>  	unsigned long flags;
>  	struct zone *zone;
> @@ -1494,9 +1493,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
>  	 * avoid using walk_system_ram_range() later.
>  	 */
> -	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
> +	walk_system_ram_range(start_pfn, nr_pages, &system_ram_pages,
>  			      count_system_ram_pages_cb);
> -	if (nr_pages != end_pfn - start_pfn) {
> +	if (system_ram_pages != nr_pages) {
>  		ret = -EINVAL;
>  		reason = "memory holes";
>  		goto failed_removal;
> @@ -1631,11 +1630,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  	return ret;
>  }
>  
> -int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> -{
> -	return __offline_pages(start_pfn, start_pfn + nr_pages);
> -}
> -
>  static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  {
>  	int ret = !is_memblock_offlined(mem);
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
