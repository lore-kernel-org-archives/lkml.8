Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEBAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911F2207E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGCCGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:06:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51245 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbgGCCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:06:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U1XOPYH_1593741974;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U1XOPYH_1593741974)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:06:15 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/5] tracing: simplify the logic by defining next to be "lasst + 1"
Date:   Fri,  3 Jul 2020 10:06:09 +0800
Message-Id: <20200703020612.12930-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
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
index 47bf9f042b97..b704b3ef4264 100644
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

