Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA66C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79712072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgCDJHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:07:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:17638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387761AbgCDJHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:07:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="413074288"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 01:07:49 -0800
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
Subject: [PATCH V4 08/13] ftrace: Add perf text poke events for ftrace trampolines
Date:   Wed,  4 Mar 2020 11:06:28 +0200
Message-Id: <20200304090633.420-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304090633.420-1-adrian.hunter@intel.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
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
index fda0c9144642..75f9aac31fec 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2795,6 +2795,13 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
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
@@ -6812,6 +6819,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
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

