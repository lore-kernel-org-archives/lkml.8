Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828DDC433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501F22B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AQE90AHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgHDJSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:18:30 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:47956 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596532708; x=1628068708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZahW3cCbZDrLljIKQak41NNjLpTyRpmxCU8KvV7M7WM=;
  b=AQE90AHpD4z0sn+qw2945y6rQKEOSGEQtQw2NlZiMFq5dMLv2KxBYjaw
   bhfea4Mc9V5UgsXqvl4oMvV7hmCvnvJRbcW3bg/TbE6Qcz+kb0hR4lbMq
   vQuv4Cgz8Y3J97jtoEtMdVRIH+juTw624NLTYZoQRMDYYN1HL1Qik/ENH
   k=;
IronPort-SDR: 22njl7WK5u7wZL+YBVWGd5Ed7AyOo1x+MSZCy0jWJcIbWKWQutJylA156F7OJZmdG1Yxcffo0m
 G28rz6UqhyNg==
X-IronPort-AV: E=Sophos;i="5.75,433,1589241600"; 
   d="scan'208";a="46006402"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-60ce1996.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 04 Aug 2020 09:18:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-60ce1996.us-west-2.amazon.com (Postfix) with ESMTPS id 89B11A313F;
        Tue,  4 Aug 2020 09:18:22 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 Aug 2020 09:18:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.248) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 Aug 2020 09:18:04 +0000
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
Subject: [PATCH v19 10/15] damon/debugfs: Support pidfd target id
Date:   Tue, 4 Aug 2020 11:14:11 +0200
Message-ID: <20200804091416.31039-11-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804091416.31039-1-sjpark@amazon.com>
References: <20200804091416.31039-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D36UWA004.ant.amazon.com (10.43.160.175) To
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
index 01003a1ff551..61d93f1ea974 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1450,11 +1450,32 @@ static unsigned long *str_to_target_ids(const char *str, ssize_t len,
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
@@ -1466,13 +1487,23 @@ static ssize_t debugfs_target_ids_write(struct file *file,
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

