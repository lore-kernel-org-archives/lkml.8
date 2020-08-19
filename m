Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F73C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70D320882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FXBqjW85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgHSPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgHSPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6641C061344
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8q+ndZ4/Y2q5+lYRF8YSq2RAsXmcPhdjyF015TYyQpk=; b=FXBqjW85otlxrGuLoj9/ySIq4h
        51V0lryzbfAMivyqnQ+xywaqdXtOiL2N2XcK+pnggF84kLyzOkTKKcSt89oPRi1Vr3pTME10bdm4m
        VVEXV+EUvukB0Xl/cS+MxITYNBdsO1JCI5R7Ud5KDnkztC5ZDFeZ6K6O6u9CCTogeUPk/shuGPR5a
        nIGwZPXxmAZf9GU/MJGO3nTtalViImhMjKHkXhXPE9SAUEQXnPb9BO1yLrTXCIK/1m20/dKD30Cbp
        Wn6Yjk9OMMFROiKSnHJ9D/0iO96plFhcOUgpEPFxqjPuZnRB4+w6CpXXc4fjJYtpHRpMPE2UIKMkm
        qXVKNhxw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf5-0008G0-Rn; Wed, 19 Aug 2020 15:05:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mm: Remove nr_entries parameter from pagevec_lookup_entries
Date:   Wed, 19 Aug 2020 16:05:53 +0100
Message-Id: <20200819150555.31669-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819150555.31669-1-willy@infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers want to fetch the full size of the pvec.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h |  2 +-
 mm/swap.c               |  4 ++--
 mm/truncate.c           | 10 ++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 4b245592262c..ce77724a2ab7 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -27,7 +27,7 @@ void __pagevec_release(struct pagevec *pvec);
 void __pagevec_lru_add(struct pagevec *pvec);
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		unsigned nr_entries, pgoff_t *indices);
+		pgoff_t *indices);
 void pagevec_remove_exceptionals(struct pagevec *pvec);
 unsigned pagevec_lookup_range(struct pagevec *pvec,
 			      struct address_space *mapping,
diff --git a/mm/swap.c b/mm/swap.c
index b6e56a84b466..d4e3ba4c967c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1058,9 +1058,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
  */
 unsigned pagevec_lookup_entries(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t start, pgoff_t end,
-		unsigned nr_entries, pgoff_t *indices)
+		pgoff_t *indices)
 {
-	pvec->nr = find_get_entries(mapping, start, end, nr_entries,
+	pvec->nr = find_get_entries(mapping, start, end, PAGEVEC_SIZE,
 				    pvec->pages, indices);
 	return pagevec_count(pvec);
 }
diff --git a/mm/truncate.c b/mm/truncate.c
index 9c617291fb1e..96a45ba28042 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -327,7 +327,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	pagevec_init(&pvec);
 	index = start;
 	while (pagevec_lookup_entries(&pvec, mapping, index, end - 1,
-			PAGEVEC_SIZE, indices)) {
+			indices)) {
 		/*
 		 * Pagevec array has exceptional entries and we may also fail
 		 * to lock some pages. So we store pages that can be deleted
@@ -411,7 +411,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	for ( ; ; ) {
 		cond_resched();
 		if (!pagevec_lookup_entries(&pvec, mapping, index, end - 1,
-				PAGEVEC_SIZE, indices)) {
+				indices)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -540,8 +540,7 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 	int i;
 
 	pagevec_init(&pvec);
-	while (pagevec_lookup_entries(&pvec, mapping, index, end,
-			PAGEVEC_SIZE, indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
@@ -680,8 +679,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	index = start;
-	while (pagevec_lookup_entries(&pvec, mapping, index, end,
-			PAGEVEC_SIZE, indices)) {
+	while (pagevec_lookup_entries(&pvec, mapping, index, end, indices)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
-- 
2.28.0

