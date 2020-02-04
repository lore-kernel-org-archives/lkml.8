Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C71C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4A02087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgBDJG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:06:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDJG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:06:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9214DB1E4;
        Tue,  4 Feb 2020 09:06:25 +0000 (UTC)
Date:   Tue, 4 Feb 2020 10:06:22 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v6 07/10] mm/memory_hotplug: We always have a zone in
 find_(smallest|biggest)_section_pfn
Message-ID: <20200204090622.GB6494@linux>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-8-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 10:56:43AM +0200, David Hildenbrand wrote:
> With shrink_pgdat_span() out of the way, we now always have a valid
> zone.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bf5173e7913d..f294918f7211 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -337,7 +337,7 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
>  		if (unlikely(pfn_to_nid(start_pfn) != nid))
>  			continue;
>  
> -		if (zone && zone != page_zone(pfn_to_page(start_pfn)))
> +		if (zone != page_zone(pfn_to_page(start_pfn)))
>  			continue;
>  
>  		return start_pfn;
> @@ -362,7 +362,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>  		if (unlikely(pfn_to_nid(pfn) != nid))
>  			continue;
>  
> -		if (zone && zone != page_zone(pfn_to_page(pfn)))
> +		if (zone != page_zone(pfn_to_page(pfn)))
>  			continue;
>  
>  		return pfn;
> -- 
> 2.21.0
> 

-- 
Oscar Salvador
SUSE L3
