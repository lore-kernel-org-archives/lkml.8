Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11099C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D893420842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nq6MKW8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbgDAXkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:40:36 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:55791 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgDAXke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:40:34 -0400
Received: by mail-ua1-f74.google.com with SMTP id u3so508097uau.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fw+yQGCuc66qsKCfiv8tB1DIU00RCb9NXGODIc5CbC0=;
        b=nq6MKW8vjnHoYBrrSdgrb6aBTxh5KddIzu2+cqAx2OoMKkLD+wRnUXxzXIQimi/+a6
         4mJoy8SbmZZ3TsRLZttKMCW5dr36evrm1pVnAOpHUUQbKcV74xvQH1HWrYJ/kooFxPNg
         PY8MPRvTYRDUutFZYQMT9CZrwpeS+Xq23fWt8D/yXCNr0jcM186DzC4tHon6PbCECHAa
         31Jj8Ft/k0174vHBzQRTgF8sJj9sppQBujsrtc47DqepxZRJ3hv0cCxg/ytP5KeqXQzj
         jE9spyDT41erJsPEr0AW957Bm3biGat/1lzMTOxQg7ZtgUK3isnD8LvUHQVj+NkfKUMe
         VPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fw+yQGCuc66qsKCfiv8tB1DIU00RCb9NXGODIc5CbC0=;
        b=MdkSTNwdqo5cMsRaFGw80uUHvpjbWLp8GWPJNtpLXBPYTsofNQ/4fWSEWnywLHQsKW
         o/Wy7rqUXNhGy4yGtXBOVQXhpqbs/titY/jGPnwRR+kf6QLHlR10dqYGwhSCLh0iC5Al
         j8HZT2g9byLnSbRtxKJsjNwCVvWTyL1YSHst4aCBweEYKpCke1jHNDRwiPumAKtkwogr
         xh3SCHMuqkZ3gxeE2DnJ3jTwq5wUSFOxPAEIqR5V5h1yG4knUluo/v92whcG/Nr9E017
         eMpEMX2UPZykHFQusYWOAT2SwAXWsEl+f2TowiGlP1AdPrI4YavHV1szzE5NHrXoqZCN
         3u/A==
X-Gm-Message-State: AGi0PuYByQl+UZgv9L5d+meriLtkzWPQc/ZpjFJTB/nCr8T6HJ5MggGw
        MLV+GPL+WqciQqZtvN9cM1tVYPw/8MdC
X-Google-Smtp-Source: APiQypKQvIHLrjwvEpYASJdHdxgbmPDO3zEzH/O+p7qQIf12N1bBJDDBy1z77NKJwFa4iDlbqyR7DzlT8sXH
X-Received: by 2002:a67:7f8a:: with SMTP id a132mr309716vsd.147.1585784432486;
 Wed, 01 Apr 2020 16:40:32 -0700 (PDT)
Date:   Wed,  1 Apr 2020 16:39:43 -0700
In-Reply-To: <20200401233945.133550-1-irogers@google.com>
Message-Id: <20200401233945.133550-4-irogers@google.com>
Mime-Version: 1.0
References: <20200401233945.133550-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 3/5] perf synthetic-events: save 4kb from 2 stack frames
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

Reuse an existing char buffer to avoid two PATH_MAX sized char buffers.
Reduces stack frame sizes by 4kb.

perf_event__synthesize_mmap_events before 'sub $0x45b8,%rsp' after
'sub $0x35b8,%rsp'.

perf_event__get_comm_ids before 'sub $0x2028,%rsp' after
'sub $0x1028,%rsp'.

The performance impact of this change is negligible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3f28af39f9c6..1f3d8d4bb879 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -70,7 +70,6 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
 static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 				    pid_t *tgid, pid_t *ppid)
 {
-	char filename[PATH_MAX];
 	char bf[4096];
 	int fd;
 	size_t size = 0;
@@ -80,11 +79,11 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	*tgid = -1;
 	*ppid = -1;
 
-	snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
+	snprintf(bf, sizeof(bf), "/proc/%d/status", pid);
 
-	fd = open(filename, O_RDONLY);
+	fd = open(bf, O_RDONLY);
 	if (fd < 0) {
-		pr_debug("couldn't open %s\n", filename);
+		pr_debug("couldn't open %s\n", bf);
 		return -1;
 	}
 
@@ -280,9 +279,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       struct machine *machine,
 				       bool mmap_data)
 {
-	char filename[PATH_MAX];
 	FILE *fp;
 	unsigned long long t;
+	char bf[BUFSIZ];
 	bool truncation = false;
 	unsigned long long timeout = proc_map_timeout * 1000000ULL;
 	int rc = 0;
@@ -292,15 +291,15 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	if (machine__is_default_guest(machine))
 		return 0;
 
-	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
-		 machine->root_dir, pid, pid);
+	snprintf(bf, sizeof(bf), "%s/proc/%d/task/%d/maps",
+		machine->root_dir, pid, pid);
 
-	fp = fopen(filename, "r");
+	fp = fopen(bf, "r");
 	if (fp == NULL) {
 		/*
 		 * We raced with a task exiting - just return:
 		 */
-		pr_debug("couldn't open %s\n", filename);
+		pr_debug("couldn't open %s\n", bf);
 		return -1;
 	}
 
@@ -308,7 +307,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	t = rdclock();
 
 	while (1) {
-		char bf[BUFSIZ];
 		char prot[5];
 		char execname[PATH_MAX];
 		char anonstr[] = "//anon";
@@ -320,10 +318,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			break;
 
 		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
+			pr_warning("Reading %s/proc/%d/task/%d/maps time out. "
 				   "You may want to increase "
 				   "the time limit by --proc-map-timeout\n",
-				   filename);
+				   machine->root_dir, pid, pid);
 			truncation = true;
 			goto out;
 		}
-- 
2.26.0.rc2.310.g2932bb562d-goog

