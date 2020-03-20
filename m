Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E45C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DF120774
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRteJ3wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgCTIcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:32:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44690 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:32:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id 37so2701174pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fPSSxy7Sb5FMFyGDgOEpC3OGiXR80DXgt3C2tiJbk38=;
        b=SRteJ3wZGid+C453tX+JpakjQekyh2c3gekBGk5Ab8LTwjFyn4TfftkKuG5A94i/pC
         uJwr76zrbrp5GWijPJYxUg9Az9s/F6a1sJMqbHjwJ3wUxjEl1U5OnPmpDeqOCj6wyCJh
         rXon7fgTFJmel1nH9nQNK4hw41unwplMZKbBctQFPgs3assTSvI0NGxYz5C65H9InsE2
         HAXk53MCsBnO5p99y24uSDFcxyVVnD/pwJUY+jzRwGuT4pO9hsipVKW3una8t5HNbn7c
         XsPHtByrCNWOb/aZfgh4Wi7lYPbucsuXueryXN2LQOqm4eGhALv4R6GrBC7vfNsOTAk5
         UWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fPSSxy7Sb5FMFyGDgOEpC3OGiXR80DXgt3C2tiJbk38=;
        b=sTy+yheZZdjuT9FDBZVavM6wxllZMaAs8Eyvgm5zf4XFU4dQeRI/k+NpNb01oU9X3W
         lgFP6/EHywf16W9qze7rqhfWed048k6NKBJLNmlamsNEFLsoA/hBOeWIsng0eBP3ZZLq
         4aPvDWjlMDZaQHOZE1k5jBBahz/nv+fcKRphZBJLcJcXdP9tIC5Qk0bwsXvj0o5e/A22
         MTXZ2h1Fd9FZ2KauidzRwjJy5br4h3NPky8LcRK3Lwtof3MoqAoZNi6/cSHMc3RNtaDF
         OeZiXDFAvI6je8QTVNopErDN0u55MtquJ4DlqkRjaJzRoEisP13x38NF2mxg5J+BhhF0
         3shQ==
X-Gm-Message-State: ANhLgQ3RB7LljRBCLtCXqrsRIhhxV+tpgamkPUnzQCLJRZKzjG32ltFo
        ae5IvSc0bvMw5llOdmZR9zA=
X-Google-Smtp-Source: ADFU+vuk9Hc9r1N9+VblRAXdUT+tBZqrOZVC0Thl3oIx30Nev25k84+uml3nHPGeVgwis+YTNu247Q==
X-Received: by 2002:a63:6b8a:: with SMTP id g132mr7254055pgc.359.1584693158467;
        Fri, 20 Mar 2020 01:32:38 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y193sm4501986pgd.87.2020.03.20.01.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 01:32:37 -0700 (PDT)
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 1/2] mm/page_alloc: use ac->high_zoneidx for classzone_idx
Date:   Fri, 20 Mar 2020 17:32:14 +0900
Message-Id: <1584693135-4396-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Currently, we use the zone index of preferred_zone which represents
the best matching zone for allocation, as classzone_idx. It has
a problem on NUMA systems when the lowmem reserve protection exists
for some zones on a node that do not exist on other nodes.

In NUMA system, it can be possible that each node has different populated
zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone and
node 1 could have only NORMAL zone. In this setup, allocation request
initiated on node 0 and the one on node 1 would have different
classzone_idx, 3 and 2, respectively, since their preferred_zones are
different. If the allocation is local, there is no problem. However,
if it is handled by the remote node due to memory shortage, the problem
would happen.

In the following setup, allocation initiated on node 1 will have some
precedence than allocation initiated on node 0 when former allocation is
processed on node 0 due to not enough memory on node 1. They will have
different lowmem reserve due to their different classzone_idx thus
an watermark bars are also different.

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

min watermark for NORMAL zone on node 0
allocation initiated on node 0: 750 + 4096 = 4846
allocation initiated on node 1: 750 + 0 = 750

This watermark difference could cause too many numa_miss allocation
in some situation and then performance could be downgraded.

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

