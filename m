Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F001C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035152173E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596620131;
	bh=LBs2XltRMp7zbBi1MpqTu20E2fbMFf3z3TnoUOVnr/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znKpfzi8nsDWid8qpsnRj9HXYo9Ez0SpTa4k6HzJZ3ZeDYmbYqMHs3d2l4kQWMIjF
	 R9tyfYSYmGWf60GJzJYS6sJKHVoQ3mLpmpD0M6pMx1LQj6jXAnZDGs3qBD49qUYacZ
	 g5OPXs1Y7Kc6Pt9sDlVRPOggqWnPJ323LSvK/ors=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHEJf3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:35:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728377AbgHEJfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:35:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-KysbiRRcO3CKnUNYoGcOoQ-1; Wed, 05 Aug 2020 05:34:56 -0400
X-MC-Unique: KysbiRRcO3CKnUNYoGcOoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 567758015CE;
        Wed,  5 Aug 2020 09:34:54 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A8B7193A;
        Wed,  5 Aug 2020 09:34:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH v2 1/7] perf tools: Move parse_clockid into clockid object
Date:   Wed,  5 Aug 2020 11:34:38 +0200
Message-Id: <20200805093444.314999-2-jolsa@kernel.org>
In-Reply-To: <20200805093444.314999-1-jolsa@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move parse_clockid and all needed clcckid related stuff
into clockid object. We are going to add clockid_name
function in following change, so it's better it's placed
in separated object and not in builtin-record.c.

No functional change is intended.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c |  98 +-------------------------------
 tools/perf/util/Build       |   1 +
 tools/perf/util/clockid.c   | 108 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/clockid.h   |   9 +++
 4 files changed, 119 insertions(+), 97 deletions(-)
 create mode 100644 tools/perf/util/clockid.c
 create mode 100644 tools/perf/util/clockid.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b6bdccd875bc..eb42d2d9d16b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -46,6 +46,7 @@
 #include "util/bpf-event.h"
 #include "util/util.h"
 #include "util/pfm.h"
+#include "util/clockid.h"
 #include "asm/bug.h"
 #include "perf.h"
 
@@ -2078,103 +2079,6 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-struct clockid_map {
-	const char *name;
-	int clockid;
-};
-
-#define CLOCKID_MAP(n, c)	\
-	{ .name = n, .clockid = (c), }
-
-#define CLOCKID_END	{ .name = NULL, }
-
-
-/*
- * Add the missing ones, we need to build on many distros...
- */
-#ifndef CLOCK_MONOTONIC_RAW
-#define CLOCK_MONOTONIC_RAW 4
-#endif
-#ifndef CLOCK_BOOTTIME
-#define CLOCK_BOOTTIME 7
-#endif
-#ifndef CLOCK_TAI
-#define CLOCK_TAI 11
-#endif
-
-static const struct clockid_map clockids[] = {
-	/* available for all events, NMI safe */
-	CLOCKID_MAP("monotonic", CLOCK_MONOTONIC),
-	CLOCKID_MAP("monotonic_raw", CLOCK_MONOTONIC_RAW),
-
-	/* available for some events */
-	CLOCKID_MAP("realtime", CLOCK_REALTIME),
-	CLOCKID_MAP("boottime", CLOCK_BOOTTIME),
-	CLOCKID_MAP("tai", CLOCK_TAI),
-
-	/* available for the lazy */
-	CLOCKID_MAP("mono", CLOCK_MONOTONIC),
-	CLOCKID_MAP("raw", CLOCK_MONOTONIC_RAW),
-	CLOCKID_MAP("real", CLOCK_REALTIME),
-	CLOCKID_MAP("boot", CLOCK_BOOTTIME),
-
-	CLOCKID_END,
-};
-
-static int get_clockid_res(clockid_t clk_id, u64 *res_ns)
-{
-	struct timespec res;
-
-	*res_ns = 0;
-	if (!clock_getres(clk_id, &res))
-		*res_ns = res.tv_nsec + res.tv_sec * NSEC_PER_SEC;
-	else
-		pr_warning("WARNING: Failed to determine specified clock resolution.\n");
-
-	return 0;
-}
-
-static int parse_clockid(const struct option *opt, const char *str, int unset)
-{
-	struct record_opts *opts = (struct record_opts *)opt->value;
-	const struct clockid_map *cm;
-	const char *ostr = str;
-
-	if (unset) {
-		opts->use_clockid = 0;
-		return 0;
-	}
-
-	/* no arg passed */
-	if (!str)
-		return 0;
-
-	/* no setting it twice */
-	if (opts->use_clockid)
-		return -1;
-
-	opts->use_clockid = true;
-
-	/* if its a number, we're done */
-	if (sscanf(str, "%d", &opts->clockid) == 1)
-		return get_clockid_res(opts->clockid, &opts->clockid_res_ns);
-
-	/* allow a "CLOCK_" prefix to the name */
-	if (!strncasecmp(str, "CLOCK_", 6))
-		str += 6;
-
-	for (cm = clockids; cm->name; cm++) {
-		if (!strcasecmp(str, cm->name)) {
-			opts->clockid = cm->clockid;
-			return get_clockid_res(opts->clockid,
-					       &opts->clockid_res_ns);
-		}
-	}
-
-	opts->use_clockid = false;
-	ui__warning("unknown clockid %s, check man page\n", ostr);
-	return -1;
-}
 
 static int record__parse_affinity(const struct option *opt, const char *str, int unset)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 380e6a9f564d..494626e303f5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -128,6 +128,7 @@ perf-y += expr-bison.o
 perf-y += expr.o
 perf-y += branch.o
 perf-y += mem2node.o
+perf-y += clockid.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
diff --git a/tools/perf/util/clockid.c b/tools/perf/util/clockid.c
new file mode 100644
index 000000000000..b7a08606dc3e
--- /dev/null
+++ b/tools/perf/util/clockid.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <subcmd/parse-options.h>
+#include <stdio.h>
+#include <time.h>
+#include <strings.h>
+#include <linux/time64.h>
+#include "debug.h"
+#include "clockid.h"
+#include "record.h"
+
+struct clockid_map {
+	const char *name;
+	int clockid;
+};
+
+#define CLOCKID_MAP(n, c)	\
+	{ .name = n, .clockid = (c), }
+
+#define CLOCKID_END	{ .name = NULL, }
+
+
+/*
+ * Add the missing ones, we need to build on many distros...
+ */
+#ifndef CLOCK_MONOTONIC_RAW
+#define CLOCK_MONOTONIC_RAW 4
+#endif
+#ifndef CLOCK_BOOTTIME
+#define CLOCK_BOOTTIME 7
+#endif
+#ifndef CLOCK_TAI
+#define CLOCK_TAI 11
+#endif
+
+static const struct clockid_map clockids[] = {
+	/* available for all events, NMI safe */
+	CLOCKID_MAP("monotonic", CLOCK_MONOTONIC),
+	CLOCKID_MAP("monotonic_raw", CLOCK_MONOTONIC_RAW),
+
+	/* available for some events */
+	CLOCKID_MAP("realtime", CLOCK_REALTIME),
+	CLOCKID_MAP("boottime", CLOCK_BOOTTIME),
+	CLOCKID_MAP("tai", CLOCK_TAI),
+
+	/* available for the lazy */
+	CLOCKID_MAP("mono", CLOCK_MONOTONIC),
+	CLOCKID_MAP("raw", CLOCK_MONOTONIC_RAW),
+	CLOCKID_MAP("real", CLOCK_REALTIME),
+	CLOCKID_MAP("boot", CLOCK_BOOTTIME),
+
+	CLOCKID_END,
+};
+
+static int get_clockid_res(clockid_t clk_id, u64 *res_ns)
+{
+	struct timespec res;
+
+	*res_ns = 0;
+	if (!clock_getres(clk_id, &res))
+		*res_ns = res.tv_nsec + res.tv_sec * NSEC_PER_SEC;
+	else
+		pr_warning("WARNING: Failed to determine specified clock resolution.\n");
+
+	return 0;
+}
+
+int parse_clockid(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+	const struct clockid_map *cm;
+	const char *ostr = str;
+
+	if (unset) {
+		opts->use_clockid = 0;
+		return 0;
+	}
+
+	/* no arg passed */
+	if (!str)
+		return 0;
+
+	/* no setting it twice */
+	if (opts->use_clockid)
+		return -1;
+
+	opts->use_clockid = true;
+
+	/* if its a number, we're done */
+	if (sscanf(str, "%d", &opts->clockid) == 1)
+		return get_clockid_res(opts->clockid, &opts->clockid_res_ns);
+
+	/* allow a "CLOCK_" prefix to the name */
+	if (!strncasecmp(str, "CLOCK_", 6))
+		str += 6;
+
+	for (cm = clockids; cm->name; cm++) {
+		if (!strcasecmp(str, cm->name)) {
+			opts->clockid = cm->clockid;
+			return get_clockid_res(opts->clockid,
+					       &opts->clockid_res_ns);
+		}
+	}
+
+	opts->use_clockid = false;
+	ui__warning("unknown clockid %s, check man page\n", ostr);
+	return -1;
+}
diff --git a/tools/perf/util/clockid.h b/tools/perf/util/clockid.h
new file mode 100644
index 000000000000..8e567b3ebbbd
--- /dev/null
+++ b/tools/perf/util/clockid.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PERF_CLOCKID_H
+#define __PERF_CLOCKID_H
+
+struct option;
+int parse_clockid(const struct option *opt, const char *str, int unset);
+
+#endif
-- 
2.25.4

