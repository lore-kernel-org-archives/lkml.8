Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E26C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E820715
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHMLRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:17:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMLRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:17:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EC8BB6F5;
        Thu, 13 Aug 2020 11:17:53 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:17:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: include CMA pages in lowmem_reserve at boot
Message-ID: <20200813111730.GH9477@dhcp22.suse.cz>
References: <1597290698-24266-1-git-send-email-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597290698-24266-1-git-send-email-opendmb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-08-20 20:51:38, Doug Berger wrote:
> The lowmem_reserve arrays provide a means of applying pressure
> against allocations from lower zones that were targeted at
> higher zones. Its values are a function of the number of pages
> managed by higher zones and are assigned by a call to the
> setup_per_zone_lowmem_reserve() function.
> 
> The function is initially called at boot time by the function
> init_per_zone_wmark_min() and may be called later by accesses
> of the /proc/sys/vm/lowmem_reserve_ratio sysctl file.
> 
> The function init_per_zone_wmark_min() was moved up from a
> module_init to a core_initcall to resolve a sequencing issue
> with khugepaged. Unfortunately this created a sequencing issue
> with CMA page accounting.
> 
> The CMA pages are added to the managed page count of a zone
> when cma_init_reserved_areas() is called at boot also as a
> core_initcall. This makes it uncertain whether the CMA pages
> will be added to the managed page counts of their zones before
> or after the call to init_per_zone_wmark_min() as it becomes
> dependent on link order. With the current link order the pages
> are added to the managed count after the lowmem_reserve arrays
> are initialized at boot.
> 
> This means the lowmem_reserve values at boot may be lower than
> the values used later if /proc/sys/vm/lowmem_reserve_ratio is
> accessed even if the ratio values are unchanged.
> 
> In many cases the difference is not significant, but in others
> it may have an affect.

Could you be more specific please?

> This commit breaks the link order dependency by invoking
> init_per_zone_wmark_min() as a postcore_initcall so that the
> CMA pages have the chance to be properly accounted in their
> zone(s) and allowing the lowmem_reserve arrays to receive
> consistent values.
> 
> Fixes: bc22af74f271 ("mm: update min_free_kbytes from khugepaged after core initialization")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8b7d0ecf30b1..f3e340ec2b6b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7887,7 +7887,7 @@ int __meminit init_per_zone_wmark_min(void)
>  
>  	return 0;
>  }
> -core_initcall(init_per_zone_wmark_min)
> +postcore_initcall(init_per_zone_wmark_min)
>  
>  /*
>   * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
