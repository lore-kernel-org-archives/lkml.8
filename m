Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C5DC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744822051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tws2LMcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCTKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:30:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33711 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgCTKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584700219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n50kHpROexT6YiYa/Io5ADXBuL5kM7y5ZXouNOkPHn4=;
        b=Tws2LMcFlCxeQHCWoHBI5bPddIhntGHRYnQwjfnvGo7DZLGspnjOF4jQOUuUR48AxJcIPz
        o/NvqWnumzYeNmXV+wuHo/z/DE89fH2351ByBHyqr/BvBy5JL5PSukKjGgIOb5jlHD4pC/
        sMFY03D/ZP2qPfiHRrFxZrSvCo5TZVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-rWClrCJ-MqerTG3aAiIE2A-1; Fri, 20 Mar 2020 06:30:11 -0400
X-MC-Unique: rWClrCJ-MqerTG3aAiIE2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F48E190D343;
        Fri, 20 Mar 2020 10:30:09 +0000 (UTC)
Received: from localhost (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25DFF5C28D;
        Fri, 20 Mar 2020 10:30:02 +0000 (UTC)
Date:   Fri, 20 Mar 2020 18:30:00 +0800
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
Subject: Re: [PATCH v3 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
Message-ID: <20200320103000.GB3039@MiWiFi-R3L-srv>
References: <1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584693135-4396-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584693135-4396-2-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/20/20 at 05:32pm, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, we use the zone index of preferred_zone which represents
> the best matching zone for allocation, as classzone_idx. It has
> a problem on NUMA systems when the lowmem reserve protection exists
> for some zones on a node that do not exist on other nodes.
> 
> In NUMA system, it can be possible that each node has different populated
> zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
> node 1 could have only NORMAL zone. In this setup, allocation request
> initiated on node 0 and the one on node 1 would have different
> classzone_idx, 3 and 2, respectively, since their preferred_zones are
> different. If the allocation is local, there is no problem. However,
> if it is handled by the remote node due to memory shortage, the problem
> would happen.

Hi Joonsoo,

Not sure if adding one sentence into above paragraph would be make it
easier to understand. Assume you are only talking about the high_zoneidx
is MOVABLE_ZONE with calculation of gfp_zone(gfp_mask), since any other
case doesn't have this problem. Please correct me if I am wrong.

In NUMA system, it can be possible that each node has different populated
zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
node 1 could have only NORMAL zone. In this setup, if we get high_zoneidx
as 3 (namely MOVABLE zone), with gfp_zone(gfp_mask), allocation request
initiated on node 0 and the one on node 1 would have different
classzone_idx, 3 and 2, respectively, since their preferred_zones are
different. If the allocation is local, there is no problem. However,
if it is handled by the remote node due to memory shortage, the problem
would happen.

Thanks
Baoquan

> 
> In the following setup, allocation initiated on node 1 will have some
> precedence than allocation initiated on node 0 when former allocation is
> processed on node 0 due to not enough memory on node 1. They will have
> different lowmem reserve due to their different classzone_idx thus
> an watermark bars are also different.
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
> min watermark for NORMAL zone on node 0
> allocation initiated on node 0: 750 + 4096 = 4846
> allocation initiated on node 1: 750 + 0 = 750
> 
> This watermark difference could cause too many numa_miss allocation
> in some situation and then performance could be downgraded.
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
>  
>  /*
>   * Locate the struct page for both the matching buddy in our
> -- 
> 2.7.4
> 
> 

