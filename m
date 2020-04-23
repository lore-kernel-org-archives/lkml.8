Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B20BC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B6B2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgDWXTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgDWXTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:19:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94891216FD;
        Thu, 23 Apr 2020 23:19:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jRl7o-000Ysl-GT; Thu, 23 Apr 2020 19:19:20 -0400
Message-Id: <20200423231920.393503922@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 19:18:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [for-linus][PATCH 3/4] tracing: Remove DECLARE_TRACE_NOARGS
References: <20200423231838.682478056@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

This macro was intentionally broken so that the kernel code is not
poluted with such noargs macro used simply as markers. This use case
can be satisfied by using dummy no inline functions. Just remove it.

Link: http://lkml.kernel.org/r/20200413153246.8511-1-nborisov@suse.com

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c53..a1fecf311621 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -156,8 +156,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * Note, the proto and args passed in includes "__data" as the first parameter.
  * The reason for this is to handle the "void" prototype. If a tracepoint
  * has a "void" prototype, then it is invalid to declare a function
- * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
- * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
+ * as "(void *, void)".
  */
 #define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
 	do {								\
@@ -373,25 +372,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 # define __tracepoint_string
 #endif
 
-/*
- * The need for the DECLARE_TRACE_NOARGS() is to handle the prototype
- * (void). "void" is a special value in a function prototype and can
- * not be combined with other arguments. Since the DECLARE_TRACE()
- * macro adds a data element at the beginning of the prototype,
- * we need a way to differentiate "(void *data, proto)" from
- * "(void *data, void)". The second prototype is invalid.
- *
- * DECLARE_TRACE_NOARGS() passes "void" as the tracepoint prototype
- * and "void *__data" as the callback prototype.
- *
- * DECLARE_TRACE() passes "proto" as the tracepoint protoype and
- * "void *__data, proto" as the callback prototype.
- */
-#define DECLARE_TRACE_NOARGS(name)					\
-	__DECLARE_TRACE(name, void, ,					\
-			cpu_online(raw_smp_processor_id()),		\
-			void *__data, __data)
-
 #define DECLARE_TRACE(name, proto, args)				\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
 			cpu_online(raw_smp_processor_id()),		\
-- 
2.26.1


