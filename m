Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38FFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 01:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84D1206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 01:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgGLBLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 21:11:36 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48635 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbgGLBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 21:11:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2PF1Lq_1594516293;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2PF1Lq_1594516293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Jul 2020 09:11:33 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 1/4] tracing: simplify the logic by defining next to be "lasst + 1"
Date:   Sun, 12 Jul 2020 09:10:33 +0800
Message-Id: <20200712011036.70948-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
References: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value to be used and compared in trace_search_list() is "last + 1".
Let's just define next to be "last + 1" instead of doing the addition
each time.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
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
2.20.1 (Apple Git-117)

