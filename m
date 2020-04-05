Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A905EC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6D2072F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgDEUOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:14:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:62225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgDEUOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:14:50 -0400
IronPort-SDR: NeCfW+PsRJd2QT15VsPwCBqo1wFUGDoccAXMKWgQCUx1aYoPWnuz5vPLVtN/4YnAKK/B7M+hL+
 HxT2xw6OKEmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 13:14:48 -0700
IronPort-SDR: nAz0zEyAUNi/4Q4cIYuoxGYec2pcaf887fY+E8VeRg2C2WjHHYEh+YoD6NA0OBj9AHtQ7nKpOI
 2CQgY3LasVzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329688426"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 13:14:46 -0700
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
Subject: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace trampolines
Date:   Sun,  5 Apr 2020 23:13:20 +0300
Message-Id: <20200405201327.7332-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405201327.7332-1-adrian.hunter@intel.com>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf text poke events for ftrace trampolines when created and when
freed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/trace/ftrace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 398d58b8ffa5..3318f7eca76c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2792,6 +2792,13 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
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
@@ -6816,6 +6823,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
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

