Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90275C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F50820757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDIKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:40:37 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:46387 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgDIKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:40:37 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 5E507FACA9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 11:40:36 +0100 (IST)
Received: (qmail 26492 invoked from network); 9 Apr 2020 10:40:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2020 10:40:36 -0000
Date:   Thu, 9 Apr 2020 11:40:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Remove obsolete PREEMPTIRQ_EVENTS kconfig option
Message-ID: <20200409104034.GJ3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PREEMPTIRQ_EVENTS option is unused after commit c3bc8fd637a9 ("tracing:
Centralize preemptirq tracepoints and unify their usage"). Remove it.

Note that this option is hazardous as it stands. It enables TRACE_IRQFLAGS
event on non-preempt configurations without the irqsoff tracer enabled.
TRACE_IRQFLAGS as it stands incurs significant overhead on each IRQ
entry/exit. This is because trace_hardirqs_[on|off] does all the per-cpu
manipulations and NMI checks even if tracing is completely disabled for
some insane reason.  For example, netperf running UDP_STREAM on localhost
incurs a 4-6% performance penalty without any tracing if IRQFLAGS is
set. It can be put behind a static brach but even the function entry/exit
costs a little bit.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/trace/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 402eef84c859..568ad371e19c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -258,15 +258,6 @@ config TRACE_PREEMPT_TOGGLE
 	  Enables hooks which will be called when preemption is first disabled,
 	  and last enabled.
 
-config PREEMPTIRQ_EVENTS
-	bool "Enable trace events for preempt and irq disable/enable"
-	select TRACE_IRQFLAGS
-	select TRACE_PREEMPT_TOGGLE if PREEMPTION
-	select GENERIC_TRACER
-	default n
-	help
-	  Enable tracing of disable and enable events for preemption and irqs.
-
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
 	default n
