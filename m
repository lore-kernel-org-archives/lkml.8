Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C475C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6092074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyyoxkE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393373AbgDOFlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393366AbgDOFlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:41:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A999C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:41:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x6so7223048pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zcSOEJ0YcJVVjySOtzo8rhml9rHIFC8051EBtxpXHQQ=;
        b=MyyoxkE4J+p6swxNxZ/OqEUhyZ4UKGBFDxSRrAym8DVNzgnGIEEwlv3X1bDOilEI+6
         SwW9H9Ht4KN5DKp4/4DX+RKni4g0KnmpXE4m8RPDfQmd+Cjn7OTFEmzhcrfk66YxIsuD
         3kNg91UsTDou+IrpxGtM8jXzr+NTUZh9gwNS2LuuFr++8NtALygdHrjnXUERaJwlAE/3
         ye3tVw69XGm7rAPlgtprmMqhcORpjNwT6CPNgxyi9Hwkjfwg3XY0H5heYH9coq8uWlKn
         XWftTRXuCYlrYjyrSvHMkMRdgtiqgINUx2Bd2pC2jNxPI1+VV33nXBrNjoVZWPJAuQJh
         liiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zcSOEJ0YcJVVjySOtzo8rhml9rHIFC8051EBtxpXHQQ=;
        b=I6yKf+un2qzNz16FmX8faikB6wiaYCeK5e8YBEulgg2mS96Ko5Eu8UrTT1KiLcNF4a
         Sm3pLvNKKUr4ecB3Ib8Xvs+c2eXWtoGzaDCjKH1clz1SmnQqwV4yCK/fb2r89YzUG7gH
         jnXus15iNQKPvVBSqXYBvuYMxXokvaaMUfCL6KLdr40Wcu0lmkucWuMKCkIHiPJB3s+h
         Mrlq7L3TMoOgDhbVFpnsRUHhwuk89Sm3Nu8mG+u5DtK1urzPRQA+as5D4MV2NvUiElNd
         HgXxChobjkRNM9M5mk0BPaRTiDXjZ1Mmq2uZJQZKleT6mCPaB+AQ1cn5a8V0CmJk2F7z
         0h7Q==
X-Gm-Message-State: AGi0PuaTUvRIocXXMmVkED9JO/PU+rQSv0ls0vUvZh3StxPkvewwTa+1
        ByeEh3T8L35xcjmZAopUQXUNKV7veNn3
X-Google-Smtp-Source: APiQypIF1NJIPzatvJUWJphrlwuxt9Xj9upvji9L/PUjV451nsfhbtUyLfAp5swH36J/ZIXjyiRf/rEG4d0d
X-Received: by 2002:a17:90a:266c:: with SMTP id l99mr3888402pje.186.1586929264665;
 Tue, 14 Apr 2020 22:41:04 -0700 (PDT)
Date:   Tue, 14 Apr 2020 22:40:50 -0700
In-Reply-To: <20200415054050.31645-1-irogers@google.com>
Message-Id: <20200415054050.31645-4-irogers@google.com>
Mime-Version: 1.0
References: <20200415054050.31645-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 3/3] perf synthetic events: Remove use of sscanf from /proc reading
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

The synthesize benchmark, run on a single process and thread, shows
perf_event__synthesize_mmap_events as the hottest function with fgets
and sscanf taking the majority of execution time. fscanf performs
similarly well. Replace the scanf call with manual reading of each field
of the /proc/pid/maps line, and remove some unnecessary buffering.
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

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.26.0.110.g2183baf09c-goog

