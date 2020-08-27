Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB24AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E896207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ahin3CTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH0TcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:32:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbgH0TcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598556733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/9xAmTgJVfsiCYeKazNzgThAXMURwu5yzaqgwbV0E6Y=;
        b=Ahin3CTi5mDpj5isbXg+RJhVJR0LPYWeolvwIfIRNGDvvbxdOTm6XMsfQD+c5DLA9A2AZd
        grd4Z2Aw8eT3A/OKVM6/sQW7fs21XdrG+S+bcvJVUjhHVEq3DYNCQ77/d8+9CwYGGOMziL
        7AvO7MyxtULec7jwMNp4hsIVGWmERe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-JYC_s1ssP6ue45qGYdp3KA-1; Thu, 27 Aug 2020 15:32:08 -0400
X-MC-Unique: JYC_s1ssP6ue45qGYdp3KA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 488FA807337;
        Thu, 27 Aug 2020 19:32:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.67])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26B075D9E8;
        Thu, 27 Aug 2020 19:32:02 +0000 (UTC)
Date:   Thu, 27 Aug 2020 21:32:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHv2] perf tools: Call test_attr__open directly
Message-ID: <20200827193201.GB127372@krava>
References: <20200827134830.126721-1-jolsa@kernel.org>
 <20200827134830.126721-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827134830.126721-2-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nack.. forgot python header change :-\ v2 attached

thanks,
jirka


---
There's no longer need to have test_attr__open inside
sys_perf_event_open call, because both record and stat
call evsel__open_cpu, so we can call it directly from
there and not polute perf-sys.h header.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/perf-sys.h    | 22 ++--------------------
 tools/perf/tests/attr.c  |  2 +-
 tools/perf/util/evsel.c  |  5 +++++
 tools/perf/util/python.c |  2 +-
 tools/perf/util/util.h   |  6 ++++++
 5 files changed, 15 insertions(+), 22 deletions(-)

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
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 75a9b1d62bba..74f85948d101 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,7 +17,7 @@
 #include "mmap.h"
 #include "util/env.h"
 #include <internal/lib.h>
-#include "../perf-sys.h"
+#include "util.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
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

