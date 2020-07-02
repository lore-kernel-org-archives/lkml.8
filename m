Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4292073E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGBKaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:30:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728552AbgGBKae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:30:34 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1E801CDC32E9AD15771;
        Thu,  2 Jul 2020 18:30:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 18:30:23 +0800
From:   tongtiangen <tongtiangen@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <kan.liang@linux.intel.com>, <mhiramat@kernel.org>,
        <tongtiangen@huawei.com>, <weiyongjun1@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf header: Fix possible memory leak when using do_read_string
Date:   Thu, 2 Jul 2020 18:35:04 +0800
Message-ID: <20200702103504.119845-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the header.c file, some functions allocate memory after using
do_read_string, but the corresponding memory is not released after
subsequent processing errors, causing memory leaks.

Fixes: acae8b36cded ("perf header: Add die information in CPU topology")
Fixes: c60da22aca87 ("perf header: Transform nodes string info to struct")
Fixes: 642aadaa320b ("perf header: Make topology checkers to check return value of strbuf")
Signed-off-by: tongtiangen <tongtiangen@huawei.com>
---
 tools/perf/util/header.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7a67d017d72c..2f77391e0787 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2307,8 +2307,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		/* include a NULL character at the end */
-		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
+			free(str);
 			goto error;
+		}
 		size += string_size(str);
 		free(str);
 	}
@@ -2326,8 +2328,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		/* include a NULL character at the end */
-		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
+			free(str);
 			goto error;
+		}
 		size += string_size(str);
 		free(str);
 	}
@@ -2390,8 +2394,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		/* include a NULL character at the end */
-		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0) {
+			free(str);
 			goto error;
+		}
 		size += string_size(str);
 		free(str);
 	}
@@ -2446,7 +2452,7 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 
 		n->map = perf_cpu_map__new(str);
 		if (!n->map)
-			goto error;
+			goto free_str;
 
 		free(str);
 	}
@@ -2454,6 +2460,8 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 	ff->ph->env.numa_nodes = nodes;
 	return 0;
 
+free_str:
+	free(str);
 error:
 	free(nodes);
 	return -1;
@@ -2487,10 +2495,10 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 			goto error;
 
 		if (strbuf_addf(&sb, "%u:%s", type, name) < 0)
-			goto error;
+			goto free_name;
 		/* include a NULL character at the end */
 		if (strbuf_add(&sb, "", 1) < 0)
-			goto error;
+			goto free_name;
 
 		if (!strcmp(name, "msr"))
 			ff->ph->env.msr_pmu_type = type;
@@ -2501,6 +2509,8 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
 	ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
 	return 0;
 
+free_name:
+	free(name);
 error:
 	strbuf_release(&sb);
 	return -1;
-- 
2.20.1

