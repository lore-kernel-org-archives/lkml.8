Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04965C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1352074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgFHSbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgFHSbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:31:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8428206D5;
        Mon,  8 Jun 2020 18:31:34 +0000 (UTC)
Date:   Mon, 8 Jun 2020 14:31:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [for-next][PATCH] tracing: Remove obsolete PREEMPTIRQ_EVENTS
 kconfig option
Message-ID: <20200608143133.0e72efde@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 388d8bdb87e01bcea6d0b2bf797b5f6d7b2401fb


Mel Gorman (1):
      tracing: Remove obsolete PREEMPTIRQ_EVENTS kconfig option

----
 kernel/trace/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)
---------------------------
commit 388d8bdb87e01bcea6d0b2bf797b5f6d7b2401fb
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Thu Apr 9 11:40:34 2020 +0100

    tracing: Remove obsolete PREEMPTIRQ_EVENTS kconfig option
    
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
    
    Link: https://lkml.kernel.org/r/20200409104034.GJ3818@techsingularity.net
    
    Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 75407d5dc83a..0c82ac2c5688 100644
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
