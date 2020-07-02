Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79376C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE1C20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGBV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2F521534;
        Thu,  2 Jul 2020 21:58:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E0-004BfR-AI; Thu, 02 Jul 2020 17:58:32 -0400
Message-ID: <20200702215832.199933166@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-next][PATCH 05/18] tracing: not necessary to undefine DEFINE_EVENT again
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

After un-define DEFINE_EVENT in Stage 2, DEFINE_EVENT is not defined to a
specific form. It is not necessary to un-define it again.

Let's skip this.

Link: http://lkml.kernel.org/r/20200612092844.56107-2-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 502c7be50b8d..a4994761bdaf 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -443,9 +443,6 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
-#undef DEFINE_EVENT
-#define DEFINE_EVENT(template, name, proto, args)
-
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
@@ -523,9 +520,6 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
-#undef DEFINE_EVENT
-#define DEFINE_EVENT(template, name, proto, args)
-
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
 	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
-- 
2.26.2


