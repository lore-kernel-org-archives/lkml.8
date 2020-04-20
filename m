Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A0AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E01A20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383708;
	bh=R0LGZCVn1b70Jp2+XXLCkJWEFlY0wkTJiT6feqChB10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0nGPNsNX593V/S5d3HZb0DzWSbfL9oSlEcGbC5MJ/7nTDlDp+KAYGO5NYg47yIecQ
	 CgNtTPzRoz3Qu6sxFhVYqFGp6Dc0/5QZxRUsOLqRzT810hNUgMHJrQQ/qrdDzT4G8D
	 pzNqWXwBEkrwoir8CUpbCMbgMv0luxtfbcnsuEQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgDTLzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgDTLzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:55:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED96214AF;
        Mon, 20 Apr 2020 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383702;
        bh=R0LGZCVn1b70Jp2+XXLCkJWEFlY0wkTJiT6feqChB10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S493+sAx+0Ndz4KD78XH21HtyezaDoWKqq0CjyNVFec7UGmWfdwzLSEF310QWmMUD
         BdGpSkPm70E9XJApwhJraNm0ELTzeqOYAvsmxSeTKDfTJVd+IVKCNyFWek6RBWi+Jd
         2+JwWZG0AjVwDI1CnUW0yteivxlyzehUM1EmYjis=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/60] tools api fs: Make xxx__mountpoint() more scalable
Date:   Mon, 20 Apr 2020 08:52:35 -0300
Message-Id: <20200420115316.18781-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

The xxx_mountpoint() interface provided by fs.c finds mount points for
common pseudo filesystems. The first time xxx_mountpoint() is invoked,
it scans the mount table (/proc/mounts) looking for a match. If found,
it is cached. The price to scan /proc/mounts is paid once if the mount
is found.

When the mount point is not found, subsequent calls to xxx_mountpoint()
scan /proc/mounts over and over again.  There is no caching.

This causes a scaling issue in perf record with hugeltbfs__mountpoint().
The function is called for each process found in
synthesize__mmap_events().  If the machine has thousands of processes
and if the /proc/mounts has many entries this could cause major overhead
in perf record. We have observed multi-second slowdowns on some
configurations.

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

One could argue that the non-caching in case the moint point is not
found is intentional. That way subsequent calls may discover a moint
point if the sysadmin mounts the filesystem. But the same argument could
be made against caching the mount point. It could be unmounted causing
errors.  It all depends on the intent of the interface. This patch
assumes it is expected to scan /proc/mounts once. The patch documents
the caching behavior in the fs.h header file.

An alternative would be to just fix perf record. But it would solve the
problem with hugetlbs__mountpoint() but there could be similar issues
(possibly down the line) with other xxx_mountpoint() calls in perf or
other tools.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200402154357.107873-3-irogers@google.com
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.1

