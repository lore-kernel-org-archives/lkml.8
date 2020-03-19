Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF95C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B120732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgCSM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:29:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgCSM3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:29:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E56CAAB8;
        Thu, 19 Mar 2020 12:29:21 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ea81a1dd-8c8d-e586-8c4f-dc935b2b55e6@suse.cz>
Date:   Thu, 19 Mar 2020 13:29:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 4:32 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, we use the zone index of preferred_zone which represents
> the best matching zone for allocation, as classzone_idx. It has a problem
> on NUMA system with ZONE_MOVABLE.
> 
> In NUMA system, it can be possible that each node has different populated
> zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
> node 1 could have only NORMAL zone. In this setup, allocation request
> initiated on node 0 and the one on node 1 would have different
> classzone_idx, 3 and 2, respectively, since their preferred_zones are
> different. If they are handled by only their own node, there is no problem.
> However, if they are somtimes handled by the remote node due to memory
> shortage, the problem would happen.
> 
> In the following setup, allocation initiated on node 1 will have some
> precedence than allocation initiated on node 0 when former allocation is
> processed on node 0 due to not enough memory on node 1. They will have
> different lowmem reserve due to their different classzone_idx thus
> an watermark bars are also different.

...

> Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

With the clarifications that David requested,

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> ---
>  mm/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index c39c895..aebaa33 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -119,7 +119,7 @@ struct alloc_context {
>  	bool spread_dirty_pages;
>  };
>  
> -#define ac_classzone_idx(ac) zonelist_zone_idx(ac->preferred_zoneref)
> +#define ac_classzone_idx(ac) (ac->high_zoneidx)
>  
>  /*
>   * Locate the struct page for both the matching buddy in our
> 

