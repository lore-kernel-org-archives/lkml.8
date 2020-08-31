Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C02C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E61D206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vasZcCXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHaKul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:50:41 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:41162 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHaKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598871013; x=1630407013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7XLAfjNDxAGlOXL+oVVQMgpD8ljZ3iheJ5Jq9ck8vb8=;
  b=vasZcCXIPYk3rI5o8AkvNBTlOMtuZ5fBlP21WZMi+8WdprsFUKEcfNmV
   tdsMA+fd96Nrtj85aA2ZWz5j/xJ5o3k5zLQCmbCPa7lYKEE/6qIwEEnyt
   2IBrn9xXXkkFV+GbJ5fcW//SaO5XFM+bru27KqsBQISzymyQTNDG1DDmK
   k=;
X-IronPort-AV: E=Sophos;i="5.76,375,1592870400"; 
   d="scan'208";a="50991505"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 31 Aug 2020 10:50:09 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 1AF37A1EAD;
        Mon, 31 Aug 2020 10:50:06 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.100) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 10:49:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v8 07/10] mm/damon/debugfs: Support physical memory monitoring
Date:   Mon, 31 Aug 2020 12:47:27 +0200
Message-ID: <20200831104730.28970-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831104730.28970-1-sjpark@amazon.com>
References: <20200831104730.28970-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D49UWB002.ant.amazon.com (10.43.163.68) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit makes the debugfs interface to support the physical memory
monitoring, in addition to the virtual memory monitoring.

Users can do the physical memory monitoring by writing a special
keyword, 'paddr\n' to the 'pids' debugfs file.  Then, DAMON will check
the special keyword and configure the callbacks of the monitoring
context for the debugfs user for physical memory.  This will internally
add one fake monitoring target process, which has pid as -1.

Unlike the virtual memory monitoring, DAMON debugfs will not
automatically set the monitoring target region.  Therefore, users should
also set the monitoring target address region using the 'init_regions'
debugfs file.  While doing this, the 'pid' in the input should be '-1'.

Finally, the physical memory monitoring will not automatically
terminated because it has fake monitoring target process.  The user
should explicitly turn off the monitoring by writing 'off' to the
'monitor_on' debugfs file.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 464209039bf8..98f52580bd5d 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -2127,9 +2127,29 @@ static ssize_t debugfs_target_ids_write(struct file *file,
 		return PTR_ERR(kbuf);
 
 	nrs = kbuf;
-	if (!strncmp(kbuf, "pidfd ", 6)) {
-		received_pidfds = true;
-		nrs = &kbuf[6];
+	if (!strncmp(kbuf, "paddr\n", count)) {
+		/* Configure the context for physical memory monitoring */
+		ctx->init_target_regions = kdamond_init_phys_regions;
+		ctx->update_target_regions = kdamond_update_phys_regions;
+		ctx->prepare_access_checks = kdamond_prepare_phys_access_checks;
+		ctx->check_accesses = kdamond_check_phys_accesses;
+		ctx->target_valid = NULL;
+		ctx->cleanup = NULL;
+
+		/* target id is meaningless here, but we set it just for fun */
+		snprintf(kbuf, count, "42    ");
+	} else {
+		/* Configure the context for virtual memory monitoring */
+		ctx->init_target_regions = kdamond_init_vm_regions;
+		ctx->update_target_regions = kdamond_update_vm_regions;
+		ctx->prepare_access_checks = kdamond_prepare_vm_access_checks;
+		ctx->check_accesses = kdamond_check_vm_accesses;
+		ctx->target_valid = kdamond_vm_target_valid;
+		ctx->cleanup = kdamond_vm_cleanup;
+		if (!strncmp(kbuf, "pidfd ", 6)) {
+			received_pidfds = true;
+			nrs = &kbuf[6];
+		}
 	}
 
 	targets = str_to_target_ids(nrs, ret, &nr_targets);
-- 
2.17.1

