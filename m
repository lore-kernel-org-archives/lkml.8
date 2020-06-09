Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB35C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1947A20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S1rZ2mQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgFIOXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:23:12 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:26926 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591712591; x=1623248591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IPd4MAGBWxg6kOh+k8voQ+4pluey7PcsDkEHOVO6xUg=;
  b=S1rZ2mQvqT92tE+BtR0pilGMoKunwiUxLK63gjzdxlHbEVPlz22r6fhp
   eJAUHEsX90tYpfDSl8hZzZ4R12WxFe48sd2m7l3HBpfRtn2fIHT0MU14g
   AS0rTwwfOuG0hdcZmb2Jdd3QbQIBTHJ79nh92m7XTOkE+Zqjq5ihGQxl9
   s=;
IronPort-SDR: wwPwNkR4Zj9cANfnfbprtrW6WycDxHCId//+PvCS6TMpwF/Tbo+KxU76ZQVkbbyamwTCzS7oK+
 GyqRUW2Kbggg==
X-IronPort-AV: E=Sophos;i="5.73,492,1583193600"; 
   d="scan'208";a="36626317"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 09 Jun 2020 14:23:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 4BC44A2091;
        Tue,  9 Jun 2020 14:22:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:22:58 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 14:22:41 +0000
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
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v3 08/10] mm/damon/debugfs: Support physical memory monitoring
Date:   Tue, 9 Jun 2020 16:19:39 +0200
Message-ID: <20200609141941.19184-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609141941.19184-1-sjpark@amazon.com>
References: <20200609141941.19184-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
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
index 3a5d14720cb7..b9cec7766b6c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1310,6 +1310,9 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 		return true;
 
 	damon_for_each_task(t, ctx) {
+		if (t->pid == -1)
+			return false;
+
 		task = damon_get_task_struct(t);
 		if (task) {
 			put_task_struct(task);
@@ -1849,6 +1852,23 @@ static ssize_t debugfs_pids_write(struct file *file,
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

