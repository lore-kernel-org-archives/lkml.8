Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E459B208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRxPAsh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgHUIzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgHUIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:55:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AEFC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=F45YFZuttlutg1lZuthTExfTKRHBCwyIgvem4y0biOo=; b=iRxPAsh1krS5F5cPaoxQtikX4P
        1KTyLRzD3Lh3q/PG7i1hBhbrRUzdunvvsXcjhJATTtYdVax9skS25S/uhG9J0e96dVkNoVTBnQ5TI
        dx7ZGl8V0a5NJ1Qav0srv+3wQn0J/Q2mkpi1eOFBK2+ViPT/ylzRpaBa4wMIcs4mvoCzaOR7cBzpW
        WSGPuS8Cwjd8I2W7QtQbFc6OBBIQyOyVZ+gRjbuqSv+ZDmnapYMPTzIKiwdSG+h6cbRm713HaVYSy
        OpSlZGXZbzBXeEF0tN0CSX/G1uODwGg6QZ90sGAF3wozXL8OJIfcUamGpT40bRbEmrJyXWCqyX6BA
        mhNRa8ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92p4-0008UY-PY; Fri, 21 Aug 2020 08:54:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 832F13060F2;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F25F12B64991A; Fri, 21 Aug 2020 10:54:49 +0200 (CEST)
Message-ID: <20200821085348.546087214@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 07/11] locking/lockdep: Cleanup
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
---
 include/linux/irqflags.h |   54 ++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -49,10 +49,11 @@ struct irqtrace_events {
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 
-  extern void trace_hardirqs_on_prepare(void);
-  extern void trace_hardirqs_off_finish(void);
-  extern void trace_hardirqs_on(void);
-  extern void trace_hardirqs_off(void);
+extern void trace_hardirqs_on_prepare(void);
+extern void trace_hardirqs_off_finish(void);
+extern void trace_hardirqs_on(void);
+extern void trace_hardirqs_off(void);
+
 # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
@@ -120,17 +121,17 @@ do {						\
 #else
 # define trace_hardirqs_on_prepare()		do { } while (0)
 # define trace_hardirqs_off_finish()		do { } while (0)
-# define trace_hardirqs_on()		do { } while (0)
-# define trace_hardirqs_off()		do { } while (0)
-# define lockdep_hardirq_context()	0
-# define lockdep_softirq_context(p)	0
-# define lockdep_hardirqs_enabled()	0
-# define lockdep_softirqs_enabled(p)	0
-# define lockdep_hardirq_enter()	do { } while (0)
-# define lockdep_hardirq_threaded()	do { } while (0)
-# define lockdep_hardirq_exit()		do { } while (0)
-# define lockdep_softirq_enter()	do { } while (0)
-# define lockdep_softirq_exit()		do { } while (0)
+# define trace_hardirqs_on()			do { } while (0)
+# define trace_hardirqs_off()			do { } while (0)
+# define lockdep_hardirq_context()		0
+# define lockdep_softirq_context(p)		0
+# define lockdep_hardirqs_enabled()		0
+# define lockdep_softirqs_enabled(p)		0
+# define lockdep_hardirq_enter()		do { } while (0)
+# define lockdep_hardirq_threaded()		do { } while (0)
+# define lockdep_hardirq_exit()			do { } while (0)
+# define lockdep_softirq_enter()		do { } while (0)
+# define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
 # define lockdep_hrtimer_exit(__context)	do { } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
@@ -181,17 +182,25 @@ do {						\
  * if !TRACE_IRQFLAGS.
  */
 #ifdef CONFIG_TRACE_IRQFLAGS
-#define local_irq_enable() \
-	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
-#define local_irq_disable() \
-	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
+
+#define local_irq_enable()				\
+	do {						\
+		trace_hardirqs_on();			\
+		raw_local_irq_enable();			\
+	} while (0)
+
+#define local_irq_disable()				\
+	do {						\
+		raw_local_irq_disable();		\
+		trace_hardirqs_off();			\
+	} while (0)
+
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
 		trace_hardirqs_off();			\
 	} while (0)
 
-
 #define local_irq_restore(flags)			\
 	do {						\
 		if (raw_irqs_disabled_flags(flags)) {	\
@@ -214,10 +223,7 @@ do {						\
 
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
 #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
-#define local_irq_save(flags)					\
-	do {							\
-		raw_local_irq_save(flags);			\
-	} while (0)
+#define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
 #define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
 #define safe_halt()		do { raw_safe_halt(); } while (0)
 


