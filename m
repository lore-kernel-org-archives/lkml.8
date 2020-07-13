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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDEC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF482075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2I7IHnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgGMGmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgGMGmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F8C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so5760024pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/VWaVj++GlMblCwFxNC0BZkTiy01OBPAbi2yw768aI=;
        b=Z2I7IHnRW+ZYg5Nqfw07NGatjjCO1bAgkzqvtLhoYSfW6FAOpO1im6WU8yjHJ53lxq
         EWFuNOu+TFNnYRx5Xk5sTYJwroMRtC/1LUPsAjhmzZj3CBTtCCBzCYYgyxhPKn9yqBxM
         tDe6qn1pGF3aZ6jYDL9z2u2wo60h1osPbUdYcUmz/gaZnubPl9lgA/GFYMsHWcLfbykh
         dQ0QDMZx0dT15wG4MRB+R9x+LkLAw5Gef71VthPDqVLmNgGyZOs13FgSmyFpXKWH2fZg
         OlgNFbzWlCM0d1FgCj8DXoVutaqKNQygYu+cTj8YzQ+VxD4T4peIXL+3mBUT9qaW5LbL
         qovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/VWaVj++GlMblCwFxNC0BZkTiy01OBPAbi2yw768aI=;
        b=WAlgpLbCnAk8p6y/RCPdgrR9Ahynazoo/W9m437rMgmv9vqoxkDMcYDly7tKSWS1qd
         BPwzwxWL8I2LgyCZ3VfebsteDNme/Noq69xDiraaY3M2Cm5GShGu9+jGZ5eUOVUf9JqI
         arhGYkFdNGdVW4JrscO74J3LAqFRPmPA3ZfrYwZsjffuaLL+4iZPVIH7rK1UdhSgYrt+
         zv0bIk6wktx1kJqwhuxhI3j87yWTS5FK+WcvFzxlr/ah4A54/AbdQhmWQ9swkenMW14h
         83Jb+ONbZre1PThLO3jTmVtSDPee8lOUdchV5yW5zlUDQzkI2p8IPjlixlDRxRTAMYYX
         jl2Q==
X-Gm-Message-State: AOAM5325kp4CZ4k2SNn2Sb789K3yKQFbhrX9cBADrvbFY88OJ+XZzKbI
        tAHok75gDkgQKpMKlhF+nTg=
X-Google-Smtp-Source: ABdhPJxHz84Y2guRTiEMqec1Vum4rDt1oofAjeSRK64Je2VNieMcvFdodBtEjaCCjiTI7beclxBSug==
X-Received: by 2002:a17:902:d211:: with SMTP id t17mr36230695ply.323.1594622560225;
        Sun, 12 Jul 2020 23:42:40 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:39 -0700 (PDT)
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
Subject: [PATCH v5 8/9] mm/memory-failure: remove a wrapper for alloc_migration_target()
Date:   Mon, 13 Jul 2020 15:41:56 +0900
Message-Id: <1594622517-20681-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined standard migration target callback. Use it
directly.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
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

