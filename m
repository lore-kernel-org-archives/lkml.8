Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C0C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E20320735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgEHNIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729387AbgEHNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B9C05BD09;
        Fri,  8 May 2020 06:05:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gs-0007k2-HJ; Fri, 08 May 2020 15:05:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1F7241C0080;
        Fri,  8 May 2020 15:05:07 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:07 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Move routines that probe for perf API
 features to separate file
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894310706.8414.5129111932590526442.tip-bot2@tip-bot2>
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

Commit-ID:     40c7d2460e03b0916c5fcc5edbedae05b4b571fc
Gitweb:        https://git.kernel.org/tip/40c7d2460e03b0916c5fcc5edbedae05b4b571fc
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 05 May 2020 11:49:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:26 -03:00

perf tools: Move routines that probe for perf API features to separate file

Trying to disentangle this a bit further, unfortunately it uses
parse_events(), its interesting to have it separated anyway, so do it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c   |   1 +-
 tools/perf/arch/x86/util/intel-pt.c |   1 +-
 tools/perf/builtin-record.c         |   1 +-
 tools/perf/util/Build               |   1 +-
 tools/perf/util/auxtrace.c          |   1 +-
 tools/perf/util/evlist.c            |   1 +-
 tools/perf/util/evlist.h            |   4 +-
 tools/perf/util/intel-pt.c          |   1 +-
 tools/perf/util/perf_api_probe.c    | 164 +++++++++++++++++++++++++++-
 tools/perf/util/perf_api_probe.h    |  14 ++-
 tools/perf/util/record.c            | 155 +--------------------------
 11 files changed, 186 insertions(+), 158 deletions(-)
 create mode 100644 tools/perf/util/perf_api_probe.c
 create mode 100644 tools/perf/util/perf_api_probe.h

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 941f814..b8df805 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -23,6 +23,7 @@
 #include "../../util/event.h"
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
+#include "../../util/perf_api_probe.h"
 #include "../../util/evsel_config.h"
 #include "../../util/pmu.h"
 #include "../../util/cs-etm.h"
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1643aed..6b88896 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -25,6 +25,7 @@
 #include "../../../util/pmu.h"
 #include "../../../util/debug.h"
 #include "../../../util/auxtrace.h"
+#include "../../../util/perf_api_probe.h"
 #include "../../../util/record.h"
 #include "../../../util/target.h"
 #include "../../../util/tsc.h"
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2e8011f..bf3a6f7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -34,6 +34,7 @@
 #include "util/tsc.h"
 #include "util/parse-branch-options.h"
 #include "util/parse-regs-options.h"
+#include "util/perf_api_probe.h"
 #include "util/llvm-utils.h"
 #include "util/bpf-loader.h"
 #include "util/trigger.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c0cf8df..229abef 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -88,6 +88,7 @@ perf-y += counts.o
 perf-y += stat.o
 perf-y += stat-shadow.o
 perf-y += stat-display.o
+perf-y += perf_api_probe.o
 perf-y += record.o
 perf-y += srcline.o
 perf-y += srccode.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 33ad333..ac6e099 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -33,6 +33,7 @@
 #include "evsel.h"
 #include "evsel_config.h"
 #include "symbol.h"
+#include "util/perf_api_probe.h"
 #include "util/synthetic-events.h"
 #include "thread_map.h"
 #include "asm/bug.h"
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 82d9f9b..3f7e7d5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -23,6 +23,7 @@
 #include "asm/bug.h"
 #include "bpf-event.h"
 #include "util/string2.h"
+#include "util/perf_api_probe.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c3..48622e5 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -173,10 +173,6 @@ void evlist__close(struct evlist *evlist);
 struct callchain_param;
 
 void perf_evlist__set_id_pos(struct evlist *evlist);
-bool perf_can_sample_identifier(void);
-bool perf_can_record_switch_events(void);
-bool perf_can_record_cpu_wide(void);
-bool perf_can_aux_sample(void);
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain);
 int record_opts__config(struct record_opts *opts);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4be7634..30e1ee6 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -33,6 +33,7 @@
 #include "tsc.h"
 #include "intel-pt.h"
 #include "config.h"
+#include "util/perf_api_probe.h"
 #include "util/synthetic-events.h"
 #include "time-utils.h"
 
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
new file mode 100644
index 0000000..1337965
--- /dev/null
+++ b/tools/perf/util/perf_api_probe.c
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "perf-sys.h"
+#include "util/cloexec.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/parse-events.h"
+#include "util/perf_api_probe.h"
+#include <perf/cpumap.h>
+#include <errno.h>
+
+typedef void (*setup_probe_fn_t)(struct evsel *evsel);
+
+static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
+{
+	struct evlist *evlist;
+	struct evsel *evsel;
+	unsigned long flags = perf_event_open_cloexec_flag();
+	int err = -EAGAIN, fd;
+	static pid_t pid = -1;
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	if (parse_events(evlist, str, NULL))
+		goto out_delete;
+
+	evsel = evlist__first(evlist);
+
+	while (1) {
+		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
+		if (fd < 0) {
+			if (pid == -1 && errno == EACCES) {
+				pid = 0;
+				continue;
+			}
+			goto out_delete;
+		}
+		break;
+	}
+	close(fd);
+
+	fn(evsel);
+
+	fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
+	if (fd < 0) {
+		if (errno == EINVAL)
+			err = -EINVAL;
+		goto out_delete;
+	}
+	close(fd);
+	err = 0;
+
+out_delete:
+	evlist__delete(evlist);
+	return err;
+}
+
+static bool perf_probe_api(setup_probe_fn_t fn)
+{
+	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
+	struct perf_cpu_map *cpus;
+	int cpu, ret, i = 0;
+
+	cpus = perf_cpu_map__new(NULL);
+	if (!cpus)
+		return false;
+	cpu = cpus->map[0];
+	perf_cpu_map__put(cpus);
+
+	do {
+		ret = perf_do_probe_api(fn, cpu, try[i++]);
+		if (!ret)
+			return true;
+	} while (ret == -EAGAIN && try[i]);
+
+	return false;
+}
+
+static void perf_probe_sample_identifier(struct evsel *evsel)
+{
+	evsel->core.attr.sample_type |= PERF_SAMPLE_IDENTIFIER;
+}
+
+static void perf_probe_comm_exec(struct evsel *evsel)
+{
+	evsel->core.attr.comm_exec = 1;
+}
+
+static void perf_probe_context_switch(struct evsel *evsel)
+{
+	evsel->core.attr.context_switch = 1;
+}
+
+bool perf_can_sample_identifier(void)
+{
+	return perf_probe_api(perf_probe_sample_identifier);
+}
+
+bool perf_can_comm_exec(void)
+{
+	return perf_probe_api(perf_probe_comm_exec);
+}
+
+bool perf_can_record_switch_events(void)
+{
+	return perf_probe_api(perf_probe_context_switch);
+}
+
+bool perf_can_record_cpu_wide(void)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_CPU_CLOCK,
+		.exclude_kernel = 1,
+	};
+	struct perf_cpu_map *cpus;
+	int cpu, fd;
+
+	cpus = perf_cpu_map__new(NULL);
+	if (!cpus)
+		return false;
+	cpu = cpus->map[0];
+	perf_cpu_map__put(cpus);
+
+	fd = sys_perf_event_open(&attr, -1, cpu, -1, 0);
+	if (fd < 0)
+		return false;
+	close(fd);
+
+	return true;
+}
+
+/*
+ * Architectures are expected to know if AUX area sampling is supported by the
+ * hardware. Here we check for kernel support.
+ */
+bool perf_can_aux_sample(void)
+{
+	struct perf_event_attr attr = {
+		.size = sizeof(struct perf_event_attr),
+		.exclude_kernel = 1,
+		/*
+		 * Non-zero value causes the kernel to calculate the effective
+		 * attribute size up to that byte.
+		 */
+		.aux_sample_size = 1,
+	};
+	int fd;
+
+	fd = sys_perf_event_open(&attr, -1, 0, -1, 0);
+	/*
+	 * If the kernel attribute is big enough to contain aux_sample_size
+	 * then we assume that it is supported. We are relying on the kernel to
+	 * validate the attribute size before anything else that could be wrong.
+	 */
+	if (fd < 0 && errno == E2BIG)
+		return false;
+	if (fd >= 0)
+		close(fd);
+
+	return true;
+}
diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
new file mode 100644
index 0000000..706c3c6
--- /dev/null
+++ b/tools/perf/util/perf_api_probe.h
@@ -0,0 +1,14 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_API_PROBE_H
+#define __PERF_API_PROBE_H
+
+#include <stdbool.h>
+
+bool perf_can_aux_sample(void);
+bool perf_can_comm_exec(void);
+bool perf_can_record_cpu_wide(void);
+bool perf_can_record_switch_events(void);
+bool perf_can_sample_identifier(void);
+
+#endif // __PERF_API_PROBE_H
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 6d3e3df..c2c8cce 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -10,163 +10,10 @@
 #include <subcmd/parse-options.h>
 #include <perf/cpumap.h>
 #include "cloexec.h"
+#include "util/perf_api_probe.h"
 #include "record.h"
 #include "../perf-sys.h"
 
-typedef void (*setup_probe_fn_t)(struct evsel *evsel);
-
-static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
-{
-	struct evlist *evlist;
-	struct evsel *evsel;
-	unsigned long flags = perf_event_open_cloexec_flag();
-	int err = -EAGAIN, fd;
-	static pid_t pid = -1;
-
-	evlist = evlist__new();
-	if (!evlist)
-		return -ENOMEM;
-
-	if (parse_events(evlist, str, NULL))
-		goto out_delete;
-
-	evsel = evlist__first(evlist);
-
-	while (1) {
-		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
-		if (fd < 0) {
-			if (pid == -1 && errno == EACCES) {
-				pid = 0;
-				continue;
-			}
-			goto out_delete;
-		}
-		break;
-	}
-	close(fd);
-
-	fn(evsel);
-
-	fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
-	if (fd < 0) {
-		if (errno == EINVAL)
-			err = -EINVAL;
-		goto out_delete;
-	}
-	close(fd);
-	err = 0;
-
-out_delete:
-	evlist__delete(evlist);
-	return err;
-}
-
-static bool perf_probe_api(setup_probe_fn_t fn)
-{
-	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
-	struct perf_cpu_map *cpus;
-	int cpu, ret, i = 0;
-
-	cpus = perf_cpu_map__new(NULL);
-	if (!cpus)
-		return false;
-	cpu = cpus->map[0];
-	perf_cpu_map__put(cpus);
-
-	do {
-		ret = perf_do_probe_api(fn, cpu, try[i++]);
-		if (!ret)
-			return true;
-	} while (ret == -EAGAIN && try[i]);
-
-	return false;
-}
-
-static void perf_probe_sample_identifier(struct evsel *evsel)
-{
-	evsel->core.attr.sample_type |= PERF_SAMPLE_IDENTIFIER;
-}
-
-static void perf_probe_comm_exec(struct evsel *evsel)
-{
-	evsel->core.attr.comm_exec = 1;
-}
-
-static void perf_probe_context_switch(struct evsel *evsel)
-{
-	evsel->core.attr.context_switch = 1;
-}
-
-bool perf_can_sample_identifier(void)
-{
-	return perf_probe_api(perf_probe_sample_identifier);
-}
-
-static bool perf_can_comm_exec(void)
-{
-	return perf_probe_api(perf_probe_comm_exec);
-}
-
-bool perf_can_record_switch_events(void)
-{
-	return perf_probe_api(perf_probe_context_switch);
-}
-
-bool perf_can_record_cpu_wide(void)
-{
-	struct perf_event_attr attr = {
-		.type = PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_CPU_CLOCK,
-		.exclude_kernel = 1,
-	};
-	struct perf_cpu_map *cpus;
-	int cpu, fd;
-
-	cpus = perf_cpu_map__new(NULL);
-	if (!cpus)
-		return false;
-	cpu = cpus->map[0];
-	perf_cpu_map__put(cpus);
-
-	fd = sys_perf_event_open(&attr, -1, cpu, -1, 0);
-	if (fd < 0)
-		return false;
-	close(fd);
-
-	return true;
-}
-
-/*
- * Architectures are expected to know if AUX area sampling is supported by the
- * hardware. Here we check for kernel support.
- */
-bool perf_can_aux_sample(void)
-{
-	struct perf_event_attr attr = {
-		.size = sizeof(struct perf_event_attr),
-		.exclude_kernel = 1,
-		/*
-		 * Non-zero value causes the kernel to calculate the effective
-		 * attribute size up to that byte.
-		 */
-		.aux_sample_size = 1,
-	};
-	int fd;
-
-	fd = sys_perf_event_open(&attr, -1, 0, -1, 0);
-	/*
-	 * If the kernel attribute is big enough to contain aux_sample_size
-	 * then we assume that it is supported. We are relying on the kernel to
-	 * validate the attribute size before anything else that could be wrong.
-	 */
-	if (fd < 0 && errno == E2BIG)
-		return false;
-	if (fd >= 0)
-		close(fd);
-
-	return true;
-}
-
 /*
  * perf_evsel__config_leader_sampling() uses special rules for leader sampling.
  * However, if the leader is an AUX area event, then assume the event to sample
