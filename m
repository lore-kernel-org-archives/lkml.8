Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2B0C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AA520732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgBXRXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgBXRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F93121D7E;
        Mon, 24 Feb 2020 17:21:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1j6HPx-001AfK-7b; Mon, 24 Feb 2020 12:21:17 -0500
Message-Id: <20200224172117.099980969@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 24 Feb 2020 12:20:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 08/15] tracing: Clear trace_state when starting trace
References: <20200224172022.330525468@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Clear trace_state data structure when starting trace
in __synth_event_trace_start() internal function.

Currently trace_state is initialized only in the
synth_event_trace_start() API, but the trace_state
in synth_event_trace() and synth_event_trace_array()
are on the stack without initialization.
This means those APIs will see wrong parameters and
wil skip closing process in __synth_event_trace_end()
because trace_state->disabled may be !0.

Link: http://lkml.kernel.org/r/158193315899.8868.1781259176894639952.stgit@devnote2

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f068d55bd37f..9d87aa1f0b79 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1824,6 +1824,8 @@ __synth_event_trace_start(struct trace_event_file *file,
 	int entry_size, fields_size = 0;
 	int ret = 0;
 
+	memset(trace_state, '\0', sizeof(*trace_state));
+
 	/*
 	 * Normal event tracing doesn't get called at all unless the
 	 * ENABLED bit is set (which attaches the probe thus allowing
@@ -2063,8 +2065,6 @@ int synth_event_trace_start(struct trace_event_file *file,
 	if (!trace_state)
 		return -EINVAL;
 
-	memset(trace_state, '\0', sizeof(*trace_state));
-
 	ret = __synth_event_trace_start(file, trace_state);
 	if (ret == -ENOENT)
 		ret = 0; /* just disabled, not really an error */
-- 
2.25.0


