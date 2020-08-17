Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B972C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A0F20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lMDEyYIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHQK4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:56:35 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:44041 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgHQK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597661764; x=1629197764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KcjXBRoSeaBzlmTOkaWaNRYAUTMpxxwSd6cag9EUwC0=;
  b=lMDEyYIhy6TQwEVB77pXrPnzZdsAEdqeYJ2jFJRwVbtho5mh4FsYcqL7
   rPk+a+RSUmH4DkT6racdVm67D2vZL/Il6blHc3nRiUYGCqNusIHSCyOKB
   jW7uDOAuodR3ruhI0Oves9cTUMt0aiE9Ep83dGJQDZ+xIF6+0kEsze05H
   g=;
X-IronPort-AV: E=Sophos;i="5.76,322,1592870400"; 
   d="scan'208";a="60303487"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Aug 2020 10:56:01 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 0A530A243E;
        Mon, 17 Aug 2020 10:55:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:55:57 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:55:40 +0000
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
Subject: [PATCH v20 10/15] damon/debugfs: Support pidfd target id
Date:   Mon, 17 Aug 2020 12:51:32 +0200
Message-ID: <20200817105137.19296-11-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
References: <20200817105137.19296-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D02UWC004.ant.amazon.com (10.43.162.236) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON programming interface users are safe from pid recycling problem
since it uses 'struct pid *' as target id.  However, debugfs interface
users might still get the problem since they should describe the target
ids with pid numbers.

This commit makes the debugfs interface to support pidfd target ids.
Using it, debugfs interface users can also easily be safe from the
races.  That said, the pid numbers are stil supported for the simple
command line uses.

The pid numbers target ids usages are same to the old one.  Therefore,
old users don't need to change anything.  To use pidfd target ids, users
should add a prefix, 'pidfd ' in front of the numbers.  Because pidfd is
process private, reading 'target_ids' file again will show pid numbers
of the target processes.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 92159aaf8b07..ddae98cac8ac 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1529,11 +1529,32 @@ static unsigned long *str_to_target_ids(const char *str, ssize_t len,
 	return ids;
 }
 
+/* Returns pid for the given pidfd if it's valid, or NULL otherwise. */
+static struct pid *damon_get_pidfd_pid(unsigned int pidfd)
+{
+	struct fd f;
+	struct pid *pid;
+
+	f = fdget(pidfd);
+	if (!f.file)
+		return NULL;
+
+	pid = pidfd_pid(f.file);
+	if (!IS_ERR(pid))
+		get_pid(pid);
+	else
+		pid = NULL;
+
+	fdput(f);
+	return pid;
+}
+
 static ssize_t debugfs_target_ids_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = &damon_user_ctx;
-	char *kbuf;
+	char *kbuf, *nrs;
+	bool received_pidfds = false;
 	unsigned long *targets;
 	ssize_t nr_targets;
 	ssize_t ret = count;
@@ -1544,13 +1565,23 @@ static ssize_t debugfs_target_ids_write(struct file *file,
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
-	targets = str_to_target_ids(kbuf, ret, &nr_targets);
+	nrs = kbuf;
+	if (!strncmp(kbuf, "pidfd ", 6)) {
+		received_pidfds = true;
+		nrs = &kbuf[6];
+	}
+
+	targets = str_to_target_ids(nrs, ret, &nr_targets);
 	if (!targets) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	if (targetid_is_pid(ctx)) {
+	if (received_pidfds) {
+		for (i = 0; i < nr_targets; i++)
+			targets[i] = (unsigned long)damon_get_pidfd_pid(
+					(unsigned int)targets[i]);
+	} else if (targetid_is_pid(ctx)) {
 		for (i = 0; i < nr_targets; i++)
 			targets[i] = (unsigned long)find_get_pid(
 					(int)targets[i]);
-- 
2.17.1

