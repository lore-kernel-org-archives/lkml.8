Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C18BC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579B20783
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qcsw+kdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCRT7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:59:15 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:32927 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:59:14 -0400
Received: by mail-qv1-f67.google.com with SMTP id cz10so13631718qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MW1khS2qQW71Yr9yMFnDNZBVf/InPzdKnt32+BMPiU=;
        b=qcsw+kdxLAdFvyqgPxS3CjlNfeXWpNtMQwVcq0KqSZkSqqwS4LYCSYqlmTcbRRlKqp
         1BSb9s2dJ2AFfBe5xqA2GXzY3FFyFwZuAchScpUG2eYLDOXdv08dTshVTlsdVbnfsNUU
         SceCk87Eh8ed2NN8s/82Aihy0BMFXRbOQOQtdsX3CAB+k4BzMleEJQYLqwy3qvK01ncW
         vD7lNa/4GZnO3L5bTV/jwY5IkTKWH/tSxp4VuNS7APAsC54BxtQ+Q8YvucyfbV5zjh0a
         fw676eLpoJjhEjBIxuNtTh9x3PW6ZS+avBISAKMR0uoJkLrUTlPWC3Jg3lqTI+H6nk8/
         7Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MW1khS2qQW71Yr9yMFnDNZBVf/InPzdKnt32+BMPiU=;
        b=thoPI2EsaTD3dw5mKOY4nftFHtkQdujiDZCA9jjMfKgF6q0eaCezdivYOTNKdnmR2N
         v+MFGbQbc2dtXB43aE22zvBnupPWrBLxcjj/x4vj29VgNwwHeFwe++OR8jX7R7QU0LLN
         Ugj8j3sFpVjV8yaEu9UVoYqVWj0Wv5JbPkNFbr+Q9c7+KKeEGCGRzTDHMTpx8YCC67oF
         HVNyvc28uKES1QB9bMNciAIdMxebHdJqoou+NnXgEjuGUHBo42BvRDk/1tmnoHrzxfp3
         LVW+8nZ7rQn0AMKDL0xqzOqIRBnX3vL2GiCrLeH9xMKS0WVQMGPimlkYLhbRlHaasKiW
         4YAg==
X-Gm-Message-State: ANhLgQ0OrMF3jj7lj8VvUY3WRXAQd/k0Zy7oDBsbXulGECMSkUHSefpG
        hpWsOxp86QWSPCioWj0lL53+4w==
X-Google-Smtp-Source: ADFU+vtltW6J9lzvZJskDISWB0LAqm0qyo4IZHS82WwSon+sUAgD9TM/A1X8gY+Db4dq/1nUj/C8ZA==
X-Received: by 2002:a0c:ebcc:: with SMTP id k12mr6115047qvq.69.1584561553300;
        Wed, 18 Mar 2020 12:59:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id q66sm4804335qkd.47.2020.03.18.12.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:59:12 -0700 (PDT)
Date:   Wed, 18 Mar 2020 15:59:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 6/9] mm/workingset: handle the page without memcg
Message-ID: <20200318195911.GF154135@cmpxchg.org>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-7-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584423717-3440-7-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:41:54PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> When implementing workingset detection for anonymous page, I found
> some swapcache pages with NULL memcg. From the code reading, I found
> two reasons.
> 
> One is the case that swap-in readahead happens. The other is the
> corner case related to the shmem cache. These two problems should be
> fixed, but, it's not straight-forward to fix. For example, when swap-off,
> all swapped-out pages are read into swapcache. In this case, who's the
> owner of the swapcache page?
> 
> Since this problem doesn't look trivial, I decide to leave the issue and
> handles this corner case on the place where the error occurs.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

It wouldn't be hard to find out who owns this page. The code in
mem_cgroup_try_charge() is only a few lines:

			swp_entry_t ent = { .val = page_private(page), };
			unsigned short id = lookup_swap_cgroup_id(ent);

			rcu_read_lock();
			memcg = mem_cgroup_from_id(id);
			if (memcg && !css_tryget_online(&memcg->css))
				memcg = NULL;
			rcu_read_unlock();

THAT BEING SAID, I don't think we actually *want* to know the original
cgroup for readahead pages. Because before they are accessed and
charged to the original owner, the pages are sitting on the root
cgroup LRU list and follow the root group's aging speed and LRU order.

Eviction and refault tracking is about the LRU that hosts the pages.

So IMO your patch is much less of a hack than you might think.

> diff --git a/mm/workingset.c b/mm/workingset.c
> index a9f474a..8d2e83a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -257,6 +257,10 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> +	/* page_memcg() can be NULL if swap-in readahead happens */
> +	if (!page_memcg(page))
> +		return NULL;
> +
>  	advance_inactive_age(page_memcg(page), pgdat, is_file);
>  
>  	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);

This means a readahead page that hasn't been accessed will actively
not be tracked as an eviction and later as a refault.

I think that's the right thing to do, but I would expand the comment:

/*
 * A page can be without a cgroup here when it was brought in by swap
 * readahead and nobody has touched it since.
 *
 * The idea behind the workingset code is to tell on page fault time
 * whether pages have been previously used or not. Since this page
 * hasn't been used, don't store a shadow entry for it; when it later
 * faults back in, we treat it as the new page that it is.
 */
