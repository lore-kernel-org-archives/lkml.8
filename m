Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EFDC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDDF20732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSa6hTuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgCURhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 13:37:15 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47560 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgCURhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 13:37:15 -0400
Received: by mail-pf1-f202.google.com with SMTP id h191so7387346pfe.14
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zu/ko19fJEk23AdhKpVKxqyVrywVf5s+LZW2dHQxgwo=;
        b=oSa6hTuhGeyvB3LzN6n2WmpWTgkpR6yuhl2R9IXaXngXuc0zDFqQb3fpqDjh5Aq2iv
         q5Qv7uzezEwUXxlyQbGsdJEV6PkW3OGml6U6kk55lpn4LFbV5r7WmCWBhBEWDiy+SXER
         l98x+P8GZ5kJNfsoSPiLvsLZ49T7OJ85s+aZUewSvQbWH6rEJvpYAgC+XpQ34Hq3LFIJ
         tArZFOJX6wm9ujGuPntEf7l2n9jkLQk5SOzaX9ppIpS7BMSvhftrL9TaytItW2UGgNoR
         0ZuTUdfBFl7hRizfvX8U5TMlo06+XI4Z/CdevKh/cnxsDwmqv8E8iEbuzZ+9GXO9ccX1
         fGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zu/ko19fJEk23AdhKpVKxqyVrywVf5s+LZW2dHQxgwo=;
        b=CfZcNmBJYmzeF8rII9Q9TYwMNVj1JCXuqHqJdM1ALixDV+nFI+/MZt9PzVwGX4q9xa
         jC9keb5hq9LIpTvK6xvWQYW+q/tFVHsTVfVLYj5CgtQCDMgE2nnz1fNREbFjJNrsakh6
         GdyPsqlODcMAn+N+82ZsXnBvY7eJfc7ZICGyCnecR3VhXBhJE77JmhpfzhiXpTG4smnq
         GDvMrHzi0TB+R732ao+vuMaXBZ1ivsyY/ECD2Otd7d6ATGCSekV46+9EygJdF1UziDY8
         GPwDMNF2x2qvnTIf90AnkQaaSJ96mDrf1erdF4SJbF3YZ3aflhpCx8rU/jI71NByYN/9
         8XeA==
X-Gm-Message-State: ANhLgQ2UwwA2kcNyGErCeqA2bb2lID4o1WCQ4Yh9QDP8Ge43Pubv2CXJ
        gWb9MFjImmDyoh3EmeRi8obCVk/n9Dkv
X-Google-Smtp-Source: ADFU+vsgySIbS/6+H9RR7Eph/+CPM2208gC3IwDF9z7V7zyHOM8601MvFUQ1r9EKYAlDyrQNxwIy1+6st69r
X-Received: by 2002:a17:90a:cf95:: with SMTP id i21mr14642507pju.97.1584812234644;
 Sat, 21 Mar 2020 10:37:14 -0700 (PDT)
Date:   Sat, 21 Mar 2020 10:37:10 -0700
Message-Id: <20200321173710.127770-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2] perf test x86: address multiplexing in rdpmc test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counters may be being used for pinned or other events which inhibit the
instruction counter in the test from being scheduled - time_enabled > 0
but time_running == 0. This causes the test to fail with division by 0.
Make time_running an out parameter of mmap_read_self and add a sleep loop
to ensure that the counter is running before computing the delta.

v2. Address review feedback from Peter Zijlstra.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/rdpmc.c | 57 +++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 1ea916656a2d..64145d4e3d4d 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -34,20 +34,33 @@ static u64 rdtsc(void)
 	return low | ((u64)high) << 32;
 }
 
-static u64 mmap_read_self(void *addr)
+/*
+ * Return a user rdpmc result. The kernel may be multiplexing events and so the
+ * result is scaled to the period of time the counter was enabled. The
+ * time_running out parameter is set to the amount of time the counter has been
+ * running. The result will be zero if time_running is zero.
+ */
+static u64 mmap_read_self(void *addr, u64 *running)
 {
 	struct perf_event_mmap_page *pc = addr;
 	u32 seq, idx, time_mult = 0, time_shift = 0;
-	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
+	u64 count, cyc = 0, time_offset = 0, enabled, delta;
 
 	do {
 		seq = pc->lock;
 		barrier();
 
 		enabled = pc->time_enabled;
-		running = pc->time_running;
-
-		if (enabled != running) {
+		*running = pc->time_running;
+
+		if (*running == 0) {
+			/*
+			 * Counter won't have a value as due to multiplexing the
+			 * event wasn't scheduled.
+			 */
+			return 0;
+		}
+		if (enabled != *running) {
 			cyc = rdtsc();
 			time_mult = pc->time_mult;
 			time_shift = pc->time_shift;
@@ -62,7 +75,7 @@ static u64 mmap_read_self(void *addr)
 		barrier();
 	} while (pc->lock != seq);
 
-	if (enabled != running) {
+	if (enabled != *running) {
 		u64 quot, rem;
 
 		quot = (cyc >> time_shift);
@@ -72,11 +85,11 @@ static u64 mmap_read_self(void *addr)
 
 		enabled += delta;
 		if (idx)
-			running += delta;
+			*running += delta;
 
-		quot = count / running;
-		rem = count % running;
-		count = quot * enabled + (rem * enabled) / running;
+		quot = count / *running;
+		rem = count % *running;
+		count = quot * enabled + (rem * enabled) / *running;
 	}
 
 	return count;
@@ -104,7 +117,7 @@ static int __test__rdpmc(void)
 		.config = PERF_COUNT_HW_INSTRUCTIONS,
 		.exclude_kernel = 1,
 	};
-	u64 delta_sum = 0;
+	u64 delta_sum = 0, sleep_count = 0;
         struct sigaction sa;
 	char sbuf[STRERR_BUFSIZE];
 
@@ -130,14 +143,23 @@ static int __test__rdpmc(void)
 	}
 
 	for (n = 0; n < 6; n++) {
-		u64 stamp, now, delta;
-
-		stamp = mmap_read_self(addr);
+		u64 stamp, now, delta, running;
+
+		for (;;) {
+			stamp = mmap_read_self(addr, &running);
+			if (running != 0)
+				break;
+			/* Try to wait for event to be running. */
+			sleep_count++;
+			if (sleep_count > 60)
+				goto out_never_run;
+			sleep(1);
+		}
 
 		for (i = 0; i < loops; i++)
 			tmp++;
 
-		now = mmap_read_self(addr);
+		now = mmap_read_self(addr, &running);
 		loops *= 10;
 
 		delta = now - stamp;
@@ -155,6 +177,11 @@ static int __test__rdpmc(void)
 		return -1;
 
 	return 0;
+
+out_never_run:
+	close(fd);
+	pr_err("Event counter failed to multiplexed in. Are higher priority counters being sampled by a different process?\n");
+	return -1;
 }
 
 int test__rdpmc(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.25.1.696.g5e7596f4ac-goog

