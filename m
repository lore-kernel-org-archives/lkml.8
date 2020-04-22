Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235BAC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0658822202
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgDVMW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728344AbgDVMRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B0BC03C1AC;
        Wed, 22 Apr 2020 05:17:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJY-0007fP-JG; Wed, 22 Apr 2020 14:17:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1298C1C02FC;
        Wed, 22 Apr 2020 14:17:16 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:15 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf machine: Remove the indent in
 resolve_lbr_callchain_sample
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319202517.23423-6-kan.liang@linux.intel.com>
References: <20200319202517.23423-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783560.28353.6964819556320935379.tip-bot2@tip-bot2>
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

Commit-ID:     f8603267bf8589f2a6a3e0a7de0a8dc6b6bd3c7d
Gitweb:        https://git.kernel.org/tip/f8603267bf8589f2a6a3e0a7de0a8dc6b6bd3c7d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:05 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf machine: Remove the indent in resolve_lbr_callchain_sample

The indent is unnecessary in resolve_lbr_callchain_sample.  Removing it
will make the following patch simpler.

Current code path for resolve_lbr_callchain_sample()

        /* LBR only affects the user callchain */
        if (i != chain_nr) {
                body of the function
                ....
                return 1;
        }

        return 0;

With the patch,

        /* LBR only affects the user callchain */
        if (i == chain_nr)
                return 0;

        body of the function
        ...
        return 1;

No functional changes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-6-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 123 ++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 09845ea..be1bd92 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2208,6 +2208,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	u64 ip, branch_from = 0;
+	struct branch_stack *lbr_stack;
+	struct branch_entry *entries;
+	int lbr_nr, j, k;
+	bool branch;
+	struct branch_flags *flags;
+	int mix_chain_nr;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -2215,71 +2221,68 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	}
 
 	/* LBR only affects the user callchain */
-	if (i != chain_nr) {
-		struct branch_stack *lbr_stack = sample->branch_stack;
-		struct branch_entry *entries = perf_sample__branch_entries(sample);
-		int lbr_nr = lbr_stack->nr, j, k;
-		bool branch;
-		struct branch_flags *flags;
-		/*
-		 * LBR callstack can only get user call chain.
-		 * The mix_chain_nr is kernel call chain
-		 * number plus LBR user call chain number.
-		 * i is kernel call chain number,
-		 * 1 is PERF_CONTEXT_USER,
-		 * lbr_nr + 1 is the user call chain number.
-		 * For details, please refer to the comments
-		 * in callchain__printf
-		 */
-		int mix_chain_nr = i + 1 + lbr_nr + 1;
-
-		for (j = 0; j < mix_chain_nr; j++) {
-			int err;
-			branch = false;
-			flags = NULL;
+	if (i == chain_nr)
+		return 0;
 
-			if (callchain_param.order == ORDER_CALLEE) {
-				if (j < i + 1)
-					ip = chain->ips[j];
-				else if (j > i + 1) {
-					k = j - i - 2;
-					ip = entries[k].from;
-					branch = true;
-					flags = &entries[k].flags;
-				} else {
-					ip = entries[0].to;
-					branch = true;
-					flags = &entries[0].flags;
-					branch_from = entries[0].from;
-				}
+	lbr_stack = sample->branch_stack;
+	entries = perf_sample__branch_entries(sample);
+	lbr_nr = lbr_stack->nr;
+	/*
+	 * LBR callstack can only get user call chain.
+	 * The mix_chain_nr is kernel call chain
+	 * number plus LBR user call chain number.
+	 * i is kernel call chain number,
+	 * 1 is PERF_CONTEXT_USER,
+	 * lbr_nr + 1 is the user call chain number.
+	 * For details, please refer to the comments
+	 * in callchain__printf
+	 */
+	mix_chain_nr = i + 1 + lbr_nr + 1;
+
+	for (j = 0; j < mix_chain_nr; j++) {
+		int err;
+
+		branch = false;
+		flags = NULL;
+
+		if (callchain_param.order == ORDER_CALLEE) {
+			if (j < i + 1)
+				ip = chain->ips[j];
+			else if (j > i + 1) {
+				k = j - i - 2;
+				ip = entries[k].from;
+				branch = true;
+				flags = &entries[k].flags;
 			} else {
-				if (j < lbr_nr) {
-					k = lbr_nr - j - 1;
-					ip = entries[k].from;
-					branch = true;
-					flags = &entries[k].flags;
-				}
-				else if (j > lbr_nr)
-					ip = chain->ips[i + 1 - (j - lbr_nr)];
-				else {
-					ip = entries[0].to;
-					branch = true;
-					flags = &entries[0].flags;
-					branch_from = entries[0].from;
-				}
+				ip = entries[0].to;
+				branch = true;
+				flags = &entries[0].flags;
+				branch_from = entries[0].from;
+			}
+		} else {
+			if (j < lbr_nr) {
+				k = lbr_nr - j - 1;
+				ip = entries[k].from;
+				branch = true;
+				flags = &entries[k].flags;
+			} else if (j > lbr_nr)
+				ip = chain->ips[i + 1 - (j - lbr_nr)];
+			else {
+				ip = entries[0].to;
+				branch = true;
+				flags = &entries[0].flags;
+				branch_from = entries[0].from;
 			}
-
-			err = add_callchain_ip(thread, cursor, parent,
-					       root_al, &cpumode, ip,
-					       branch, flags, NULL,
-					       branch_from);
-			if (err)
-				return (err < 0) ? err : 0;
 		}
-		return 1;
-	}
 
-	return 0;
+		err = add_callchain_ip(thread, cursor, parent,
+				       root_al, &cpumode, ip,
+				       branch, flags, NULL,
+				       branch_from);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
+	return 1;
 }
 
 static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
