Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB4C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6413249C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgEHNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730343AbgEHNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE42C05BD0C;
        Fri,  8 May 2020 06:04:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gL-0007Cx-Ni; Fri, 08 May 2020 15:04:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E29E91C04CD;
        Fri,  8 May 2020 15:04:45 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__fallback() to
 evsel__fallback()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308584.8414.7577772122114599634.tip-bot2@tip-bot2>
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

Commit-ID:     ae4308927e488435073a6aaf601a842ff7e5738f
Gitweb:        https://git.kernel.org/tip/ae4308927e488435073a6aaf601a842ff7e5738f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 30 Apr 2020 11:46:15 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename perf_evsel__fallback() to evsel__fallback()

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-stat.c   | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/util/cloexec.c   | 2 +-
 tools/perf/util/evsel.c     | 3 +--
 tools/perf/util/evsel.h     | 3 +--
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ab303c4..46aaa6b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -845,7 +845,7 @@ static int record__open(struct record *rec)
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
-			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e3629ca..92a59f0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -466,7 +466,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if ((counter->leader != counter) ||
 		    !(counter->leader->core.nr_members > 1))
 			return COUNTER_SKIP;
-	} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+	} else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4403a76..d5bfffe 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1045,7 +1045,7 @@ try_again:
 			    perf_top_overwrite_fallback(top, counter))
 				goto try_again;
 
-			if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index a12872f..6b3988a 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -28,7 +28,7 @@ int __weak sched_getcpu(void)
 
 static int perf_flag_probe(void)
 {
-	/* use 'safest' configuration as used in perf_evsel__fallback() */
+	/* use 'safest' configuration as used in evsel__fallback() */
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_CPU_CLOCK,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 909e993..a75bcb9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2382,8 +2382,7 @@ u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *n
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
 
-bool perf_evsel__fallback(struct evsel *evsel, int err,
-			  char *msg, size_t msgsize)
+bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 {
 	int paranoid;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 101cfff..783246b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -350,8 +350,7 @@ static inline bool evsel__is_clock(struct evsel *evsel)
 	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
-bool perf_evsel__fallback(struct evsel *evsel, int err,
-			  char *msg, size_t msgsize);
+bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
 int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size);
 
