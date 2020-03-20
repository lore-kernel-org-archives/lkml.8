Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06E4C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5D20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYcELcvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCTMAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:00:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCTMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zIn6jQud/lKBgUAbg2D9shfSdMDZ9Xw30Vc/HZHD74Q=; b=qYcELcvIoQ3cTBvgcwbemQtxON
        U7JBvW/RczsWjvCYDTfQGRDHZCDtqQMgg/wPrtCsxOEpwetdXiixjGzH+hnglYnBBjl32bdcTWGP2
        H3eCceFEPih8iBj90MIn9n4JhvHFtjMTYZiltKs/QbhoD0eCln7jGZY+ET7YGwyvMWuL0bdpQMnvd
        QP34f/AXRJWwTlFcE8H0k68gRcpd1FKM2OJrXj6WwHu8hqMYhJy41qVvE3wt6PugOmUuYAFG0VoFq
        JFhq8c7D7FDm6WPIeSwD6mt32bYE04Y0Tdei+yPfF8B1rrv8YdqhyJDnj/BiEQ9kQLj5RygRaM529
        dJNslwIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFGK8-0004CN-60; Fri, 20 Mar 2020 12:00:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC61D305C92;
        Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 80F2A2858D593; Fri, 20 Mar 2020 13:00:21 +0100 (CET)
Message-Id: <20200320115859.119434738@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 12:56:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, will@kernel.org, peterz@infradead.org
Subject: [PATCH 3/4] lockdep: Rename trace_softirqs_{on,off}()
References: <20200320115638.737385408@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue what commit:

  d820ac4c2fa8 ("locking: rename trace_softirq_[enter|exit] => lockdep_softirq_[enter|exit]")

started, rename these to avoid confusing them with tracepoints.

git grep -l "trace_softirqs_\(on\|off\)" | while read file;
do
	sed -ie 's/trace_softirqs_\(on\|off\)/lockdep_softirqs_\1/g' $file;
done

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irqflags.h |   10 +++++-----
 kernel/locking/lockdep.c |    4 ++--
 kernel/softirq.c         |    6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -15,15 +15,15 @@
 #include <linux/typecheck.h>
 #include <asm/irqflags.h>
 
-/* Currently trace_softirqs_on/off is used only by lockdep */
+/* Currently lockdep_softirqs_on/off is used only by lockdep */
 #ifdef CONFIG_PROVE_LOCKING
-  extern void trace_softirqs_on(unsigned long ip);
-  extern void trace_softirqs_off(unsigned long ip);
+  extern void lockdep_softirqs_on(unsigned long ip);
+  extern void lockdep_softirqs_off(unsigned long ip);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
 #else
-  static inline void trace_softirqs_on(unsigned long ip) { }
-  static inline void trace_softirqs_off(unsigned long ip) { }
+  static inline void lockdep_softirqs_on(unsigned long ip) { }
+  static inline void lockdep_softirqs_off(unsigned long ip) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3703,7 +3703,7 @@ NOKPROBE_SYMBOL(lockdep_hardirqs_off);
 /*
  * Softirqs will be enabled:
  */
-void trace_softirqs_on(unsigned long ip)
+void lockdep_softirqs_on(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
@@ -3743,7 +3743,7 @@ void trace_softirqs_on(unsigned long ip)
 /*
  * Softirqs were disabled:
  */
-void trace_softirqs_off(unsigned long ip)
+void lockdep_softirqs_off(unsigned long ip)
 {
 	struct task_struct *curr = current;
 
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -126,7 +126,7 @@ void __local_bh_disable_ip(unsigned long
 	 * Were softirqs turned off above:
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_off(ip);
+		lockdep_softirqs_off(ip);
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt) {
@@ -147,7 +147,7 @@ static void __local_bh_enable(unsigned i
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_on(_RET_IP_);
+		lockdep_softirqs_on(_RET_IP_);
 
 	__preempt_count_sub(cnt);
 }
@@ -174,7 +174,7 @@ void __local_bh_enable_ip(unsigned long
 	 * Are softirqs going to be turned on now:
 	 */
 	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
-		trace_softirqs_on(ip);
+		lockdep_softirqs_on(ip);
 	/*
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:


