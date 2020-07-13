Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62436C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8820738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="XPk/m3az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgGMLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgGMLmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:42:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:42:50 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so13280205edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNFqZOOI2Y2+hjmMi9f9WyAk2VzDnQXCrSncEbD+OF8=;
        b=XPk/m3az111JebUG3++E4Wc34pLE+nXcrm2myLzSUtXpP/DQgp3Zg3cR1US1pAiaSG
         0mGCh9yrvAoIixSWMzggOTBPUTnXB+1q7SwVYb61N8Hns40cEjd/WdPnGEmftaVWuz+Z
         /JdxhvRkhZqRwlwtNRjOFAMtHiRhDuGB9MNfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNFqZOOI2Y2+hjmMi9f9WyAk2VzDnQXCrSncEbD+OF8=;
        b=golml2pTGOD8RvtmgVDByigVykDaHjH+QDHZGdI0+APYOfnlbI5Dx0zjHlJQ13AUfk
         EAkcPerqPBNC1PrNaoIpcVe0P46hm4Y2lvm0Gv/TkxFtsU29RJgVz/M20k75RdDFV76t
         L4EyYJcEKwJoeGwUydmKamVVY6NOkQqZHHeQylQZShBfVSS1kSaG73FeMHmkXUg2sNXx
         F6zGap4SdxQnw4EaNSBV/lBv7QzQ3kQhHLZTQE9U1bmBsyYafwlJ3NJcKNQvFUISNXDg
         PW43gSongMgMjgK0IuTW45lOSlTA0gmP6/hrUK58bDawUr4vX/sa3Kq2/1EpkaxMxCFM
         9RaA==
X-Gm-Message-State: AOAM533DDUp2JknCS5RD+5LQgBjjXnE1wfInbJc1HwR2Rv0ofuwgLhsM
        gcnIah6+9bgTUjlIhlQaI/okUw==
X-Google-Smtp-Source: ABdhPJyBWP+SbDDs651fzGxZ9kryEASz/UerrssnUJ7RuqAc2LHY/8f18CH1WZPS/mJY1MOX+dZAcw==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr87336086edb.60.1594640569319;
        Mon, 13 Jul 2020 04:42:49 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id v24sm11220349eds.71.2020.07.13.04.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:42:49 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:42:48 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 2/2] mm, memcg: unify reclaim retry limits with page
 allocator
Message-ID: <da557856c9c7654308eaff4eedc1952a95e8df5f.1594640214.git.chris@chrisdown.name>
References: <cover.1594640214.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594640214.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reclaim retries have been set to 5 since the beginning of time in
commit 66e1707bc346 ("Memory controller: add per cgroup LRU and
reclaim").  However, we now have a generally agreed-upon standard for
page reclaim: MAX_RECLAIM_RETRIES (currently 16), added many years later
in commit 0a0337e0d1d1 ("mm, oom: rework oom detection").

In the absence of a compelling reason to declare an OOM earlier in memcg
context than page allocator context, it seems reasonable to supplant
MEM_CGROUP_RECLAIM_RETRIES with MAX_RECLAIM_RETRIES, making the page
allocator and memcg internals more similar in semantics when reclaim
fails to produce results, avoiding premature OOMs or throttling.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d4b0d8af3747..672123875494 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,9 +73,6 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 
-/* The number of times we should retry reclaim failures before giving up. */
-#define MEM_CGROUP_RECLAIM_RETRIES	5
-
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket;
 
@@ -2540,7 +2537,7 @@ void mem_cgroup_handle_over_high(void)
 	unsigned long pflags;
 	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
-	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
 	bool in_retry = false;
 
@@ -2617,7 +2614,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
-	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
@@ -2736,7 +2733,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
 	switch (oom_status) {
 	case OOM_SUCCESS:
-		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
 	case OOM_FAILED:
 		goto force;
@@ -3396,7 +3393,7 @@ static inline bool memcg_has_children(struct mem_cgroup *memcg)
  */
 static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
-	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	int nr_retries = MAX_RECLAIM_RETRIES;
 
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
@@ -6225,7 +6222,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long high;
 	int err;
@@ -6273,7 +6270,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned int nr_reclaims = MEM_CGROUP_RECLAIM_RETRIES;
+	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long max;
 	int err;
-- 
2.27.0

