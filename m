Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8407C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1420714
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCVRZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 13:25:41 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:35374 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgCVRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 13:25:41 -0400
Received: from localhost.localdomain ([93.22.150.255])
        by mwinf5d85 with ME
        id HVRR220015WryPR03VRRhT; Sun, 22 Mar 2020 18:25:36 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Mar 2020 18:25:36 +0100
X-ME-IP: 93.22.150.255
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kan.liang@linux.intel.com,
        zhe.he@windriver.com, dzickus@redhat.com, jstancek@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Date:   Sun, 22 Mar 2020 18:25:23 +0100
Message-Id: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'scnprintf' returns the number of characters written in the output buffer
excluding the trailing '\0', instead of the number of characters which
would be generated for the given input.

Both function return a number of characters, excluding the trailing '\0'.
So comparaison to check if it overflows, should be done against max_size-1.
Comparaison against max_size can never match.

Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
Fixes: a24020e6b7cf6 ("perf tools: Change cpu_map__fprintf output")
Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 tools/perf/util/cpumap.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 983b7388f22b..b87e7ef4d130 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -316,8 +316,8 @@ static void set_max_cpu_num(void)
 		goto out;
 
 	/* get the highest possible cpu number for a sparse allocation */
-	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
-	if (ret == PATH_MAX) {
+	ret = scnprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
+	if (ret == PATH_MAX-1) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -327,8 +327,8 @@ static void set_max_cpu_num(void)
 		goto out;
 
 	/* get the highest present cpu number for a sparse allocation */
-	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
-	if (ret == PATH_MAX) {
+	ret = scnprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
+	if (ret == PATH_MAX-1) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -355,8 +355,8 @@ static void set_max_node_num(void)
 		goto out;
 
 	/* get the highest possible cpu number for a sparse allocation */
-	ret = snprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
-	if (ret == PATH_MAX) {
+	ret = scnprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
+	if (ret == PATH_MAX-1) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -440,8 +440,8 @@ int cpu__setup_cpunode_map(void)
 	if (!mnt)
 		return 0;
 
-	n = snprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
-	if (n == PATH_MAX) {
+	n = scnprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
+	if (n == PATH_MAX-1) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		return -1;
 	}
@@ -455,8 +455,8 @@ int cpu__setup_cpunode_map(void)
 		if (dent1->d_type != DT_DIR || sscanf(dent1->d_name, "node%u", &mem) < 1)
 			continue;
 
-		n = snprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
-		if (n == PATH_MAX) {
+		n = scnprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
+		if (n == PATH_MAX-1) {
 			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 			continue;
 		}
@@ -501,21 +501,22 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 		if (start == -1) {
 			start = i;
 			if (last) {
-				ret += snprintf(buf + ret, size - ret,
-						"%s%d", COMMA,
-						map->map[i]);
+				ret += scnprintf(buf + ret, size - ret,
+						 "%s%d", COMMA,
+						 map->map[i]);
 			}
 		} else if (((i - start) != (cpu - map->map[start])) || last) {
 			int end = i - 1;
 
 			if (start == end) {
-				ret += snprintf(buf + ret, size - ret,
-						"%s%d", COMMA,
-						map->map[start]);
+				ret += scnprintf(buf + ret, size - ret,
+						 "%s%d", COMMA,
+						 map->map[start]);
 			} else {
-				ret += snprintf(buf + ret, size - ret,
-						"%s%d-%d", COMMA,
-						map->map[start], map->map[end]);
+				ret += scnprintf(buf + ret, size - ret,
+						 "%s%d-%d", COMMA,
+						 map->map[start],
+						 map->map[end]);
 			}
 			first = false;
 			start = i;
-- 
2.20.1

