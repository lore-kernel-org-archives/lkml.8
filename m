Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EA520782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="AQxOqGkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHYPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:33:53 -0400
Received: from smtp2.axis.com ([195.60.68.18]:42874 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgHYPdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3188; q=dns/txt; s=axis-central1;
  t=1598369624; x=1629905624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9DWfFxacgfI90ODdFuxGvqVhFWoL7hEO0qJYfgj5pc=;
  b=AQxOqGkpkMa3/iroHdWTuz4b55j9rrZ+O6Pjhfq9UEk1K0MqoRebq4tU
   ooZqd+IekHiM0HDKa7Vlu/pD8rkEuAqjdPs/l6XoVLhega0SO+VkJM7V0
   KtBkd0VsHku3CbyTo8M19f4qRiIxgb4bP1E0SZqmgDIh7UoSj9zDIvv8G
   a3vzoOCCxPDDmzz5ZQjxC3qUdGAWSeodbm6HFCWmh9j2hL+2/6Lq5rqra
   MRgOsasR2f4uv/tkYbIJpvSMKeh7V3NZKRXZn4I6fHxHoohrDRCs+3+UC
   azzV2TzdWQQwU8vJgtUIcGbbC7v7ifD3t095E4yH0SrhzZYncLxv7A7Y6
   g==;
IronPort-SDR: YYBl7pzffhPWUUFqBB3dntU1FxuEU8rAOa8STLiMFJ66GbsatuUed1daoaZ7HCr9rmD7TV6Kf+
 9RD0k54Aaos+34Hp0vEfR/FenwT3DCAYRzYl8NR819NxXLGjYZCPInE2WGJiUaL3dgqTklX3K7
 kuPt+iMwJkesVHFi2qVXBCs/UdyK+CQhz/WFRoWzCzIZYeTw9EfMGjYdFavVD2+EQG5BC18ze/
 Ex+cq2+any95oEQB+Jlk3K87KgjpHEkiUQ5XmqsqajaOJUdl1VbPTUebnrZFuufvrucry/UUvN
 LnI=
X-IronPort-AV: E=Sophos;i="5.76,353,1592863200"; 
   d="scan'208";a="11853116"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jbaron@akamai.com>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <kernel@axis.com>, <corbet@lwn.net>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v3 1/2] dynamic debug: split enable and printk flags
Date:   Tue, 25 Aug 2020 17:33:37 +0200
Message-ID: <20200825153338.17061-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825153338.17061-1-vincent.whitchurch@axis.com>
References: <20200825153338.17061-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to add support to allow dynamic debug locations to print to
a trace event, and that will make _DPRINTK_FLAGS_PRINT a bit ambiguous.
Will it mean printk(), or printing to the trace event, or any of the
two?

To make it clearer, split _DPRINTK_FLAGS_PRINT into two:

 (1) _DPRINTK_FLAGS_PRINTK for turning on the printk() and
 (2) _DPRINTK_FLAGS_ENABLE when checking if the dynamic debug location
     is enabled.

_DPRINTK_FLAGS_ENABLE is currently just an alias of
_DPRINTK_FLAGS_PRINTK but will later also include a new flag for
enabling printing to the trace event.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 include/linux/dynamic_debug.h | 9 +++++----
 lib/dynamic_debug.c           | 8 ++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa9ff9e1c0b3..738421898aac 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -27,13 +27,14 @@ struct _ddebug {
 	 * writes commands to <debugfs>/dynamic_debug/control
 	 */
 #define _DPRINTK_FLAGS_NONE	0
-#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_ENABLE		_DPRINTK_FLAGS_PRINTK
 #if defined DEBUG
-#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
+#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
@@ -111,10 +112,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLE)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLE)
 #endif
 
 #endif
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..88af85cb5222 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -84,7 +84,7 @@ static inline const char *trim_prefix(const char *path)
 }
 
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_PRINTK, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
@@ -206,10 +206,10 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(modifiers->flags & _DPRINTK_FLAGS_PRINT))
+			if (dp->flags & _DPRINTK_FLAGS_ENABLE) {
+				if (!(modifiers->flags & _DPRINTK_FLAGS_ENABLE))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
+			} else if (modifiers->flags & _DPRINTK_FLAGS_ENABLE)
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-- 
2.28.0

