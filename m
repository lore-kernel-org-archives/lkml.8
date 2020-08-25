Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A6DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B0A207DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="EF9lKHIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHYPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:34:14 -0400
Received: from smtp2.axis.com ([195.60.68.18]:42892 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHYPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=9504; q=dns/txt; s=axis-central1;
  t=1598369632; x=1629905632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8WhMDL8LJEs1e0sSsXwxr1TN3f4XeNkg2mUjGIX/ww=;
  b=EF9lKHINVUZrlj5H+u9vAlbTuZ/TRk8S9J6/LOWlOsu5c81PPbzUVXD5
   qDlR/2QAUDb8NLNj02A5gcpy8LCCLqjNhq6F+nsWTMSZr7jwq/4ArJ1Gh
   lhkbXyDX05aG7svwA0/wrmnfuLXMBf05rHchPp/8JyZJ3VQNPobPTfR1/
   een6BiOwkxvRHhsurn/fjofxr5Uhag0VXs6ZW8tI/hIeJE+cUo2TfbPtM
   fJMNhc0KfCglRuMHwJ+Ei5UcdKsfVRFOa1VhAaIz/Amazb0G51YDE5BQL
   VhHleox+m2E0sBl7fTKpeLaN+bezqz57vkXBrpXRff49ulW1bAzO0N48D
   Q==;
IronPort-SDR: lW75XlzX18EBI1ODyecotQf2cXZS30lZjmIcJvGWdU/BpR4jPsegxV/O821FPxfMMhaAUpgjG+
 W7WB2cdhYdHEaKdYtcpvInzRc2jyJuE//AdWLs/jvocxOvgTe7H48rzK3iS8XJ2k9qlw2QT2uW
 MBlFapRRzUp699bB5nye4gfk1RpQz2srPcOiRHVAJLtFUpkNlNp8siiaEnAQBMLeCkW4V9AmeP
 h2VEu2A43HXThOXdcSTT8rCxZDngKPYRwarxwePJmbzXeh1uJXllj7OgpykuZM994sfbt+TiKT
 rwM=
X-IronPort-AV: E=Sophos;i="5.76,353,1592863200"; 
   d="scan'208";a="11853118"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jbaron@akamai.com>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <kernel@axis.com>, <corbet@lwn.net>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v3 2/2] dynamic debug: allow printing to trace event
Date:   Tue, 25 Aug 2020 17:33:38 +0200
Message-ID: <20200825153338.17061-3-vincent.whitchurch@axis.com>
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

When debugging device drivers, I've found it very useful to be able to
redirect existing pr_debug()/dev_dbg() prints to the trace buffer
instead of dmesg.  Among the many advantages of the trace buffer is that
it can be dynamically resized, allows these prints to combined with
other trace events, and doesn't fill up system logs.

Since dynamic debug already has hooks in these call sites, getting these
prints into the ftrace buffer is straightforward if we have dynamic
debug do it.

Add an "x" flag to make the dynamic debug call site print to a new
printk:dyndbg trace event.  The trace event can be emitted instead of or
in addition to the printk().

The print buffer is statically allocated and managed using code borrowed
from __ftrace_trace_stack() and is limited to 256 bytes (four of these
are allocated per CPU to handle the various contexts); anything larger
will be truncated.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |   1 +
 include/linux/dynamic_debug.h                 |   4 +-
 include/trace/events/printk.h                 |  12 +-
 lib/dynamic_debug.c                           | 153 +++++++++++++++---
 4 files changed, 143 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e5a8def45f3f..e717054ae142 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -229,6 +229,7 @@ of the characters::
 The flags are::
 
   p    enables the pr_debug() callsite.
+  x    enables trace to the printk:dyndbg event
   f    Include the function name in the printed message
   l    Include line number in the printed message
   m    Include module name in the printed message
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 738421898aac..74aee3f922d7 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,7 +32,9 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
-#define _DPRINTK_FLAGS_ENABLE		_DPRINTK_FLAGS_PRINTK
+#define _DPRINTK_FLAGS_TRACE		(1<<5)
+#define _DPRINTK_FLAGS_ENABLE		(_DPRINTK_FLAGS_PRINTK | \
+					 _DPRINTK_FLAGS_TRACE)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
index 13d405b2fd8b..1f78bd237a91 100644
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
+DEFINE_EVENT(printk, dyndbg,
+	TP_PROTO(const char *text, size_t len),
+	TP_ARGS(text, len)
+);
 #endif /* _TRACE_PRINTK_H */
 
 /* This part must be outside protection */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 88af85cb5222..3319da2e235c 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <trace/events/printk.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -89,6 +90,7 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
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
+	trace_dyndbg(buf->buf, len);
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
2.28.0

