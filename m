Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D77C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD72D22202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJ+MrGbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgDQTBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727997AbgDQTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:01:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C377DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:01:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu11so1462394pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=49omjXsA5fBWctSyjgxE1tPtwh8kx0lLfOwxC+2xFD0=;
        b=CJ+MrGbGGTuL55Wi5HfpaSJgbygZyhf77d/k48dhWRmwATG8wpvvzhDEpGu5XO/drj
         WSSuxG6cnXoF0ZRNRqA4fsy80K3PoTPFz2PqN2Q6wMqmaVOyhHMnlbpcvdtOyszHJFHL
         odqt17DSf0R7Z5AYxY70eg3pn9+zU+HI+kPekEGEGld9Bzv/+6GtXTNtNkwoPVNS/iue
         HM8eH0Sc2YRbF4/NrgJadJXC/txrTR9ICAKk401L2XV1y51jSC03tMshNBTPrmb/e2J5
         EBVht55LLwd0GCWdU56nbBcPJj3QmLe4LEWZC4Ml+HnrGqnR9Fh4e8pn+Eel7gfI782T
         Bkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=49omjXsA5fBWctSyjgxE1tPtwh8kx0lLfOwxC+2xFD0=;
        b=kpZ2/QgrUeHMHixQP2p9d42TXmcyeAz1YRZe247PLEf3DRDv5QRai9COi0SUam6jZd
         4DslL5w7oR5AohvgPDFdVGZgi2V25AbNc5GF1Rabr69ahoJSV9Ix7OmpfxvU0YVQ4Jj+
         FeEos/TCVm/9hPRxhjPoRGGMOQ7kySC+oqDr8aRktbZQkOBNWDBPvao74X2BOhvGiL/W
         ujQnyGHyvsegDmTErdgfiLUdvU7d5RuvyGYZTYgvuHNYalVosW3O9wsKTAfpu/uE7h17
         6SRKrq0iS6SfMwIyAKTXGZFqrkiiI5qDLuutsAYQXSx1C91IrrT+TL583UE24NKjoHvV
         h+hQ==
X-Gm-Message-State: AGi0Pub6YXPshJaaLBz/LLuOtyLQnSussaymX/roFY3G0cKY2f5b64id
        wM4oYduUGyK+ZbHSSeBdLGKX98JednM=
X-Google-Smtp-Source: APiQypJR2aEv+nVOxpZ+QV+bA+DRRYKEcg9WvB8SA1gqEMtj4QsgnpkWOhRhOAEoEiVEiuS8cqe50A==
X-Received: by 2002:a17:90a:c24a:: with SMTP id d10mr6084087pjx.5.1587150068682;
        Fri, 17 Apr 2020 12:01:08 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m14sm18781679pgk.56.2020.04.17.12.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 12:01:07 -0700 (PDT)
Date:   Fri, 17 Apr 2020 12:01:06 -0700 (PDT)
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
        Baoquan He <bhe@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v5 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
In-Reply-To: <1587095923-7515-2-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.22.394.2004171200530.89859@chino.kir.corp.google.com>
References: <1587095923-7515-1-git-send-email-iamjoonsoo.kim@lge.com> <1587095923-7515-2-git-send-email-iamjoonsoo.kim@lge.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, js1304@gmail.com wrote:

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
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: David Rientjes <rientjes@google.com>
