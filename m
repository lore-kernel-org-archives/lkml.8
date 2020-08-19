Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259F52072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgHSMj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:39:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgHSMjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:39:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A35C5AF92;
        Wed, 19 Aug 2020 12:40:07 +0000 (UTC)
Date:   Wed, 19 Aug 2020 14:39:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 03/11] mm/memory_hotplug: simplify checking if all
 pages are isolated in offline_pages()
Message-ID: <20200819123940.GG5422@dhcp22.suse.cz>
References: <20200819101157.12723-1-david@redhat.com>
 <20200819101157.12723-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101157.12723-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 12:11:49, David Hildenbrand wrote:
> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages(). We no longer need walk_system_ram_range() and can
> call test_pages_isolated() directly.
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
>  mm/memory_hotplug.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6856702af68d9..f64478349148d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1384,17 +1384,6 @@ offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
>  	return 0;
>  }
>  
> -/*
> - * Check all pages in range, recorded as memory resource, are isolated.
> - */
> -static int
> -check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
> -			void *data)
> -{
> -	return test_pages_isolated(start_pfn, start_pfn + nr_pages,
> -				   MEMORY_OFFLINE);
> -}
> -
>  static int __init cmdline_parse_movable_node(char *p)
>  {
>  	movable_node_enabled = true;
> @@ -1579,10 +1568,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  			reason = "failure to dissolve huge pages";
>  			goto failed_removal_isolated;
>  		}
> -		/* check again */
> -		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -					    NULL, check_pages_isolated_cb);
> -	} while (ret);
> +	} while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
>  
>  	/* Ok, all of our target is isolated.
>  	   We cannot do rollback at this point. */
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
