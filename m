Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD4C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDD0207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifPDsbrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBSB17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:27:59 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:56265 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgBSB17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:27:59 -0500
Received: by mail-vs1-f74.google.com with SMTP id x15so1700257vsq.22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 17:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=NyXzgKqqlwj77LRuwVimuxxnchYdD60uwJY9TwWTfVQ=;
        b=ifPDsbrQIK1DJQT7gYr+3k2jKIzwCslljV05SmxfXu5wb9BG8KCrC99qq8al5JWPWJ
         +cZS73agavKV2UYS2um59GDVhCXRtB0Jwfu1y2TFc21l8IAVD8FvBDbJb3ZZaXdHaaXX
         svhVcWp0vVkPqijCzOWop8vM8n4bfy2gRWteE3qwvhYh50lEgKaKzeyUhf5opvWnuVbq
         wU1NjZl/qX399Yg6XQD1JTwMCc/T+CIc69THlXMKhXhBdkn+grnDHynYO+33otbekWLg
         BdKuDJO6dintg8t2VRKgO+TKA/JbL9VAVn3k2Gh6vFidPhNcQZmqqJKF/XRx0ea18+nA
         Vkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=NyXzgKqqlwj77LRuwVimuxxnchYdD60uwJY9TwWTfVQ=;
        b=UQHmnqJaYFZo0QLYoR3iF6iL6NTg7cheDAgt+WZ3y3OaPUjUm64QdpkyUctL6tNV/L
         wIw3W3mGj57Vhh3wxlX6gpcFrPZgbnQfyw2Y2vEohy+jwGqMrAb09iB9wijUqUWKIBFw
         JgHUrjaixN5I/xdypJA3sQmjAtbgoMwiM1inJmKJUf49/JBw+2BgFUeLugjDeOc0A0Gy
         ZOvaM8MkI1s9mxsvDd7/sA/R3HIk9ff7mOcqdKprwvCnRTvNlf7YBY9wm9awD9bCot7p
         XKH1lENT4SX6ESsggEdYPtdeTxtW5xxrrOjtMt5ka/psPrNocGNkNM7vecXTtcSpD2yA
         6WcQ==
X-Gm-Message-State: APjAAAXfG6Pqq6as8QYNNcQT04HZ4DaIUC23COe4RdvzsuV/Ir01m3BG
        +5WzAATQxtbT5krdFNabcuIgkf/ITNaztROHtQ==
X-Google-Smtp-Source: APXvYqwjkuvT6dWYO7+hiYJqkQ5AejmFmZcOjhVWPjc7QQVrsotE37gkApVWZhNMQ4bjdF+RaP3BLBsSENnaSWXAaQ==
X-Received: by 2002:a67:bb18:: with SMTP id m24mr12972747vsn.92.1582075678201;
 Tue, 18 Feb 2020 17:27:58 -0800 (PST)
Date:   Tue, 18 Feb 2020 17:27:37 -0800
In-Reply-To: <67aa82a8-3c8d-d1eb-7e83-4f722b1eeb2a@oracle.com>
Message-Id: <20200219012736.20363-1-almasrymina@google.com>
Mime-Version: 1.0
References: <67aa82a8-3c8d-d1eb-7e83-4f722b1eeb2a@oracle.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] mm/hugetlb: Fix file_region entry allocations
From:   Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        mike.kravetz@oracle.com, Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a9e443086489e ("hugetlb: disable region_add file_region
coalescing") introduced a bug with adding file_region entries
that is fixed here:

1. Refactor file_region entry allocation logic into 1 function called
   from region_add and region_chg since the code is now identical.
2. region_chg only modifies resv->adds_in_progress after the regions
   have been allocated. In the past it used to increment
   adds_in_progress and then drop the lock, which would confuse racing
   region_add calls into thinking they need to allocate entries when
   they are not allowed.
3. In region_add, only try to allocate regions when
   actual_regions_needed > in_regions_needed. This is not causing a bug
   but is better for cleanliness and reasoning about the code.

Tested using ltp hugemmap0* tests, and libhugetlbfs tests.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Fixes: Commit a9e443086489e ("hugetlb: disable region_add file_region
coalescing")

---

Changes in v2:
- Added __must_hold.
- Fixed formatting issues due to clang format adding space after
list_for_each_entry_safe

---
 mm/hugetlb.c | 150 +++++++++++++++++++++++++--------------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8171d2211be77..94e27dfec0435 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -439,6 +439,67 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	return add;
 }

+/* Must be called with resv->lock acquired. Will drop lock to allocate entries.
+ */
+static int allocate_file_region_entries(struct resv_map *resv,
+					int regions_needed)
+	__must_hold(&resv->lock)
+{
+	struct list_head allocated_regions;
+	int to_allocate = 0, i = 0;
+	struct file_region *trg = NULL, *rg = NULL;
+
+	VM_BUG_ON(regions_needed < 0);
+
+	INIT_LIST_HEAD(&allocated_regions);
+
+	/*
+	 * Check for sufficient descriptors in the cache to accommodate
+	 * the number of in progress add operations plus regions_needed.
+	 *
+	 * This is a while loop because when we drop the lock, some other call
+	 * to region_add or region_del may have consumed some region_entries,
+	 * so we keep looping here until we finally have enough entries for
+	 * (adds_in_progress + regions_needed).
+	 */
+	while (resv->region_cache_count <
+	       (resv->adds_in_progress + regions_needed)) {
+		to_allocate = resv->adds_in_progress + regions_needed -
+			      resv->region_cache_count;
+
+		/* At this point, we should have enough entries in the cache
+		 * for all the existings adds_in_progress. We should only be
+		 * needing to allocate for regions_needed.
+		 */
+		VM_BUG_ON(resv->region_cache_count < resv->adds_in_progress);
+
+		spin_unlock(&resv->lock);
+		for (i = 0; i < to_allocate; i++) {
+			trg = kmalloc(sizeof(*trg), GFP_KERNEL);
+			if (!trg)
+				goto out_of_memory;
+			list_add(&trg->link, &allocated_regions);
+		}
+
+		spin_lock(&resv->lock);
+
+		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+			list_del(&rg->link);
+			list_add(&rg->link, &resv->region_cache);
+			resv->region_cache_count++;
+		}
+	}
+
+	return 0;
+
+out_of_memory:
+	list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
+		list_del(&rg->link);
+		kfree(rg);
+	}
+	return -ENOMEM;
+}
+
 /*
  * Add the huge page range represented by [f, t) to the reserve
  * map.  Regions will be taken from the cache to fill in this range.
@@ -460,11 +521,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 		       long in_regions_needed, struct hstate *h,
 		       struct hugetlb_cgroup *h_cg)
 {
-	long add = 0, actual_regions_needed = 0, i = 0;
-	struct file_region *trg = NULL, *rg = NULL;
-	struct list_head allocated_regions;
-
-	INIT_LIST_HEAD(&allocated_regions);
+	long add = 0, actual_regions_needed = 0;

 	spin_lock(&resv->lock);
 retry:
@@ -476,34 +533,24 @@ static long region_add(struct resv_map *resv, long f, long t,
 	/*
 	 * Check for sufficient descriptors in the cache to accommodate
 	 * this add operation. Note that actual_regions_needed may be greater
-	 * than in_regions_needed. In this case, we need to make sure that we
+	 * than in_regions_needed, as the resv_map may have been modified since
+	 * the region_chg call. In this case, we need to make sure that we
 	 * allocate extra entries, such that we have enough for all the
 	 * existing adds_in_progress, plus the excess needed for this
 	 * operation.
 	 */
-	if (resv->region_cache_count <
-	    resv->adds_in_progress +
-		    (actual_regions_needed - in_regions_needed)) {
+	if (actual_regions_needed > in_regions_needed &&
+	    resv->region_cache_count <
+		    resv->adds_in_progress +
+			    (actual_regions_needed - in_regions_needed)) {
 		/* region_add operation of range 1 should never need to
 		 * allocate file_region entries.
 		 */
 		VM_BUG_ON(t - f <= 1);

-		/* Must drop lock to allocate a new descriptor. */
-		spin_unlock(&resv->lock);
-		for (i = 0; i < (actual_regions_needed - in_regions_needed);
-		     i++) {
-			trg = kmalloc(sizeof(*trg), GFP_KERNEL);
-			if (!trg)
-				goto out_of_memory;
-			list_add(&trg->link, &allocated_regions);
-		}
-		spin_lock(&resv->lock);
-
-		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
-			list_del(&rg->link);
-			list_add(&rg->link, &resv->region_cache);
-			resv->region_cache_count++;
+		if (allocate_file_region_entries(
+			    resv, actual_regions_needed - in_regions_needed)) {
+			return -ENOMEM;
 		}

 		goto retry;
@@ -516,13 +563,6 @@ static long region_add(struct resv_map *resv, long f, long t,
 	spin_unlock(&resv->lock);
 	VM_BUG_ON(add < 0);
 	return add;
-
-out_of_memory:
-	list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
-		list_del(&rg->link);
-		kfree(rg);
-	}
-	return -ENOMEM;
 }

 /*
@@ -548,11 +588,7 @@ static long region_add(struct resv_map *resv, long f, long t,
 static long region_chg(struct resv_map *resv, long f, long t,
 		       long *out_regions_needed)
 {
-	struct file_region *trg = NULL, *rg = NULL;
-	long chg = 0, i = 0, to_allocate = 0;
-	struct list_head allocated_regions;
-
-	INIT_LIST_HEAD(&allocated_regions);
+	long chg = 0;

 	spin_lock(&resv->lock);

@@ -563,49 +599,13 @@ static long region_chg(struct resv_map *resv, long f, long t,
 	if (*out_regions_needed == 0)
 		*out_regions_needed = 1;

-	resv->adds_in_progress += *out_regions_needed;
-
-	/*
-	 * Check for sufficient descriptors in the cache to accommodate
-	 * the number of in progress add operations.
-	 */
-	while (resv->region_cache_count < resv->adds_in_progress) {
-		to_allocate = resv->adds_in_progress - resv->region_cache_count;
-
-		/* Must drop lock to allocate a new descriptor. Note that even
-		 * though we drop the lock here, we do not make another call to
-		 * add_reservation_in_range after re-acquiring the lock.
-		 * Essentially this branch makes sure that we have enough
-		 * descriptors in the cache as suggested by the first call to
-		 * add_reservation_in_range. If more regions turn out to be
-		 * required, region_add will deal with it.
-		 */
-		spin_unlock(&resv->lock);
-		for (i = 0; i < to_allocate; i++) {
-			trg = kmalloc(sizeof(*trg), GFP_KERNEL);
-			if (!trg)
-				goto out_of_memory;
-			list_add(&trg->link, &allocated_regions);
-		}
-
-		spin_lock(&resv->lock);
+	if (allocate_file_region_entries(resv, *out_regions_needed))
+		return -ENOMEM;

-		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
-			list_del(&rg->link);
-			list_add(&rg->link, &resv->region_cache);
-			resv->region_cache_count++;
-		}
-	}
+	resv->adds_in_progress += *out_regions_needed;

 	spin_unlock(&resv->lock);
 	return chg;
-
-out_of_memory:
-	list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
-		list_del(&rg->link);
-		kfree(rg);
-	}
-	return -ENOMEM;
 }

 /*
--
2.25.0.265.gbab2e86ba0-goog
