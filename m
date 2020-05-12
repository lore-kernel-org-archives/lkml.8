Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3092C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA272098B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgELMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:19:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgELMTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:36 -0400
IronPort-SDR: Zc3SSC43KXU7+tsBaIwa9o0o4exL44TlPJfgI1pUytr6mc+N1VwIbDPPpu3dtst9EYR4qDbHQF
 0WHzHYykCx0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:36 -0700
IronPort-SDR: T/8TaV9hjMK3Q43FnadbynK/DPIzoB0cFY4L0ui6LLeaPVP1YnBA2j7acbHk7KT6Ni2cv3UIAC
 9va03+iK1oFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879287"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V7 07/15] ftrace: Add perf ksymbol events for ftrace trampolines
Date:   Tue, 12 May 2020 15:19:14 +0300
Message-Id: <20200512121922.8997-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 9b0baeb4f0bb..1103a8fcf142 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2801,8 +2801,13 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
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
@@ -6815,8 +6820,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 
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

