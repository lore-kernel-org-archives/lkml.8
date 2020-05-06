Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB3C47259
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E72215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778657;
	bh=EuMiTUhO77Cz6r56et1aEf/RP7touwqt4/F6ZEAoVzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MT+VxY8OTBz5hTU72WTEtuG0HbF29t/FurpBI4kcbT7aEcpbHMEkpc6giDi7SoWCK
	 BFC0GPhRc4yMXBjgfhHL1LG4Kuz1/J3UlSWGHgKWZuQtW9eYulBg5UA+du0B3I1C1P
	 P7Y1dW19thahoHdro4WnWVREFhyI5xLhIvuA48aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgEFPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgEFPYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19E0214D8;
        Wed,  6 May 2020 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778653;
        bh=EuMiTUhO77Cz6r56et1aEf/RP7touwqt4/F6ZEAoVzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZFhFZR1SNDxTJ1RFDy/dw5OH+FYL4YsMWDMJCojpFk+dU2Bbo0ozc1rzAe2sJg/J
         16d9TCkYh3F780QlFz7Q/elPdLkdc/DsGCZNaucIKSMjP5iTswI1v0XLNnHdHnv0fm
         we8NPdB6cDt2A3o6mq9JAksSnFD0gG8lkAWwbkTI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 22/91] perf tools: Move routines that probe for perf API features to separate file
Date:   Wed,  6 May 2020 12:21:25 -0300
Message-Id: <20200506152234.21977-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Trying to disentangle this a bit further, unfortunately it uses
parse_events(), its interesting to have it separated anyway, so do it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c   |   1 +
 tools/perf/arch/x86/util/intel-pt.c |   1 +
 tools/perf/builtin-record.c         |   1 +
 tools/perf/util/Build               |   1 +
 tools/perf/util/auxtrace.c          |   1 +
 tools/perf/util/evlist.c            |   1 +
 tools/perf/util/evlist.h            |   4 -
 tools/perf/util/intel-pt.c          |   1 +
 tools/perf/util/perf_api_probe.c    | 164 ++++++++++++++++++++++++++++
 tools/perf/util/perf_api_probe.h    |  14 +++
 tools/perf/util/record.c            | 155 +-------------------------
 11 files changed, 186 insertions(+), 158 deletions(-)
 create mode 100644 tools/perf/util/perf_api_probe.c
 create mode 100644 tools/perf/util/perf_api_probe.h

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 941f814820b8..b8df8054dd5e 100644
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
index 1643aed8c4c8..6b888963c21c 100644
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
index 2e8011f179f2..bf3a6f7df463 100644
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
index c0cf8dff694e..229abefed59a 100644
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
index 33ad33378a90..ac6e09965a78 100644
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
index 82d9f9bb8975..3f7e7d5f008b 100644
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
index f5bd5c386df1..48622e593972 100644
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
index 4be7634dccf5..30e1ee6d3e40 100644
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
index 000000000000..1337965673d7
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
index 000000000000..706c3c6426e2
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
index 6d3e3df6e2a1..c2c8cce506b4 100644
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
-- 
2.21.1

