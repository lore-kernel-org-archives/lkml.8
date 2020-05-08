Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B3C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F1324999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgEHNKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728463AbgEHNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270AC05BD0A;
        Fri,  8 May 2020 06:05:13 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gd-0007WI-Bs; Fri, 08 May 2020 15:05:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFA9F1C0852;
        Fri,  8 May 2020 15:04:57 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:57 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf thread-stack: Add thread_stack__br_sample_late()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429150751.12570-7-adrian.hunter@intel.com>
References: <20200429150751.12570-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158894309779.8414.7778487024910558473.tip-bot2@tip-bot2>
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

Commit-ID:     3749e0bbdef24efbf1698bf0dbd9575fddb9ed22
Gitweb:        https://git.kernel.org/tip/3749e0bbdef24efbf1698bf0dbd9575fddb9ed22
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 29 Apr 2020 18:07:48 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf thread-stack: Add thread_stack__br_sample_late()

Add a thread stack function to create a branch stack for hardware events
where the sample records get created some time after the event occurred.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 104 ++++++++++++++++++++++++++++++++-
 tools/perf/util/thread-stack.h |   3 +-
 2 files changed, 107 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 7969883..1b992bb 100644
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
index c279a0c..3bc47a4 100644
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
