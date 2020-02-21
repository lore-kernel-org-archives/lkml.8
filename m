Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB06C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EB524650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEokdEKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgBUNv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:51:27 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgBUNui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=d/0V3LhRAG1PrLn+gcCjQbXdVZCS7GcV5Q+9iS3zycc=; b=MEokdEKSO+kESf0cERiiv1bx4A
        n/mxBSm7Mqjo5GXINcJzIVJ6UgMKuhss0p+2u4dtf4z7J2+lgIvIOIhiaJNvn+1ZD1by8JWj2ymT5
        fiIzXf5VEk2IRj0wS2Q801/FGD/YXVN5S+U4LWtCNOkzbszr5edcCgTYUQNnLVIIsv0zFODEX+jQM
        xB+uKPbdATDftAtHCthh3S0+6kWh3hEpLnQcl0w2hbc+4I7OGW/XyC0Y9Bj2TI/XVgeDi94IFUmgS
        l0Wa1kQUo8jAaFzmA2lOBL5EtqF+ia1tZ2J/2Ixd182fg6/sL2/dQ7LTp3XFZEJZ6zi+z5Ji2qbAI
        7hO7H+yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gv-0006Uz-3g; Fri, 21 Feb 2020 13:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CCED307485;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D1C1629B59044; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.730523211@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: [PATCH v4 12/27] sched,rcu,tracing: Avoid tracing before in_nmi() is correct
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we call into a tracer before in_nmi() becomes true, the tracer can
no longer detect it is called from NMI context and behave correctly.

Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
as the normal preempt_count_{add,sub}() have a (desired) function
trace entry.

This fixes a potential issue with current code; AFAICT when the
function-tracer has stack-tracing enabled __trace_stack() will
malfunction when it hits the preempt_count_add() function entry from
NMI context.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/hardirq.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -66,6 +66,15 @@ extern void irq_exit(void);
 #endif
 
 /*
+ * NMI vs Tracing
+ * --------------
+ *
+ * We must not land in a tracer until (or after) we've changed preempt_count
+ * such that in_nmi() becomes true. To that effect all NMI C entry points must
+ * be marked 'notrace' and call nmi_enter() as soon as possible.
+ */
+
+/*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
 #define nmi_enter()						\
@@ -75,7 +84,7 @@ extern void irq_exit(void);
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
-		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET); \
 		rcu_nmi_enter();				\
 		trace_hardirq_enter();				\
 	} while (0)
@@ -85,7 +94,7 @@ extern void irq_exit(void);
 		trace_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
-		preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET); \
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\


