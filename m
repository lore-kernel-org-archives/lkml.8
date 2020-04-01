Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A11FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91C820719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANRbvwnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbgDAXkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:40:33 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55562 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgDAXkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:40:32 -0400
Received: by mail-qt1-f201.google.com with SMTP id o10so1490394qtk.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IJbUqAZoaZbcftRq/6j3id1/PIehiPTgOI+a+J70oz0=;
        b=ANRbvwnGcWbAdfV/0DjJdBoS7WfxjOUDLjkOX9FtAUuCLbTkQc5Vm8o6ng/9PBOcUY
         L6MzCBafGFHQFw0rNrH4auccGNPaPKJNj+HpgTHoBWXw7BQjkZfJIHTbYJ6sZ0BA9S3F
         O6Vn/WOdYUJgQQLy63630NocVAVp9jwoCH4XrQH+/Fv5R1aKyB3lxsyIqCX1tUrpJwj0
         Qi+KwVhq0Slp3zyedKe2fB9ucOgRqCCUdONtXtPmT1r6OHeb0SdjyW9B1WjDT4e5TZPV
         2myHWCmxlbzh/TkmW60y51EO559ilCvJOjt5rQHupor2MTeFh3WLhaSrOLLXq/3CpZrJ
         ZRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IJbUqAZoaZbcftRq/6j3id1/PIehiPTgOI+a+J70oz0=;
        b=IJUUzrpfuEHvscovIzokYi6qFzysKkzA3SJQCTS/oiBVsu4hnZm9UtoVcRiJ1Xgpiz
         Cuef/5ZOaQ27sjLLS0we99KAGPxhyRQ06RVio9XiKkiqvZvzcMx9+hx513kaAxpzpYLk
         oBbUf865jfMMrvYY7bZ8oX+04WnX4VNeun284+kd/US+2ETKMvWU5yDEEsXa0rGh8XQi
         /i9uJ3E//+JQR+REEJTwdfT5foH6sv/b/AxexAUhAgicr6Nsc7A2TcovnWCU8hvZJFEI
         fg8imMDfxgPnCMRmeJYK/idfK+sFl/8wOxzyexEVWxXI8p175stz8wqsSHjk9daau2e/
         xlgA==
X-Gm-Message-State: AGi0PubAPnhmCxWsIThL2Ryp6RVSS9FbNzGSlO5rAFmTPu9craK62rBk
        p9RC+unHNC4eerEVmRPEzP7WGWsjHV07
X-Google-Smtp-Source: APiQypJj1nzy0xxZiK/ancIXb99LI/aD6DB8ovIp38LT8P7v9l2KUFKyZzm4EK63vqAlR6TV4bnqFDCVobNf
X-Received: by 2002:a05:6214:2c4:: with SMTP id g4mr618723qvu.65.1585784430080;
 Wed, 01 Apr 2020 16:40:30 -0700 (PDT)
Date:   Wed,  1 Apr 2020 16:39:42 -0700
In-Reply-To: <20200401233945.133550-1-irogers@google.com>
Message-Id: <20200401233945.133550-3-irogers@google.com>
Mime-Version: 1.0
References: <20200401233945.133550-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 2/5] tools api fs: make xxx__mountpoint() more scalable
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

The xxx_mountpoint() interface provided by fs.c finds
mount points for common pseudo filesystems. The first
time xxx_mountpoint() is invoked, it scans the mount
table (/proc/mounts) looking for a match. If found, it
is cached. The price to scan /proc/mounts is paid once
if the mount is found.

When the mount point is not found, subsequent calls to
xxx_mountpoint() scan /proc/mounts over and over again.
There is no caching.

This causes a scaling issue in perf record with hugeltbfs__mountpoint().
The function is called for each process found in synthesize__mmap_events().
If the machine has thousands of processes and if the /proc/mounts has many
entries this could cause major overhead in perf record. We have observed
multi-second slowdowns on some configurations.

As an example on a laptop:

Before:
$ sudo umount /dev/hugepages
$ strace -e trace=openat -o /tmp/tt perf record -a ls
$ fgrep mounts /tmp/tt
285

After:
$ sudo umount /dev/hugepages
$ strace -e trace=openat -o /tmp/tt perf record -a ls
$ fgrep mounts /tmp/tt
1

One could argue that the non-caching in case the moint point is not found
is intentional. That way subsequent calls may discover a moint point if
the sysadmin mounts the filesystem. But the same argument could be made
against caching the mount point. It could be unmounted causing errors.
It all depends on the intent of the interface. This patch assumes it
is expected to scan /proc/mounts once. The patch documents the caching
behavior in the fs.h header file.

An alternative would be to just fix perf record. But it would solve
the problem with hugetlbs__mountpoint() but there could be similar
issues (possibly down the line) with other xxx_mountpoint() calls
in perf or other tools.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 17 +++++++++++++++++
 tools/lib/api/fs/fs.h | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 027b18f7ed8c..82f53d81a7a7 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -90,6 +90,7 @@ struct fs {
 	const char * const	*mounts;
 	char			 path[PATH_MAX];
 	bool			 found;
+	bool			 checked;
 	long			 magic;
 };
 
@@ -111,31 +112,37 @@ static struct fs fs__entries[] = {
 		.name	= "sysfs",
 		.mounts	= sysfs__fs_known_mountpoints,
 		.magic	= SYSFS_MAGIC,
+		.checked = false,
 	},
 	[FS__PROCFS] = {
 		.name	= "proc",
 		.mounts	= procfs__known_mountpoints,
 		.magic	= PROC_SUPER_MAGIC,
+		.checked = false,
 	},
 	[FS__DEBUGFS] = {
 		.name	= "debugfs",
 		.mounts	= debugfs__known_mountpoints,
 		.magic	= DEBUGFS_MAGIC,
+		.checked = false,
 	},
 	[FS__TRACEFS] = {
 		.name	= "tracefs",
 		.mounts	= tracefs__known_mountpoints,
 		.magic	= TRACEFS_MAGIC,
+		.checked = false,
 	},
 	[FS__HUGETLBFS] = {
 		.name	= "hugetlbfs",
 		.mounts = hugetlbfs__known_mountpoints,
 		.magic	= HUGETLBFS_MAGIC,
+		.checked = false,
 	},
 	[FS__BPF_FS] = {
 		.name	= "bpf",
 		.mounts = bpf_fs__known_mountpoints,
 		.magic	= BPF_FS_MAGIC,
+		.checked = false,
 	},
 };
 
@@ -158,6 +165,7 @@ static bool fs__read_mounts(struct fs *fs)
 	}
 
 	fclose(fp);
+	fs->checked = true;
 	return fs->found = found;
 }
 
@@ -220,6 +228,7 @@ static bool fs__env_override(struct fs *fs)
 		return false;
 
 	fs->found = true;
+	fs->checked = true;
 	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
 	fs->path[sizeof(fs->path) - 1] = '\0';
 	return true;
@@ -246,6 +255,14 @@ static const char *fs__mountpoint(int idx)
 	if (fs->found)
 		return (const char *)fs->path;
 
+	/* the mount point was already checked for the mount point
+	 * but and did not exist, so return NULL to avoid scanning again.
+	 * This makes the found and not found paths cost equivalent
+	 * in case of multiple calls.
+	 */
+	if (fs->checked)
+		return NULL;
+
 	return fs__get_mountpoint(fs);
 }
 
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index 936edb95e1f3..aa222ca30311 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -18,6 +18,18 @@
 	const char *name##__mount(void);	\
 	bool name##__configured(void);		\
 
+/*
+ * The xxxx__mountpoint() entry points find the first match mount point for each
+ * filesystems listed below, where xxxx is the filesystem type.
+ *
+ * The interface is as follows:
+ *
+ * - If a mount point is found on first call, it is cached and used for all
+ *   subsequent calls.
+ *
+ * - If a mount point is not found, NULL is returned on first call and all
+ *   subsequent calls.
+ */
 FS(sysfs)
 FS(procfs)
 FS(debugfs)
-- 
2.26.0.rc2.310.g2932bb562d-goog

