Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664AC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0877F206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgA3Osl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbgA3OsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:48:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68F3C2468C;
        Thu, 30 Jan 2020 14:48:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1ixB77-001CTP-Ap; Thu, 30 Jan 2020 09:48:13 -0500
Message-Id: <20200130144813.219617268@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Jan 2020 09:48:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 20/21] tracing: Move mmio tracer config up with the other tracers
References: <20200130144743.527378179@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Move the config that enables the mmiotracer with the other tracers such that
all the tracers are together.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 47d0149347a9..2014056682f5 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -353,6 +353,19 @@ config HWLAT_TRACER
 	 file. Every time a latency is greater than tracing_thresh, it will
 	 be recorded into the ring buffer.
 
+config MMIOTRACE
+	bool "Memory mapped IO tracing"
+	depends on HAVE_MMIOTRACE_SUPPORT && PCI
+	select GENERIC_TRACER
+	help
+	  Mmiotrace traces Memory Mapped I/O access and is meant for
+	  debugging and reverse engineering. It is called from the ioremap
+	  implementation and works via page faults. Tracing is disabled by
+	  default and can be enabled at run-time.
+
+	  See Documentation/trace/mmiotrace.rst.
+	  If you are not helping to develop drivers, say N.
+
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
 	depends on !GENERIC_TRACER
@@ -627,19 +640,6 @@ config EVENT_TRACE_TEST_SYSCALLS
 	 TBD - enable a way to actually call the syscalls as we test their
 	       events
 
-config MMIOTRACE
-	bool "Memory mapped IO tracing"
-	depends on HAVE_MMIOTRACE_SUPPORT && PCI
-	select GENERIC_TRACER
-	help
-	  Mmiotrace traces Memory Mapped I/O access and is meant for
-	  debugging and reverse engineering. It is called from the ioremap
-	  implementation and works via page faults. Tracing is disabled by
-	  default and can be enabled at run-time.
-
-	  See Documentation/trace/mmiotrace.rst.
-	  If you are not helping to develop drivers, say N.
-
 config TRACING_MAP
 	bool
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
-- 
2.24.1


