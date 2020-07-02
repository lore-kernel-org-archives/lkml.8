Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E1FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2647F20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgGBNp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:45:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgGBNp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:45:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EAA1AD88;
        Thu,  2 Jul 2020 13:45:26 +0000 (UTC)
Subject: Re: [PATCH v6 6/6] mm/vmscan: restore active/inactive ratio for
 anonymous LRU
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-7-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ed5a75ea-42bb-9acf-c567-3ff2d2af4fcb@suse.cz>
Date:   Thu, 2 Jul 2020 15:45:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592371583-30672-7-git-send-email-iamjoonsoo.kim@lge.com>
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
> Now, workingset detection is implemented for anonymous LRU.
> We don't have to worry about the misfound for workingset due to
> the ratio of active/inactive. Let's restore the ratio.

How about:

Now that workingset detection is implemented for anonymous LRU, we don't need
large inactive list to allow detecting frequently accessed pages before they are
reclaimed, anymore. This effectively reverts the temporary measure put in by
commit "mm/vmscan: make active/inactive ratio as 1:1 for anon lru".

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
I still hope Matthew can review updated patch 4/6 (I'm not really familiar with
proper xarray handling), and Johannes patch 5/6.

And then we just need a nice Documentation file describing how reclaim really
works after all the recent changes :)

Vlastimil

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eb02d18..ec77691 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2211,7 +2211,7 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
>  	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
>  
>  	gb = (inactive + active) >> (30 - PAGE_SHIFT);
> -	if (gb && is_file_lru(inactive_lru))
> +	if (gb)
>  		inactive_ratio = int_sqrt(10 * gb);
>  	else
>  		inactive_ratio = 1;
> 

