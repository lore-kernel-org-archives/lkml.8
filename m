Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852CCC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6029F22243
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="heHbWPmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635086AbgDPQLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729590AbgDPQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:11:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F08CC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:11:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g74so21796627qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WXomWteiFWVmrWLcFY6iZh/HgoTgIs2V8Ey9iDSmLpU=;
        b=heHbWPmNVF6QnBeTczw0WIPHnzrNa8j/rwXaA1v/govfRhT5LZnZNq0pOi18t6v+uU
         NqCD0JSa4nbeuaJBm1DjhpN2BUDqaoH1Vt4Xjn6CfYqDEglmlpeQ4rALaEvHJlypqsBP
         aboi7GSH+ukTpUC4i5F0IMrwvkXL66daDbMfDqpmj66RvuvxpDqZe15z48fGFL64auOe
         Eg0S0wCkrAggvaJSQM6lGYVdpXczM4gQKqXu04xSCrqFXOnDtk0Hw99w07yfWsklS8ip
         9IpV9xZMPg6CQn/fNTfsep2qfCE4mj4r5a/gGHGgRaFPxqBIPPrd3N69gFt8exyAjki+
         YkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WXomWteiFWVmrWLcFY6iZh/HgoTgIs2V8Ey9iDSmLpU=;
        b=Sc0nDcENfofDDw+11cwTPRngF/aKj6BwAo6pYeyz/9HNQXbzNzaB2k40SulpFROytW
         HDzfvroK4flG4tvtO3DVhwjH0TzF/dwqWm3QA/In5RgWc3MyQP3kIOkMa9hw+TF8Sms+
         6Ly4jzvHBPNbd+DWFR+XWiuYYBsR01aADzhwMGvMFoRsYBAQnLQDph5RvFOvleLJ4M2h
         zkAhOnPKni6k2hRD7YTRDC57zQHbp897ne2MhC1yfwZYDpPzeW5PCh3K+c9u3pAGqxaX
         JO4a7vQvdo4jVkK72DPkqWPwZ3uPZrByZjxbUG7Bm413mTwIkQWRmJfmu00Ck2uUf/qY
         IZdg==
X-Gm-Message-State: AGi0PuY8doBvlYOjuImdXqXUWko2hgBZuusRZaE5tdSmDG8/ce3PqQT8
        +C6ejUc44CirRuWrZCAbsvTJCEm/syA=
X-Google-Smtp-Source: APiQypLaXSyK/uVmOpaYdWRImkATTH3C0TP8Cyztog5XzcvHxmUcVc/LmjmbHFrvjYfpUIVXKQH75w==
X-Received: by 2002:a37:ac18:: with SMTP id e24mr24767970qkm.234.1587053495392;
        Thu, 16 Apr 2020 09:11:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id i5sm15335021qtw.97.2020.04.16.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:11:34 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:11:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v5 05/10] mm/swap: charge the page when adding to the
 swap cache
Message-ID: <20200416161133.GA178028@cmpxchg.org>
References: <1585892447-32059-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585892447-32059-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joonsoo,

On Fri, Apr 03, 2020 at 02:40:43PM +0900, js1304@gmail.com wrote:
> @@ -112,7 +112,7 @@ void show_swap_cache_info(void)
>   * but sets SwapCache flag and private instead of mapping and index.
>   */
>  int add_to_swap_cache(struct page *page, swp_entry_t entry,
> -			gfp_t gfp, void **shadowp)
> +			struct vm_area_struct *vma, gfp_t gfp, void **shadowp)
>  {
>  	struct address_space *address_space = swap_address_space(entry);
>  	pgoff_t idx = swp_offset(entry);
> @@ -120,14 +120,26 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>  	unsigned long i, nr = compound_nr(page);
>  	unsigned long nrexceptional = 0;
>  	void *old;
> +	bool compound = !!compound_order(page);
> +	int error;
> +	struct mm_struct *mm = vma ? vma->vm_mm : current->mm;
> +	struct mem_cgroup *memcg;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(PageSwapCache(page), page);
>  	VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
>  
>  	page_ref_add(page, nr);
> +	/* PageSwapCache() prevent the page from being re-charged */
>  	SetPageSwapCache(page);
>  
> +	error = mem_cgroup_try_charge(page, mm, gfp, &memcg, compound);
> +	if (error) {
> +		ClearPageSwapCache(page);
> +		page_ref_sub(page, nr);
> +		return error;
> +	}
> +
>  	do {
>  		xas_lock_irq(&xas);
>  		xas_create_range(&xas);
> @@ -153,11 +165,16 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>  		xas_unlock_irq(&xas);
>  	} while (xas_nomem(&xas, gfp));
>  
> -	if (!xas_error(&xas))
> +	if (!xas_error(&xas)) {
> +		mem_cgroup_commit_charge(page, memcg, false, compound);

Unfortunately you cannot commit here yet because the rmap isn't set up
and that will cause memcg_charge_statistics() to account the page
incorrectly as file. And rmap is only set up during a page fault.

This needs a bit of a rework of the memcg charging code that appears
out of scope for your patches. I'm preparing a series right now to do
just that. It'll also fix the swap ownership tracking problem when the
swap controller is disabled, so we don't have to choose between
charging the wrong cgroup or hampering swap readahead efficiency.

The patches also unblock Alex Shi's "per lruvec lru_lock for memcg"
series, which is all the more indication that memcg needs fixing in
that area.
