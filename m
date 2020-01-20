Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA2C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031822464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579529266;
	bh=tllGqrZx8tFdG9U9YV8zHK0+mx1jD3BQvyjcsyYvllk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TgHMedbzKWT3gEV/dOD0mT/R6g9oVoZqKORv4Z+1IbFs63Qqr7MVQSxWaM0/kKWvM
	 PoEuCDtkZ82m/TMd6lpcwvny5CuRFt6BpxD7tKMvWDTK0YXQXOAMeFlMpccPLYKttj
	 69bqGNuj2RW6q+pfJE/XrCbtOgkR1NqUhm6Lqn3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATOHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:07:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33052 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:07:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so14833929wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PEshjh6oj1hS5bO6DIB8H4W+Hl04tdhGeOu91RZ3Ik=;
        b=UlvQjsycbRfKhSMNlrV1182zcjOgsIJh9pf++VvFitTebOymm/cVHB9QixkxxvNyVl
         lwFwnQ46C+j/4jEp6IgQYbolaSqHPgK1x7ajn3af8F5nVJjgMw2BHeC9jH2ICZ2UgGRu
         WyCowoiGrvXniVB+sCP8vXvm/6ou8KMAAk0aif5AJdiDOuXSBdasNdkXOIzpJBcjX22f
         X+Q/6p8LxhZrD8pcCHq7NmziKEKrdQCTxsSf3Bow/M+4Kq4F0urWSdiPDLoJR1x58b5m
         dnDtZhVhflUM1FfhpwTmHZ5gDCDaDRWBBtL2nLQ3EP1gquNHZUcCdBj+55YMg1Lsb0mW
         +E5A==
X-Gm-Message-State: APjAAAWaSmiAH578QYvdvCMwYrBpS4F4Pir3WCq+7FYLVoz6AVKyDTaE
        0zVkH6HPIMHgHL0fEY5N7v1HWQaG
X-Google-Smtp-Source: APXvYqzbAArKV7ShAu35gL43PdCCsBpRP7+6QHgxCRNfYMckD6wi/7J21ZbhsQFYE/sU93amP7GCRQ==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr20003235wmg.154.1579529262880;
        Mon, 20 Jan 2020 06:07:42 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v3sm47402669wru.32.2020.01.20.06.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:07:41 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:07:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm v2] mm/page_isolation: fix potential warning from user
Message-ID: <20200120140740.GG18451@dhcp22.suse.cz>
References: <20200120131909.813-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120131909.813-1-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 08:19:09, Qian Cai wrote:
> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
> from start_isolate_page_range(), but should avoid triggering it from
> userspace, i.e, from is_mem_section_removable() because it could be a
> DoS if warn_on_panic is set.

Let's just make it clear that this mostly a pre-cautious because a real
DoS should be pretty much impossible. But let's see whether somebody
want to make a CVE out of it ;)

> While at it, simplify the code a bit by removing an unnecessary jump
> label and a local variable, so set_migratetype_isolate() could really
> return a bool.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> v2: Improve the commit log.
>     Warn for all start_isolate_page_range() users not just offlining.
> 
>  mm/page_alloc.c     | 11 ++++-------
>  mm/page_isolation.c | 30 +++++++++++++++++-------------
>  2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 621716a25639..3c4eb750a199 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		if (is_migrate_cma(migratetype))
>  			return NULL;
>  
> -		goto unmovable;
> +		return page;
>  	}
>  
>  	for (; iter < pageblock_nr_pages; iter++) {
> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		page = pfn_to_page(pfn + iter);
>  
>  		if (PageReserved(page))
> -			goto unmovable;
> +			return page;
>  
>  		/*
>  		 * If the zone is movable and we have ruled out all reserved
> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			unsigned int skip_pages;
>  
>  			if (!hugepage_migration_supported(page_hstate(head)))
> -				goto unmovable;
> +				return page;
>  
>  			skip_pages = compound_nr(head) - (page - head);
>  			iter += skip_pages - 1;
> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 * is set to both of a memory hole page and a _used_ kernel
>  		 * page at boot.
>  		 */
> -		goto unmovable;
> +		return page;
>  	}
>  	return NULL;
> -unmovable:
> -	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	return pfn_to_page(pfn + iter);
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e70586523ca3..31f5516f5d54 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -15,12 +15,12 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/page_isolation.h>
>  
> -static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
> +static bool set_migratetype_isolate(struct page *page, int migratetype,
> +				    int isol_flags)
>  {
> -	struct page *unmovable = NULL;
> +	struct page *unmovable = ERR_PTR(-EBUSY);
>  	struct zone *zone;
>  	unsigned long flags;
> -	int ret = -EBUSY;
>  
>  	zone = page_zone(page);
>  
> @@ -49,21 +49,25 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  									NULL);
>  
>  		__mod_zone_freepage_state(zone, -nr_pages, mt);
> -		ret = 0;
>  	}
>  
>  out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret)
> +
> +	if (!unmovable) {
>  		drain_all_pages(zone);
> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
> -		/*
> -		 * printk() with zone->lock held will guarantee to trigger a
> -		 * lockdep splat, so defer it here.
> -		 */
> -		dump_page(unmovable, "unmovable page");
> -
> -	return ret;
> +	} else {
> +		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> +
> +		if ((isol_flags & REPORT_FAILURE) && !IS_ERR(unmovable))
> +			/*
> +			 * printk() with zone->lock held will likely trigger a
> +			 * lockdep splat, so defer it here.
> +			 */
> +			dump_page(unmovable, "unmovable page");
> +	}
> +
> +	return !!unmovable;
>  }
>  
>  static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> -- 
> 2.21.0 (Apple Git-122.2)

-- 
Michal Hocko
SUSE Labs
