Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBBCC35DFE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CA020714
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZVI6/rik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgBYKXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:23:55 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37731 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgBYKXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582626235; x=1614162235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kAdTeVn39NF6MtyWxbSfFrMuEluavNfxQ8uqZzEFpes=;
  b=ZVI6/rikNFGBaKEYyZlaN2v2GsQaF8SumkBGPNvajNFSyWxWEJjYHfNM
   DL6KI5OhUM94TWm1FpcIBkKtyJx3TxPTcM0SHOMTXsbhD3Mv4QOXuoHaI
   vj5oI3tFHinEXzdvxWBDV9aOQa43ovO12Qnzorbqw0Aw9rgz7xmQp74Ur
   Q=;
IronPort-SDR: 6wwrgkGYYv8CpR1fY1H7m84KIHG0aC7W/f56Ef/NEvS6zsJ76rwI6GR2ureJsBKf5rUl3zLmHN
 0DU74Z+OjKEQ==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="27313100"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Feb 2020 10:23:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 2B969A2B80;
        Tue, 25 Feb 2020 10:23:40 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 10:23:40 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 10:23:28 +0000
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
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 1/7] mm/madvise: Export madvise_common() to mm internal code
Date:   Tue, 25 Feb 2020 11:22:54 +0100
Message-ID: <20200225102300.23895-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225102300.23895-1-sjpark@amazon.com>
References: <20200225102300.23895-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
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

