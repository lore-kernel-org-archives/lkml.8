Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEBDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8D320702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGMHwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:52:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMHwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2364ACE1;
        Mon, 13 Jul 2020 07:52:23 +0000 (UTC)
Subject: Re: [PATCH v5 4/9] mm/migrate: clear __GFP_RECLAIM to make the
 migration callback consistent with regular THP allocations
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594622517-20681-5-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <367ca602-1112-f87f-7d2a-b0a75cce7269@suse.cz>
Date:   Mon, 13 Jul 2020 09:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594622517-20681-5-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 8:41 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_page_nodemask is a migration callback and it tries to use a common
> gfp flags for the target page allocation whether it is a base page or a
> THP. The later only adds GFP_TRANSHUGE to the given mask. This results
> in the allocation being slightly more aggressive than necessary because
> the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
> allocations usually exclude this flag to reduce over eager background
> reclaim during a high THP allocation load which has been seen during
> large mmaps initialization. There is no indication that this is a
> problem for migration as well but theoretically the same might happen
> when migrating large mappings to a different node. Make the migration
> callback consistent with regular THP allocations.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

Typo below (I assume Andrew will fix it)

> ---
>  mm/migrate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3b3d918..1cfc965 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
>  	}
>  
>  	if (PageTransHuge(page)) {
> +		/*
> +		 * clear __GFP_RECALIM to make the migration callback

                         __GFP_RECLAIM

> +		 * consistent with regular THP allocations.
> +		 */
> +		gfp_mask &= ~__GFP_RECLAIM;
>  		gfp_mask |= GFP_TRANSHUGE;
>  		order = HPAGE_PMD_ORDER;
>  	}
> 

