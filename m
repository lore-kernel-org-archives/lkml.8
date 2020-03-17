Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222FD20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCQVfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbgCQVeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1980D20880;
        Tue, 17 Mar 2020 21:34:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEJqr-000EZi-0n; Tue, 17 Mar 2020 17:34:17 -0400
Message-Id: <20200317213416.903351225@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:32:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [RFC][PATCH 09/11] tracing: Do not disable tracing when reading the trace file
References: <20200317213222.421100128@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When opening the "trace" file, it is no longer necessary to disable tracing.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1085b3d5d0dc..a60f49c401f9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4261,10 +4261,6 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 	if (trace_clocks[tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
 
-	/* stop the trace while dumping if we are not opening "snapshot" */
-	if (!iter->snapshot)
-		tracing_stop_tr(tr);
-
 	if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			iter->buffer_iter[cpu] =
@@ -4358,10 +4354,6 @@ static int tracing_release(struct inode *inode, struct file *file)
 	if (iter->trace && iter->trace->close)
 		iter->trace->close(iter);
 
-	if (!iter->snapshot)
-		/* reenable tracing if it was previously enabled */
-		tracing_start_tr(tr);
-
 	__trace_array_put(tr);
 
 	mutex_unlock(&trace_types_lock);
-- 
2.25.1


