Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04B22068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="M5UNK1wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgGUOLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:11:25 -0400
Received: from smtp1.axis.com ([195.60.68.17]:38703 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgGUOLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=8960; q=dns/txt; s=axis-central1;
  t=1595340682; x=1626876682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TOYYPBavvt/Q4yO52CzIS5dWjGXXrosIPuNpI0GXQDI=;
  b=M5UNK1wbqJGO7IpZ8La91T3bM69wNuUIUHBhe0s/kTajTUUagAiXKnuP
   C9XI8z75h7Cu0Td5Wh+lw29r5LgaNT4vZ59qGBi7avPE5iDjJC7FaxqAO
   +ugpELtckua8czbx6BUGS/+/CTUvXriz0dXn6aa9Qimi33g5KTC8IiqNM
   wu+mLbblnyIQfxCqlLF2/fKvRKL62m2HDf2YoxycPvWHZefsJAkPukGFY
   eRYh0ItHe9sFrCvKkRoVFnhGY9uBh+PadUdilTvtLXa8h42nrlKEeUIeF
   /gYr6u3ZaFhgK7PQ41KdSprpKMu2MHO+u8sz2kDQHcJqWPGUtT42g3xrn
   Q==;
IronPort-SDR: SSWOXADTagX53bICgAuiJUB9wRJWsI4lgj3QUfkTBfGy0poHEhEs+gFhb7w1H6/PTNAcfXr2lo
 ZhO69fLaGwkvDb71Wtd0JVZZXrB8kxz6A/sVFQ5Yy8AXARNPnxHjG641tFsRMoG0IC92/5F27C
 /BgHPWu4W8jBD3UVpPOv950lE+/O+eL69CkZjQxtrJBSulyho3nEsHBmxAYz3+L9qGhGVudOQW
 c3YVkNT9SxOv5f/hLozhMMpn/NyVCXcNjiZXm6dQhapPhfw00ByGapL2Wj6oPZi7XKFQoiPl9y
 wD0=
X-IronPort-AV: E=Sophos;i="5.75,379,1589234400"; 
   d="scan'208";a="11073013"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jbaron@akamai.com>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <kernel@axis.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] dynamic debug: allow printing to trace event
Date:   Tue, 21 Jul 2020 16:11:05 +0200
Message-ID: <20200721141105.16034-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging device drivers, I've found it very useful to be able to
redirect existing pr_debug()/dev_dbg() prints to the trace buffer
instead of dmesg.  Among the many advantages of the trace buffer is that
it can be dynamically resized, allows these prints to combined with
other trace events, and doesn't fill up system logs.

Since dynamic debug already has hooks in these call sites, getting these
prints into the ftrace buffer is straightforward if we have dynamic
debug do it.

Add an "x" flag to make the dynamic debug call site print to a new
printk:dynamic trace event.  The trace event can be emitted instead of
or in addition to the printk().  The print buffer is placed on the stack
and is limited to a somewhat arbitrarily chosen 256 bytes; anything
larger will be truncated.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |   1 +
 include/linux/dynamic_debug.h                 |   7 +-
 include/trace/events/printk.h                 |  16 +++
 lib/dynamic_debug.c                           | 124 ++++++++++++++----
 4 files changed, 120 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 1012bd9305e9..b235327fbb53 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -224,6 +224,7 @@ of the characters::
 The flags are::
 
   p    enables the pr_debug() callsite.
+  x    enables trace to the printk:dynamic event
   f    Include the function name in the printed message
   l    Include line number in the printed message
   m    Include module name in the printed message
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index abcd5fde30eb..9dee405985c4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -27,13 +27,16 @@ struct _ddebug {
 	 * writes commands to <debugfs>/dynamic_debug/control
 	 */
 #define _DPRINTK_FLAGS_NONE	0
-#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_TRACE		(1<<5)
+#define _DPRINTK_FLAGS_PRINT		(_DPRINTK_FLAGS_PRINTK | \
+					 _DPRINTK_FLAGS_TRACE)
 #if defined DEBUG
-#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
+#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
index 13d405b2fd8b..696d6e19a9b7 100644
--- a/include/trace/events/printk.h
+++ b/include/trace/events/printk.h
@@ -31,6 +31,22 @@ TRACE_EVENT(console,
 
 	TP_printk("%s", __get_str(msg))
 );
+
+TRACE_EVENT(dynamic,
+	TP_PROTO(const char *message),
+
+	TP_ARGS(message),
+
+	TP_STRUCT__entry(
+		__string(message, message)
+	),
+
+	TP_fast_assign(
+		__assign_str(message, message);
+	),
+
+	TP_printk("%s", __get_str(message))
+);
 #endif /* _TRACE_PRINTK_H */
 
 /* This part must be outside protection */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 321437bbf87d..9f6d8867af7c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <trace/events/printk.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -79,11 +80,12 @@ static inline const char *trim_prefix(const char *path)
 }
 
 static struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_PRINTK, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
+	{ _DPRINTK_FLAGS_TRACE, 'x' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
@@ -550,6 +552,65 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	return buf;
 }
 
+static void dynamic_trace(const char *fmt, va_list args)
+{
+	char buf[256];
+	int len;
+
+	len = vscnprintf(buf, sizeof(buf), fmt, args);
+	if (!len)
+		return;
+
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+
+	trace_dynamic(buf);
+}
+
+static void dynamic_printk(unsigned int flags, const char *fmt, ...)
+{
+	if (flags & _DPRINTK_FLAGS_TRACE) {
+		va_list args;
+
+		va_start(args, fmt);
+		/*
+		 * All callers include the KERN_DEBUG prefix to keep the
+		 * vprintk case simple; strip it out for tracing.
+		 */
+		dynamic_trace(fmt + strlen(KERN_DEBUG), args);
+		va_end(args);
+	}
+
+	if (flags & _DPRINTK_FLAGS_PRINTK) {
+		va_list args;
+
+		va_start(args, fmt);
+		vprintk(fmt, args);
+		va_end(args);
+	}
+}
+
+static void dynamic_dev_printk(unsigned int flags, const struct device *dev,
+			       const char *fmt, ...)
+{
+
+	if (flags & _DPRINTK_FLAGS_TRACE) {
+		va_list args;
+
+		va_start(args, fmt);
+		dynamic_trace(fmt, args);
+		va_end(args);
+	}
+
+	if (flags & _DPRINTK_FLAGS_PRINTK) {
+		va_list args;
+
+		va_start(args, fmt);
+		dev_vprintk_emit(LOGLEVEL_DEBUG, dev, fmt, args);
+		va_end(args);
+	}
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
@@ -564,7 +625,8 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
+	dynamic_printk(descriptor->flags, KERN_DEBUG "%s%pV",
+		       dynamic_emit_prefix(descriptor, buf), &vaf);
 
 	va_end(args);
 }
@@ -574,6 +636,7 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 		      const struct device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -583,16 +646,18 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
+	flags = descriptor->flags;
 
 	if (!dev) {
-		printk(KERN_DEBUG "(NULL device *): %pV", &vaf);
+		dynamic_printk(flags, KERN_DEBUG "(NULL device *): %pV",
+			      &vaf);
 	} else {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
-				dev_driver_string(dev), dev_name(dev),
-				&vaf);
+		dynamic_dev_printk(flags, dev, "%s%s %s: %pV",
+				   dynamic_emit_prefix(descriptor, buf),
+				   dev_driver_string(dev), dev_name(dev),
+				   &vaf);
 	}
 
 	va_end(args);
@@ -605,6 +670,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -614,22 +680,24 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
+	flags = descriptor->flags;
 
 	if (dev && dev->dev.parent) {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
-				"%s%s %s %s%s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
-				dev_driver_string(dev->dev.parent),
-				dev_name(dev->dev.parent),
-				netdev_name(dev), netdev_reg_state(dev),
-				&vaf);
+		dynamic_dev_printk(flags, dev->dev.parent,
+				   "%s%s %s %s%s: %pV",
+				   dynamic_emit_prefix(descriptor, buf),
+				   dev_driver_string(dev->dev.parent),
+				   dev_name(dev->dev.parent),
+				   netdev_name(dev), netdev_reg_state(dev),
+				   &vaf);
 	} else if (dev) {
-		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
-		       netdev_reg_state(dev), &vaf);
+		dynamic_printk(flags, KERN_DEBUG "%s%s: %pV",
+			       netdev_name(dev), netdev_reg_state(dev), &vaf);
 	} else {
-		printk(KERN_DEBUG "(NULL net_device): %pV", &vaf);
+		dynamic_printk(flags, KERN_DEBUG "(NULL net_device): %pV",
+			       &vaf);
 	}
 
 	va_end(args);
@@ -644,27 +712,31 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
+	flags = descriptor->flags;
 
 	if (ibdev && ibdev->dev.parent) {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
-				"%s%s %s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
-				dev_driver_string(ibdev->dev.parent),
-				dev_name(ibdev->dev.parent),
-				dev_name(&ibdev->dev),
-				&vaf);
+		dynamic_dev_printk(flags, ibdev->dev.parent,
+				   "%s%s %s %s: %pV",
+				   dynamic_emit_prefix(descriptor, buf),
+				   dev_driver_string(ibdev->dev.parent),
+				   dev_name(ibdev->dev.parent),
+				   dev_name(&ibdev->dev),
+				   &vaf);
 	} else if (ibdev) {
-		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
+		dynamic_printk(flags, KERN_DEBUG "%s: %pV",
+			       dev_name(&ibdev->dev), &vaf);
 	} else {
-		printk(KERN_DEBUG "(NULL ib_device): %pV", &vaf);
+		dynamic_printk(flags, KERN_DEBUG "(NULL ib_device): %pV",
+			       &vaf);
 	}
 
 	va_end(args);
-- 
2.25.1

