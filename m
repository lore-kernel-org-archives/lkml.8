Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27EBC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5B3217BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgDVMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbgDVMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:18:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE058C03C1A8;
        Wed, 22 Apr 2020 05:18:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJw-0007vo-UR; Wed, 22 Apr 2020 14:17:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E1B061C04D7;
        Wed, 22 Apr 2020 14:17:29 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:29 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf synthetic-events: save 4kb from 2 stack frames
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402154357.107873-4-irogers@google.com>
References: <20200402154357.107873-4-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158755784947.28353.14696778467230047692.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     04ed4ccb9c07868bc0cb41f699391332bf62220c
Gitweb:        https://git.kernel.org/tip/04ed4ccb9c07868bc0cb41f699391332bf62220c
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 02 Apr 2020 08:43:55 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:13 -03:00

perf synthetic-events: save 4kb from 2 stack frames

Reuse an existing char buffer to avoid two PATH_MAX sized char buffers.

Reduces stack frame sizes by 4kb.

perf_event__synthesize_mmap_events before 'sub $0x45b8,%rsp' after
'sub $0x35b8,%rsp'.

perf_event__get_comm_ids before 'sub $0x2028,%rsp' after
'sub $0x1028,%rsp'.

The performance impact of this change is negligible.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrey Zhizhikin <andrey.z@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200402154357.107873-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/synthetic-events.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a661b12..9d4aa95 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -71,7 +71,6 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
 static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 				    pid_t *tgid, pid_t *ppid)
 {
-	char filename[PATH_MAX];
 	char bf[4096];
 	int fd;
 	size_t size = 0;
@@ -81,11 +80,11 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
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
 
@@ -281,9 +280,9 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
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
@@ -293,15 +292,15 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
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
 
@@ -309,7 +308,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	t = rdclock();
 
 	while (1) {
-		char bf[BUFSIZ];
 		char prot[5];
 		char execname[PATH_MAX];
 		char anonstr[] = "//anon";
@@ -321,10 +319,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
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
