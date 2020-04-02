Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F7C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB4120757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWzT/3Ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbgDBPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:44:15 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59312 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389468AbgDBPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:44:11 -0400
Received: by mail-pj1-f74.google.com with SMTP id r42so3723777pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fw+yQGCuc66qsKCfiv8tB1DIU00RCb9NXGODIc5CbC0=;
        b=NWzT/3Ny1+zUXCvzI3R7vGQKE/E8rXlsKKJXRSYZ4DY7EKkQexqj89Z1BzUo55D2Hj
         SWzXGebWatU4IJG9S4V1IALkdo9L3idl40/dZ3weAWL90ksEGZHahom1UC+D5pEXjtwi
         mYaJihimyTaMbUiyn5Qsz1ODRCKuIoic1thdCig65OA3vPjP0bLBYyDoIZ7GMQ3J4ZbE
         mIRkxfheMvCA4V/sfH8yHDJcuRbWInsZ6f3Mj05hO5iJk0DD46PUqTq/DSKPf8DECMQc
         mh8bMn0cdW7K6shso/2sPR6o4/WURLOCi/s74FsXJBKzr+fJ6djiskMFv+0dxDtflade
         12Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fw+yQGCuc66qsKCfiv8tB1DIU00RCb9NXGODIc5CbC0=;
        b=obhU9qfl2/Dvfx8VKlc9CSiuDYTaIq0toQRlhrY3n/4D35b88OvrZrvbmejolFmlAX
         /YG53MFXPb/4Xd48/eVXppmD5jMTnc/2MMweeXeW5GPXxGWK1ms/GVJpWrWI7rz3ssao
         AGCBt0ky70bH0/0I3F9aLGocoTI2vBbORVs7we+ujat8ty61Y1+qgK2U7USBCoagidWL
         EJuSYOGbkzuKC0M9rNlU6QG0uToPCovszMMhtLkZ1K4jjCX6A22F7QNRhF6WanCX8n7q
         zVuKpcSQa2kRSt30aPMq0XqNxKbqCP5NQPWT9EpwkDH2VMBdRgDEpbzpLVpOZ4s30vSM
         wrtw==
X-Gm-Message-State: AGi0PubaKgIrH7dO1vZ5X5wz4X0GrEalkj5zKUtwz0f9sg7GVY9AkqPD
        yznahmnccD9IqqptPokqrw25yG9lCE6L
X-Google-Smtp-Source: APiQypJLF1I6D3GBoOVCNri7Odg3ZuWUr4+GSOGWM/qM2w54VfEhfDShRy3SpVbHBinotQq6K/3xeaPOUCuZ
X-Received: by 2002:a65:5641:: with SMTP id m1mr3763686pgs.2.1585842249565;
 Thu, 02 Apr 2020 08:44:09 -0700 (PDT)
Date:   Thu,  2 Apr 2020 08:43:55 -0700
In-Reply-To: <20200402154357.107873-1-irogers@google.com>
Message-Id: <20200402154357.107873-4-irogers@google.com>
Mime-Version: 1.0
References: <20200402154357.107873-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 3/5] perf synthetic-events: save 4kb from 2 stack frames
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

