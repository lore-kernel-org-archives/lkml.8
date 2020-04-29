Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71048C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A47721973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD2PHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:48789 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgD2PHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:41 -0400
IronPort-SDR: YFvsZFQ66ZYRJGS/sCIm2JmX+Yn8ex+3WFYUvIh7hFr0mwgE4YCVAkwwCOMgbgBijbvT0uaDll
 K1Ff6hfedAXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:39 -0700
IronPort-SDR: PRi4d9u5Asp60DEDpNL0qKyEtZzjYUf3pEA7dbqL2gMGtR1bx4iaz9PTuQKxpQdxp3pFVLiZEX
 5vfFSHw2GOJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227439"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] perf thread-stack: Add thread_stack__br_sample_late()
Date:   Wed, 29 Apr 2020 18:07:48 +0300
Message-Id: <20200429150751.12570-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429150751.12570-1-adrian.hunter@intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a thread stack function to create a branch stack for hardware events
where the sample records get created some time after the event occurred.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 104 +++++++++++++++++++++++++++++++++
 tools/perf/util/thread-stack.h |   3 +
 2 files changed, 107 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 79698831b4b9..1b992bbba4e8 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -645,6 +645,110 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
 	}
 }
 
+/* Start of user space branch entries */
+static bool us_start(struct branch_entry *be, u64 kernel_start, bool *start)
+{
+	if (!*start)
+		*start = be->to && be->to < kernel_start;
+
+	return *start;
+}
+
+/*
+ * Start of branch entries after the ip fell in between 2 branches, or user
+ * space branch entries.
+ */
+static bool ks_start(struct branch_entry *be, u64 sample_ip, u64 kernel_start,
+		     bool *start, struct branch_entry *nb)
+{
+	if (!*start) {
+		*start = (nb && sample_ip >= be->to && sample_ip <= nb->from) ||
+			 be->from < kernel_start ||
+			 (be->to && be->to < kernel_start);
+	}
+
+	return *start;
+}
+
+/*
+ * Hardware sample records, created some time after the event occurred, need to
+ * have subsequent addresses removed from the branch stack.
+ */
+void thread_stack__br_sample_late(struct thread *thread, int cpu,
+				  struct branch_stack *dst, unsigned int sz,
+				  u64 ip, u64 kernel_start)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+	struct branch_entry *d, *s, *spos, *ssz;
+	struct branch_stack *src;
+	unsigned int nr = 0;
+	bool start = false;
+
+	dst->nr = 0;
+
+	if (!ts)
+		return;
+
+	src = ts->br_stack_rb;
+	if (!src->nr)
+		return;
+
+	spos = &src->entries[ts->br_stack_pos];
+	ssz  = &src->entries[ts->br_stack_sz];
+
+	d = &dst->entries[0];
+	s = spos;
+
+	if (ip < kernel_start) {
+		/*
+		 * User space sample: start copying branch entries when the
+		 * branch is in user space.
+		 */
+		for (s = spos; s < ssz && nr < sz; s++) {
+			if (us_start(s, kernel_start, &start)) {
+				*d++ = *s;
+				nr += 1;
+			}
+		}
+
+		if (src->nr >= ts->br_stack_sz) {
+			for (s = &src->entries[0]; s < spos && nr < sz; s++) {
+				if (us_start(s, kernel_start, &start)) {
+					*d++ = *s;
+					nr += 1;
+				}
+			}
+		}
+	} else {
+		struct branch_entry *nb = NULL;
+
+		/*
+		 * Kernel space sample: start copying branch entries when the ip
+		 * falls in between 2 branches (or the branch is in user space
+		 * because then the start must have been missed).
+		 */
+		for (s = spos; s < ssz && nr < sz; s++) {
+			if (ks_start(s, ip, kernel_start, &start, nb)) {
+				*d++ = *s;
+				nr += 1;
+			}
+			nb = s;
+		}
+
+		if (src->nr >= ts->br_stack_sz) {
+			for (s = &src->entries[0]; s < spos && nr < sz; s++) {
+				if (ks_start(s, ip, kernel_start, &start, nb)) {
+					*d++ = *s;
+					nr += 1;
+				}
+				nb = s;
+			}
+		}
+	}
+
+	dst->nr = nr;
+}
+
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index c279a0cbbdd0..3bc47a42af8e 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -91,6 +91,9 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
 			       u64 kernel_start);
 void thread_stack__br_sample(struct thread *thread, int cpu,
 			     struct branch_stack *dst, unsigned int sz);
+void thread_stack__br_sample_late(struct thread *thread, int cpu,
+				  struct branch_stack *dst, unsigned int sz,
+				  u64 sample_ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
-- 
2.17.1

