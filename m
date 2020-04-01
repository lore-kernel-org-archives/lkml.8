Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F36C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF092077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgDAKRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbgDAKRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:51 -0400
IronPort-SDR: xW5WFBz0BaIl8WTt/W6TJTHYTYtyVAfXx5ZP6GuQNFEaXosoOTnTPSwRbiqi9F/lfcayR/x6cF
 PXw7ipxTvcFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:49 -0700
IronPort-SDR: ZAWlKZHZRJZOOrk8xqtsqOIyFPEVW8w3oYwmt7RPiup67+JGrHYQPkjZD/ec1MjoqLAS+rxsv0
 ZmqWIsoLgQCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925545"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/16] perf thread-stack: Add thread_stack__sample_late()
Date:   Wed,  1 Apr 2020 13:16:06 +0300
Message-Id: <20200401101613.6201-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a thread stack function to create a call chain for hardware events
where the sample records get created some time after the event occurred.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 57 ++++++++++++++++++++++++++++++++++
 tools/perf/util/thread-stack.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 0885967d5bc3..83f6c83f5617 100644
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
index e1ec5a58f1b2..8962ddc4e1ab 100644
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
-- 
2.17.1

