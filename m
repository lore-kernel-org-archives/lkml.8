Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC02C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5692A207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580119240;
	bh=/vTowjDIUnwjl81wFtl/OQM+koWRAV7kT/DB0wH+CJw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mrUh8lFkPCdRUD5EknaETB+7CUZXX8+O1rX++COkBDqnj/TQM3GyBXCy3iSGFrj74
	 OobCSeZIXN/sPxgyEUO9o4n3wNQ7xMCN1OMtOgVPwONJ57sHROs3AqRxx+6VkGs4ST
	 LFCVkOS2yzPCm9VwmabfjYcCo2W1Mb4DWTZW28m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgA0KAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:00:39 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:34864 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA0KAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:00:39 -0500
Received: by mail-pj1-f54.google.com with SMTP id q39so2911381pjc.0;
        Mon, 27 Jan 2020 02:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mckNNp9UKxn7W2DnL8nnDaXbQehqA1+WXvXBkFoXeuc=;
        b=RBv6hdOOhhfk1QrJz7mI7SjMFmFgUM3RbEDIe391LQnb5vCxGPsbiwlSNhphe1gv8O
         X08vMAsJ7rWRDC/VZ0Fr6p+/raaTgFk6vsG1ovDmO0Y3c1QL1VNo4xdbt8pEUnDGK+sN
         bUQEJGHsDxUzm2ZI8XTBKpPU+qVfg6Bgk45sFgc805RYm4Ki3ezC0zNlOdrJd9SYVLlv
         rAnWzNEcvlqq7BlIjVDC3FNUb0dwY0TxPcrjlXL69egPXmh3tk9UQ/B85PO1WpwaRSJu
         SjY2WscqnNeJiKC5WDlPIHh0PS7AFyfCwWlvAy7/uJdlwumbXMw6LzS9CRlPQwDbglgE
         hZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mckNNp9UKxn7W2DnL8nnDaXbQehqA1+WXvXBkFoXeuc=;
        b=CpBzgRlGzHNpR8vLJEs8sYq1hgbHlZY/8E98kB9EhufOv7qJcTWSzwdgq8O3mZ4dyQ
         4j4Zioe93mTRF/BdBTYtpdXYcQEUNGtGU78A+6Ez2zif98j1u9UvVzV9+niQro65Uz1F
         /ffBIdOVOmXwm84SsZNdeg0NloskSrXmhUfg1ba/zy0Ii8yZPaNNzEas/CHyYqnLJSHa
         TpX0WIkGKTeE3PVn5fSWGTSOvCwSjAKHh0hLjAlGs3HxMYMhx2wdF5eq7KwWVcf9SKDn
         4r/C1JBIzIoj6nu7Zm0qjlzZBMxYu+J3WYHKmXdmDlAjNF6MjuLRHHBBYoLqLloVk0NU
         L1ng==
X-Gm-Message-State: APjAAAWPnAG7hTlo5lDQeLBGO2uQkrILCbRf0kZZA1cAIzg3StYsMeu2
        ob0hHlKpigTl9pNX862+zVL+UoN8
X-Google-Smtp-Source: APXvYqyEZXf/qpC3z+cjP4kg9QoMak2TCNYMdkPHJYzLUUOHOsiEXIREklX7KvRgxxOue5EilOZvDw==
X-Received: by 2002:a17:902:bd87:: with SMTP id q7mr16877875pls.239.1580119238437;
        Mon, 27 Jan 2020 02:00:38 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id v9sm15497872pja.26.2020.01.27.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:00:37 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] tools lib api fs: Move cgroupsfs_find_mountpoint()
Date:   Mon, 27 Jan 2020 19:00:31 +0900
Message-Id: <20200127100031.1368732-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it from tools/perf/util/cgroup.c as it can be used by other places.
Note that cgroup filesystem is different from others since it's usually
mounted separately (in v1) for each subsystem.

I just copied the code with a little modification to pass a name of
subsystem.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
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
2.25.0.341.g760bfbb309-goog

