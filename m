Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204B4214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCSOLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgCSOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvt3-0002Mj-Kz; Thu, 19 Mar 2020 15:11:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8796D1C22AD;
        Thu, 19 Mar 2020 15:10:56 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:56 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools lib api fs: Move cgroupsfs_find_mountpoint()
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200127100031.1368732-1-namhyung@kernel.org>
References: <20200127100031.1368732-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <158462705621.28353.16079958689067092641.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7982a898515064ba180d958bfc89ed22d13905ee
Gitweb:        https://git.kernel.org/tip/7982a898515064ba180d958bfc89ed22d13905ee
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 27 Jan 2020 19:00:31 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 04 Mar 2020 10:34:09 -03:00

tools lib api fs: Move cgroupsfs_find_mountpoint()

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
 tools/lib/api/fs/Build    |  1 +-
 tools/lib/api/fs/cgroup.c | 67 ++++++++++++++++++++++++++++++++++++++-
 tools/lib/api/fs/fs.h     |  2 +-
 tools/perf/util/cgroup.c  | 63 +-----------------------------------
 4 files changed, 72 insertions(+), 61 deletions(-)
 create mode 100644 tools/lib/api/fs/cgroup.c

diff --git a/tools/lib/api/fs/Build b/tools/lib/api/fs/Build
index f4ed962..0f75b28 100644
--- a/tools/lib/api/fs/Build
+++ b/tools/lib/api/fs/Build
@@ -1,2 +1,3 @@
 libapi-y += fs.o
 libapi-y += tracing_path.o
+libapi-y += cgroup.o
diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
new file mode 100644
index 0000000..889a6eb
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
index 92d03b8..936edb9 100644
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
index 4881d4a..5bc9d3b 100644
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
