Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110DCC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FC120707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598538692;
	bh=C0BXsosC1fUu2OJxxiogSZtfYlNckVnVLpBCE4XgaRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6YpSkVW/FV+8LBBuAUn3WbYprz9nVM+A+JNwDqjEsjk6tH+71h73d35Qn8+Sv7rX
	 iu2oOfUoTKQn4y1JZlJZiT21Lwkbw2Eiy3WQTsqskkVhJrG8bLHd8aqPUvn+t+dYk4
	 47GSTA45R5wQ/vPtVUEXkcYDoSL7bxalcjMtzZAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgH0Ob3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:31:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727864AbgH0OXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:23:55 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-8yj2RV4cM1isgEhjcUsosg-1; Thu, 27 Aug 2020 09:48:37 -0400
X-MC-Unique: 8yj2RV4cM1isgEhjcUsosg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B4AF10506E1;
        Thu, 27 Aug 2020 13:48:36 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DF32702E7;
        Thu, 27 Aug 2020 13:48:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf tools: Call test_attr__open directly
Date:   Thu, 27 Aug 2020 15:48:30 +0200
Message-Id: <20200827134830.126721-2-jolsa@kernel.org>
In-Reply-To: <20200827134830.126721-1-jolsa@kernel.org>
References: <20200827134830.126721-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no longer need to have test_attr__open inside
sys_perf_event_open call, because both record and stat
call evsel__open_cpu, so we can call it directly from
there and not polute perf-sys.h header.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/perf-sys.h   | 22 ++--------------------
 tools/perf/tests/attr.c |  2 +-
 tools/perf/util/evsel.c |  5 +++++
 tools/perf/util/util.h  |  6 ++++++
 4 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index 15e458e150bd..7a2264e1e4e1 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -9,31 +9,13 @@
 
 struct perf_event_attr;
 
-extern bool test_attr__enabled;
-void test_attr__ready(void);
-void test_attr__init(void);
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
-		     int fd, int group_fd, unsigned long flags);
-
-#ifndef HAVE_ATTR_TEST
-#define HAVE_ATTR_TEST 1
-#endif
-
 static inline int
 sys_perf_event_open(struct perf_event_attr *attr,
 		      pid_t pid, int cpu, int group_fd,
 		      unsigned long flags)
 {
-	int fd;
-
-	fd = syscall(__NR_perf_event_open, attr, pid, cpu,
-		     group_fd, flags);
-
-#if HAVE_ATTR_TEST
-	if (unlikely(test_attr__enabled))
-		test_attr__open(attr, pid, cpu, fd, group_fd, flags);
-#endif
-	return fd;
+	return syscall(__NR_perf_event_open, attr, pid, cpu,
+		       group_fd, flags);
 }
 
 #endif /* _PERF_SYS_H */
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index a9599ab8c471..ec972e0892ab 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -30,9 +30,9 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include "../perf-sys.h"
 #include <subcmd/exec-cmd.h>
 #include "event.h"
+#include "util.h"
 #include "tests.h"
 
 #define ENV "PERF_TEST_ATTR"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fd865002cbbd..6f0e23105cf8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1680,6 +1680,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			FD(evsel, cpu, thread) = fd;
 
+			if (unlikely(test_attr__enabled)) {
+				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
+						fd, group_fd, flags);
+			}
+
 			if (fd < 0) {
 				err = -errno;
 
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f486fdd3a538..ad737052e597 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -62,4 +62,10 @@ char *perf_exe(char *buf, int len);
 #endif
 #endif
 
+extern bool test_attr__enabled;
+void test_attr__ready(void);
+void test_attr__init(void);
+struct perf_event_attr;
+void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+		     int fd, int group_fd, unsigned long flags);
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.26.2

