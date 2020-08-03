Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D64BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAA8207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHCPqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:46:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCPqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:46:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBB63AF21;
        Mon,  3 Aug 2020 15:46:39 +0000 (UTC)
Date:   Mon, 3 Aug 2020 17:46:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, memory_hotplug: update pcp lists everytime onlining
 a memory block
Message-ID: <20200803154623.GX5174@dhcp22.suse.cz>
References: <1596372896-15336-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596372896-15336-1-git-send-email-charante@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02-08-20 18:24:56, Charan Teja Reddy wrote:
> When onlining a first memory block in a zone, pcp lists are not updated
> thus pcp struct will have the default setting of ->high = 0,->batch = 1.
> This means till the second memory block in a zone(if it have) is onlined
> the pcp lists of this zone will not contain any pages because pcp's
> ->count is always greater than ->high thus free_pcppages_bulk() is
> called to free batch size(=1) pages every time system wants to add a
> page to the pcp list through free_unref_page(). To put this in a word,
> system is not using benefits offered by the pcp lists when there is a
> single onlineable memory block in a zone. Correct this by always
> updating the pcp lists when memory block is onlined.

Yes this seems like an ancient bug
Fixes: 1f522509c77a ("mem-hotplug: avoid multiple zones sharing same boot strapping boot_pageset")

Just nobody has noticed because a single block memory zone is really
rare.
 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

> ---
>  mm/memory_hotplug.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index dcdf327..7f62d69 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -854,8 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	node_states_set_node(nid, &arg);
>  	if (need_zonelists_rebuild)
>  		build_all_zonelists(NULL);
> -	else
> -		zone_pcp_update(zone);
> +	zone_pcp_update(zone);
>  
>  	init_per_zone_wmark_min();
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
Michal Hocko
SUSE Labs
