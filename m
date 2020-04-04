Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3408CC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94A62078A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgDDImF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41502 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgDDIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNA-00010Q-16; Sat, 04 Apr 2020 10:41:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 392B91C0243;
        Sat,  4 Apr 2020 10:41:46 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:45 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf record: Support synthesizing cgroup events
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200325124536.2800725-7-namhyung@kernel.org>
References: <20200325124536.2800725-7-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970584.28353.12408640779888059491.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ab64069f1a6604a43daec5fc4a4294b0b77a8b93
Gitweb:        https://git.kernel.org/tip/ab64069f1a6604a43daec5fc4a4294b0b77a8b93
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 25 Mar 2020 21:45:33 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf record: Support synthesizing cgroup events

Synthesize cgroup events by iterating cgroup filesystem directories.
The cgroup event only saves the portion of cgroup path after the mount
point and the cgroup id (which actually is a file handle).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200325124536.2800725-7-namhyung@kernel.org
Link: http://lore.kernel.org/lkml/20200402015249.3800462-1-namhyung@kernel.org
[ Extracted the HAVE_FILE_HANDLE from the followup patch, added missing __maybe_unused ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c        |   5 +-
 tools/perf/util/synthetic-events.c | 122 ++++++++++++++++++++++++++++-
 tools/perf/util/synthetic-events.h |   1 +-
 tools/perf/util/tool.h             |   1 +-
 4 files changed, 129 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c30146..2802de9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1397,6 +1397,11 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
 
+	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
+					     machine);
+	if (err < 0)
+		pr_warning("Couldn't synthesize cgroup events.\n");
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    process_synthesized_event, opts->sample_address,
 					    1);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f72d809..a661b12 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -16,6 +16,7 @@
 #include "util/synthetic-events.h"
 #include "util/target.h"
 #include "util/time-utils.h"
+#include "util/cgroup.h"
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -414,6 +415,127 @@ out:
 	return rc;
 }
 
+#ifdef HAVE_FILE_HANDLE
+static int perf_event__synthesize_cgroup(struct perf_tool *tool,
+					 union perf_event *event,
+					 char *path, size_t mount_len,
+					 perf_event__handler_t process,
+					 struct machine *machine)
+{
+	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
+	size_t path_len = strlen(path) - mount_len + 1;
+	struct {
+		struct file_handle fh;
+		uint64_t cgroup_id;
+	} handle;
+	int mount_id;
+
+	while (path_len % sizeof(u64))
+		path[mount_len + path_len++] = '\0';
+
+	memset(&event->cgroup, 0, event_size);
+
+	event->cgroup.header.type = PERF_RECORD_CGROUP;
+	event->cgroup.header.size = event_size + path_len + machine->id_hdr_size;
+
+	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
+	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
+		pr_debug("stat failed: %s\n", path);
+		return -1;
+	}
+
+	event->cgroup.id = handle.cgroup_id;
+	strncpy(event->cgroup.path, path + mount_len, path_len);
+	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
+
+	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
+		pr_debug("process synth event failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
+					union perf_event *event,
+					char *path, size_t mount_len,
+					perf_event__handler_t process,
+					struct machine *machine)
+{
+	size_t pos = strlen(path);
+	DIR *d;
+	struct dirent *dent;
+	int ret = 0;
+
+	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
+					  process, machine) < 0)
+		return -1;
+
+	d = opendir(path);
+	if (d == NULL) {
+		pr_debug("failed to open directory: %s\n", path);
+		return -1;
+	}
+
+	while ((dent = readdir(d)) != NULL) {
+		if (dent->d_type != DT_DIR)
+			continue;
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		/* any sane path should be less than PATH_MAX */
+		if (strlen(path) + strlen(dent->d_name) + 1 >= PATH_MAX)
+			continue;
+
+		if (path[pos - 1] != '/')
+			strcat(path, "/");
+		strcat(path, dent->d_name);
+
+		ret = perf_event__walk_cgroup_tree(tool, event, path,
+						   mount_len, process, machine);
+		if (ret < 0)
+			break;
+
+		path[pos] = '\0';
+	}
+
+	closedir(d);
+	return ret;
+}
+
+int perf_event__synthesize_cgroups(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine)
+{
+	union perf_event event;
+	char cgrp_root[PATH_MAX];
+	size_t mount_len;  /* length of mount point in the path */
+
+	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
+		pr_debug("cannot find cgroup mount point\n");
+		return -1;
+	}
+
+	mount_len = strlen(cgrp_root);
+	/* make sure the path starts with a slash (after mount point) */
+	strcat(cgrp_root, "/");
+
+	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
+					 process, machine) < 0)
+		return -1;
+
+	return 0;
+}
+#else
+int perf_event__synthesize_cgroups(struct perf_tool *tool __maybe_unused,
+				   perf_event__handler_t process __maybe_unused,
+				   struct machine *machine __maybe_unused)
+{
+	return -1;
+}
+#endif
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index baead0c..e7a3e95 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -45,6 +45,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool, perf_event__handl
 int perf_event__synthesize_mmap_events(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine, bool mmap_data);
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_namespaces(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_cgroups(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
 int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 472ef5e..3fb67bd 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -79,6 +79,7 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	bool		cgroup_events;
 	bool		no_warn;
 	enum show_feature_header show_feat_hdr;
 };
