Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E957C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF5F20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chYOJJ4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCRV3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:29:12 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34966 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:29:11 -0400
Received: by mail-pj1-f68.google.com with SMTP id j20so10442pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=luLLxM+pebJSNcHLA00A2aMuXWaYc4PSBM2OmwBMj6M=;
        b=chYOJJ4okeOHY9w3bJVU4rZAgvUM4x9pWQhofFXYN9Y2TbfqhskBfRM77FDWl0S2WV
         k0uuNmu96X9TL1kzVqkoVp13+9zEboH88wcGBZs5Z+N2qCfMmS34alZPIpy7KqYWQUgE
         aASOVyl9xEqIfPoOnaApbSnLwdsoa/cxRDkDDJZGuG1wWnbUm1ioldt/z5DjMcKQsIiH
         vNOgJW4/2Px1fReNKGN97yPLF6SpALNKMkdSLYkG1PFoxgn5tlFAMaAzpXJY3bj+4tXb
         wBELO5xTi4LzzaBiN+x2J6QYYuKYEfa4ZjZq8d4Q/0QwLSG8I7B7CyvEYtHgeBEc0PBF
         jimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=luLLxM+pebJSNcHLA00A2aMuXWaYc4PSBM2OmwBMj6M=;
        b=eJdit4igmg5vW/ugZweeO4LN2x5o3ncYFFgfiiCDXwBVGEydtltmGyfQJoBA4FuzfM
         pm8WRf9bYc9VAgD5euLBTNDx3KZcWRFA6GQmrWjjgTrTgkgEqRMuJwRftYSvpjJ3fuG8
         1E43y49Zw94wmZyhnvQH4+tdvaTbUhAnGUEDQK26SzUwaCjf0lYHD0MMfWdYRnF2UcL1
         xqpzgE4RYXVh7dQl/qN0zBdArEqX9vVIInGkg7TPrgUk3A6Ai1haZfsyvHrFWnZ2DZ6f
         DcVNRj86k4EuXhGYfgBYWkocC+53FyIYPsluClrY6AwDGclHrsoFhhU4j5X3r0DsKtFa
         RSLA==
X-Gm-Message-State: ANhLgQ0Oh4RaD6ID+lVdD5x6TPcxeCBtJbdMvoQ7hImqbkEUCf0A3nAN
        5daVzqN7p5SqvdyjusI2NZcCzg==
X-Google-Smtp-Source: ADFU+vshgCuUakR66TyN7qp4KI0ClMouQhgO9hiHUzPHXbFvgwnZ3bEm0XudIwPWiq7ESqzt1C5i4g==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr15460plb.115.1584566948722;
        Wed, 18 Mar 2020 14:29:08 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y131sm11324pfg.25.2020.03.18.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:29:08 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:29:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     js1304@gmail.com
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
In-Reply-To: <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.21.2003181419090.70237@chino.kir.corp.google.com>
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com> <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, js1304@gmail.com wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, we use the zone index of preferred_zone which represents
> the best matching zone for allocation, as classzone_idx. It has a problem
> on NUMA system with ZONE_MOVABLE.
> 

Hi Joonsoo,

More specifically, it has a problem on NUMA systems when the lowmem 
reserve protection exists for some zones on a node that do not exist on 
other nodes, right?

In other words, to make sure I understand correctly, if your node 1 had a 
ZONE_MOVABLE than this would not have happened.  If that's true, it might 
be helpful to call out that ZONE_MOVABLE itself is not necessarily a 
problem, but a system where one node has ZONE_NORMAL and ZONE_MOVABLE and 
another only has ZONE_NORMAL is the problem.

> In NUMA system, it can be possible that each node has different populated
> zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
> node 1 could have only NORMAL zone. In this setup, allocation request
> initiated on node 0 and the one on node 1 would have different
> classzone_idx, 3 and 2, respectively, since their preferred_zones are
> different. If they are handled by only their own node, there is no problem.

I'd say "If the allocation is local" rather than "If they are handled by 
only their own node".

> However, if they are somtimes handled by the remote node due to memory
> shortage, the problem would happen.
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

Alternatively, I assume that this could also be fixed by changing the 
value of the lowmem protection on the node without managed pages in the 
upper zone to be the max protection from the lowest zones?  In your 
example, node 1 ZONE_NORMAL would then be (0, 0, 0, 4096).

> One could wonder if there is a side effect that allocation initiated on
> node 1 will use higher bar when allocation is handled on node 1 since
> classzone_idx could be higher than before. It will not happen because
> the zone without managed page doesn't contributes lowmem_reserve at all.
> 
> Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Curious: is this only an issue when vm.numa_zonelist_order is set to Node?

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
> 
