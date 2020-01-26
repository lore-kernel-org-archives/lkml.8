Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00AAC35247
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF2921927
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 19:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgAZTUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 14:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:53702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgAZTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 14:20:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FEEB21556;
        Sun, 26 Jan 2020 19:20:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ivnSH-000zs2-64; Sun, 26 Jan 2020 14:20:21 -0500
Message-Id: <20200126192021.069996945@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 Jan 2020 14:19:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hou Pengyang <houpengyang@huawei.com>
Subject: [for-next][PATCH 5/7] tracing: Fix comments about trace/ftrace.h
References: <20200126191932.984391723@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Pengyang <houpengyang@huawei.com>

commit f42c85e74faa422cf0bc747ed808681145448f88 moved tracepoint's ftrace
creation into include/trace/ftrace.h and trace/define_trace.h was deleted
as a result. However some comment info does not adapt to the change, which
is such a misguiding when reading related code.

This patch fix this by moving trace/trace_events.h to <trace/events/XXX.h>,
since tracepoint headers have already been moved to tarce/events/.

Link: http://lkml.kernel.org/r/1425419298-61941-1-git-send-email-houpengyang@huawei.com

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
[ Pulled from the archeological digging of my INBOX ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 13a58d453992..831048507fef 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -2,7 +2,8 @@
 /*
  * Stage 1 of the trace events.
  *
- * Override the macros in <trace/trace_events.h> to include the following:
+ * Override the macros in the event tracepoint header <trace/events/XXX.h>
+ * to include the following:
  *
  * struct trace_event_raw_<call> {
  *	struct trace_entry		ent;
@@ -223,7 +224,8 @@ TRACE_MAKE_SYSTEM_STR();
 /*
  * Stage 3 of the trace events.
  *
- * Override the macros in <trace/trace_events.h> to include the following:
+ * Override the macros in the event tracepoint header <trace/events/XXX.h>
+ * to include the following:
  *
  * enum print_line_t
  * trace_raw_output_<call>(struct trace_iterator *iter, int flags)
@@ -555,7 +557,8 @@ static inline notrace int trace_event_get_offsets_##call(		\
 /*
  * Stage 4 of the trace events.
  *
- * Override the macros in <trace/trace_events.h> to include the following:
+ * Override the macros in the event tracepoint header <trace/events/XXX.h>
+ * to include the following:
  *
  * For those macros defined with TRACE_EVENT:
  *
-- 
2.24.1


