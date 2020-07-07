Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FEC2077D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6OMYuv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgGGHpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgGGHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0BC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so17890140pfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6Rbtl/txKKgUuy/PEsZA5yJ3o5QkIBUvNqo+dh4x9U=;
        b=e6OMYuv6Cvw8rOj3djW6dTQTmnVCROGwcC5f18pto4sRD2ohXbd8J2oHAO7OEJMjjo
         dEWQKsL9DBuiqYEOSoAkza3yycdMtE6wkMJSEbf7dh4owmMNOvJKUZ+8B6U5wGu1xHjz
         6xkqCdO8l2H8jHQJYr09htT4bf5pIvamI22VNvk30BVA4oZEYJ2FjLBl2BroVX3+vLpG
         IRvuYZd/Lf0CxYfl2CKzbsyK2FWiNN/UlZJ4ide9GbUB4HIKewuWsCec9yh41m0tG6Vk
         UchpaM7bkesbK02c6sKL+q64Z+Vm6CGjMT9AyiAvuXKE/CUrRoCJ8HWZ/kHrE/0NA1yo
         ALiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6Rbtl/txKKgUuy/PEsZA5yJ3o5QkIBUvNqo+dh4x9U=;
        b=oQlD0zsezsfj5eWjUX/Vj42C4e7x+++ppR0UENUDaOqYGEPtVopwRRBMS5AO0Q374H
         6E/ZmiWiNvbYQzAMSXtRq+dMOCFz6OMCaOXttW9Bl37MV6pUVauDQsZrFUz3aGseJ4Ij
         CPV7TQVdHj3EqGRebLATVRII9QJKBpkmusHeCStCkDKLtM7c0RvbMLITLLtuKSSpFdcl
         lup8Yw9EHvR2Hoy3YwAyKm76zdgD+25rFfKrymAKuE949y9h3xSRh6qTjXOJnobGzYQj
         CxJ8yXuqXtnMjzMzdnDEBbD5t5Fe5o77VcuACesdoVT925LMEhFDU/u2gizYr1azVgIt
         zo2w==
X-Gm-Message-State: AOAM530o1sUqzzvfUcPxbo3cjYe/xeQiYrwaIQynz09Bos3a9d+4bqcM
        vwgurquuoYztWTcG49BzgKs=
X-Google-Smtp-Source: ABdhPJyw8VwJQhpVC5lwFEMc/qLi7+XCVCWj0fqhAIQ9/IxGxoDSgpKnUy27bITILGbIBXVOmhWGoA==
X-Received: by 2002:a63:3fc2:: with SMTP id m185mr45078394pga.426.1594107943087;
        Tue, 07 Jul 2020 00:45:43 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:42 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 10/11] mm/memory-failure: remove a wrapper for alloc_migration_target()
Date:   Tue,  7 Jul 2020 16:44:48 +0900
Message-Id: <1594107889-32228-11-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined standard migration target callback. Use it
directly.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memory-failure.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 609d42b6..3b89804 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1677,16 +1677,6 @@ int unpoison_memory(unsigned long pfn)
 }
 EXPORT_SYMBOL(unpoison_memory);
 
-static struct page *new_page(struct page *p, unsigned long private)
-{
-	struct migration_target_control mtc = {
-		.nid = page_to_nid(p),
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
-	};
-
-	return alloc_migration_target(p, (unsigned long)&mtc);
-}
-
 /*
  * Safely get reference count of an arbitrary page.
  * Returns 0 for a free page, -EIO for a zero refcount page
@@ -1793,6 +1783,10 @@ static int __soft_offline_page(struct page *page)
 	const char *msg_page[] = {"page", "hugepage"};
 	bool huge = PageHuge(page);
 	LIST_HEAD(pagelist);
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	/*
 	 * Check PageHWPoison again inside page lock because PageHWPoison
@@ -1829,8 +1823,8 @@ static int __soft_offline_page(struct page *page)
 	}
 
 	if (isolate_page(hpage, &pagelist)) {
-		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-					MIGRATE_SYNC, MR_MEMORY_FAILURE);
+		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
 		if (!ret) {
 			bool release = !huge;
 
-- 
2.7.4

