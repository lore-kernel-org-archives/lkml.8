Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476DCC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B647207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 01:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGLBLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 21:11:46 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53205 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbgGLBLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 21:11:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2PGA0b_1594516294;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2PGA0b_1594516294)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 12 Jul 2020 09:11:34 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 2/4] tracing: save one trace_event->type by using __TRACE_LAST_TYPE
Date:   Sun, 12 Jul 2020 09:10:34 +0800
Message-Id: <20200712011036.70948-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
References: <20200712011036.70948-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static defined trace_event->type stops at (__TRACE_LAST_TYPE - 1) and
dynamic trace_event->type starts from (__TRACE_LAST_TYPE + 1).

To save one trace_event->type index, let's use __TRACE_LAST_TYPE.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/trace_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a35232d61601..4d1893564912 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -20,7 +20,7 @@ DECLARE_RWSEM(trace_event_sem);
 
 static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
 
-static int next_event_type = __TRACE_LAST_TYPE + 1;
+static int next_event_type = __TRACE_LAST_TYPE;
 
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
@@ -675,7 +675,7 @@ static LIST_HEAD(ftrace_event_list);
 static int trace_search_list(struct list_head **list)
 {
 	struct trace_event *e;
-	int next = __TRACE_LAST_TYPE + 1;
+	int next = __TRACE_LAST_TYPE;
 
 	if (list_empty(&ftrace_event_list)) {
 		*list = &ftrace_event_list;
-- 
2.20.1 (Apple Git-117)

