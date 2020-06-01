Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8ACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52CF207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAM2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgFAM2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF29C20897;
        Mon,  1 Jun 2020 12:28:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjY0-00279u-Ur; Mon, 01 Jun 2020 08:28:08 -0400
Message-ID: <20200601122808.839838080@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [for-next][PATCH 12/12] tracing: Add a trace print when traceoff_on_warning is triggered
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When "traceoff_on_warning" is enabled and a warning happens, there can still
be many trace events happening on other CPUs between the time the warning
occurred and the last trace event on that same CPU. This can cause confusion
in examining the trace, as it may not be obvious where the warning happened.
By adding a trace print into the trace just before disabling tracing, it
makes it obvious where the warning occurred, and the developer doesn't have
to look at other means to see what CPU it occurred on.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 29615f15a820..760fd102dbe2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1299,8 +1299,11 @@ EXPORT_SYMBOL_GPL(tracing_off);
 
 void disable_trace_on_warning(void)
 {
-	if (__disable_trace_on_warning)
+	if (__disable_trace_on_warning) {
+		trace_array_printk_buf(global_trace.array_buffer.buffer, _THIS_IP_,
+			"Disabling tracing due to warning\n");
 		tracing_off();
+	}
 }
 
 /**
-- 
2.26.2


