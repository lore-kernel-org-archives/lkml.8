Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BB2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2496D206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGGQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:34:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 586C1B001;
        Tue,  7 Jul 2020 16:34:07 +0000 (UTC)
Subject: Re: [PATCH v4 11/11] mm/memory_hotplug: remove a wrapper for
 alloc_migration_target()
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-12-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <575ab75d-1382-5f12-96df-53c0bb947f8c@suse.cz>
Date:   Tue, 7 Jul 2020 17:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594107889-32228-12-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> To calculate the correct node to migrate the page for hotplug, we need
> to check node id of the page. Wrapper for alloc_migration_target() exists
> for this purpose.
> 
> However, Vlastimil informs that all migration source pages come from
> a single node. In this case, we don't need to check the node id for each
> page and we don't need to re-set the target nodemask for each page by
> using the wrapper. Set up the migration_target_control once and use it for
> all pages.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks! Nitpick below.

> @@ -1345,9 +1324,28 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		put_page(page);
>  	}
>  	if (!list_empty(&source)) {
> -		/* Allocate a new page from the nearest neighbor node */
> -		ret = migrate_pages(&source, new_node_page, NULL, 0,
> -					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> +		nodemask_t nmask = node_states[N_MEMORY];
> +		struct migration_target_control mtc = {
> +			.nmask = &nmask,
> +			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +		};
> +
> +		/*
> +		 * We have checked that migration range is on a single zone so
> +		 * we can use the nid of the first page to all the others.
> +		 */
> +		mtc.nid = page_to_nid(list_first_entry(&source, struct page, lru));
> +
> +		/*
> +		 * try to allocate from a different node but reuse this node
> +		 * if there are no other online nodes to be used (e.g. we are
> +		 * offlining a part of the only existing node)
> +		 */
> +		node_clear(mtc.nid, *mtc.nmask);
> +		if (nodes_empty(*mtc.nmask))
> +			node_set(mtc.nid, *mtc.nmask);

You could have kept using 'nmask' instead of '*mtc.nmask'. Actually that applies
to patch 6 too, for less churn.

> +		ret = migrate_pages(&source, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>  		if (ret) {
>  			list_for_each_entry(page, &source, lru) {
>  				pr_warn("migrating pfn %lx failed ret:%d ",
> 

