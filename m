Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D4CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A7422202
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383792;
	bh=lmGTczQYs73nSnR9l2DZ9fp/5CLokuQYfrpr+ojkbZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qvtSltpkHzu4+z9nPOrR2Q6ju4FAEyC8qrIe+yt1uaE8XZFw1f2RBhjGJRIC6txOf
	 lTG2J0QT0VKtBZ0oiLcNf/L1n6tO9neaBCTY2bfbxzWndNRuSiLnFKrHkbDNZUBzj5
	 +f72mHfJc3uIsiNmRMs26V6t9qZNrICcrJE1qL0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgDTL4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgDTL43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7936D2223D;
        Mon, 20 Apr 2020 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383788;
        bh=lmGTczQYs73nSnR9l2DZ9fp/5CLokuQYfrpr+ojkbZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WG0qxW3cuUVh3s0Wyj2B6alDMm+wWZ9o/YoY4dclbwOiirTgrYGc1yU9hjBoxAYC
         A79TY678sj3YJu/LSHg2yd+L7LMNiEbzihp0ajDHOYGEh18057qw03kGzqO+coirfu
         RSLBgeqKXdbSUUF+IO9FKBo5ytiTWkL4z1o5FWnA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 42/60] perf stat: Force error in fallback on :k events
Date:   Mon, 20 Apr 2020 08:52:58 -0300
Message-Id: <20200420115316.18781-43-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

When it is not possible for a non-privilege perf command to monitor at
the kernel level (:k), the fallback code forces a :u. That works if the
event was previously monitoring both levels.  But if the event was
already constrained to kernel only, then it does not make sense to
restrict it to user only.

Given the code works by exclusion, a kernel only event would have:

  attr->exclude_user = 1

The fallback code would add:

  attr->exclude_kernel = 1

In the end the end would not monitor in either the user level or kernel
level. In other words, it would count nothing.

An event programmed to monitor kernel only cannot be switched to user
only without seriously warning the user.

This patch forces an error in this case to make it clear the request
cannot really be satisfied.

Behavior with paranoid 1:

  $ sudo bash -c "echo 1 > /proc/sys/kernel/perf_event_paranoid"
  $ perf stat -e cycles:k sleep 1

   Performance counter stats for 'sleep 1':

           1,520,413      cycles:k

         1.002361664 seconds time elapsed

         0.002480000 seconds user
         0.000000000 seconds sys

Old behavior with paranoid 2:

  $ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
  $ perf stat -e cycles:k sleep 1
   Performance counter stats for 'sleep 1':

                   0      cycles:ku

         1.002358127 seconds time elapsed

         0.002384000 seconds user
         0.000000000 seconds sys

New behavior with paranoid 2:

  $ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
  $ perf stat -e cycles:k sleep 1
  Error:
  You may not have permission to collect stats.

  Consider tweaking /proc/sys/kernel/perf_event_paranoid,
  which controls use of the performance events system by
  unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).

  The current value is 2:

    -1: Allow use of (almost) all events by all users
        Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
  >= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN
        Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN
  >= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN
  >= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN

  To make this setting permanent, edit /etc/sysctl.conf too, e.g.:

          kernel.perf_event_paranoid = -1

v2 of this patch addresses the review feedback from jolsa@redhat.com.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200414161550.225588-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8300e8c7aea8..6a571d322bb2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2427,6 +2427,10 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		char *new_name;
 		const char *sep = ":";
 
+		/* If event has exclude user then don't exclude kernel. */
+		if (evsel->core.attr.exclude_user)
+			return false;
+
 		/* Is there already the separator in the name. */
 		if (strchr(name, '/') ||
 		    strchr(name, ':'))
-- 
2.21.1

