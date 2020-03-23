Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF06C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8C9206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDd1f+L/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCWEtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 00:49:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40192 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgCWEty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 00:49:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so5403448plk.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 21:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RyA/WFJ7OIIKWj1oEQMHX6SzWBI3+p9s2ndbG4zvYc0=;
        b=MDd1f+L/uULab5heF0EGov2GBDJoXND5VXz5Rfu2Ed3bQLGIEfmmCfrdlS1DntThgw
         qPIXJtVOPfZqC4LoR02tkN8R9U2E2vhzjDuJAuBcd84tcCdYC/lxN5EOP1qQoV8/HR2D
         u3nabHbiKRR435g2abZOzoCZapr4pl3GUj8vK6h79xj+gO72YNfts2Wv+sFhaYIZvPKg
         KXuewWxDWpfx4XoJtIV7jdVswQ/oFc1zXETpXPREimNohCuXzamSyJqp/KGaWWHG8zvl
         xEvP95Rb73uv/EOhcie9oBjfFxc5WBlq2HCx6qVdeSrMf2qKvFrcEVLgLWXAoyjlV6+0
         v3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RyA/WFJ7OIIKWj1oEQMHX6SzWBI3+p9s2ndbG4zvYc0=;
        b=gRk87F3GXT5I8OD4xyVMBefSmOG9mT7L2tBEGy0w62eZqLvMchuwY99zhgkQTC4N2q
         xYBDHG9gxPnAnNeKZBNHWTCPCDZrn6JvE3rr3jDdZkfIDEZZ5gRE7acdyix7P43cBQj1
         Z/o1WXvpqZpmZFc/V2fzW8d56SYrRzdGFWFhGF3MqNfqXYWa3WLhxZP9TRyPO1rRdKNd
         RiM+85tT4ypSmunzqISyZC2GyUw1+0sl5dMUv8mmW7SXY2j281PG3pbn8qfNtY/iUNM1
         OaRXKK0Vg1DfZWdDQGE6/U9lJyQcUBE27dj+w/QsaM5B7dh+RkrI+/8VFmAN+IeBRJN4
         E1wA==
X-Gm-Message-State: ANhLgQ3ho7jAkPbpOux5bgi2xgxRkQCcmflp5AUSxQfNcXAa2Y8ynia0
        5QsIlOuUaUO19pD4bDezKxM=
X-Google-Smtp-Source: ADFU+vs3p0Gv+RPRIYA6+pAEe8Ga0ChAYUqhA5SU9MbvWvWsOpEh4ywinxxDhIsI3MpFeGbTEIOKYQ==
X-Received: by 2002:a17:90a:c392:: with SMTP id h18mr11377828pjt.89.1584938993097;
        Sun, 22 Mar 2020 21:49:53 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id c207sm11903982pfb.47.2020.03.22.21.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 21:49:52 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Baoquan He <bhe@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 1/2] mm/page_alloc: use ac->high_zoneidx for classzone_idx
Date:   Mon, 23 Mar 2020 13:49:31 +0900
Message-Id: <1584938972-7430-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584938972-7430-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584938972-7430-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Currently, we use classzone_idx to calculate lowmem reserve proetection
for an allocation request. This classzone_idx causes a problem
on NUMA systems when the lowmem reserve protection exists for some zones
on a node that do not exist on other nodes.

Before further explanation, I should first clarify how to compute
the classzone_idx and the high_zoneidx.

- ac->high_zoneidx is computed via the arcane gfp_zone(gfp_mask) and
represents the index of the highest zone the allocation can use
- classzone_idx was supposed to be the index of the highest zone on
the local node that the allocation can use, that is actually available
in the system

Think about following example. Node 0 has 4 populated zone,
DMA/DMA32/NORMAL/MOVABLE. Node 1 has 1 populated zone, NORMAL. Some zones,
such as MOVABLE, doesn't exist on node 1 and this makes following
difference.

Assume that there is an allocation request whose gfp_zone(gfp_mask) is
the zone, MOVABLE. Then, it's high_zoneidx is 3. If this allocation is
initiated on node 0, it's classzone_idx is 3 since actually
available/usable zone on local (node 0) is MOVABLE. If this allocation
is initiated on node 1, it's classzone_idx is 2 since actually
available/usable zone on local (node 1) is NORMAL.

You can see that classzone_idx of the allocation request are different
according to their starting node, even if their high_zoneidx is the same.

Think more about these two allocation requests. If they are processed
on local, there is no problem. However, if allocation is initiated
on node 1 are processed on remote, in this example, at the NORMAL zone
on node 0, due to memory shortage, problem occurs. Their different
classzone_idx leads to different lowmem reserve and then different
min watermark. See the following example.

root@ubuntu:/sys/devices/system/memory# cat /proc/zoneinfo
Node 0, zone      DMA
  per-node stats
...
  pages free     3965
        min      5
        low      8
        high     11
        spanned  4095
        present  3998
        managed  3977
        protection: (0, 2961, 4928, 5440)
...
Node 0, zone    DMA32
  pages free     757955
        min      1129
        low      1887
        high     2645
        spanned  1044480
        present  782303
        managed  758116
        protection: (0, 0, 1967, 2479)
...
Node 0, zone   Normal
  pages free     459806
        min      750
        low      1253
        high     1756
        spanned  524288
        present  524288
        managed  503620
        protection: (0, 0, 0, 4096)
...
Node 0, zone  Movable
  pages free     130759
        min      195
        low      326
        high     457
        spanned  1966079
        present  131072
        managed  131072
        protection: (0, 0, 0, 0)
...
Node 1, zone      DMA
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 1006, 1006)
Node 1, zone    DMA32
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 1006, 1006)
Node 1, zone   Normal
  per-node stats
...
  pages free     233277
        min      383
        low      640
        high     897
        spanned  262144
        present  262144
        managed  257744
        protection: (0, 0, 0, 0)
...
Node 1, zone  Movable
  pages free     0
        min      0
        low      0
        high     0
        spanned  262144
        present  0
        managed  0
        protection: (0, 0, 0, 0)

- static min watermark for the NORMAL zone on node 0 is 750.
- lowmem reserve for the request with classzone idx 3 at the NORMAL
on node 0 is 4096.
- lowmem reserve for the request with classzone idx 2 at the NORMAL
on node 0 is 0.

So, overall min watermark is:
allocation initiated on node 0 (classzone_idx 3): 750 + 4096 = 4846
allocation initiated on node 1 (classzone_idx 2): 750 + 0 = 750

allocation initiated on node 1 will have some precedence than allocation
initiated on node 0 because min watermark of the former allocation is
lower than the other. So, allocation initiated on node 1 could succeed
on node 0 when allocation initiated on node 0 could not, and, this could
cause too many numa_miss allocation. Then, performance could be
downgraded.

Recently, there was a regression report about this problem on CMA patches
since CMA memory are placed in ZONE_MOVABLE by those patches. I checked
that problem is disappeared with this fix that uses high_zoneidx
for classzone_idx.

http://lkml.kernel.org/r/20180102063528.GG30397@yexl-desktop

Using high_zoneidx for classzone_idx is more consistent way than previous
approach because system's memory layout doesn't affect anything to it.
With this patch, both classzone_idx on above example will be 3 so will
have the same min watermark.

allocation initiated on node 0: 750 + 4096 = 4846
allocation initiated on node 1: 750 + 4096 = 4846

One could wonder if there is a side effect that allocation initiated on
node 1 will use higher bar when allocation is handled on local since
classzone_idx could be higher than before. It will not happen because
the zone without managed page doesn't contributes lowmem_reserve at all.

Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
Tested-by: Ye Xiaolong <xiaolong.ye@intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index c39c895..aebaa33 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -119,7 +119,7 @@ struct alloc_context {
 	bool spread_dirty_pages;
 };
 
-#define ac_classzone_idx(ac) zonelist_zone_idx(ac->preferred_zoneref)
+#define ac_classzone_idx(ac) (ac->high_zoneidx)
 
 /*
  * Locate the struct page for both the matching buddy in our
-- 
2.7.4

