Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF0722CA0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgHDU7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbgHDU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BFB722CBB;
        Tue,  4 Aug 2020 20:58:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340j-006HCQ-18; Tue, 04 Aug 2020 16:58:13 -0400
Message-ID: <20200804205812.917542970@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [for-linus][PATCH 07/17] tracing: Remove outdated comment in stack handling
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

This comment describes the behaviour before commit 2a820bf74918
("tracing: Use percpu stack trace buffer more intelligently").  Since
that commit, interrupts and NMIs do use the per-cpu stacks so the
comment is no longer correct.  Remove it.

(Note that the FTRACE_STACK_SIZE mentioned in the comment has never
existed, it probably should have said FTRACE_STACK_ENTRIES.)

Link: https://lkml.kernel.org/r/20200727092840.18659-1-vincent.whitchurch@axis.com

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4aab712f9567..dbcacdd56b02 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2930,12 +2930,6 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		skip++;
 #endif
 
-	/*
-	 * Since events can happen in NMIs there's no safe way to
-	 * use the per cpu ftrace_stacks. We reserve it and if an interrupt
-	 * or NMI comes in, it will just have to use the default
-	 * FTRACE_STACK_SIZE.
-	 */
 	preempt_disable_notrace();
 
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
-- 
2.26.2


