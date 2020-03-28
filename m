Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A454C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEACD2074A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjoel3bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgC1Bm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:42:28 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43492 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1Bm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:42:28 -0400
Received: by mail-ua1-f74.google.com with SMTP id s8so4711472uap.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YJhNgskAc1JTX/Lb9UVALj/ihktIQcG0OBTySTkArx4=;
        b=rjoel3bH0nKIqhRrUEr9KkmW0mL2GxOprQKa0Slf6sIqUEuEWUbyCNvyO3Q51Qh4kk
         4oEFekPbxEMfBMGzPqROc3qqHO2tLVdhX+FaDb0z7gPSfCGRVPHAZyGrZdnr4RI30dj4
         DhATwvrkydMdmNA/0O7fpTtTBXCIreKcFNQm1XPWI/HUjpr3E8DwlHT1n1jdVy+6EGR1
         lu+Y5beSqzBulCZi7ebWgatVVHlHticoNnVyj512YWvMDJR+jIzRSzqzqXbhTtVqFKji
         69jWzj6Q7PtmroKSmnNFyls6xFn7n9eOmYL8MtVJQ5SNxTeCoiXM/Gt76KqVT5mtG1dU
         gAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YJhNgskAc1JTX/Lb9UVALj/ihktIQcG0OBTySTkArx4=;
        b=CXJYoV1C+c8JAvBKXIBeo/si52qDNI5ntx9ae9gIpHT447v01k6KmEFLBOrtXzrvik
         npctKNjZCjSmWCwBp0rbc+xm9XkCxOY1M/fdiJBQyllrKHjeyv24AJaDm9/L0USEdWwP
         vEb4qs3kaS0xWMsgSn/BzPVNu8FJz1+t5oWIkTwoTxvFZM8f0FX/SENfVfRMeEuGl5Mz
         Jg3kowjpxh+iHd3jqIqxrZbNMgP/VJdMmB0dPH/gDrmjO82zDwXQtCk+2QtgrqHlzLtH
         kt6i1UQ1HrIx05jaZksU2mM+7dlkFNKeioXl/p451pmwYsKVFJ0wtTqPJe34kHeJXMZW
         QxXQ==
X-Gm-Message-State: AGi0PuZUwl2cYDVUYEwugqQQNpaWaV5OexfKm1oeM+Ns59VUnEq+CRRQ
        8m0N3E9tA/W+LxbA/BlXZ6VRpARJ6X5f
X-Google-Smtp-Source: APiQypKystsZIHvo3DbaX8xoK/m5y7aUTEEGSPX442O5Js7xXNBYElPhgDyhp9X28DItrL7YW3LfV4FqJu8m
X-Received: by 2002:a9f:378a:: with SMTP id q10mr1389212uaq.47.1585359745772;
 Fri, 27 Mar 2020 18:42:25 -0700 (PDT)
Date:   Fri, 27 Mar 2020 18:42:21 -0700
Message-Id: <20200328014221.168130-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] tools api fs: make xxx__mountpoint() more scalable
From:   Ian Rogers <irogers@google.com>
To:     Petr Mladek <pmladek@suse.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
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

