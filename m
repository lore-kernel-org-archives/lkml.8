Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E954C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1821324682
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580172589;
	bh=KgdxAy35tJKPY2d9NruQQc2qjn0slHIDntTEjZKiE+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=feKad9VygiXZty2Ss8+S2xdnJMVR2TjfBpG0fDnLidaA/irMauh0+LmGp4E4YRkbK
	 ug80sKqZ334MRpIvL8xKhmXCkdI7F4Li655kRnUnZAButw9F9yV7HdOjd8DKFPs2GQ
	 X+QiTWanOtl8aOUw9zVPB05YWX5PsD51b7HwfRAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1Ats (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:49:48 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:50617 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1Ats (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:49:48 -0500
Received: by mail-pj1-f45.google.com with SMTP id r67so243945pjb.0;
        Mon, 27 Jan 2020 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTAodgesT1Ltz7QSaTxWSle2A6ZOgIKklY+JLHB4hyo=;
        b=i77OzunuAh7WFn40SKUPeSuX+XCOtQIBM3Y5awNWmXfxd60H8IR3cJ17M7ekIuK56m
         NphT7jl3RTOJXZg7b1V1bpJJgYrSCqiQzLM219+qNCPg9unuQNhtNtMNdTQjlHLnTDIb
         XK591Xbf6HPlRekMH20+mc48qicRzjdoi1pY84W/Wv2WTQLjl5lRpl2ssT/Rf6JRKVlX
         jt7ptE64aENbqTz8W3+NxodykE0+kxpRoUCXMyg1I0x8Mb79gKXEaUYnoh3PaAS+a0IR
         rEkM8+pzOzPrQMgR7Q7hnuc/33+Wd6sKPvFTe5c7JzVCPLdZMUhMhz2jUuukdQdJpHBj
         ayGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hTAodgesT1Ltz7QSaTxWSle2A6ZOgIKklY+JLHB4hyo=;
        b=P7qz0hme+rwzZkYmNBGjJlFm2ZqVoD2qbe+709ONz04vKYJ1SSQ7tYdVZyluCycK/i
         5wYkcv9MzFhsdzHzo+prObr3KB1F21Suw7DQ3tVM4eAuFMPwF06HX9Elcp3RGXDaefKf
         Mvk7OlbEpbQYA1c8z4gsWPUz5q3l4QR2VZhhk0xFGpGIxKO1SDWa3BRfH6Sz7qs3XXOf
         1k8OwawtXCeVFzXvxrpwbtgj1beUzhaPEry08vtCof97RQluY/vkJWIt1VhLK27GpvSA
         d/0uCSuRR0QtHJg35geArvZXJzZpVm56G82CzMvkxAgp6GpnnZ8ZmYvAHxNaWMMB2J8J
         emLQ==
X-Gm-Message-State: APjAAAV6BfZghwG+kZEsOBHnXJmPw7QuQEytWaCwyLHLtYkTKZop/e55
        RR1NcaULAll/hEICL7SdG94=
X-Google-Smtp-Source: APXvYqwtnRxf1M+he9rzCDrtsCKb5MBvttktS73K8aLONrh635IqnQelYW5xaTO0qrUQi9REIXUTLw==
X-Received: by 2002:a17:902:a414:: with SMTP id p20mr20994602plq.7.1580172587198;
        Mon, 27 Jan 2020 16:49:47 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id a13sm7025949pfl.162.2020.01.27.16.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:49:46 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2] tools lib api fs: Move cgroupsfs__mountpoint()
Date:   Tue, 28 Jan 2020 09:49:40 +0900
Message-Id: <20200128004940.1590044-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200127162222.GG1114818@krava>
References: <20200127162222.GG1114818@krava>
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
subsystem and renamed it to follow other APIs.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* rename to cgroupfs__mountpoint()

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
index 000000000000..c7e1cdaa36e1
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
+int cgroupfs__mountpoint(char *buf, size_t maxlen, const char *subsys)
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
index 92d03b8396b1..07591ecbe39f 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -28,6 +28,8 @@ FS(bpf_fs)
 #undef FS
 
 
+int cgroupfs__mountpoint(char *buf, size_t maxlen, const char *subsys);
+
 int filename__read_int(const char *filename, int *value);
 int filename__read_ull(const char *filename, unsigned long long *value);
 int filename__read_xll(const char *filename, unsigned long long *value);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4881d4af3381..12e466d1ec3b 100644
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
+	if (cgroupfs__mountpoint(mnt, PATH_MAX + 1, "perf_event"))
 		return -1;
 
 	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
-- 
2.25.0.341.g760bfbb309-goog

