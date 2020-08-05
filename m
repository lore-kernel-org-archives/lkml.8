Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC41022BF3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FoBuz7+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHEHDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:03:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52727 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHEHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596611002; x=1628147002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qEyO3NjOJgBbi06zZ5Eyf5uiQGCDh0wt+SIXSMbxXjs=;
  b=FoBuz7+2lJp0E7qAp5oKkZdnfS7Di8nRhkp5YiqWjk1mDv3QGgrJ7E5B
   RpTF6ODoSnBIuHFBJx70Z2wu2D3Q/4Kpiye0LBG+Wac9CYtY9L3sButTZ
   lMAw3d7h7tGilJuYeR75Q1zifNP/zufQt5IjZbo/1AlY0lzRReN+4Rx+o
   w=;
IronPort-SDR: +oMl3lt0gfbUgWw/YdBcmZv1+Cp4lWhZOkuJP030jhL5YT/5WTvhaaVsbCnA44++IV+bR4e9SP
 NMyzFlBxDkeA==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="46228955"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 05 Aug 2020 07:03:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id BE137A21BF;
        Wed,  5 Aug 2020 07:03:09 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:03:08 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:02:51 +0000
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 07/10] mm/damon/debugfs: Support physical memory monitoring
Date:   Wed, 5 Aug 2020 08:59:48 +0200
Message-ID: <20200805065951.18221-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
References: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
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
 mm/damon.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index c8d834ce188d..0b6960f62ae9 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -2035,9 +2035,27 @@ static ssize_t debugfs_target_ids_write(struct file *file,
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
+
+		/* target id is meaningless here, but we set it just for fun */
+		snprintf(kbuf, count, "-1    ");
+	} else {
+		/* Configure the context for virtual memory monitoring */
+		ctx->init_target_regions = kdamond_init_vm_regions;
+		ctx->update_target_regions = kdamond_update_vm_regions;
+		ctx->prepare_access_checks = kdamond_prepare_vm_access_checks;
+		ctx->check_accesses = kdamond_check_vm_accesses;
+		ctx->target_valid = kdamond_vm_target_valid;
+		if (!strncmp(kbuf, "pidfd ", 6)) {
+			received_pidfds = true;
+			nrs = &kbuf[6];
+		}
 	}
 
 	targets = str_to_target_ids(nrs, ret, &nr_targets);
-- 
2.17.1

