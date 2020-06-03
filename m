Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBAB207F7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J8PrvYRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgFCOQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:16:19 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:8523 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193777; x=1622729777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=uykKOZZjn9dx48r34/9kMX/c9ZH8aqf2dtSlZ4UrAfo=;
  b=J8PrvYRz74XPZ4+ED9/4iq1bt96jP2v4oOtSI39wjaAlOdAxoqfuKi1/
   OtJisXzh/Hvju+JbjbFGrPGnpjlC7/iBwx8RjAo1WhQdCLx7Oqcf6g4b0
   2qvQ/quBH7ye3a7BXy2dXtzmXGiexJP1hiF1bbPbWQaWjr9rET5YSr48e
   s=;
IronPort-SDR: Wn8WtR/08hi8t6atRaPbX10k0NQMvGJ+CDx3dpUypdxdiNtV+Tsd9TCNSIPehX4z6lraeTb3fE
 jo/uCpEfjZbA==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="49526531"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Jun 2020 14:16:15 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 563131A19DC;
        Wed,  3 Jun 2020 14:16:13 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:16:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:15:56 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 8/9] mm/damon/debugfs: Support physical memory monitoring
Date:   Wed, 3 Jun 2020 16:11:34 +0200
Message-ID: <20200603141135.10575-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603141135.10575-1-sjpark@amazon.com>
References: <20200603141135.10575-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D45UWB002.ant.amazon.com (10.43.161.78) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
 mm/damon.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon.c b/mm/damon.c
index 6a5c6d540580..7361d5885118 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1263,6 +1263,9 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 		return true;
 
 	damon_for_each_task(t, ctx) {
+		if (t->pid == -1)
+			return false;
+
 		task = damon_get_task_struct(t);
 		if (task) {
 			put_task_struct(task);
@@ -1796,6 +1799,23 @@ static ssize_t debugfs_pids_write(struct file *file,
 	if (ret < 0)
 		goto out;
 
+	if (!strncmp(kbuf, "paddr\n", count)) {
+		/* Configure the context for physical memory monitoring */
+		ctx->init_target_regions = kdamond_init_phys_regions;
+		ctx->update_target_regions = kdamond_update_phys_regions;
+		ctx->prepare_access_checks = kdamond_prepare_phys_access_checks;
+		ctx->check_accesses = kdamond_check_phys_accesses;
+
+		/* Set the fake target task pid as -1 */
+		snprintf(kbuf, count, "-1");
+	} else {
+		/* Configure the context for virtual memory monitoring */
+		ctx->init_target_regions = kdamond_init_vm_regions;
+		ctx->update_target_regions = kdamond_update_vm_regions;
+		ctx->prepare_access_checks = kdamond_prepare_vm_access_checks;
+		ctx->check_accesses = kdamond_check_vm_accesses;
+	}
+
 	targets = str_to_pids(kbuf, ret, &nr_targets);
 	if (!targets) {
 		ret = -ENOMEM;
-- 
2.17.1

