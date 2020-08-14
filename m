Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50399C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B31520791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="Q8PTC4Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHNNb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:31:56 -0400
Received: from smtp1.axis.com ([195.60.68.17]:55130 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgHNNb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=10159; q=dns/txt; s=axis-central1;
  t=1597411915; x=1628947915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0pgMPV92f759j772BAb65TdIH1uz74Ejo9KR80SU1HU=;
  b=Q8PTC4EuDRxOBrIPR5hcTZZKxPMHpSUutrkeB8eCMa9Jz4ZZHkYfpH1I
   UeCcF//XeQW2WDKTVK2Rh5TggnpIJIVLJW6l17cigD2jqeiRMIyFWKXzw
   bHQlTWZKElI/X1GU0ZLZfUtA0Q6jbzRX3eUtA+EzrPscfTTJ+1Ecq+VUs
   sof1Zdk+9tSpqA8eDmd2VJz4OyuX5jW7ODsVTkHVf0KGbB1eE349zJ7EM
   Hv9LcMZE0YoIsmgw4IJgfXnGapNxizbeOivSwhqprldFwsFqZe0s5dBGX
   I8Tk+wbwMkrYAidG3nBcyUYKQkh7sX3ugaEdWbqRcO/04Lz/NnFe48t7S
   w==;
IronPort-SDR: sMWGEmpxnLxU8ogXyUUWxWrdbbvFlnQ8FkWgQPPmXmQPSLBPr6HuCmUziTwNd+26CAaH58/tI/
 VOB9C34IxJt1RuhLL1DNuTcGQd7i9G1XFUP/KBBvs+lH1eOyVmNUp4qocs8lczgMEYXs8h8YAz
 8R/lXDZEZNYJfeTMth1Agur3aLJEUXeH+t3a6S25xC8cFY80LX8E/X4c5pJjPh+KR0pIu2HaCz
 Qsvjeaovtg9uvbKY0gEJTQ312SxwM/+OHjwKwoAcQ4YXAjqnL+jv6qlnOgbY/+q40tSBnzzz77
 fSs=
X-IronPort-AV: E=Sophos;i="5.76,312,1592863200"; 
   d="scan'208";a="11808837"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jbaron@akamai.com>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <kernel@axis.com>, <corbet@lwn.net>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2] dynamic debug: allow printing to trace event
Date:   Fri, 14 Aug 2020 15:31:51 +0200
Message-ID: <20200814133151.7759-1-vincent.whitchurch@axis.com>
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
or in addition to the printk().

The print buffer is statically allocated and managed using code borrowed
from __ftrace_trace_stack() and is limited to 256 bytes (four of these
are allocated per CPU to handle the various contexts); anything larger
will be truncated.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2:
 - Remove stack buffer and use code similar to __ftrace_trace_stack()
 - Use an event with the same class as printk:console

 .../admin-guide/dynamic-debug-howto.rst       |   1 +
 include/linux/dynamic_debug.h                 |   7 +-
 include/trace/events/printk.h                 |  12 +-
 lib/dynamic_debug.c                           | 155 +++++++++++++++---
 4 files changed, 146 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e5a8def45f3f..d2ebee464db7 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -229,6 +229,7 @@ of the characters::
 The flags are::
 
   p    enables the pr_debug() callsite.
+  x    enables trace to the printk:dynamic event
   f    Include the function name in the printed message
   l    Include line number in the printed message
   m    Include module name in the printed message
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aa9ff9e1c0b3..f599ed21ecc5 100644
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
index 13d405b2fd8b..6c89121a1669 100644
--- a/include/trace/events/printk.h
+++ b/include/trace/events/printk.h
@@ -7,7 +7,7 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(console,
+DECLARE_EVENT_CLASS(printk,
 	TP_PROTO(const char *text, size_t len),
 
 	TP_ARGS(text, len),
@@ -31,6 +31,16 @@ TRACE_EVENT(console,
 
 	TP_printk("%s", __get_str(msg))
 );
+
+DEFINE_EVENT(printk, console,
+	TP_PROTO(const char *text, size_t len),
+	TP_ARGS(text, len)
+);
+
+DEFINE_EVENT(printk, dynamic,
+	TP_PROTO(const char *text, size_t len),
+	TP_ARGS(text, len)
+);
 #endif /* _TRACE_PRINTK_H */
 
 /* This part must be outside protection */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..76fc3e33fe41 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <trace/events/printk.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -84,11 +85,12 @@ static inline const char *trim_prefix(const char *path)
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
 
@@ -600,6 +602,96 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	return buf;
 }
 
+/*
+ * This code is heavily based on __ftrace_trace_stack().
+ *
+ * Allow 4 levels of nesting: normal, softirq, irq, NMI.
+ */
+#define DYNAMIC_TRACE_NESTING	4
+
+struct dynamic_trace_buf {
+	char buf[256];
+};
+
+struct dynamic_trace_bufs {
+	struct dynamic_trace_buf bufs[DYNAMIC_TRACE_NESTING];
+};
+
+static DEFINE_PER_CPU(struct dynamic_trace_bufs, dynamic_trace_bufs);
+static DEFINE_PER_CPU(int, dynamic_trace_reserve);
+
+static void dynamic_trace(const char *fmt, va_list args)
+{
+	struct dynamic_trace_buf *buf;
+	int bufidx;
+	int len;
+
+	preempt_disable_notrace();
+
+	bufidx = __this_cpu_inc_return(dynamic_trace_reserve) - 1;
+
+	if (WARN_ON_ONCE(bufidx > DYNAMIC_TRACE_NESTING))
+		goto out;
+
+	/* For the same reasons as in __ftrace_trace_stack(). */
+	barrier();
+
+	buf = this_cpu_ptr(dynamic_trace_bufs.bufs) + bufidx;
+
+	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
+	trace_dynamic(buf->buf, len);
+
+out:
+	/* As above. */
+	barrier();
+	__this_cpu_dec(dynamic_trace_reserve);
+	preempt_enable_notrace();
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
@@ -614,7 +706,8 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
+	dynamic_printk(descriptor->flags, KERN_DEBUG "%s%pV",
+		       dynamic_emit_prefix(descriptor, buf), &vaf);
 
 	va_end(args);
 }
@@ -624,6 +717,7 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 		      const struct device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -633,16 +727,18 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 
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
@@ -655,6 +751,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -664,22 +761,24 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
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
@@ -694,27 +793,31 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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

