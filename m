Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D9C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4857D20659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgDEUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:14:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDEUOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:14:46 -0400
IronPort-SDR: QQzPGs4RAIt/ZjKnr9bXMcfZRVhD7AXusoE6514rE6dehpCNuGOv2/lvZy4GJAC5R/Zi4y9W0O
 p22P/f/q1FqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:14:46 -0700
IronPort-SDR: XMQuICm0v+92zGuPPnSy57QzteL6l/8dGmledHxPFvtDu2now0KasYefybK/cjRbNQPnQdGk+W
 O/MnW5/JIjZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688414"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:14:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V6 07/15] ftrace: Add perf ksymbol events for ftrace trampolines
Date:   Sun,  5 Apr 2020 23:13:19 +0300
Message-Id: <20200405201327.7332-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/uapi/linux/perf_event.h |  2 +-
 kernel/trace/ftrace.c           | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index e1a4179144a1..52ca2093831c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1051,7 +1051,7 @@ enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
 	/*
 	 * Out of line code such as kprobe-replaced instructions or optimized
-	 * kprobes.
+	 * kprobes or ftrace trampolines.
 	 */
 	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4e1c2f0bea76..398d58b8ffa5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2791,8 +2791,13 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
 static void ftrace_trampoline_free(struct ftrace_ops *ops)
 {
 	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
-	    ops->trampoline)
+	    ops->trampoline) {
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+				   ops->trampoline, ops->trampoline_size,
+				   true, FTRACE_TRAMPOLINE_SYM);
+		/* Remove from kallsyms after the perf events */
 		ftrace_remove_trampoline_from_kallsyms(ops);
+	}
 
 	arch_ftrace_trampoline_free(ops);
 }
@@ -6805,8 +6810,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	arch_ftrace_update_trampoline(ops);
 	if (ops->trampoline && ops->trampoline != trampoline &&
-	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP)) {
+		/* Add to kallsyms before the perf events */
 		ftrace_add_trampoline_to_kallsyms(ops);
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+				   ops->trampoline, ops->trampoline_size, false,
+				   FTRACE_TRAMPOLINE_SYM);
+	}
 }
 
 void ftrace_init_trace_array(struct trace_array *tr)
-- 
2.17.1

