Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4C6C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E5C2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgDVMRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgDVMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E4C03C1AA;
        Wed, 22 Apr 2020 05:17:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJc-0007iH-MC; Wed, 22 Apr 2020 14:17:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0542B1C02FC;
        Wed, 22 Apr 2020 14:17:19 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:18 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf stat: Force error in fallback on :k events
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200414161550.225588-1-irogers@google.com>
References: <20200414161550.225588-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158755783861.28353.11402611117303898622.tip-bot2@tip-bot2>
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

Commit-ID:     bec49a9e05db3dbdca696fa07c62c52638fb6371
Gitweb:        https://git.kernel.org/tip/bec49a9e05db3dbdca696fa07c62c52638fb6371
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 14 Apr 2020 09:15:50 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf stat: Force error in fallback on :k events

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
index 8300e8c..6a571d3 100644
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
