Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36166C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD82076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgDHMVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:21:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49631 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgDHMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gt-00062m-Ah; Wed, 08 Apr 2020 14:20:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 78EC11C0481;
        Wed,  8 Apr 2020 14:20:22 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:22 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/cgroup: Correct indirection in perf_less_group_idx()
Cc:     Ian Rogers <irogers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321164331.107337-1-irogers@google.com>
References: <20200321164331.107337-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158634842209.28353.12822262473429054927.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     24fb6b8e7c2280000966e3f2c9c8069a538518eb
Gitweb:        https://git.kernel.org/tip/24fb6b8e7c2280000966e3f2c9c8069a538518eb
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Sat, 21 Mar 2020 09:43:31 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:33:45 +02:00

perf/cgroup: Correct indirection in perf_less_group_idx()

The void* in perf_less_group_idx() is to a member in the array which points
at a perf_event*, as such it is a perf_event**.

Reported-By: John Sperbeck <jsperbeck@google.com>
Fixes: 6eef8a7116de ("perf/core: Use min_heap in visit_groups_merge()")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200321164331.107337-1-irogers@google.com
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7afd0b5..26de0a5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3522,7 +3522,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 
 static bool perf_less_group_idx(const void *l, const void *r)
 {
-	const struct perf_event *le = l, *re = r;
+	const struct perf_event *le = *(const struct perf_event **)l;
+	const struct perf_event *re = *(const struct perf_event **)r;
 
 	return le->group_index < re->group_index;
 }
