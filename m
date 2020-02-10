Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE1EC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964DB20863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RPOeDZE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBJPKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:10:08 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4382 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581347407; x=1612883407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=F26ZRQO3/UfTN1ZCUzNbj2G2BvxRH0xH7tCak0qka1I=;
  b=RPOeDZE3m8rVduZ4sM3Xw6ewzU37/ZRtbb4+qiwAUxhwfD9ELnYkZiF0
   5z9BGuQPM4g91rbXS0EHbSASmytVTN41XgermLso18bZE0CpmiMCjz1qO
   WVWAOkQ4B1vGF+McW4I3YgnzmkTp1par38WbHPtA5oBk7uRzY4V9Z2ehX
   Q=;
IronPort-SDR: cfsemWlJhYhAMppAPoQYyesLXzMAvoEoRPaqLF0Nv+x54tSEMnhHY9nYEPRHSZiHLS6/GzNN5W
 DMFfCAcXmWBw==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="17017407"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Feb 2020 15:10:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 31595A1851;
        Mon, 10 Feb 2020 15:10:02 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 15:10:01 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.69) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 15:09:50 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/3] mm/madvise: Export madvise_common() to mm internal code
Date:   Mon, 10 Feb 2020 16:09:19 +0100
Message-ID: <20200210150921.32482-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210150921.32482-1-sjpark@amazon.com>
References: <20200210150921.32482-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.69]
X-ClientProxiedBy: EX13D17UWB002.ant.amazon.com (10.43.161.141) To
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
 mm/madvise.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 0c901de531e4..4bb75be7a186 100644
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
-- 
2.17.1

