Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F2C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3056D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZB4uQqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgGMGmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgGMGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2CC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so5083744plm.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMAOJW0/CmwPwEQhOEGIEPyh16r3aJTNjCuNXO3OJWw=;
        b=AZB4uQqXY6c9kubbJEswrTO/ZtxFCRCcCXxcRIeAq76C8iM4CZt2RAS4FUMZGDxans
         +fKptV+TKZx0eeYmhpKtTa25EkoObRsvtEbOZwGEEurWsvxUVK4dK4M7ghncW4DrSNy1
         H4u7kcW2CvTkCDPTcAb/JJw/H8xv+IIJJJieJ8u9GECfgsodCAVM2uoVbYAyAtj5AJJV
         KHRSaGRSjBnzMEKyed3AQnwNyKQH3spdbaNOWkPza41TTK6YEXMT6WYtN1BKCmG56Qa8
         B6kdgEN8x7WrjMubEjFt70/UrkVTEL66RJWtuaWALjDbVySBjeYQ0PSZipwgdi2WgmOJ
         lBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMAOJW0/CmwPwEQhOEGIEPyh16r3aJTNjCuNXO3OJWw=;
        b=j0ZsXl6pk6cuIlJbS9kxPhbnI4kLI01AmoyI1ws292IH+jbbMV/SMu6sGx2PPF9GSE
         +Y7MbwSTeQUYv1W02sxrcH/YrB/vysNL5LddSD5gBxkXTe46Rs6/pmVEsrKesXyjlK6U
         h5ca6AbRT4poQ2SdRROZ0ES6EoMSsL3WgqRpi7X0J23hofAhs2HaE2KNbKYCOJPTCL5R
         eMrFpaoiZzWUk7WjdG09a0F3NUZrtXZoeXrQ0kMDriV2F7qxOG8M8Dfi7qf8HQdve8k9
         gv3TkVsHRGrFY4pbcpadJUNxyiLVRIg5YFonTQW6KeQVU60MrizIkjfxev+xNs8LNrP2
         eIpg==
X-Gm-Message-State: AOAM532Q9cXDEqzSFsAhOu5s7q5Pyf9XxcVZ5J4QWpCGrtEcgWibV+rN
        X1AUwgMB6xTwQxPa4bY3Us8=
X-Google-Smtp-Source: ABdhPJxmeB8MEEIDLVv5USvjyzYJ9LQmHfHKPMcFOR38oMOIYgi4ke1nsR2D9huc7P4TGo3RkIv4sg==
X-Received: by 2002:a17:90a:bf89:: with SMTP id d9mr18915464pjs.89.1594622563228;
        Sun, 12 Jul 2020 23:42:43 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:42 -0700 (PDT)
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
Subject: [PATCH v5 9/9] mm/memory_hotplug: remove a wrapper for alloc_migration_target()
Date:   Mon, 13 Jul 2020 15:41:57 +0900
Message-Id: <1594622517-20681-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memory_hotplug.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 431b470f..7c216d6 100644
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
-	node_clear(mtc.nid, nmask);
-	if (nodes_empty(nmask))
-		node_set(mtc.nid, nmask);
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
+		node_clear(mtc.nid, nmask);
+		if (nodes_empty(nmask))
+			node_set(mtc.nid, nmask);
+		ret = migrate_pages(&source, alloc_migration_target, NULL,
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
-- 
2.7.4

