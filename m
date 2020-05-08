Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E391C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1044A24953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="pxoqGiGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEHScZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgEHScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB168C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o10so2139724qtr.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJumjdWPL8ImmNUzRG9WEC1TfJwykzONtYCeiyJV9G4=;
        b=pxoqGiGXEuav96/KW40PHN/56mIPcv+pG8bFWXckn7KWmaroqEIKnTBtfp2ivpknd5
         eUpMr7sVbK7wX5G7uKSEf6hU2QLAr9AEmkT21qOLTwpAVEFYgmqlYrmbipLmLqyW+aEg
         ZhH0rgKtQ7J9/dzwlS7Saf/IslIKpJyNjugFrVQaBFZAetBkf2SmcUJpvZMK224rS+sI
         7ZWJEzgwBB3geO6LRoXV6e6KGSiF+SXl75wg2aniVze4+KdN6IR370Kh08YZ+2h72JEY
         /nnZCbfLQYr3kMrU7gIvvm8tBrJnemtlzyBLO7s+HDGXMNiJFvXkQqDGmd7mhPa7/s4o
         y7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJumjdWPL8ImmNUzRG9WEC1TfJwykzONtYCeiyJV9G4=;
        b=PVNd+9mg56Wl20B0bKLI/nSRs8PgvjYPM+7MOEl9Z/d35oMJ9K5LZO0xgshac/wdDB
         fuQbz6p+BJnWtEyJRjyqwr4Kvq8kb8Essh1ekoZ580HpDQU3/IclHdOdolLsBWygbIyt
         1vVadceb/r7brg63VUil+tQgpy4i8/hx4yO+5ZqHSIlkDKPUEbWGMr/yGyy7Aru8PIu2
         smWSG6CBc+/f1mOybbN8JIdVG1uqxDzi8tFvdf3RQUVNYkLqGlCWby7iV3/mQcl1O4K2
         c2yZf8CbU5KJvH1YCcwQECpPnM635MEMq+zN/JY4zMdVdizFibxtLsLkrl1Hy5zqCeb+
         yb5w==
X-Gm-Message-State: AGi0PubTfIf7qi0XimY0pKr4Rkjzgip/Dz91nS/MjA6k4bdAW/Qs6c3B
        NEaPzmjPOQcEbQIm4A0FbPkuAQ==
X-Google-Smtp-Source: APiQypJfBtzB9Izp4VoWSxD1LvsBcJL01Juo/72A8UeQeymaN8ofP40ppKn9jTkqrlZ3wkzGb0+wKA==
X-Received: by 2002:aed:3009:: with SMTP id 9mr4480935qte.191.1588962739111;
        Fri, 08 May 2020 11:32:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id q207sm1700107qka.13.2020.05.08.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:18 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 04/19] mm: memcontrol: move out cgroup swaprate throttling
Date:   Fri,  8 May 2020 14:30:51 -0400
Message-Id: <20200508183105.225460-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup swaprate throttling is about matching new anon allocations
to the rate of available IO when that is being throttled. It's the io
controller hooking into the VM, rather than a memory controller thing.

Rename mem_cgroup_throttle_swaprate() to cgroup_throttle_swaprate(),
and drop the @memcg argument which is only used to check whether the
preceding page charge has succeeded and the fault is proceeding.

We could decouple the call from mem_cgroup_try_charge() here as well,
but that would cause unnecessary churn: the following patches convert
all callsites to a new charge API and we'll decouple as we go along.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/swap.h |  6 ++----
 mm/memcontrol.c      |  5 ++---
 mm/swapfile.c        | 14 +++++++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 873bf5206afb..b42fb47d8cbe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -650,11 +650,9 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 #endif
 
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-extern void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
-					 gfp_t gfp_mask);
+extern void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
 #else
-static inline void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg,
-						int node, gfp_t gfp_mask)
+static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 {
 }
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 13da46a5d8ae..8188d462d7ce 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6494,12 +6494,11 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
 {
-	struct mem_cgroup *memcg;
 	int ret;
 
 	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp);
-	memcg = *memcgp;
-	mem_cgroup_throttle_swaprate(memcg, page_to_nid(page), gfp_mask);
+	if (*memcgp)
+		cgroup_throttle_swaprate(page, gfp_mask);
 	return ret;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 15e5f8f290cc..ad42eac1822d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3748,11 +3748,12 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 }
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
-				  gfp_t gfp_mask)
+void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 {
 	struct swap_info_struct *si, *next;
-	if (!(gfp_mask & __GFP_IO) || !memcg)
+	int nid = page_to_nid(page);
+
+	if (!(gfp_mask & __GFP_IO))
 		return;
 
 	if (!blk_cgroup_congested())
@@ -3766,11 +3767,10 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
 		return;
 
 	spin_lock(&swap_avail_lock);
-	plist_for_each_entry_safe(si, next, &swap_avail_heads[node],
-				  avail_lists[node]) {
+	plist_for_each_entry_safe(si, next, &swap_avail_heads[nid],
+				  avail_lists[nid]) {
 		if (si->bdev) {
-			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
-						true);
+			blkcg_schedule_throttle(bdev_get_queue(si->bdev), true);
 			break;
 		}
 	}
-- 
2.26.2

