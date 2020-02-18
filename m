Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5CC3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF06208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzWZN8N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBRW1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:27:15 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42768 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgBRW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:27:15 -0500
Received: by mail-pl1-f201.google.com with SMTP id k16so10936773pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=eGlw4mfkVo6U76801oQzH59xpynvIYX/RN7BDkRX24s=;
        b=fzWZN8N1C4R3jALjqLTu+KjZnmG9DjN+7vqKhgsbyDGFqcoPuvuf6X5xGBIrqlg/4e
         S0ieQI4H+uX2+da6XAMXzqkwympEJ/+0AJWHK6bB+C6/p9yDx+tVh+psoKQg5nsPINHB
         mPtmJuTqihDid89LGZQTEmIqdUwpNwasFWWNdgE2y/duUG9YMWhRPaYknwxHXLF3xSIx
         V6R5HpVBmYgJe4NNTNMfJ0BdSV9AxNI8hEWpnZLBpDKn6sXAZ0SJuAwnkwVdZq6V9qoj
         JjXDpImWPsvRVeoEZAe5lGnYtp76nDHvFqObFZli6Yw6hUg7HqBunAyZDBevNvv4KAVB
         aumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=eGlw4mfkVo6U76801oQzH59xpynvIYX/RN7BDkRX24s=;
        b=tqPTzVGBB14iHSasHgcyp+7J8skwf+qmLz8HbECBgf805GK24f+RhzW97LOik8Qr0y
         Oc78AJq0XndA5mEcfzTGpZWUiY5KzgRilYY91AI7ErESMbGHnzw8PQk+HhYGji92WaWI
         TtcYClZNuSkOFxwpwihLyz9Zez1bcrwDZZYQ4ZARbU2+gY6Lslx4RM1CquUvtz3isval
         TqKIfQ5nMNzhwRLnoEEhxoWUa5ogOQkwcRLuxTfwWqdCuKCrP1likVeXpCCfFI/v0wTv
         wAZDBRKTPR2SgXRLohdG/rgtD+rFFg3MI029BCZIpLfno3GK+k35nHW9QEn+adO5TMaE
         oQfQ==
X-Gm-Message-State: APjAAAVv1bv1t8I7+SE5Y3cKz/GXptQHQzIe3LuP1EqCHUWPd2U/VNWI
        AJHmeNZzATXRWol77lX806G9XqW0M2wg4FEJ7g==
X-Google-Smtp-Source: APXvYqxAcnEHkXsaFEzbR1G9lrKsAuVIgxKmGwoJE1hFhI3xxkcGXJ3AY2YDmQaA2VGkBG60gw60jq3c5KG7MGCz6A==
X-Received: by 2002:a65:669a:: with SMTP id b26mr2237466pgw.24.1582064833005;
 Tue, 18 Feb 2020 14:27:13 -0800 (PST)
Date:   Tue, 18 Feb 2020 14:26:58 -0800
Message-Id: <20200218222658.132101-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH -next] mm/hugetlb: Fix file_region entry allocations
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
 mm/hugetlb.c | 149 +++++++++++++++++++++++++--------------------------
 1 file changed, 74 insertions(+), 75 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8171d2211be77..3d5b48ae8971f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -439,6 +439,66 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	return add;
 }

+/* Must be called with resv->lock acquired. Will drop lock to allocate entries.
+ */
+static int allocate_file_region_entries(struct resv_map *resv,
+					int regions_needed)
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
+		list_for_each_entry_safe (rg, trg, &allocated_regions, link) {
+			list_del(&rg->link);
+			list_add(&rg->link, &resv->region_cache);
+			resv->region_cache_count++;
+		}
+	}
+
+	return 0;
+
+out_of_memory:
+	list_for_each_entry_safe (rg, trg, &allocated_regions, link) {
+		list_del(&rg->link);
+		kfree(rg);
+	}
+	return -ENOMEM;
+}
+
 /*
  * Add the huge page range represented by [f, t) to the reserve
  * map.  Regions will be taken from the cache to fill in this range.
@@ -460,11 +520,7 @@ static long region_add(struct resv_map *resv, long f, long t,
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
@@ -476,34 +532,24 @@ static long region_add(struct resv_map *resv, long f, long t,
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
@@ -516,13 +562,6 @@ static long region_add(struct resv_map *resv, long f, long t,
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
@@ -548,11 +587,7 @@ static long region_add(struct resv_map *resv, long f, long t,
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

@@ -563,49 +598,13 @@ static long region_chg(struct resv_map *resv, long f, long t,
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
