Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2057822D03
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHDU6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgHDU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBEE22CA0;
        Tue,  4 Aug 2020 20:58:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1k340j-006HDy-Eu; Tue, 04 Aug 2020 16:58:13 -0400
Message-ID: <20200804205813.348568049@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 04 Aug 2020 16:57:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [for-linus][PATCH 10/17] tracepoint: Use __used attribute definitions from
 compiler_attributes.h
References: <20200804205743.419135730@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

Just a small cleanup while I was touching this header.
compiler_attributes.h does feature detection of these __attributes__(())
and provides more concise ways to invoke them.

Link: https://lkml.kernel.org/r/20200730224555.2142154-3-ndesaulniers@google.com

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 3a5b717d92e8..598fec9f9dbf 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -116,8 +116,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define __TRACEPOINT_ENTRY(name)					 \
 	static tracepoint_ptr_t __tracepoint_ptr_##name __used		 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name
+	__section(__tracepoints_ptrs) = &__tracepoint_##name
 #endif
 
 #endif /* _LINUX_TRACEPOINT_H */
@@ -280,9 +279,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 #define DEFINE_TRACE_FN(name, reg, unreg)				 \
 	static const char __tpstrtab_##name[]				 \
-	__attribute__((section("__tracepoints_strings"))) = #name;	 \
-	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"), used)) =		 \
+	__section(__tracepoints_strings) = #name;			 \
+	struct tracepoint __tracepoint_##name __used			 \
+	__section(__tracepoints) =					 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
 	__TRACEPOINT_ENTRY(name);
 
@@ -361,7 +360,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		static const char *___tp_str __tracepoint_string = str; \
 		___tp_str;						\
 	})
-#define __tracepoint_string	__attribute__((section("__tracepoint_str"), used))
+#define __tracepoint_string	__used __section(__tracepoint_str)
 #else
 /*
  * tracepoint_string() is used to save the string address for userspace
-- 
2.26.2


