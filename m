Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815B5C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F1421D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgDVMSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728716AbgDVMRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CDBC03C1A9;
        Wed, 22 Apr 2020 05:17:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJo-0007nH-6v; Wed, 22 Apr 2020 14:17:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6804F1C0483;
        Wed, 22 Apr 2020 14:17:23 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:22 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf thread-stack: Add thread_stack__sample_late()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-10-adrian.hunter@intel.com>
References: <20200401101613.6201-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784297.28353.7627391855107279620.tip-bot2@tip-bot2>
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

Commit-ID:     4fef41bfb1d8d2ada4a18eb3ab80c2682bcbae12
Gitweb:        https://git.kernel.org/tip/4fef41bfb1d8d2ada4a18eb3ab80c2682bcbae12
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:06 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:15 -03:00

perf thread-stack: Add thread_stack__sample_late()

Add a thread stack function to create a call chain for hardware events
where the sample records get created some time after the event occurred.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 57 +++++++++++++++++++++++++++++++++-
 tools/perf/util/thread-stack.h |  3 ++-
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 0885967..83f6c83 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -497,6 +497,63 @@ void thread_stack__sample(struct thread *thread, int cpu,
 	chain->nr = i;
 }
 
+/*
+ * Hardware sample records, created some time after the event occurred, need to
+ * have subsequent addresses removed from the call chain.
+ */
+void thread_stack__sample_late(struct thread *thread, int cpu,
+			       struct ip_callchain *chain, size_t sz,
+			       u64 sample_ip, u64 kernel_start)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+	u64 sample_context = callchain_context(sample_ip, kernel_start);
+	u64 last_context, context, ip;
+	size_t nr = 0, j;
+
+	if (sz < 2) {
+		chain->nr = 0;
+		return;
+	}
+
+	if (!ts)
+		goto out;
+
+	/*
+	 * When tracing kernel space, kernel addresses occur at the top of the
+	 * call chain after the event occurred but before tracing stopped.
+	 * Skip them.
+	 */
+	for (j = 1; j <= ts->cnt; j++) {
+		ip = ts->stack[ts->cnt - j].ret_addr;
+		context = callchain_context(ip, kernel_start);
+		if (context == PERF_CONTEXT_USER ||
+		    (context == sample_context && ip == sample_ip))
+			break;
+	}
+
+	last_context = sample_ip; /* Use sample_ip as an invalid context */
+
+	for (; nr < sz && j <= ts->cnt; nr++, j++) {
+		ip = ts->stack[ts->cnt - j].ret_addr;
+		context = callchain_context(ip, kernel_start);
+		if (context != last_context) {
+			if (nr >= sz - 1)
+				break;
+			chain->ips[nr++] = context;
+			last_context = context;
+		}
+		chain->ips[nr] = ip;
+	}
+out:
+	if (nr) {
+		chain->nr = nr;
+	} else {
+		chain->ips[0] = sample_context;
+		chain->ips[1] = sample_ip;
+		chain->nr = 2;
+	}
+}
+
 struct call_return_processor *
 call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index e1ec5a5..8962ddc 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -85,6 +85,9 @@ int thread_stack__event(struct thread *thread, int cpu, u32 flags, u64 from_ip,
 void thread_stack__set_trace_nr(struct thread *thread, int cpu, u64 trace_nr);
 void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start);
+void thread_stack__sample_late(struct thread *thread, int cpu,
+			       struct ip_callchain *chain, size_t sz, u64 ip,
+			       u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
