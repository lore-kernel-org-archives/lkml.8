Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C7C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE3020BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="jSJCSfFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDTWLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgDTWLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:11:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17923C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:11:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o10so10031262qtr.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdvfGvgiqTSSOoBTgsdkzUj0PUR50dAV0CLgbDwpjiQ=;
        b=jSJCSfFnTO4OPR2PXMMzBOLsjd60fYz1Vz33KEeQxmcKLLFNqwHx+eXNUVCnUa2jgm
         MQ4870epg/fzfEnY9kY5ISvA7kYnVP/9AuHpnpKNUl/oO0szqT26wFUh2CLiVtMBuEeT
         ZQ5OHAfKrv2ncOOfaqOue/BLHXBNj0mcCmcukxAk66reBSpYugVJdzKsveaTJa52j0jM
         8hWWqm8AlHfx56RV3dkaOZgwf/VK1N06+y7NVVNpwC6B7rOoga8lfZ2wESPCMrP38XY9
         mNp05N9AcF1W0XAbs5y1ZVxleAKBZyozJujlPFrpgen1kBAtNDHA683yLdfD8tP2K5ne
         g74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdvfGvgiqTSSOoBTgsdkzUj0PUR50dAV0CLgbDwpjiQ=;
        b=p+S7pmYskpdd3YlmSePnL+4lZyj6lFUpzXro5EUlrcbMNfVk2AugYFiq4NlVF08WoT
         9WP/Cy27UudYSsn/KymnrYBOStDzQ9PvCS7Gq2tufKkf6SNrp3n7a1vcg+XT43XvEmU1
         wYGlgvWwF+Pw/wjS+AbnYWW3VeqriwHsXMqTv/mJ2EAQvQeDhLbXm6FbWreQX9OCx8Cp
         1UHzKltxrcr+4IehaLjIH0n+cjfrCgJXYdTiVGT2pqKiRshP/jfaCJlQuhdc4yf8uyYi
         MFO229CqmzdvTRMCoesnaXX0pZImGTBPhe5g1NmbiIN0rpzUxYkwfvCGg88Wm1Nzi1XM
         D+pQ==
X-Gm-Message-State: AGi0PuY5S8r73jfq8RhyHDbHNL0IbEnwi+uo45lFX3mTtRjF7/gQpVRS
        GMlt5vm/CR+OIs9ZtDcKZEBSGQ==
X-Google-Smtp-Source: APiQypLfSIi+vdlDFawvJqDgWwzmcuPG3NT3Wp2BJPzm3VNpRR8NI6wXFm3m0cUbCRlugdLi8j0DTQ==
X-Received: by 2002:ac8:16d2:: with SMTP id y18mr18682751qtk.64.1587420707285;
        Mon, 20 Apr 2020 15:11:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id j2sm426943qth.57.2020.04.20.15.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:11:46 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 04/18] mm: memcontrol: move out cgroup swaprate throttling
Date:   Mon, 20 Apr 2020 18:11:12 -0400
Message-Id: <20200420221126.341272-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
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
---
 include/linux/swap.h |  6 ++----
 mm/memcontrol.c      |  5 ++---
 mm/swapfile.c        | 14 +++++++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b835d8dbea0e..e0380554f4c4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -645,11 +645,9 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
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
index 5ed8f6651383..711d6dd5cbb1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6493,12 +6493,11 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
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
index 9c9ab44780ba..74543137371b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3744,11 +3744,12 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
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
@@ -3762,11 +3763,10 @@ void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg, int node,
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
2.26.0

