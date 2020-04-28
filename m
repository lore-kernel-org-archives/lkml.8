Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E167C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4571E20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OuNXAGxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgD1S1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728834AbgD1S1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:27:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7BEC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:27:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x4so3952962wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RbhBW/kVDmKBpgBPPDRywC4JTwBWDdk0LU6fqNqndyM=;
        b=OuNXAGxvdUOUc9ZBfgB767lk50030ejNZaRDkEYB6KuqorrlYWG7cJxPf4RkcJWkbV
         Rb5HrQ+gTll9Y+l5xv5kK3PWiwLB2qNBQTpDztW5AuUSMfVYEKH8jHOJQHQPMsSXbjSK
         fa1BiGUCbJIK9mdCAFVMw9EgkTzhHxxjmy7lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbhBW/kVDmKBpgBPPDRywC4JTwBWDdk0LU6fqNqndyM=;
        b=jwO4auqGseqj6xyfT6BkM1JLeLiGhsfAq0y10J2YYJUnzAJ4+L7qcSu6QPZyIccu0s
         s0g2HWhA+sTAvPi4BT++2ClptSGLUV8wPPj9kT+SXH7ChHwWfigX1Rfnzw/SiNzGgpuq
         EmxKZ9pt3VPE9X3tLnybRyEgP/Inx5moRjayU94Cb5JggwbdoQQOw0Twn08DYTUL1K1z
         vydlsrmQLVMubNB235Rx60tUBfc8fQGmQh9UMDqeGKb+1bOQyF5qbXviXUSnxDNlmoWH
         9fFLeNWC9rdxwX6ddSRpj3cgQIkn0dC3w9WNXQB1c1qfepiMcIoxd3FXZ6/bfD6jUDvD
         OugQ==
X-Gm-Message-State: AGi0PuYqG+j1GtkCeZLDhQpd1uRcS+0SGqL0oVgZD87zJ+hzBXEBc0o9
        f3exJG8YoEXtbrCXX7R90MwiMA==
X-Google-Smtp-Source: APiQypItaAgbrMyavidZT6lgynKH9R7FHzJu+K99KFV9jUtxw7W/Ss6N3fBp/UNDfbIk0XzuT3fBvw==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr6261512wmk.39.1588098421110;
        Tue, 28 Apr 2020 11:27:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id h2sm4475049wmf.34.2020.04.28.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:27:00 -0700 (PDT)
Date:   Tue, 28 Apr 2020 19:27:00 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm, memcg: Decouple e{low,min} state mutations from
 protection checks
Message-ID: <51ffacb736bb02ecc09c828ebe8f4ec7fda68c48.1588092152.git.chris@chrisdown.name>
References: <cover.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588092152.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_protected currently is both used to set effective low and min
and return a mem_cgroup_protection based on the result. As a user, this
can be a little unexpected: it appears to be a simple predicate
function, if not for the big warning in the comment above about the
order in which it must be executed.

This change makes it so that we separate the state mutations from the
actual protection checks, which makes it more obvious where we need to
be careful mutating internal state, and where we are simply checking and
don't need to worry about that.

Signed-off-by: Chris Down <chris@chrisdown.name>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/memcontrol.h | 48 +++++++++++++++++++++++++++++---------
 mm/memcontrol.c            | 30 +++++++-----------------
 mm/vmscan.c                | 17 ++++----------
 3 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d630af1a4e17..88576b1235b0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -50,12 +50,6 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
-enum mem_cgroup_protection {
-	MEMCG_PROT_NONE,
-	MEMCG_PROT_LOW,
-	MEMCG_PROT_MIN,
-};
-
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	unsigned int generation;
@@ -357,8 +351,26 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 		   READ_ONCE(memcg->memory.elow));
 }
 
-enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
-						struct mem_cgroup *memcg);
+void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg);
+
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return false;
+
+	return READ_ONCE(memcg->memory.elow) >=
+		page_counter_read(&memcg->memory);
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return false;
+
+	return READ_ONCE(memcg->memory.emin) >=
+		page_counter_read(&memcg->memory);
+}
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  gfp_t gfp_mask, struct mem_cgroup **memcgp,
@@ -838,13 +850,27 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 						  bool in_low_reclaim)
 {
+
+
+static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+						   struct mem_cgroup *memcg);
+{
+}
+
+static inline void mem_cgroup_protection(struct mem_cgroup *memcg,
+					 bool in_low_reclaim)
+{
 	return 0;
 }
 
-static inline enum mem_cgroup_protection mem_cgroup_protected(
-	struct mem_cgroup *root, struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+{
+	return false;
+}
+
+static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 {
-	return MEMCG_PROT_NONE;
+	return false;
 }
 
 static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b0374be44e9e..317dbbaac603 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6368,27 +6368,21 @@ static unsigned long effective_protection(unsigned long usage,
 }
 
 /**
- * mem_cgroup_protected - check if memory consumption is in the normal range
+ * mem_cgroup_calculate_protection - calculate and cache effective low and min
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
- *
- * Returns one of the following:
- *   MEMCG_PROT_NONE: cgroup memory is not protected
- *   MEMCG_PROT_LOW: cgroup memory is protected as long there is
- *     an unprotected supply of reclaimable memory from other cgroups.
- *   MEMCG_PROT_MIN: cgroup memory is protected
  */
-enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
-						struct mem_cgroup *memcg)
+void mem_cgroup_calculate_protection(struct mem_cgroup *root,
+				     struct mem_cgroup *memcg)
 {
 	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
 
 	if (mem_cgroup_disabled())
-		return MEMCG_PROT_NONE;
+		return;
 
 	if (!root)
 		root = root_mem_cgroup;
@@ -6403,22 +6397,22 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 		 */
 		WRITE_ONCE(memcg->memory.emin, 0);
 		WRITE_ONCE(memcg->memory.elow, 0);
-		return MEMCG_PROT_NONE;
+		return;
 	}
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-		return MEMCG_PROT_NONE;
+		return;
 
 	parent = parent_mem_cgroup(memcg);
 	/* No parent means a non-hierarchical mode on v1 memcg */
 	if (!parent)
-		return MEMCG_PROT_NONE;
+		return;
 
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
 		memcg->memory.elow = memcg->memory.low;
-		goto out;
+		return;
 	}
 
 	parent_usage = page_counter_read(&parent->memory);
@@ -6431,14 +6425,6 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
 			memcg->memory.low, READ_ONCE(parent->memory.elow),
 			atomic_long_read(&parent->memory.children_low_usage)));
-
-out:
-	if (usage <= memcg->memory.emin)
-		return MEMCG_PROT_MIN;
-	else if (usage <= memcg->memory.elow)
-		return MEMCG_PROT_LOW;
-	else
-		return MEMCG_PROT_NONE;
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 72ac38eb8c29..e913c4652341 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2645,14 +2645,15 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		unsigned long reclaimed;
 		unsigned long scanned;
 
-		switch (mem_cgroup_protected(target_memcg, memcg)) {
-		case MEMCG_PROT_MIN:
+		mem_cgroup_calculate_protection(target_memcg, memcg);
+
+		if (mem_cgroup_below_min(memcg)) {
 			/*
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		case MEMCG_PROT_LOW:
+		} else if (mem_cgroup_below_low(memcg)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
@@ -2664,16 +2665,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				continue;
 			}
 			memcg_memory_event(memcg, MEMCG_LOW);
-			break;
-		case MEMCG_PROT_NONE:
-			/*
-			 * All protection thresholds breached. We may
-			 * still choose to vary the scan pressure
-			 * applied based on by how much the cgroup in
-			 * question has exceeded its protection
-			 * thresholds (see get_scan_count).
-			 */
-			break;
 		}
 
 		reclaimed = sc->nr_reclaimed;
-- 
2.26.2

