Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5983520866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S6svj5FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgCCMPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:15:01 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:15259 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCCMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583237700; x=1614773700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kAdTeVn39NF6MtyWxbSfFrMuEluavNfxQ8uqZzEFpes=;
  b=S6svj5FP6PPgnfWhYC0Rp+TJAyV+krEhNOQ/BkjYlwTB3juGskKikXmb
   HH9e16kiB7CTRKS3iYHGx2lBSGc8/h/6NNl/7/CrqNya68DOsg0kooGJV
   mE5tuy3BiqVvCOUI9U1XEbLGPzt/FF6tiELZizzAvOa6J/c8zbeeSTITx
   o=;
IronPort-SDR: GYhfRpBAXYVO5zaZEBDGhb//r+/eULPj9ML7+Z5B7pjOgEjPwezpPUsUMiI2/jMfogAiI69PSW
 tjAq4D5haDZg==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20475677"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 12:14:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 0E54B225990;
        Tue,  3 Mar 2020 12:14:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 12:14:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Mar 2020 12:14:44 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v4 1/7] mm/madvise: Export madvise_common() to mm internal code
Date:   Tue, 3 Mar 2020 13:14:00 +0100
Message-ID: <20200303121406.20954-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303121406.20954-1-sjpark@amazon.com>
References: <20200303121406.20954-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D22UWB002.ant.amazon.com (10.43.161.28) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports ``madvise_common()`` to ``mm/`` code for future
reuse.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/internal.h | 4 ++++
 mm/madvise.c  | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..dcdfe00e02ff 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -576,4 +576,8 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+
+int madvise_common(struct task_struct *task, struct mm_struct *mm,
+			unsigned long start, size_t len_in, int behavior);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 0c901de531e4..4fa9dfc770bc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1005,7 +1005,7 @@ madvise_behavior_valid(int behavior)
  * @task could be a zombie leader if it calls sys_exit so accessing mm_struct
  * via task->mm is prohibited. Please use @mm instead of task->mm.
  */
-static int madvise_common(struct task_struct *task, struct mm_struct *mm,
+int madvise_common(struct task_struct *task, struct mm_struct *mm,
 			unsigned long start, size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
@@ -1103,6 +1103,7 @@ static int madvise_common(struct task_struct *task, struct mm_struct *mm,
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(madvise_common);
 
 /*
  * The madvise(2) system call.
-- 
2.17.1

