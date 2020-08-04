Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F322D74
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgHDU6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgHDU6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C8E22B42;
        Tue,  4 Aug 2020 20:58:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340i-006H9J-6K; Tue, 04 Aug 2020 16:58:12 -0400
Message-ID: <20200804205812.055623798@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-linus][PATCH 01/17] tracing: Simplify defining of the next event id
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

The value to be used and compared in trace_search_list() is "last + 1".
Let's just define next to be "last + 1" instead of doing the addition
each time.

Link: https://lkml.kernel.org/r/20200703020612.12930-2-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 73976de7f8cc..a35232d61601 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -675,11 +675,11 @@ static LIST_HEAD(ftrace_event_list);
 static int trace_search_list(struct list_head **list)
 {
 	struct trace_event *e;
-	int last = __TRACE_LAST_TYPE;
+	int next = __TRACE_LAST_TYPE + 1;
 
 	if (list_empty(&ftrace_event_list)) {
 		*list = &ftrace_event_list;
-		return last + 1;
+		return next;
 	}
 
 	/*
@@ -687,17 +687,17 @@ static int trace_search_list(struct list_head **list)
 	 * lets see if somebody freed one.
 	 */
 	list_for_each_entry(e, &ftrace_event_list, list) {
-		if (e->type != last + 1)
+		if (e->type != next)
 			break;
-		last++;
+		next++;
 	}
 
 	/* Did we used up all 65 thousand events??? */
-	if ((last + 1) > TRACE_EVENT_TYPE_MAX)
+	if (next > TRACE_EVENT_TYPE_MAX)
 		return 0;
 
 	*list = &e->list;
-	return last + 1;
+	return next;
 }
 
 void trace_event_read_lock(void)
-- 
2.26.2


