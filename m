Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3847E206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgEUNdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:33:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4879 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729197AbgEUNdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB3DC2FD30B7B2052576;
        Thu, 21 May 2020 21:33:03 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 21:32:57 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Bin <huawei.libin@huawei.com>,
        "Xie XiuQi" <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: [PATCH 2/4] perf svghelper: Fix memory leak in svg_build_topology_map
Date:   Thu, 21 May 2020 21:32:16 +0800
Message-ID: <20200521133218.30150-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521133218.30150-1-liwei391@huawei.com>
References: <20200521133218.30150-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Bin <huawei.libin@huawei.com>

Fix leak of memory pointed to by t.sib_thr and t.sib_core in
svg_build_topology_map.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 tools/perf/util/svghelper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 96f941e01681..e2b3b0e2fafe 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
 	int i, nr_cpus;
 	struct topology t;
 	char *sib_core, *sib_thr;
+	int ret;
 
 	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
 
@@ -767,12 +768,14 @@ int svg_build_topology_map(struct perf_env *env)
 
 	if (!t.sib_core || !t.sib_thr) {
 		fprintf(stderr, "topology: no memory\n");
+		ret = -1;
 		goto exit;
 	}
 
 	for (i = 0; i < env->nr_sibling_cores; i++) {
 		if (str_to_bitmap(sib_core, &t.sib_core[i], nr_cpus)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
+			ret = -1;
 			goto exit;
 		}
 
@@ -782,6 +785,7 @@ int svg_build_topology_map(struct perf_env *env)
 	for (i = 0; i < env->nr_sibling_threads; i++) {
 		if (str_to_bitmap(sib_thr, &t.sib_thr[i], nr_cpus)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
+			ret = -1;
 			goto exit;
 		}
 
@@ -791,6 +795,7 @@ int svg_build_topology_map(struct perf_env *env)
 	topology_map = malloc(sizeof(int) * nr_cpus);
 	if (!topology_map) {
 		fprintf(stderr, "topology: no memory\n");
+		ret = -1;
 		goto exit;
 	}
 
@@ -798,12 +803,11 @@ int svg_build_topology_map(struct perf_env *env)
 		topology_map[i] = -1;
 
 	scan_core_topology(topology_map, &t, nr_cpus);
-
-	return 0;
+	ret = 0;
 
 exit:
 	zfree(&t.sib_core);
 	zfree(&t.sib_thr);
 
-	return -1;
+	return ret;
 }
-- 
2.17.1

