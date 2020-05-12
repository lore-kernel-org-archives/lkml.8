Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB7AC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52088206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgELMTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:19:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:43213 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgELMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:19:40 -0400
IronPort-SDR: dHWVWfgUns/aGRR/OwiyjJFf3f3qjtcMLd+LGW/LI4w86kspBAZaS7PlwG8H5eWW6XNOAOV0z4
 dQSKjuUd7zGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:19:40 -0700
IronPort-SDR: 8kJ/1g11Ha10ZzEkMxtOCtWr7YsFkm4MU7d7STfk3M+/Nb394wY4l1EnxrYDEYddfT3wWVJxbt
 ysUCYg0CDrmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="250879308"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2020 05:19:36 -0700
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
Subject: [PATCH V7 08/15] ftrace: Add perf text poke events for ftrace trampolines
Date:   Tue, 12 May 2020 15:19:15 +0300
Message-Id: <20200512121922.8997-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512121922.8997-1-adrian.hunter@intel.com>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf text poke events for ftrace trampolines when created and when
freed.

There can be 3 text_poke events for ftrace trampolines:

1. NULL -> trampoline
   By ftrace_update_trampoline() when !ops->trampoline
   Trampoline created

2. [e.g. on x86] CALL rel32 -> CALL rel32
   By arch_ftrace_update_trampoline() when ops->trampoline and
                        ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
   [e.g. on x86] via text_poke_bp() which generates text poke events
   Trampoline-called function target updated

3. trampoline -> NULL
   By ftrace_trampoline_free() when ops->trampoline and
                 ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
   Trampoline freed

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/ftrace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1103a8fcf142..abdf8f415a6e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2802,6 +2802,13 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
 {
 	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
 	    ops->trampoline) {
+		/*
+		 * Record the text poke event before the ksymbol unregister
+		 * event.
+		 */
+		perf_event_text_poke((void *)ops->trampoline,
+				     (void *)ops->trampoline,
+				     ops->trampoline_size, NULL, 0);
 		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
 				   ops->trampoline, ops->trampoline_size,
 				   true, FTRACE_TRAMPOLINE_SYM);
@@ -6826,6 +6833,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
 				   ops->trampoline, ops->trampoline_size, false,
 				   FTRACE_TRAMPOLINE_SYM);
+		/*
+		 * Record the perf text poke event after the ksymbol register
+		 * event.
+		 */
+		perf_event_text_poke((void *)ops->trampoline, NULL, 0,
+				     (void *)ops->trampoline,
+				     ops->trampoline_size);
 	}
 }
 
-- 
2.17.1

