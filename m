Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7000C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A008C207E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGCCGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:06:21 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39515 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgGCCGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:06:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1XOPYA_1593741974;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1XOPYA_1593741974)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:06:14 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/5] tracing: use union to simplify the trace_event_functions initialization
Date:   Fri,  3 Jul 2020 10:06:08 +0800
Message-Id: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are for 4 fields in trace_event_functions with the same type of
trace_print_func. Initialize them in register_trace_event() one by one
looks redundant.

Let's take advantage of union to simplify the procedure.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/trace_events.h | 13 +++++++++----
 kernel/trace/trace_output.c  | 14 +++++---------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5c6943354049..1a421246f4a2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -122,10 +122,15 @@ typedef enum print_line_t (*trace_print_func)(struct trace_iterator *iter,
 				      int flags, struct trace_event *event);
 
 struct trace_event_functions {
-	trace_print_func	trace;
-	trace_print_func	raw;
-	trace_print_func	hex;
-	trace_print_func	binary;
+	union {
+		struct {
+			trace_print_func	trace;
+			trace_print_func	raw;
+			trace_print_func	hex;
+			trace_print_func	binary;
+		};
+		trace_print_func print_funcs[4];
+	};
 };
 
 struct trace_event {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 73976de7f8cc..47bf9f042b97 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -728,7 +728,7 @@ void trace_event_read_unlock(void)
 int register_trace_event(struct trace_event *event)
 {
 	unsigned key;
-	int ret = 0;
+	int i, ret = 0;
 
 	down_write(&trace_event_sem);
 
@@ -770,14 +770,10 @@ int register_trace_event(struct trace_event *event)
 			goto out;
 	}
 
-	if (event->funcs->trace == NULL)
-		event->funcs->trace = trace_nop_print;
-	if (event->funcs->raw == NULL)
-		event->funcs->raw = trace_nop_print;
-	if (event->funcs->hex == NULL)
-		event->funcs->hex = trace_nop_print;
-	if (event->funcs->binary == NULL)
-		event->funcs->binary = trace_nop_print;
+	for (i = 0; i < ARRAY_SIZE(event->funcs->print_funcs); i++) {
+		if (!event->funcs->print_funcs[i])
+			event->funcs->print_funcs[i] = trace_nop_print;
+	}
 
 	key = event->type & (EVENT_HASHSIZE - 1);
 
-- 
2.20.1 (Apple Git-117)

