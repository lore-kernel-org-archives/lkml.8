Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8776AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E6214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMrUJZwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgE0UvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0UvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:51:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CFC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so30690252ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YVYRNvysn9oOP+JbhCab5oPWw+cahvTfFV2XbJXPH8=;
        b=oMrUJZwK/+gkd0z9VgJ4X4RolejBPUiCG6Yidd84ll5pzlM+XjF7P+DuSSd/MrUMy2
         t9F5OqcazuBiIoU72sVHm7Xef2At2euugQ4sASnQLHP4GFG3Fx3xhNmapcDjPwh0Tiwm
         EckLuH8c064w0mo6R8INxZqDybhzkaFKsBGUoMRoLKadfHMNdOfIhTn+pN4NM09K3kvq
         arOt2fJ/9kf8aQPej9WzYfNy5Td3JPNNQrgdAj5wrDoCVNQGD1CzHhj9DCWV8MmTWc0P
         NpTxDEm3ClDVtw88sSl8R7al/GIIfI6PkxEA0DMvLENNZRA4lWH8efG2e0hKeWBfRVtQ
         y0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YVYRNvysn9oOP+JbhCab5oPWw+cahvTfFV2XbJXPH8=;
        b=ht/1JRrMJNuzninwkMdSV90uyg75kMTmDBGiJQ72ETb7cy4kP/25vHwRyqvOcPpa4J
         AyXWHbrcLv9XgejWclEWl44cfzkQMv3EmezvCLJgns1SkzHW87wVQiIOQWGTJccKwtMX
         nomdQnD5Pi5MvSOP1eoH4ceFpYiVc2vqSfR3F2UZZc4FoQ4f+y07dWE0cVWRHaO+f0So
         xPXJ+ilTN8xMER7pdfz47VE55FuaA2oXrbSBF6eo/yK3AmtcYiN0TTIW0q2VJ/nrcpqj
         qEMA7+zCYnzjKz0xmI2+yAxdZ2j4fk7ZCGz+3jTa4KKtWSK5SaMWf3SHT6hHOYNaLnKX
         Yzzg==
X-Gm-Message-State: AOAM532KRV7d0777Ft1GKorWj6vh89XM0XD07oRSI2oMt1FYLDtjV2F8
        IRnabYpzX5dl0FfPM+B8wSc=
X-Google-Smtp-Source: ABdhPJyZDeKx+C3ZTCkdHxWT44zyxSQUeuEeiLbGry792ADyf+rasHZkF14TwB0Vasi3/jtLj7i4cQ==
X-Received: by 2002:a2e:8811:: with SMTP id x17mr3776076ljh.140.1590612662606;
        Wed, 27 May 2020 13:51:02 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z78sm1045919lfc.80.2020.05.27.13.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 13:51:01 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/3] mm/vmalloc: simplify merge_or_add_vmap_area() func.
Date:   Wed, 27 May 2020 22:50:52 +0200
Message-Id: <20200527205054.1696-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when a VA is deallocated and is about to be
placed back to the tree, it can be either: merged with
next/prev neighbors or inserted if not coalesced.

On those steps the tree can be populated several times.
For example when both neighbors are merged. It can be
avoided and simplified in fact.

Therefore do it only once when VA points to final merged
area, after all manipulations: merging/removing/inserting.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 410bfe26ee73..a875eef1e2c2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -753,9 +753,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
 		if (sibling->va_start == va->va_end) {
 			sibling->va_start = va->va_start;
 
-			/* Check and update the tree if needed. */
-			augment_tree_propagate_from(sibling);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
 
@@ -775,14 +772,18 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	if (next->prev != head) {
 		sibling = list_entry(next->prev, struct vmap_area, list);
 		if (sibling->va_end == va->va_start) {
-			sibling->va_end = va->va_end;
-
-			/* Check and update the tree if needed. */
-			augment_tree_propagate_from(sibling);
-
+			/*
+			 * If both neighbors are coalesced, it is important
+			 * to unlink the "next" node first, followed by merging
+			 * with "previous" one. Otherwise the tree might not be
+			 * fully populated if a sibling's augmented value is
+			 * "normalized" because of rotation operations.
+			 */
 			if (merged)
 				unlink_va(va, root);
 
+			sibling->va_end = va->va_end;
+
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
 
@@ -793,11 +794,13 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	}
 
 insert:
-	if (!merged) {
+	if (!merged)
 		link_va(va, root, parent, link, head);
-		augment_tree_propagate_from(va);
-	}
 
+	/*
+	 * Last step is to check and update the tree.
+	 */
+	augment_tree_propagate_from(va);
 	return va;
 }
 
-- 
2.20.1

