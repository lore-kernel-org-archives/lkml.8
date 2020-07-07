Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4001C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0ACE20739
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLhvTve8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgGGHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgGGHpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911A8C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u18so2770032pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KgSYgJifAABNAdCl31WAEwkkXwU/m9EAOT3Cz401Kt8=;
        b=hLhvTve8x5zI3uXWp0qoUJQ29QsztVfkJaD3Ks6ZD1fprMNLVmGC6HZZP4lfhXGhog
         AHJj7XueKuRo+AKpUnqm8ewpNXzKFaHEes5S7LF/3eQOUFGO6rxTLUhS7qbSNvJV4f+P
         phOZGS49CF3yCcbvwkFmdBdSm1T9OUClKDCCZ6Z/qBBKbAX2x2sTGFDnD5AC5eTLI9yR
         k1vdl+vTHP086FJgF0xZ/mFgZTlP27So2vTNLVaIuSb3ftZDzmDmnT0nHIaFnkwL8Skb
         oHuVk/M7PGu4KdAovMw3oIcOl3VpnESvfZnuyj2OpD2wcIYySGWZvc1fLMO0hec0N9Lp
         t10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KgSYgJifAABNAdCl31WAEwkkXwU/m9EAOT3Cz401Kt8=;
        b=Sww20ojh4+JPlJ1zyfUk4Y+RIn759FK9O8dLsMsB9zpB0sNTw0HkLs5G0K5vlh4XkM
         Dp8J3/H6j2RrBYCjJHUXdeAFU/xIH3G6/+1OSU4x7jnFpzXxcd8+Ypkm8IjhgBrTG8sd
         5R+Zq+o1mRCwnfmSU+d7zhGJnQDZeJJP74XtdL8FNmG/dP0QklXIGvMCZde9xxSbCLME
         yG5nqF9iznvC4BF7M5uUR1I0LPMup4I0TGvf9Txw0QZT0cy88pQrjrq9oJEfKzEyGx++
         tBVj6sWQek0diZBBeIrtHjiexfktzPVZWRTLOdEBRxwCxhqAZ34DvW6ykN5IvEnRr9in
         k7kQ==
X-Gm-Message-State: AOAM533jKRk2yJGgv2mMGoe6HuknsCN62Nfg8j7yl8NJG5lY+UOWPNyP
        pb07EKBCJeW7MfnEZuhvcvc=
X-Google-Smtp-Source: ABdhPJxlDO3WoaDglb+wcPrmU/2YdnCSFYtWgnyHAXUK3MmN5luVVbSC7GR0VJ76/+5DCFgxQUNvgg==
X-Received: by 2002:a65:5502:: with SMTP id f2mr8232183pgr.375.1594107946170;
        Tue, 07 Jul 2020 00:45:46 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:45 -0700 (PDT)
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
Subject: [PATCH v4 11/11] mm/memory_hotplug: remove a wrapper for alloc_migration_target()
Date:   Tue,  7 Jul 2020 16:44:49 +0900
Message-Id: <1594107889-32228-12-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

To calculate the correct node to migrate the page for hotplug, we need
to check node id of the page. Wrapper for alloc_migration_target() exists
for this purpose.

However, Vlastimil informs that all migration source pages come from
a single node. In this case, we don't need to check the node id for each
page and we don't need to re-set the target nodemask for each page by
using the wrapper. Set up the migration_target_control once and use it for
all pages.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memory_hotplug.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 86bc2ad..269e8ca 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1265,27 +1265,6 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-static struct page *new_node_page(struct page *page, unsigned long private)
-{
-	nodemask_t nmask = node_states[N_MEMORY];
-	struct migration_target_control mtc = {
-		.nid = page_to_nid(page),
-		.nmask = &nmask,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
-	};
-
-	/*
-	 * try to allocate from a different node but reuse this node if there
-	 * are no other online nodes to be used (e.g. we are offlining a part
-	 * of the only existing node)
-	 */
-	node_clear(mtc.nid, *mtc.nmask);
-	if (nodes_empty(*mtc.nmask))
-		node_set(mtc.nid, *mtc.nmask);
-
-	return alloc_migration_target(page, (unsigned long)&mtc);
-}
-
 static int
 do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
@@ -1345,9 +1324,28 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		put_page(page);
 	}
 	if (!list_empty(&source)) {
-		/* Allocate a new page from the nearest neighbor node */
-		ret = migrate_pages(&source, new_node_page, NULL, 0,
-					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+		nodemask_t nmask = node_states[N_MEMORY];
+		struct migration_target_control mtc = {
+			.nmask = &nmask,
+			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		};
+
+		/*
+		 * We have checked that migration range is on a single zone so
+		 * we can use the nid of the first page to all the others.
+		 */
+		mtc.nid = page_to_nid(list_first_entry(&source, struct page, lru));
+
+		/*
+		 * try to allocate from a different node but reuse this node
+		 * if there are no other online nodes to be used (e.g. we are
+		 * offlining a part of the only existing node)
+		 */
+		node_clear(mtc.nid, *mtc.nmask);
+		if (nodes_empty(*mtc.nmask))
+			node_set(mtc.nid, *mtc.nmask);
+		ret = migrate_pages(&source, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
-- 
2.7.4

