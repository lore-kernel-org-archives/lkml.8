Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4E2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD11A206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mPR9oZ0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGOtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:49:35 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:14759 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133374; x=1625669374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+vbXcdeK7B92i/MHecWnl6/xV/nYKLymz3AseHDLU/s=;
  b=mPR9oZ0dAAzrnO/RDQ6RorNx3fZ0PjOEg7iPQkfI7kQJ87zdl8uezbXY
   BO+UdwxJWgkYuuNguUU7ifCqinJneOmws/z0zIL2k6x6LtM4Wc19wFNLV
   0kECVWelRtY8znCGhN/fpbTs2Ybi25HS5kQhbRMC4cWECHrQQLbaaMgvd
   g=;
IronPort-SDR: G9e8ExdjtutXnlRxVA52Mz/ywdj3GSFYDuMznosnWnMfocKrAI5evJKhW8obGrT9mc8Yo/yq3M
 FHj7tTS3hLrQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="40470401"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Jul 2020 14:49:31 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 021E7223850;
        Tue,  7 Jul 2020 14:49:27 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:49:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:49:06 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 08/11] mm/damon/debugfs: Support physical memory monitoring
Date:   Tue, 7 Jul 2020 16:45:37 +0200
Message-ID: <20200707144540.21216-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707144540.21216-1-sjpark@amazon.com>
References: <20200707144540.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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
 mm/damon.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon.c b/mm/damon.c
index fb533b2ee4bf..34c418ef4e5f 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1928,6 +1928,23 @@ static ssize_t debugfs_pids_write(struct file *file,
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
+	if (!strncmp(kbuf, "paddr\n", count)) {
+		/* Configure the context for physical memory monitoring */
+		ctx->init_target_regions = kdamond_init_phys_regions;
+		ctx->update_target_regions = kdamond_update_phys_regions;
+		ctx->prepare_access_checks = kdamond_prepare_phys_access_checks;
+		ctx->check_accesses = kdamond_check_phys_accesses;
+
+		/* Set the fake target task pid as -1 */
+		snprintf(kbuf, count, "-1    ");
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

