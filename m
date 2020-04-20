Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCC82072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383823;
	bh=mrQGR8mQ7da433xvPuuVThJWpyapRQcoo0qjohvjqXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0a1hcxi/6q0eBxNuTy0X4VwKwamE7yyic1kigFF0pcMv/cPgVzPqTfxqRrMNvsT1F
	 aPaXlV5uMX7FeJKdc71QvfTU4pG3y1isgkw+4PD03xZSbOM+il7MBOKdLFz6ogoxNW
	 pCRmvzKIjK+8OxBbsvI4/uHJV51YPFGrndQjhFgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgDTL5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgDTL47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1C522209;
        Mon, 20 Apr 2020 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383818;
        bh=mrQGR8mQ7da433xvPuuVThJWpyapRQcoo0qjohvjqXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p//tgucmcDLL+TdwU8Ho+Nmm7wcNEahMH6EliIkLRmrGfttWQ1vwhUdt2tiRwBdRw
         k3h4mXcmzR124m+OleqtcSz/ZMLO3FdbwuGVTSUMp6M9qATbmcrowNSOJg82BogQh4
         omjxsoBOTCF+vDG6bi+2aA+DinK2CRwr8DcrfSSE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 48/60] perf machine: Remove the indent in resolve_lbr_callchain_sample
Date:   Mon, 20 Apr 2020 08:53:04 -0300
Message-Id: <20200420115316.18781-49-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
 tools/perf/util/machine.c | 123 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 09845eae9c03..be1bd9277471 100644
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
-- 
2.21.1

