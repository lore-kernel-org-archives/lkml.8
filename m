Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86133206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgF3R1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:27:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:36356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgF3R1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:27:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BF59AE2D;
        Tue, 30 Jun 2020 17:27:42 +0000 (UTC)
Subject: Re: [PATCH v6 1/6] mm/vmscan: make active/inactive ratio as 1:1 for
 anon lru
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-2-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a5c8298-a1e5-93f9-eea6-214b0732ca33@suse.cz>
Date:   Tue, 30 Jun 2020 19:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592371583-30672-2-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Current implementation of LRU management for anonymous page has some
> problems. Most important one is that it doesn't protect the workingset,
> that is, pages on the active LRU list. Although, this problem will be
> fixed in the following patchset, the preparation is required and
> this patch does it.
> 
> What following patchset does is to restore workingset protection. In this

"Restore" sounds as if the protection used to be there and then it was removed.
If it's the case, it should be said what commit did that. Otherwise I would say
"implement", not "restore"?

> case, newly created or swap-in pages are started their lifetime on the

I would rephrase it: "After the following patch, newly created or swap-in pages
will start their lifetime... "

> inactive list. If inactive list is too small, there is not enough chance
> to be referenced and the page cannot become the workingset.
> 
> In order to provide enough chance to the newly anonymous pages, this patch

"In order to provide the newly anonymous pages enough chance to be referenced
again..."

> makes active/inactive LRU ratio as 1:1.

Here I would add:

This is just a temporary measure. Later patch in the series introduces
workingset detection for anonymous LRU that will be used to better decide if
pages should start on the active and inactive list. Afterwards this patch is
effectively reverted.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749d239..9f940c4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2212,7 +2212,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
>  	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
>  
>  	gb = (inactive + active) >> (30 - PAGE_SHIFT);
> -	if (gb)
> +	if (gb && is_file_lru(inactive_lru))
>  		inactive_ratio = int_sqrt(10 * gb);
>  	else
>  		inactive_ratio = 1;
> 

