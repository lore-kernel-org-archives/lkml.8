Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FECC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE9020675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582519095;
	bh=Vm/RmP1unXRHQ6SY3jj7Zt1xCV3UzENFuZcFpcGNHUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+T6SLKOGUttDw/lwN9OgjGAjemDRNrOTisrbQ5oNmWHzolwdiPCD9twIl7oZsuK4
	 IP9XV4LdN5zCdg4LkDiuJTE1FYckryBkaPJ1OcF0mbvzS9vGtyIAkdpdxXgV8u41Dz
	 O58f0t7CdLT9S5CE8jFZKL+LYhZVgDFOhHQU1uYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBXEiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:38:14 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33064 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgBXEiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:11 -0500
Received: by mail-pl1-f177.google.com with SMTP id ay11so3534437plb.0;
        Sun, 23 Feb 2020 20:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwDg5U+06f7u3u1dxrmuK7g2W0grhdkABzno2zrWZB0=;
        b=UQylhgC94k9TUop6X4tRAL//4rzp7VVqN/vMu2vek4MieRMF0ElMQPOrF1ivkoJjwN
         S9CSoLfs53kPA0UN7aGi/MzRUHd3BQZMntlngh4jzAQVNDXt7BbqHriQZ32yiwIXBwxX
         9x/uw8tADlLSj+zBKdpc2j2ptfANlxVgg3SVL+Vlb2rEZQcs+vOK76r7kRMO6m+knZih
         4GyK+fBHSCQl0YeVXQTYvyc8/sKTrCg+yJHgCQoOVd6oplmL5BqFca07zYR0ZOSBkE/I
         +NfQ74QE45lMr5KpuPTnQ48R2MPEu86s55EeDgkXkHaHlnfbBfx3kbWTBrUdzscdQYeS
         M8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RwDg5U+06f7u3u1dxrmuK7g2W0grhdkABzno2zrWZB0=;
        b=dK2DiP5fJFI15wFr23GKOnonTg0AV04RstEL85qgF3SBP5iflIqSckPNH3E7guHYIg
         9gsI/gEDp04aQgBJGKMO3/Pqmbtx7CMV+CPFwpsW7hpdwWc9O/LbAzFgW+fqcnDwinQM
         EIGSjDVO+AAXmR5hdWhUBJPCkE7x4cCDStzRk8c413y7o3FVPkqiE1mwqESA3iPuzAof
         2hYC+7eTiXfxZrWoGZfYbKaeQWBVkIiw4hZVEwjEw96y7FzLdW2kIEKvQTPkewwgoKfN
         JaGiO8c3CTXfn6CuYOM1hh2GNXajP0K8pKqXDIPgxJzmWTjDL8wqNfKOJv18GEPw+QEe
         Yq3w==
X-Gm-Message-State: APjAAAVl8A+rXart0Y5GVFeu6H4XnvvHgCOuYNCjBrwUfPzHc0ZnolzS
        OVuTMsQWbUxJSCllu44macY=
X-Google-Smtp-Source: APXvYqwyJ00ug9zsdt6hDWcPu06D+44ts50xkVWxXiBbqH/oj1ElMHb0Lz8o01OCtaFcbI8R6mZmyA==
X-Received: by 2002:a17:902:5a85:: with SMTP id r5mr49478883pli.222.1582519090684;
        Sun, 23 Feb 2020 20:38:10 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:10 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 03/10] tools lib api fs: Move cgroupsfs__mountpoint()
Date:   Mon, 24 Feb 2020 13:37:42 +0900
Message-Id: <20200224043749.69466-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
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
index 000000000000..79676cada94a
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
+	 * and inspect every cgroupfs mount point to find one that has the
+	 * given subsystem
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
+				if (!subsys || !strcmp(token, subsys)) {
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
2.25.0.265.gbab2e86ba0-goog

