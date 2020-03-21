Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB5C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF25820753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+fFGjuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCUAOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:14:05 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53525 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCUAOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:14:05 -0400
Received: by mail-pf1-f201.google.com with SMTP id i26so5938331pfk.20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rKfrdmROUvOZs7vlFYgTzomyfR+aU7XEpJ+VtYWEGxg=;
        b=c+fFGjuk2m1tfW68i8sSn+ZYRpfp9xXE5oyE3CZ/xCakl9mM6K5LBpq96HlbRHCVdR
         yFKmU2uQeY49D+kZzagFhU6uW9q01IgMRzNl57PqQAWslxx/t3YEZjnR20CndyEAhrpW
         2B+K0eYeNLJElN+RfN1NKz29NRcNHr1tnFGMdD0ts41MHZDY01m6WTfAYbD5SbiAQ3Ku
         6QADHsjTERUoIORZEdo0u/nDmIAAyIqNsZnr6MAy1hB2J76j9xzSq6o3r3TqOogieJkA
         ILd3E4aqV2MtBrJ++TBJ6zSdsYWjHWhvR08qjVcMnI3ovUMm0aU4q7U2nG6tzqjBiNXM
         9zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rKfrdmROUvOZs7vlFYgTzomyfR+aU7XEpJ+VtYWEGxg=;
        b=CiDxpHAGgs/A/U4gYyTT6NbTMCHcvSWWRG0ugvYKBNwoETqsC29iEA4Rwtjqj1QIOe
         iyr1WVecpZDDi1tByFAU9wAtrUHswXto8mWpl35NXwametlfNnn8tdyVnSU/1l3xg04w
         LMwOBgHqhLkJuKaH424/0lq7PQTo89mWxhaCqB9Y80KzfllpIXL5dCoa8vwSC3++60vx
         NMHNdIfEhGBG4rvpAdguf/CpKhBqfqnRbVpGDhWLCPraePMVN4/goZb9twfKqIU6tous
         7eFkr5ZL8aW6d/0gdMOGIA1shlWCIDnba97lz7zeLBQk937HVAd7f5OvZdaOtItEbOoy
         hsXg==
X-Gm-Message-State: ANhLgQ2fGENpqWYup0Q5uUpV1LKxvqDMUeITO2F3w68pHmvuU2BkxYax
        NcyKtXGHCcaS7emV6WhkQE9hmM8h5ATp
X-Google-Smtp-Source: ADFU+vuK5hcCKAFaXUA5qKgirZXhfYYf1KjhxNLoVGAhGoEen3x9QbV+hFfJc7/ByBtvbdOrj2PyP1YvVrLv
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr12172125pjb.38.1584749643969;
 Fri, 20 Mar 2020 17:14:03 -0700 (PDT)
Date:   Fri, 20 Mar 2020 17:14:00 -0700
Message-Id: <20200321001400.245121-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] perf test x86: address multiplexing in rdpmc test
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
Add a sleep loop to ensure that the counter is run before computing
the count.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/rdpmc.c | 45 ++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
index 1ea916656a2d..0b0792ae67f7 100644
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ b/tools/perf/arch/x86/tests/rdpmc.c
@@ -34,19 +34,35 @@ static u64 rdtsc(void)
 	return low | ((u64)high) << 32;
 }
 
-static u64 mmap_read_self(void *addr)
+static u64 mmap_read_self(void *addr, bool *error)
 {
 	struct perf_event_mmap_page *pc = addr;
-	u32 seq, idx, time_mult = 0, time_shift = 0;
+	u32 seq, idx, time_mult = 0, time_shift = 0, sleep_count = 0;
 	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
 
+	*error = false;
 	do {
-		seq = pc->lock;
-		barrier();
-
-		enabled = pc->time_enabled;
-		running = pc->time_running;
-
+		do {
+			seq = pc->lock;
+			barrier();
+
+			enabled = pc->time_enabled;
+			running = pc->time_running;
+
+			if (running == 0) {
+				/*
+				 * Event hasn't run, this may be caused by
+				 * multiplexing.
+				 */
+				sleep_count++;
+				if (sleep_count > 60) {
+					pr_err("Event failed to run. Are higher priority counters being sampled by a different process?\n");
+					*error = true;
+					return 0;
+				}
+				sleep(1);
+			}
+		} while (running == 0);
 		if (enabled != running) {
 			cyc = rdtsc();
 			time_mult = pc->time_mult;
@@ -131,13 +147,22 @@ static int __test__rdpmc(void)
 
 	for (n = 0; n < 6; n++) {
 		u64 stamp, now, delta;
+		bool error;
 
-		stamp = mmap_read_self(addr);
+		stamp = mmap_read_self(addr, &error);
+		if (error) {
+			delta_sum = 0;
+			goto out_close;
+		}
 
 		for (i = 0; i < loops; i++)
 			tmp++;
 
-		now = mmap_read_self(addr);
+		now = mmap_read_self(addr, &error);
+		if (error) {
+			delta_sum = 0;
+			goto out_close;
+		}
 		loops *= 10;
 
 		delta = now - stamp;
-- 
2.25.1.696.g5e7596f4ac-goog

