Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C5C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F822145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778611;
	bh=pd37DjXKvKVdgSaLVo6UzHxbUxOaPeqkoDrfbENCEO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PE6DL7ua97cBizxzobRROja8KLZT2yDxkAmDthdocQDDJl4VA66Cji38blJgGD3ll
	 rmyDbNuWnqfYomB5xYyS0E+okEs+KyiIYMFiueUYF9/P2d2gu3LwXKzchc/cFUjw/s
	 OfB6w8Rj1RW19tLy7DCFFOBO24garBS7KtRF9spw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgEFPXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgEFPX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA6320CC7;
        Wed,  6 May 2020 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778605;
        bh=pd37DjXKvKVdgSaLVo6UzHxbUxOaPeqkoDrfbENCEO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4Pf/mBRq1QYOSQHwV3XoDfOK74FFr/bWarHrzWsrDqE76I0evYVU/Ykf8CM4ZwdU
         +OZlkhWDZ2IY33p9kcWwOQauct16ty2+DGOReCFhVGIr/oAUwVX0ea/d6tHh38uvV6
         +7ToTlJieS6xmNNhJzjoc8+jYgDkxpxR3XtXL+w8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 11/91] perf synthetic events: Remove use of sscanf from /proc reading
Date:   Wed,  6 May 2020 12:21:14 -0300
Message-Id: <20200506152234.21977-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

The synthesize benchmark, run on a single process and thread, shows
perf_event__synthesize_mmap_events as the hottest function with fgets
and sscanf taking the majority of execution time.

fscanf performs similarly well. Replace the scanf call with manual
reading of each field of the /proc/pid/maps line, and remove some
unnecessary buffering.

This change also addresses potential, but unlikely, buffer overruns for
the string values read by scanf.

Performance before is:

  $ sudo perf bench internals synthesize -m 16 -M 16 -s -t
  \# Running 'internals/synthesize' benchmark:
  Computing performance of single threaded perf event synthesis by
  synthesizing events on the perf process itself:
    Average synthesis took: 102.810 usec (+- 0.027 usec)
    Average num. events: 17.000 (+- 0.000)
    Average time per event 6.048 usec
    Average data synthesis took: 106.325 usec (+- 0.018 usec)
    Average num. events: 89.000 (+- 0.000)
    Average time per event 1.195 usec
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 16
      Average synthesis took: 68103.100 usec (+- 441.234 usec)
      Average num. events: 30703.000 (+- 0.730)
      Average time per event 2.218 usec

And after is:

  $ sudo perf bench internals synthesize -m 16 -M 16 -s -t
  \# Running 'internals/synthesize' benchmark:
  Computing performance of single threaded perf event synthesis by
  synthesizing events on the perf process itself:
    Average synthesis took: 50.388 usec (+- 0.031 usec)
    Average num. events: 17.000 (+- 0.000)
    Average time per event 2.964 usec
    Average data synthesis took: 52.693 usec (+- 0.020 usec)
    Average num. events: 89.000 (+- 0.000)
    Average time per event 0.592 usec
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 16
      Average synthesis took: 45022.400 usec (+- 552.740 usec)
      Average num. events: 30624.200 (+- 10.037)
      Average time per event 1.470 usec

On a Intel Xeon 6154 compiling with Debian gcc 9.2.1.

Committer testing:

On a AMD Ryzen 5 3600X 6-Core Processor:

Before:

  # perf bench internals synthesize --min-threads 12 --max-threads 12 --st --mt
  # Running 'internals/synthesize' benchmark:
  Computing performance of single threaded perf event synthesis by
  synthesizing events on the perf process itself:
    Average synthesis took: 267.491 usec (+- 0.176 usec)
    Average num. events: 56.000 (+- 0.000)
    Average time per event 4.777 usec
    Average data synthesis took: 277.257 usec (+- 0.169 usec)
    Average num. events: 287.000 (+- 0.000)
    Average time per event 0.966 usec
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 12
      Average synthesis took: 81599.500 usec (+- 346.315 usec)
      Average num. events: 36096.100 (+- 2.523)
      Average time per event 2.261 usec
  #

After:

  # perf bench internals synthesize --min-threads 12 --max-threads 12 --st --mt
  # Running 'internals/synthesize' benchmark:
  Computing performance of single threaded perf event synthesis by
  synthesizing events on the perf process itself:
    Average synthesis took: 110.125 usec (+- 0.080 usec)
    Average num. events: 56.000 (+- 0.000)
    Average time per event 1.967 usec
    Average data synthesis took: 118.518 usec (+- 0.057 usec)
    Average num. events: 287.000 (+- 0.000)
    Average time per event 0.413 usec
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 12
      Average synthesis took: 43490.700 usec (+- 284.527 usec)
      Average num. events: 37028.500 (+- 0.563)
      Average time per event 1.175 usec
  #

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200415054050.31645-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/synthetic-events.c | 157 +++++++++++++++++++----------
 1 file changed, 105 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9d4aa951eaa6..1ea9adaef9c7 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -37,6 +37,7 @@
 #include <string.h>
 #include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 #include <api/fs/fs.h>
+#include <api/io.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -273,6 +274,79 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
 	return 0;
 }
 
+static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
+				u32 *prot, u32 *flags, __u64 *offset,
+				u32 *maj, u32 *min,
+				__u64 *inode,
+				ssize_t pathname_size, char *pathname)
+{
+	__u64 temp;
+	int ch;
+	char *start_pathname = pathname;
+
+	if (io__get_hex(io, start) != '-')
+		return false;
+	if (io__get_hex(io, end) != ' ')
+		return false;
+
+	/* map protection and flags bits */
+	*prot = 0;
+	ch = io__get_char(io);
+	if (ch == 'r')
+		*prot |= PROT_READ;
+	else if (ch != '-')
+		return false;
+	ch = io__get_char(io);
+	if (ch == 'w')
+		*prot |= PROT_WRITE;
+	else if (ch != '-')
+		return false;
+	ch = io__get_char(io);
+	if (ch == 'x')
+		*prot |= PROT_EXEC;
+	else if (ch != '-')
+		return false;
+	ch = io__get_char(io);
+	if (ch == 's')
+		*flags = MAP_SHARED;
+	else if (ch == 'p')
+		*flags = MAP_PRIVATE;
+	else
+		return false;
+	if (io__get_char(io) != ' ')
+		return false;
+
+	if (io__get_hex(io, offset) != ' ')
+		return false;
+
+	if (io__get_hex(io, &temp) != ':')
+		return false;
+	*maj = temp;
+	if (io__get_hex(io, &temp) != ' ')
+		return false;
+	*min = temp;
+
+	ch = io__get_dec(io, inode);
+	if (ch != ' ') {
+		*pathname = '\0';
+		return ch == '\n';
+	}
+	do {
+		ch = io__get_char(io);
+	} while (ch == ' ');
+	while (true) {
+		if (ch < 0)
+			return false;
+		if (ch == '\0' || ch == '\n' ||
+		    (pathname + 1 - start_pathname) >= pathname_size) {
+			*pathname = '\0';
+			return true;
+		}
+		*pathname++ = ch;
+		ch = io__get_char(io);
+	}
+}
+
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       union perf_event *event,
 				       pid_t pid, pid_t tgid,
@@ -280,9 +354,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       struct machine *machine,
 				       bool mmap_data)
 {
-	FILE *fp;
 	unsigned long long t;
 	char bf[BUFSIZ];
+	struct io io;
 	bool truncation = false;
 	unsigned long long timeout = proc_map_timeout * 1000000ULL;
 	int rc = 0;
@@ -295,28 +369,39 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	snprintf(bf, sizeof(bf), "%s/proc/%d/task/%d/maps",
 		machine->root_dir, pid, pid);
 
-	fp = fopen(bf, "r");
-	if (fp == NULL) {
+	io.fd = open(bf, O_RDONLY, 0);
+	if (io.fd < 0) {
 		/*
 		 * We raced with a task exiting - just return:
 		 */
 		pr_debug("couldn't open %s\n", bf);
 		return -1;
 	}
+	io__init(&io, io.fd, bf, sizeof(bf));
 
 	event->header.type = PERF_RECORD_MMAP2;
 	t = rdclock();
 
-	while (1) {
-		char prot[5];
-		char execname[PATH_MAX];
-		char anonstr[] = "//anon";
-		unsigned int ino;
+	while (!io.eof) {
+		static const char anonstr[] = "//anon";
 		size_t size;
-		ssize_t n;
 
-		if (fgets(bf, sizeof(bf), fp) == NULL)
-			break;
+		/* ensure null termination since stack will be reused. */
+		event->mmap2.filename[0] = '\0';
+
+		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
+		if (!read_proc_maps_line(&io,
+					&event->mmap2.start,
+					&event->mmap2.len,
+					&event->mmap2.prot,
+					&event->mmap2.flags,
+					&event->mmap2.pgoff,
+					&event->mmap2.maj,
+					&event->mmap2.min,
+					&event->mmap2.ino,
+					sizeof(event->mmap2.filename),
+					event->mmap2.filename))
+			continue;
 
 		if ((rdclock() - t) > timeout) {
 			pr_warning("Reading %s/proc/%d/task/%d/maps time out. "
@@ -327,23 +412,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			goto out;
 		}
 
-		/* ensure null termination since stack will be reused. */
-		strcpy(execname, "");
-
-		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		n = sscanf(bf, "%"PRI_lx64"-%"PRI_lx64" %s %"PRI_lx64" %x:%x %u %[^\n]\n",
-		       &event->mmap2.start, &event->mmap2.len, prot,
-		       &event->mmap2.pgoff, &event->mmap2.maj,
-		       &event->mmap2.min,
-		       &ino, execname);
-
-		/*
- 		 * Anon maps don't have the execname.
- 		 */
-		if (n < 7)
-			continue;
-
-		event->mmap2.ino = (u64)ino;
 		event->mmap2.ino_generation = 0;
 
 		/*
@@ -354,23 +422,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		else
 			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
 
-		/* map protection and flags bits */
-		event->mmap2.prot = 0;
-		event->mmap2.flags = 0;
-		if (prot[0] == 'r')
-			event->mmap2.prot |= PROT_READ;
-		if (prot[1] == 'w')
-			event->mmap2.prot |= PROT_WRITE;
-		if (prot[2] == 'x')
-			event->mmap2.prot |= PROT_EXEC;
-
-		if (prot[3] == 's')
-			event->mmap2.flags |= MAP_SHARED;
-		else
-			event->mmap2.flags |= MAP_PRIVATE;
-
-		if (prot[2] != 'x') {
-			if (!mmap_data || prot[0] != 'r')
+		if ((event->mmap2.prot & PROT_EXEC) == 0) {
+			if (!mmap_data || (event->mmap2.prot & PROT_READ) == 0)
 				continue;
 
 			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
@@ -380,17 +433,17 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 		if (truncation)
 			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
 
-		if (!strcmp(execname, ""))
-			strcpy(execname, anonstr);
+		if (!strcmp(event->mmap2.filename, ""))
+			strcpy(event->mmap2.filename, anonstr);
 
 		if (hugetlbfs_mnt_len &&
-		    !strncmp(execname, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
-			strcpy(execname, anonstr);
+		    !strncmp(event->mmap2.filename, hugetlbfs_mnt,
+			     hugetlbfs_mnt_len)) {
+			strcpy(event->mmap2.filename, anonstr);
 			event->mmap2.flags |= MAP_HUGETLB;
 		}
 
-		size = strlen(execname) + 1;
-		memcpy(event->mmap2.filename, execname, size);
+		size = strlen(event->mmap2.filename) + 1;
 		size = PERF_ALIGN(size, sizeof(u64));
 		event->mmap2.len -= event->mmap.start;
 		event->mmap2.header.size = (sizeof(event->mmap2) -
@@ -409,7 +462,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			break;
 	}
 
-	fclose(fp);
+	close(io.fd);
 	return rc;
 }
 
-- 
2.21.1

