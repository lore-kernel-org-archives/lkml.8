Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC4C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8628C206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="NAh8EB3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgDTWML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgDTWMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:12:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC312C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:12:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so12520342qkl.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BfoKiO68JS5GTVEtZtyPUsjUcvWwl21g5043cZUh4U=;
        b=NAh8EB3ujMtE3JW8FwO9QxU3wUahsLprFKjL+rZXgB98pAw/I1cRRlwb2E6WmfTSKr
         hMoJ1ESOu7U+cptDfS12CTHbRFNUXyTTyM+e5ZBwS3WsLfBERvNyWbjL1rz9CyOrki1Z
         by3J2+GSY280wtFvaZz6sJpi1Z0h1h5Ry/6DbqUWV1cUz9W/QtX48Irm9VN19PEM+N0T
         cEN8+VMev+TEjzZm/3dE7VyirSa+3/eDvmF2J7D947wy7TTen2d4MZUKOVw57GLfUksT
         EYoEUThyWb5X6dQHwoK7972N6f1MV1WW8Ewt3U5dEl7uQctc2S3sXKlO1FiejUhtm7vK
         evgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BfoKiO68JS5GTVEtZtyPUsjUcvWwl21g5043cZUh4U=;
        b=VP15IJeLjSDbP5FYNQhWDcJKBW3BGvJ54kVi6TzK+ugnaZRRRAORxbeV1Q4GxYjQVi
         5RXX9RiTD5c+ndbD3CNnfzs+UR32GkhZtYCn3FGQU5kcDuvJIZcq4HT5piCTSwgagzuH
         9sn1/JuE7yvp0eOeWhAeeuezdn2/tgmEhLkXq0TPTKsujqrKDfbkh5UqzVW+bHuhRI8z
         9LCkM9hcaGzcjZv0QhE/CNLMlAYC2jWQf36vgITaJSed+tJ7zlJmWtU4zJRG1y9upemW
         8xgqdz0tRWiTS0WYMiwVVdvFcrJyTFIpW2zJsobpf/56uKAdCr4X8cCLQQI640Ert1gM
         e2/w==
X-Gm-Message-State: AGi0PuZOLXhujNwpJp/gWyEAqM97Cm9XLera6yrwqOr05g6SqWPeYZ/C
        Fj1C31fC5C1yL066z44xDabjBg==
X-Google-Smtp-Source: APiQypIxbp+3vK65VX1I+DnBRv6DzoynhnXVjr4q0qoUBcIMTkCChunVmnXoTc1Lg+U3zqyPuhtE5w==
X-Received: by 2002:a05:620a:b83:: with SMTP id k3mr18223737qkh.412.1587420727081;
        Mon, 20 Apr 2020 15:12:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id k184sm573866qke.94.2020.04.20.15.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:06 -0700 (PDT)
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
Subject: [PATCH 14/18] mm: memcontrol: prepare swap controller setup for integration
Date:   Mon, 20 Apr 2020 18:11:22 -0400
Message-Id: <20200420221126.341272-15-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few cleanups to streamline the swap controller setup:

- Replace the do_swap_account flag with cgroup_memory_noswap. This
  brings it in line with other functionality that is usually available
  unless explicitly opted out of - nosocket, nokmem.

- Remove the really_do_swap_account flag that stores the boot option
  and is later used to switch the do_swap_account. It's not clear why
  this indirection is/was necessary. Use do_swap_account directly.

- Minor coding style polishing

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 59 ++++++++++++++++++--------------------
 mm/swap_cgroup.c           |  4 +--
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 52eb6411cfee..d458f1d90aa4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -560,7 +560,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
 #ifdef CONFIG_MEMCG_SWAP
-extern int do_swap_account;
+extern bool cgroup_memory_noswap;
 #endif
 
 struct mem_cgroup *lock_page_memcg(struct page *page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d5aee5577ff3..5558777023e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -83,10 +83,14 @@ static bool cgroup_memory_nokmem;
 
 /* Whether the swap controller is active */
 #ifdef CONFIG_MEMCG_SWAP
-int do_swap_account __read_mostly;
+#ifdef CONFIG_MEMCG_SWAP_ENABLED
+bool cgroup_memory_noswap __read_mostly;
 #else
-#define do_swap_account		0
-#endif
+bool cgroup_memory_noswap __read_mostly = 1;
+#endif /* CONFIG_MEMCG_SWAP_ENABLED */
+#else
+#define cgroup_memory_noswap		1
+#endif /* CONFIG_MEMCG_SWAP */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
@@ -95,7 +99,7 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && do_swap_account;
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap;
 }
 
 #define THRESHOLDS_EVENTS_TARGET 128
@@ -6458,18 +6462,19 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 		/*
 		 * Every swap fault against a single page tries to charge the
 		 * page, bail as early as possible.  shmem_unuse() encounters
-		 * already charged pages, too.  The USED bit is protected by
-		 * the page lock, which serializes swap cache removal, which
+		 * already charged pages, too.  page->mem_cgroup is protected
+		 * by the page lock, which serializes swap cache removal, which
 		 * in turn serializes uncharging.
 		 */
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		if (compound_head(page)->mem_cgroup)
 			goto out;
 
-		if (do_swap_account) {
+		if (!cgroup_memory_noswap) {
 			swp_entry_t ent = { .val = page_private(page), };
-			unsigned short id = lookup_swap_cgroup_id(ent);
+			unsigned short id;
 
+			id = lookup_swap_cgroup_id(ent);
 			rcu_read_lock();
 			memcg = mem_cgroup_from_id(id);
 			if (memcg && !css_tryget_online(&memcg->css))
@@ -6944,7 +6949,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !do_swap_account)
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) || cgroup_memory_noswap)
 		return 0;
 
 	memcg = page->mem_cgroup;
@@ -6988,7 +6993,7 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	if (!do_swap_account)
+	if (cgroup_memory_noswap)
 		return;
 
 	id = swap_cgroup_record(entry, 0, nr_pages);
@@ -7011,7 +7016,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
 	long nr_swap_pages = get_nr_swap_pages();
 
-	if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return nr_swap_pages;
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
@@ -7028,7 +7033,7 @@ bool mem_cgroup_swap_full(struct page *page)
 
 	if (vm_swap_full())
 		return true;
-	if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
 	memcg = page->mem_cgroup;
@@ -7043,22 +7048,15 @@ bool mem_cgroup_swap_full(struct page *page)
 	return false;
 }
 
-/* for remember boot option*/
-#ifdef CONFIG_MEMCG_SWAP_ENABLED
-static int really_do_swap_account __initdata = 1;
-#else
-static int really_do_swap_account __initdata;
-#endif
-
-static int __init enable_swap_account(char *s)
+static int __init setup_swap_account(char *s)
 {
 	if (!strcmp(s, "1"))
-		really_do_swap_account = 1;
+		cgroup_memory_noswap = 0;
 	else if (!strcmp(s, "0"))
-		really_do_swap_account = 0;
+		cgroup_memory_noswap = 1;
 	return 1;
 }
-__setup("swapaccount=", enable_swap_account);
+__setup("swapaccount=", setup_swap_account);
 
 static u64 swap_current_read(struct cgroup_subsys_state *css,
 			     struct cftype *cft)
@@ -7124,7 +7122,7 @@ static struct cftype swap_files[] = {
 	{ }	/* terminate */
 };
 
-static struct cftype memsw_cgroup_files[] = {
+static struct cftype memsw_files[] = {
 	{
 		.name = "memsw.usage_in_bytes",
 		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_USAGE),
@@ -7153,13 +7151,12 @@ static struct cftype memsw_cgroup_files[] = {
 
 static int __init mem_cgroup_swap_init(void)
 {
-	if (!mem_cgroup_disabled() && really_do_swap_account) {
-		do_swap_account = 1;
-		WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys,
-					       swap_files));
-		WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys,
-						  memsw_cgroup_files));
-	}
+	if (mem_cgroup_disabled() || cgroup_memory_noswap)
+		return 0;
+
+	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
+	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
+
 	return 0;
 }
 subsys_initcall(mem_cgroup_swap_init);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 45affaef3bc6..7aa764f09079 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -171,7 +171,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	unsigned long length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (!do_swap_account)
+	if (cgroup_memory_noswap)
 		return 0;
 
 	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
@@ -209,7 +209,7 @@ void swap_cgroup_swapoff(int type)
 	unsigned long i, length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (!do_swap_account)
+	if (cgroup_memory_noswap)
 		return;
 
 	mutex_lock(&swap_cgroup_mutex);
-- 
2.26.0

