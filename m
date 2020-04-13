Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5333C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40752087E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgDMPcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:32:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgDMPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A252DAC9B;
        Mon, 13 Apr 2020 15:32:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] tracing: Remove DECLARE_TRACE_NOARGS
Date:   Mon, 13 Apr 2020 18:32:46 +0300
Message-Id: <20200413153246.8511-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro was intentionally broken so that the kernel code is not
poluted with such noargs macro used simply as markers. This use case
can be satisfied by using dummy no inline functions. Just remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
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
2.17.1

