Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1159C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A3120732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 07:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+A7tpcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCWHIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:08:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29399 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbgCWHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 03:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584947311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S03b3F9iHEt841kWkXvzy1biEDEq5O5RfIpRpSYleGQ=;
        b=U+A7tpcJgSGuaiI+d05x8h7ahaEpQ3W/rDiTSx54mNVF9x7/EjV8VfW7S+KO/+0OuSbYLN
        K+dqTcT+hlZ7Aqfc8bkHq8WUrbVql765EqyWjmct621pDT8K9EFiKdqu745q9XKlJrsLye
        5PuoUjYJ6+6WW7DlmdfXKFYjO/xC43E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-sF8Ni4tDOWWouYlrPMAAbg-1; Mon, 23 Mar 2020 03:08:24 -0400
X-MC-Unique: sF8Ni4tDOWWouYlrPMAAbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA8CE8024E5;
        Mon, 23 Mar 2020 07:08:21 +0000 (UTC)
Received: from localhost (ovpn-13-26.pek2.redhat.com [10.72.13.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E04A110246E6;
        Mon, 23 Mar 2020 07:08:16 +0000 (UTC)
Date:   Mon, 23 Mar 2020 15:08:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
Message-ID: <20200323070814.GE3039@MiWiFi-R3L-srv>
References: <1584938972-7430-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584938972-7430-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584938972-7430-2-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 at 01:49pm, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, we use classzone_idx to calculate lowmem reserve proetection
> for an allocation request. This classzone_idx causes a problem
> on NUMA systems when the lowmem reserve protection exists for some zones
> on a node that do not exist on other nodes.
> 
> Before further explanation, I should first clarify how to compute
> the classzone_idx and the high_zoneidx.
> 
> - ac->high_zoneidx is computed via the arcane gfp_zone(gfp_mask) and
> represents the index of the highest zone the allocation can use
> - classzone_idx was supposed to be the index of the highest zone on
> the local node that the allocation can use, that is actually available
> in the system
> 
> Think about following example. Node 0 has 4 populated zone,
> DMA/DMA32/NORMAL/MOVABLE. Node 1 has 1 populated zone, NORMAL. Some zones,
> such as MOVABLE, doesn't exist on node 1 and this makes following
> difference.
> 
> Assume that there is an allocation request whose gfp_zone(gfp_mask) is
> the zone, MOVABLE. Then, it's high_zoneidx is 3. If this allocation is
> initiated on node 0, it's classzone_idx is 3 since actually
> available/usable zone on local (node 0) is MOVABLE. If this allocation
> is initiated on node 1, it's classzone_idx is 2 since actually
> available/usable zone on local (node 1) is NORMAL.
> 
> You can see that classzone_idx of the allocation request are different
> according to their starting node, even if their high_zoneidx is the same.
> 
> Think more about these two allocation requests. If they are processed
> on local, there is no problem. However, if allocation is initiated
> on node 1 are processed on remote, in this example, at the NORMAL zone
> on node 0, due to memory shortage, problem occurs. Their different
> classzone_idx leads to different lowmem reserve and then different
> min watermark. See the following example.
> 
> root@ubuntu:/sys/devices/system/memory# cat /proc/zoneinfo
> Node 0, zone      DMA
>   per-node stats
> ...
>   pages free     3965
>         min      5
>         low      8
>         high     11
>         spanned  4095
>         present  3998
>         managed  3977
>         protection: (0, 2961, 4928, 5440)
> ...
> Node 0, zone    DMA32
>   pages free     757955
>         min      1129
>         low      1887
>         high     2645
>         spanned  1044480
>         present  782303
>         managed  758116
>         protection: (0, 0, 1967, 2479)
> ...
> Node 0, zone   Normal
>   pages free     459806
>         min      750
>         low      1253
>         high     1756
>         spanned  524288
>         present  524288
>         managed  503620
>         protection: (0, 0, 0, 4096)
> ...
> Node 0, zone  Movable
>   pages free     130759
>         min      195
>         low      326
>         high     457
>         spanned  1966079
>         present  131072
>         managed  131072
>         protection: (0, 0, 0, 0)
> ...
> Node 1, zone      DMA
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
>         protection: (0, 0, 1006, 1006)
> Node 1, zone    DMA32
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  0
>         present  0
>         managed  0
>         protection: (0, 0, 1006, 1006)
> Node 1, zone   Normal
>   per-node stats
> ...
>   pages free     233277
>         min      383
>         low      640
>         high     897
>         spanned  262144
>         present  262144
>         managed  257744
>         protection: (0, 0, 0, 0)
> ...
> Node 1, zone  Movable
>   pages free     0
>         min      0
>         low      0
>         high     0
>         spanned  262144
>         present  0
>         managed  0
>         protection: (0, 0, 0, 0)
> 
> - static min watermark for the NORMAL zone on node 0 is 750.
> - lowmem reserve for the request with classzone idx 3 at the NORMAL
> on node 0 is 4096.
> - lowmem reserve for the request with classzone idx 2 at the NORMAL
> on node 0 is 0.
> 
> So, overall min watermark is:
> allocation initiated on node 0 (classzone_idx 3): 750 + 4096 = 4846
> allocation initiated on node 1 (classzone_idx 2): 750 + 0 = 750
> 
> allocation initiated on node 1 will have some precedence than allocation
> initiated on node 0 because min watermark of the former allocation is
> lower than the other. So, allocation initiated on node 1 could succeed
> on node 0 when allocation initiated on node 0 could not, and, this could
> cause too many numa_miss allocation. Then, performance could be
> downgraded.
> 
> Recently, there was a regression report about this problem on CMA patches
> since CMA memory are placed in ZONE_MOVABLE by those patches. I checked
> that problem is disappeared with this fix that uses high_zoneidx
> for classzone_idx.
> 
> http://lkml.kernel.org/r/20180102063528.GG30397@yexl-desktop
> 
> Using high_zoneidx for classzone_idx is more consistent way than previous
> approach because system's memory layout doesn't affect anything to it.
> With this patch, both classzone_idx on above example will be 3 so will
> have the same min watermark.
> 
> allocation initiated on node 0: 750 + 4096 = 4846
> allocation initiated on node 1: 750 + 4096 = 4846
> 
> One could wonder if there is a side effect that allocation initiated on
> node 1 will use higher bar when allocation is handled on local since
> classzone_idx could be higher than before. It will not happen because
> the zone without managed page doesn't contributes lowmem_reserve at all.
> 
> Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
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

Reviewed-by: Baoquan He <bhe@redhat.com>

