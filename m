Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8881C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABC3206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCHK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:59:34 -0400
Received: from mail1.windriver.com ([147.11.146.13]:51181 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgCHK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:59:34 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 028AxKml005931
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 8 Mar 2020 03:59:20 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Sun, 8 Mar 2020 03:59:19 -0700
From:   <zhe.he@windriver.com>
To:     <acme@redhat.com>, <jolsa@kernel.org>, <ak@linux.intel.com>,
        <meyerk@hpe.com>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] perf: Add NULL pointer check for cpu_map iteration and NULL assignment for all_cpus.
Date:   Sun, 8 Mar 2020 18:59:17 +0800
Message-ID: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

NULL pointer may be passed to perf_cpu_map__cpu and then cause crash,
such as the one commit cb71f7d43ece ("libperf: Setup initial evlist::all_cpus value")
fix.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/lib/cpumap.c | 2 +-
 tools/perf/lib/evlist.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index f93f4e7..ca02150 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -247,7 +247,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 
 int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
-	if (idx < cpus->nr)
+	if (cpus && idx < cpus->nr)
 		return cpus->map[idx];
 
 	return -1;
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 5b9f2ca..f87a239 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -127,6 +127,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
 	perf_cpu_map__put(evlist->cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
+	evlist->all_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
-- 
2.7.4

