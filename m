Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8217CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C08208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgF2VaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:30:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgF2SlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01C21AF87;
        Mon, 29 Jun 2020 10:25:16 +0000 (UTC)
Subject: Re: [PATCH for v5.8 2/3] mm/swap: fix for "mm: workingset: age
 nonresident information alongside anonymous pages"
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cc10f1e9-e75a-87aa-9556-e4d9eab6648f@suse.cz>
Date:   Mon, 29 Jun 2020 12:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/20 8:16 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Non-file-lru page could also be activated in mark_page_accessed()
> and we need to count this activation for nonresident_age.
> 
> Note that it's better for this patch to be squashed into the patch
> "mm: workingset: age nonresident information alongside anonymous pages".

Agreed.

> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/swap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 667133d..c5d5114 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -443,8 +443,7 @@ void mark_page_accessed(struct page *page)
>  		else
>  			__lru_cache_activate_page(page);
>  		ClearPageReferenced(page);
> -		if (page_is_file_lru(page))
> -			workingset_activation(page);
> +		workingset_activation(page);
>  	}
>  	if (page_is_idle(page))
>  		clear_page_idle(page);
> 

