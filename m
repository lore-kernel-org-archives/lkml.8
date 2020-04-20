Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABBAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A70B206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383769;
	bh=/LdjocWRJnI0zIamhfwcQJvo4tMtmun37qnKuIK3AC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MD5TgzfFZcq/ECDMpI5/XGz2WatwZjw4BKz4nFg9Zfj6cdwMrVsRxDriZxKSzHb5P
	 ThPY0YTx4DXhruazEOi++XKvPhTEAgLT9JoDM5HLj1zuQlqw29APcF1nBBJEiOu+N6
	 kl6SJ8cXp6Lc9dH5QMNxknzT5j9WeS/9qtauhJas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgDTL4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgDTL4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9B822209;
        Mon, 20 Apr 2020 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383760;
        bh=/LdjocWRJnI0zIamhfwcQJvo4tMtmun37qnKuIK3AC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPSBj6AY4WymkgofpKGLafK5xg4vGjucGJy5g1aV2lDZSkVmCEacZtKNpnbrui0+T
         v3i4u6A62KjAhm+48jB4bQpW4HXkfBRjZhvb+qFwW4nvJyCiOk+GpyXaym4P3iHXRa
         5PtVTIdN5prVLDZdLNVJWlKj2Jo+DIuT/JdPDhiA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/60] perf thread-stack: Add thread_stack__sample_late()
Date:   Mon, 20 Apr 2020 08:52:49 -0300
Message-Id: <20200420115316.18781-34-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a thread stack function to create a call chain for hardware events
where the sample records get created some time after the event occurred.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.1

