Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DEC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F334A2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140370;
	bh=ua0/Xeu6GurQOzdM5SIfgdo+6DK8p/3vkB8E55QjqxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tS+sJ74QRE3qbOR4xnydwifOvaeaIQ1q18aq+FjqhH4+geDU2NxYSeJ+8TQuwMkZK
	 /nxn012my8GLHR+kQN93Z4f1+ZizOh5wYtqoyZVU6m7Arkl8RuqBE8o7uI3tfTq/M/
	 62Vyqz37FEfv4pQYMdn7IZ6PWyZPxSzGIo6+XOKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCYMqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:46:08 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35587 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCYMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:46:06 -0400
Received: by mail-pj1-f66.google.com with SMTP id g9so973731pjp.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+GocZn9lpNU64/dt4y4XnOmm7wJpl7RxU9lhG/m7vA=;
        b=cQD3gFhuOPKSVqecd+HNYhAMmZZGgggOFOuLSjdqcQrSguIgvnENL1s1vcBHZzKZQL
         hAs11CErBNdPnTEfZuKRfnezreJ8aYdZQ0v/Pr3qFtEXYifw8O39JEbzQIbmQXwrIfRj
         O0Ksov/TCAmX0YTdI+WUsRpOeL8357oaA4n0yOdqfL3HiVggFlOWmL4f5oHgVXpdp0kl
         RC9/G8uCTUyQg7cIxe5tm9NbjlBphxM5GMsgtNJdn4O7wJ/CUZmuaXKUp5yJ1ZDFMsLh
         WmEHeEuctrORWDWVzSB4YZKnW9xXb9q4zM4VkXmvqlfTHmT35r90noM+SMC37dnZ0b5P
         ydbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8+GocZn9lpNU64/dt4y4XnOmm7wJpl7RxU9lhG/m7vA=;
        b=sbK5r8HyYqAyFJrHLotbcotwL/vr8XKt+PRTaisd/3SKyc/dRw7smcihN9bGj881+U
         guaGH0N0yo2dbwu9ZS1sa1Pct6sisf+4wdSQ3FYeSh2ezjhCnksXY22ZIuJlDtoDIFEr
         b/xsFBlBZgsVHbXp2SJe4fWSjVOUaIDQJFnvXFTjgtZRgEGcy9AbG0/PsxTty+AHYMT2
         MypBdGgD1vBJ6i6MZOYKUkyfSKZBU88hsZJ/HBI5ZQrfy2+0CezsW5xo4gJqmMXVS+39
         S+glvQq4PUX5kbEykgrhCbnmy8Yjo8Ebr2AjvixqSrbMDAsU8RNSbjupcgxmd2z5qyVb
         3zmg==
X-Gm-Message-State: ANhLgQ0Z9GoZTXxTL5QyT6UfGB+L2Sivbk8o4mePtQIhB6zr5rVGNAbd
        MTi5RJ7bFslsI1gl0Sov0finZL3U
X-Google-Smtp-Source: ADFU+vtlHZDwvUrDLo/sJlcyEQ4omrUxlbLQwg1cTzSucijpzRPffBKjmbXXUXDKUcoFwAqHVBt5nQ==
X-Received: by 2002:a17:90a:e649:: with SMTP id ep9mr3419385pjb.161.1585140364923;
        Wed, 25 Mar 2020 05:46:04 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id h15sm18244648pfq.10.2020.03.25.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:46:04 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date:   Wed, 25 Mar 2020 21:45:33 +0900
Message-Id: <20200325124536.2800725-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325124536.2800725-1-namhyung@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize cgroup events by iterating cgroup filesystem directories.
The cgroup event only saves the portion of cgroup path after the mount
point and the cgroup id (which actually is a file handle).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c        |   5 ++
 tools/perf/util/synthetic-events.c | 113 +++++++++++++++++++++++++++++
 tools/perf/util/synthetic-events.h |   1 +
 tools/perf/util/tool.h             |   1 +
 4 files changed, 120 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..2802de9538ff 100644
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
index f72d80999506..24975470ed5c 100644
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
@@ -414,6 +415,118 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	return rc;
 }
 
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
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index baead0cdc381..e7a3e9589738 100644
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
index 472ef5eb4068..3fb67bd31e4a 100644
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
-- 
2.25.1.696.g5e7596f4ac-goog

