Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0988AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF96207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgERJ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:59:57 -0400
Received: from foss.arm.com ([217.140.110.172]:37170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgERJ74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:59:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35402101E;
        Mon, 18 May 2020 02:59:56 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.74.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2E5A3F68F;
        Mon, 18 May 2020 02:59:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: Restrict and formalize compound_page_dtors[]
Date:   Mon, 18 May 2020 15:29:18 +0530
Message-Id: <1589795958-19317-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict elements in compound_page_dtors[] array per NR_COMPOUND_DTORS and
explicitly position them according to enum compound_dtor_id. This improves
protection against possible misalignment between compound_page_dtors[] and
enum compound_dtor_id later on.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h |  2 +-
 mm/page_alloc.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 688558c57751..d1bd7736a5e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -856,7 +856,7 @@ enum compound_dtor_id {
 #endif
 	NR_COMPOUND_DTORS,
 };
-extern compound_page_dtor * const compound_page_dtors[];
+extern compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS];
 
 static inline void set_compound_page_dtor(struct page *page,
 		enum compound_dtor_id compound_dtor)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cef05d3a23f5..2e4c23b34940 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -302,14 +302,14 @@ const char * const migratetype_names[MIGRATE_TYPES] = {
 #endif
 };
 
-compound_page_dtor * const compound_page_dtors[] = {
-	NULL,
-	free_compound_page,
+compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
+	[NULL_COMPOUND_DTOR] = NULL,
+	[COMPOUND_PAGE_DTOR] = free_compound_page,
 #ifdef CONFIG_HUGETLB_PAGE
-	free_huge_page,
+	[HUGETLB_PAGE_DTOR] = free_huge_page,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	free_transhuge_page,
+	[TRANSHUGE_PAGE_DTOR] = free_transhuge_page,
 #endif
 };
 
-- 
2.20.1

