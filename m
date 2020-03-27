Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C69C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1D206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVOvsRxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgC0R3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:29:21 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56845 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgC0R3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:29:20 -0400
Received: by mail-pl1-f202.google.com with SMTP id ba5so7395180plb.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nYM21RQKMWKnZIsx81qxWw5mST50/xX7RSJ9IL1/IfE=;
        b=GVOvsRxikbZ6W0E22qgqj80nhVJO2S4/gc8abgRK0hCAKCysjF/dPAqwlTCE/AcStD
         zLgSpbd4r1GrAbQ1D/cq+dl0dlVZMO0MVeUMXa7soKYSP3TL43BeWdhjTr6egsLaf9bt
         wkMy/7haKhW+Fa2axLvFo8fIFxx2GLKbFAthnC4p0J4yIvoZ1AhawRvp7dfbAuj//CaB
         n9gnjP5yvQOYB1SEZ6e7i3VlvHdWzfMeZUNNskJ+sIcjGAboRids+qT84Y8S1px3N/2T
         b0mbvUbXG/BZIF6jKG6rvVjHR0XWdOD9TUu0VYPh6wp6T0elxxpb8KXY4/wNhKXaLwc3
         yFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nYM21RQKMWKnZIsx81qxWw5mST50/xX7RSJ9IL1/IfE=;
        b=HU3zPEjwwr0ZZpdZW/iciTg/obAnqC51AdMZsVZhnAJsUZA3fuJHifQ+jg0+o6e9Uo
         /GHKGDM66MWlgt6RlCVcukVTIiHNAfDskfVgtXThFl/Ypkqwc9FEjHImq5+ibzg8CB6N
         UvApXUjsFMPWI8mtQ+NngOoijiJkA0uega1rVdrKhaeLl2WYdd/x2zhOT6wJ07pzxQiZ
         qMVNLdUILf/HTB8C4zpGfbnE4P57b9BJhL11NY5lS+IXGBDvG3jM+cphNke8sz1bhndr
         /BgbtE1OAPLdiYHcYSEc76cl/WeteJ41dnSh+hdkuQwDV9LgauYKRfJdOO94efxYzNuY
         Wixw==
X-Gm-Message-State: ANhLgQ3UOh9FcDgox4BkVsB3n0HherKWvi5W8LQeGEoRunGhCCUvarke
        Lrmjvif5mMesFYagOWx0O73BCC3YJ9Kd
X-Google-Smtp-Source: ADFU+vt448Oh08eoCcuE9TgJEkx1c6psomK0Lndojb9UeUMgyEL16VSjzO1etMw1f3mWs7sW2kT3fBZWnDCD
X-Received: by 2002:a63:5c1c:: with SMTP id q28mr344900pgb.125.1585330157920;
 Fri, 27 Mar 2020 10:29:17 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:29:14 -0700
Message-Id: <20200327172914.28603-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] perf synthetic-events: save 4kb from 2 stack frames
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
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
2.25.1.696.g5e7596f4ac-goog

