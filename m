Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57E822D03
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgHDU6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgHDU6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535C622BF3;
        Tue,  4 Aug 2020 20:58:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340i-006H9q-Ag; Tue, 04 Aug 2020 16:58:12 -0400
Message-ID: <20200804205812.216460366@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-linus][PATCH 02/17] tracing: Save one trace_event->type by using __TRACE_LAST_TYPE
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

Static defined trace_event->type stops at (__TRACE_LAST_TYPE - 1) and
dynamic trace_event->type starts from (__TRACE_LAST_TYPE + 1).

To save one trace_event->type index, let's use __TRACE_LAST_TYPE.

Link: https://lkml.kernel.org/r/20200703020612.12930-3-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
2.26.2


