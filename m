Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86724C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652B82071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598332255;
	bh=Tm5TGS9QxUQnZMSBd7cObay8VgPGZsJUas2eWOf9csE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rnCaNRyJWeKFuOidqbZBYzbzhD1ZL+UBqnQhGaypoCqniY2KE5uEXkotDMfr6d/rc
	 z2fDlGQVHabaU3uvjS8JG26YuUBdcsDqZx43tYdTl5cOjxvt4/rbSz8mn7RuxC3/UX
	 PEbcFemB06g+p0Tex4H3ObMCYC78SakzOWN5wf9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHYFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgHYFKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:10:51 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D782071E;
        Tue, 25 Aug 2020 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598332250;
        bh=Tm5TGS9QxUQnZMSBd7cObay8VgPGZsJUas2eWOf9csE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T43Wjah61jO7E4dy/ROpCXV6YaMsYbfXW65GEfmoSfuVTQHHiONBQPnQ9AHvCiKKZ
         FnENnMAAPPpMAXEuoT5HpmlSTg1/Sfix7DgfKuLLIASWuAlEajxtod+WhD9StoKoVB
         kbV5AUYwDsPcWT8q18WH9VdGEL5wj/mrD3m6lKcg=
Date:   Mon, 24 Aug 2020 22:10:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
Message-Id: <20200824221049.edb3c540bbfc859a6806600d@linux-foundation.org>
In-Reply-To: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 13:59:42 +0900 js1304@gmail.com wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> memalloc_nocma_{save/restore} APIs can be used to skip page allocation
> on CMA area, but, there is a missing case and the page on CMA area could
> be allocated even if APIs are used. This patch handles this case to fix
> the potential issue.
> 
> Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
> could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
> specified.
> 
> This patch implements this behaviour by checking allocated page from
> the pcplist rather than skipping an allocation from the pcplist entirely.
> Skipping the pcplist entirely would result in a mismatch between watermark
> check and actual page allocation. And, it requires to break current code
> layering that order-0 page is always handled by the pcplist. I'd prefer
> to avoid it so this patch uses different way to skip CMA page allocation
> from the pcplist.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3341,6 +3341,22 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
>  	list = &pcp->lists[migratetype];
>  	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
> +#ifdef CONFIG_CMA
> +	if (page) {
> +		int mt = get_pcppage_migratetype(page);
> +
> +		/*
> +		 * pcp could have the pages on CMA area and we need to skip it
> +		 * when !ALLOC_CMA. Free all pcplist and retry allocation.
> +		 */
> +		if (is_migrate_cma(mt) && !(alloc_flags & ALLOC_CMA)) {
> +			list_add(&page->lru, &pcp->lists[migratetype]);
> +			pcp->count++;
> +			free_pcppages_bulk(zone, pcp->count, pcp);
> +			page = __rmqueue_pcplist(zone, migratetype, alloc_flags, pcp, list);
> +		}
> +	}
> +#endif
>  	if (page) {
>  		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
>  		zone_statistics(preferred_zone, zone);

That's a bunch more code on a very hot path to serve an obscure feature
which has a single obscure callsite.

Can we instead put the burden on that callsite rather than upon
everyone?  For (dumb) example, teach __gup_longterm_locked() to put the
page back if it's CMA and go get another one?


