Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5383C10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3CC2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCFOoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:44:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53739 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCFOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAs-0006GG-P5; Fri, 06 Mar 2020 15:42:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 633BC1C21D5;
        Fri,  6 Mar 2020 15:42:02 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:02 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/cgroup: Reorder perf_cgroup_connect()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214075133.181299-2-irogers@google.com>
References: <20200214075133.181299-2-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158350572214.28353.13646888224864250072.tip-bot2@tip-bot2>
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

Commit-ID:     98add2af89bbfe8241e189b490fd91e5751c7900
Gitweb:        https://git.kernel.org/tip/98add2af89bbfe8241e189b490fd91e5751c7900
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 Feb 2020 23:51:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:56:58 +01:00

perf/cgroup: Reorder perf_cgroup_connect()

Move perf_cgroup_connect() after perf_event_alloc(), such that we can
find/use the PMU's cpu context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200214075133.181299-2-irogers@google.com
---
 kernel/events/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b7eaaba..dceeeb1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10774,12 +10774,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
 
-	if (cgroup_fd != -1) {
-		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
-		if (err)
-			goto err_ns;
-	}
-
 	pmu = perf_init_event(event);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
@@ -10801,6 +10795,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_pmu;
 	}
 
+	if (cgroup_fd != -1) {
+		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
+		if (err)
+			goto err_pmu;
+	}
+
 	err = exclusive_event_init(event);
 	if (err)
 		goto err_pmu;
@@ -10861,12 +10861,12 @@ err_per_task:
 	exclusive_event_destroy(event);
 
 err_pmu:
+	if (is_cgroup_event(event))
+		perf_detach_cgroup(event);
 	if (event->destroy)
 		event->destroy(event);
 	module_put(pmu->module);
 err_ns:
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
 	if (event->ns)
 		put_pid_ns(event->ns);
 	if (event->hw.target)
