Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F1FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E784A207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="I+Q6F55H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgETOhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETOhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:37:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C37C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:37:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s21so4123394ejd.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k9a4yj0MuIquiuHcgLAuITw21En7MJN+VIITP5CpbD4=;
        b=I+Q6F55Hv3hJbZ274sPb2I5KbpzXe2i29v/p+ck+988HySt5+6rJ3ADVXWWXkkAi0Y
         7IC/Lfq0M9titHf/akcKXX3zsJ/TKYVDJVT196lf10ijRoYQN7cnGSWWvkfIXnXVVfAj
         LDzPef6T7ZoMTtBUVPREtCsYhez7+WUwBHlcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k9a4yj0MuIquiuHcgLAuITw21En7MJN+VIITP5CpbD4=;
        b=Mcnb0+PRdORj9yoGyW4M57Bj7N3ZjeMq07b82TYsJ1x20elvmg3TvXm9Kqj666E1cf
         B8a4Cjorz2BNbOo8/tRUL451efMx9FooWnGRjzUgDY0Wy8CUg/wKET/45j0yxi6W7sp4
         wld3ZI5ULKgcCaVxyR2KWlzrQwzmuJP7gF4WuelS/MgHGrer2Qaxvjt1dATj8Mbhkgwj
         cpO8AbEE0br5RwsTCOEiIv0GlxF4ZYBeRAR4yxrdecBTmz4WOX6GaujVJodGqfHJP2Y8
         6w73dd1Bia7rv1W+E0jK0L7nQD1F/d4TtKEXUMf2LovpuiCI6BSkKlK1r7jgZO9iR63x
         ESXg==
X-Gm-Message-State: AOAM532sLIRv/4Uod0SIYOtrHLKBNGEQ8uMwy7/zbNhtzu3N++Dgnjy1
        wYhQtLC29yu0hJkEIDwKM5P1lQ==
X-Google-Smtp-Source: ABdhPJzxIHGgH9nM6vQEvQqzcIrfRNGFqaqKcb9nqpgf8jN7KzaQ9t8o4DHx4z91ww3+I5uqZxSYGw==
X-Received: by 2002:a17:906:f103:: with SMTP id gv3mr3868508ejb.226.1589985432937;
        Wed, 20 May 2020 07:37:12 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:758d])
        by smtp.gmail.com with ESMTPSA id s20sm2060359eju.96.2020.05.20.07.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:37:12 -0700 (PDT)
Date:   Wed, 20 May 2020 15:37:12 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm, memcg: reclaim more aggressively before high allocator
 throttling
Message-ID: <20200520143712.GA749486@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Facebook production, we've seen cases where cgroups have been put
into allocator throttling even when they appear to have a lot of slack
file caches which should be trivially reclaimable.

Looking more closely, the problem is that we only try a single cgroup
reclaim walk for each return to usermode before calculating whether or
not we should throttle. This single attempt doesn't produce enough
pressure to shrink for cgroups with a rapidly growing amount of file
caches prior to entering allocator throttling.

As an example, we see that threads in an affected cgroup are stuck in
allocator throttling:

    # for i in $(cat cgroup.threads); do
    >     grep over_high "/proc/$i/stack"
    > done
    [<0>] mem_cgroup_handle_over_high+0x10b/0x150
    [<0>] mem_cgroup_handle_over_high+0x10b/0x150
    [<0>] mem_cgroup_handle_over_high+0x10b/0x150

...however, there is no I/O pressure reported by PSI, despite a lot of
slack file pages:

    # cat memory.pressure
    some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
    full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
    # cat io.pressure
    some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
    full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
    # grep _file memory.stat
    inactive_file 1370939392
    active_file 661635072

This patch changes the behaviour to retry reclaim either until the
current task goes below the 10ms grace period, or we are making no
reclaim progress at all. In the latter case, we enter reclaim throttling
as before.

To a user, there's no intuitive reason for the reclaim behaviour to
differ from hitting memory.high as part of a new allocation, as opposed
to hitting memory.high because someone lowered its value. As such this
also brings an added benefit: it unifies the reclaim behaviour between
the two.

There's precedent for this behaviour: we already do reclaim retries when
writing to memory.{high,max}, in max reclaim, and in the page allocator
itself.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/memcontrol.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2df9510b7d64..b040951ccd6b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,6 +73,7 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 
+/* The number of times we should retry reclaim failures before giving up. */
 #define MEM_CGROUP_RECLAIM_RETRIES	5
 
 /* Socket memory accounting disabled? */
@@ -2228,17 +2229,22 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-static void reclaim_high(struct mem_cgroup *memcg,
-			 unsigned int nr_pages,
-			 gfp_t gfp_mask)
+static unsigned long reclaim_high(struct mem_cgroup *memcg,
+				  unsigned int nr_pages,
+				  gfp_t gfp_mask)
 {
+	unsigned long nr_reclaimed = 0;
+
 	do {
 		if (page_counter_read(&memcg->memory) <= READ_ONCE(memcg->high))
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
-		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
+		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
+							     gfp_mask, true);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
+
+	return nr_reclaimed;
 }
 
 static void high_work_func(struct work_struct *work)
@@ -2378,16 +2384,20 @@ void mem_cgroup_handle_over_high(void)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
+	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
+	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
 
 	if (likely(!nr_pages))
 		return;
 
 	memcg = get_mem_cgroup_from_mm(current->mm);
-	reclaim_high(memcg, nr_pages, GFP_KERNEL);
 	current->memcg_nr_pages_over_high = 0;
 
+retry_reclaim:
+	nr_reclaimed = reclaim_high(memcg, nr_pages, GFP_KERNEL);
+
 	/*
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
 	 * allocators proactively to slow down excessive growth.
@@ -2403,6 +2413,14 @@ void mem_cgroup_handle_over_high(void)
 	if (penalty_jiffies <= HZ / 100)
 		goto out;
 
+	/*
+	 * If reclaim is making forward progress but we're still over
+	 * memory.high, we want to encourage that rather than doing allocator
+	 * throttling.
+	 */
+	if (nr_reclaimed || nr_retries--)
+		goto retry_reclaim;
+
 	/*
 	 * If we exit early, we're guaranteed to die (since
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
-- 
2.26.2

