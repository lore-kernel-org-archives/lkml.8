Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6173620708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGGMR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:17:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:42892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGMR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:17:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69186AE65;
        Tue,  7 Jul 2020 12:17:56 +0000 (UTC)
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e72709dd-c7e2-ff26-f450-dbd2a719b2e4@suse.cz>
Date:   Tue, 7 Jul 2020 14:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
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
> In mm/migrate.c, THP allocation for migration is called with the provided
> gfp_mask | GFP_TRANSHUGE. This gfp_mask contains __GFP_RECLAIM and it
> would be conflict with the intention of the GFP_TRANSHUGE.
> 
> GFP_TRANSHUGE/GFP_TRANSHUGE_LIGHT is introduced to control the reclaim
> behaviour by well defined manner since overhead of THP allocation is
> quite large and the whole system could suffer from it. So, they deals
> with __GFP_RECLAIM mask deliberately. If gfp_mask contains __GFP_RECLAIM
> and uses gfp_mask | GFP_TRANSHUGE(_LIGHT) for THP allocation, it means
> that it breaks the purpose of the GFP_TRANSHUGE(_LIGHT).
> 
> This patch fixes this situation by clearing __GFP_RECLAIM in provided
> gfp_mask. Note that there are some other THP allocations for migration
> and they just uses GFP_TRANSHUGE(_LIGHT) directly. This patch would make
> all THP allocation for migration consistent.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/migrate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 02b31fe..ecd7615 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
>  	}
>  
>  	if (PageTransHuge(page)) {
> +		/*
> +		 * clear __GFP_RECALIM since GFP_TRANSHUGE is the gfp_mask
> +		 * that chooses the reclaim masks deliberately.
> +		 */
> +		gfp_mask &= ~__GFP_RECLAIM;
>  		gfp_mask |= GFP_TRANSHUGE;

In addition to what Michal said...

The mask is not passed to this function, so I would just redefine it, as is done
in the hugetlb case. We probably don't even need the __GFP_RETRY_MAYFAIL for the
THP case asi it's just there to prevent OOM kill (per commit 0f55685627d6d ) and
the costly order of THP is enough for that.

>  		order = HPAGE_PMD_ORDER;
>  	}
> 

