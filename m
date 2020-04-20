Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D455C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F8020724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383846;
	bh=Bs7MyTBHg4KpMB3N/TJ3QoCulD6TDLZr6+xspbm2Rxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SI4f6pgA+zEMfeZa8GF/46lcnbTOIHR7f54DkaGmhl/or/Co8lsMM9Sw3YxiFGRsD
	 YI53BvN5HorF9yoBCrrJpTyRRBhWNjjoZjRxUWagVXQpWv0qxwNCQdTSYQHPbIrGY3
	 kAWHZSMx6hlNYRchM+++HBA7l566ox2qdSkmFTGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgDTL5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgDTL5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:57:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40CD21927;
        Mon, 20 Apr 2020 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383843;
        bh=Bs7MyTBHg4KpMB3N/TJ3QoCulD6TDLZr6+xspbm2Rxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVyFCjCZapNmfLv35zhjUiFUeJ6ZzPt5q9nUk4OlViBoA17MkQhrB6pXlOVTHw8iA
         OY5xIK0oUPsU+zuYkj4no/FQ16+EigT/KAJaNlqcYfRjG7V8Tnw1aULM8oEWFXp2L6
         u8b/EXngPwhiBqWcl1VqC4zZ+ifvGJ55m1U3P+g0=
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
Subject: [PATCH 53/60] perf thread: Save previous sample for LBR stitching approach
Date:   Mon, 20 Apr 2020 08:53:09 -0300
Message-Id: <20200420115316.18781-54-acme@kernel.org>
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

To retrieve the overwritten LBRs from previous sample for LBR stitching
approach, perf has to save the previous sample.

Only allocate the struct lbr_stitch once, when LBR stitching approach is
enabled and kernel supports hw_idx.

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
Link: http://lore.kernel.org/lkml/20200319202517.23423-11-kan.liang@linux.intel.com
[ Use zalloc()/zfree() for thread->lbr_stitch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 23 +++++++++++++++++++++++
 tools/perf/util/thread.c  |  1 +
 tools/perf/util/thread.h  | 12 ++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f9d69fce584a..a54ca09a1d00 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2292,6 +2292,21 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 	return 0;
 }
 
+static bool alloc_lbr_stitch(struct thread *thread)
+{
+	if (thread->lbr_stitch)
+		return true;
+
+	thread->lbr_stitch = zalloc(sizeof(*thread->lbr_stitch));
+	if (!thread->lbr_stitch)
+		goto err;
+
+err:
+	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
+	thread->lbr_stitch_enable = false;
+	return false;
+}
+
 /*
  * Recolve LBR callstack chain sample
  * Return:
@@ -2308,6 +2323,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 {
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
+	struct lbr_stitch *lbr_stitch;
 	u64 branch_from = 0;
 	int err;
 
@@ -2320,6 +2336,13 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	if (i == chain_nr)
 		return 0;
 
+	if (thread->lbr_stitch_enable && !sample->no_hw_idx &&
+	    alloc_lbr_stitch(thread)) {
+		lbr_stitch = thread->lbr_stitch;
+
+		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
+	}
+
 	if (callchain_param.order == ORDER_CALLEE) {
 		/* Add kernel ip */
 		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 1f080db23615..8d0da260c84c 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -111,6 +111,7 @@ void thread__delete(struct thread *thread)
 
 	exit_rwsem(&thread->namespaces_lock);
 	exit_rwsem(&thread->comm_lock);
+	thread__free_stitch_list(thread);
 	free(thread);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 95294050cff2..34eb61cee6a4 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -5,6 +5,7 @@
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
@@ -13,6 +14,7 @@
 #include <strlist.h>
 #include <intlist.h>
 #include "rwsem.h"
+#include "event.h"
 
 struct addr_location;
 struct map;
@@ -20,6 +22,10 @@ struct perf_record_namespaces;
 struct thread_stack;
 struct unwind_libunwind_ops;
 
+struct lbr_stitch {
+	struct perf_sample		prev_sample;
+};
+
 struct thread {
 	union {
 		struct rb_node	 rb_node;
@@ -49,6 +55,7 @@ struct thread {
 
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
+	struct lbr_stitch	*lbr_stitch;
 };
 
 struct machine;
@@ -145,4 +152,9 @@ static inline bool thread__is_filtered(struct thread *thread)
 	return false;
 }
 
+static inline void thread__free_stitch_list(struct thread *thread)
+{
+	zfree(&thread->lbr_stitch);
+}
+
 #endif	/* __PERF_THREAD_H */
-- 
2.21.1

