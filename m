Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23EAC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8155324693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583838968;
	bh=6m2pPDBIZz9BCIb6i2UAGv1GO3JDCMX6ZibaXl68DD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJMJRqeh2susdM5xMFD4ZGSZ06kIan6CxxNMQoVvZcxOjeLbF+UosnD5vAETLYkAZ
	 efpMnT3c6y+lzKwjpbeTzySCRzZfCOuVPIr3AwXDKKeEDXRFe9BQJnGd6c3kKjCDwm
	 IhinBGWf9/u19mTaO9sKdMTGdmEnIUaQd0yadFK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCJLQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgCJLQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D21024691;
        Tue, 10 Mar 2020 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583838963;
        bh=6m2pPDBIZz9BCIb6i2UAGv1GO3JDCMX6ZibaXl68DD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhOCjCgLJqPCyRJLURFb++8DWoc3pJev7V0grZ97MMaPdZnHePguaBwLJgrhVfEFq
         doo54jQiXu+Wr8JRK3J7Cqeo7IpFuse+RvC3RrMBICMlRH+2offOQNMI6lure5R+oW
         ZBtT77NrEIKYCbo+frPUXNUhb1V8H+Szp4OXG/lM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/19] tools lib api fs: Move cgroupsfs_find_mountpoint()
Date:   Tue, 10 Mar 2020 08:15:33 -0300
Message-Id: <20200310111551.25160-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Move it from tools/perf/util/cgroup.c as it can be used by other places.
Note that cgroup filesystem is different from others since it's usually
mounted separately (in v1) for each subsystem.

I just copied the code with a little modification to pass a name of
subsystem.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200127100031.1368732-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/Build    |  1 +
 tools/lib/api/fs/cgroup.c | 67 +++++++++++++++++++++++++++++++++++++++
 tools/lib/api/fs/fs.h     |  2 ++
 tools/perf/util/cgroup.c  | 63 ++----------------------------------
 4 files changed, 72 insertions(+), 61 deletions(-)
 create mode 100644 tools/lib/api/fs/cgroup.c

diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
index f4ed9629ae85..0f75b28654de 100644
--- a/tools/lib/api/fs/Build
+++ b/tools/lib/api/fs/Build
@@ -1,2 +1,3 @@
 libapi-y += fs.o
 libapi-y += tracing_path.o
+libapi-y += cgroup.o
diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
new file mode 100644
index 000000000000..889a6eb4aaca
--- /dev/null
+++ b/tools/lib/api/fs/cgroup.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/stringify.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "fs.h"
+
+int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
+{
+	FILE *fp;
+	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
+	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
+	char *token, *saved_ptr = NULL;
+
+	fp = fopen("/proc/mounts", "r");
+	if (!fp)
+		return -1;
+
+	/*
+	 * in order to handle split hierarchy, we need to scan /proc/mounts
+	 * and inspect every cgroupfs mount point to find one that has
+	 * perf_event subsystem
+	 */
+	path_v1[0] = '\0';
+	path_v2[0] = '\0';
+
+	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
+				__stringify(PATH_MAX)"s %*d %*d\n",
+				mountpoint, type, tokens) == 3) {
+
+		if (!path_v1[0] && !strcmp(type, "cgroup")) {
+
+			token = strtok_r(tokens, ",", &saved_ptr);
+
+			while (token != NULL) {
+				if (subsys && !strcmp(token, subsys)) {
+					strcpy(path_v1, mountpoint);
+					break;
+				}
+				token = strtok_r(NULL, ",", &saved_ptr);
+			}
+		}
+
+		if (!path_v2[0] && !strcmp(type, "cgroup2"))
+			strcpy(path_v2, mountpoint);
+
+		if (path_v1[0] && path_v2[0])
+			break;
+	}
+	fclose(fp);
+
+	if (path_v1[0])
+		path = path_v1;
+	else if (path_v2[0])
+		path = path_v2;
+	else
+		return -1;
+
+	if (strlen(path) < maxlen) {
+		strcpy(buf, path);
+		return 0;
+	}
+	return -1;
+}
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index 92d03b8396b1..936edb95e1f3 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -28,6 +28,8 @@ FS(bpf_fs)
 #undef FS
 
 
+int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys);
+
 int filename__read_int(const char *filename, int *value);
 int filename__read_ull(const char *filename, unsigned long long *value);
 int filename__read_xll(const char *filename, unsigned long long *value);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4881d4af3381..5bc9d3b01bd9 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -3,75 +3,16 @@
 #include "evsel.h"
 #include "cgroup.h"
 #include "evlist.h"
-#include <linux/stringify.h>
 #include <linux/zalloc.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <string.h>
+#include <api/fs/fs.h>
 
 int nr_cgroups;
 
-static int
-cgroupfs_find_mountpoint(char *buf, size_t maxlen)
-{
-	FILE *fp;
-	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
-	char path_v1[PATH_MAX + 1], path_v2[PATH_MAX + 2], *path;
-	char *token, *saved_ptr = NULL;
-
-	fp = fopen("/proc/mounts", "r");
-	if (!fp)
-		return -1;
-
-	/*
-	 * in order to handle split hierarchy, we need to scan /proc/mounts
-	 * and inspect every cgroupfs mount point to find one that has
-	 * perf_event subsystem
-	 */
-	path_v1[0] = '\0';
-	path_v2[0] = '\0';
-
-	while (fscanf(fp, "%*s %"__stringify(PATH_MAX)"s %"__stringify(PATH_MAX)"s %"
-				__stringify(PATH_MAX)"s %*d %*d\n",
-				mountpoint, type, tokens) == 3) {
-
-		if (!path_v1[0] && !strcmp(type, "cgroup")) {
-
-			token = strtok_r(tokens, ",", &saved_ptr);
-
-			while (token != NULL) {
-				if (!strcmp(token, "perf_event")) {
-					strcpy(path_v1, mountpoint);
-					break;
-				}
-				token = strtok_r(NULL, ",", &saved_ptr);
-			}
-		}
-
-		if (!path_v2[0] && !strcmp(type, "cgroup2"))
-			strcpy(path_v2, mountpoint);
-
-		if (path_v1[0] && path_v2[0])
-			break;
-	}
-	fclose(fp);
-
-	if (path_v1[0])
-		path = path_v1;
-	else if (path_v2[0])
-		path = path_v2;
-	else
-		return -1;
-
-	if (strlen(path) < maxlen) {
-		strcpy(buf, path);
-		return 0;
-	}
-	return -1;
-}
-
 static int open_cgroup(const char *name)
 {
 	char path[PATH_MAX + 1];
@@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
 	int fd;
 
 
-	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
 		return -1;
 
 	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
-- 
2.21.1

