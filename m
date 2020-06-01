Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B31C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F762077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFAM2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgFAM2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA45920825;
        Mon,  1 Jun 2020 12:28:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjY0-00279O-QI; Mon, 01 Jun 2020 08:28:08 -0400
Message-ID: <20200601122808.686678967@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [for-next][PATCH 11/12] ftrace,bug: Improve traceoff_on_warn
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

While doing some tracing, I found a huge portion of the per-cpu buffer
was taken by printk/serial output because we're disabling the trace far
too late (after printing the CUT string).

Improve matters for architectures that have GENERIC_BUG + _BUG_FLAGS by
killing the tracer in the exception handler before printing anything
much.

Link: https://lkml.kernel.org/r/20200528145240.GF706495@hirez.programming.kicks-ass.net

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bug.c b/lib/bug.c
index 8c98af0bf585..7103440c0ee1 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -47,6 +47,7 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
 #include <linux/rculist.h>
+#include <linux/ftrace.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -153,6 +154,8 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	if (!bug)
 		return BUG_TRAP_TYPE_NONE;
 
+	disable_trace_on_warning();
+
 	file = NULL;
 	line = 0;
 	warning = 0;
-- 
2.26.2


