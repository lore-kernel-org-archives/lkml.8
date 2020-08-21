Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C112087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eenaq2/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgHUI4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgHUI4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD39C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=F95787VKtIAwJ1BhmCVsckINggrXX6maZ0FfIS1EysQ=; b=eenaq2/sssmMDOsUwsh94y0l73
        1ZPrdTLom4NFDcRyxks2X9IpcmzkC8weSOr43IhhxLvQNjjuLs6/KyQnauMA1DLtEx3FqCL8Zc6Ja
        iJGeLyI6AZiMEtyVAY6wiZSopMAYu/iTLb8zL+Vaihspyg2HtCQ6wFUFTYL8DJE7mBtJQJZMXoYXm
        5Qwz05TSfGbcS+4Uq114RJy/Iwv71n1pDK1aIN4D8+951EjxxijmgNG4tHkjFrn427CfK33LMgcrN
        xc8h9mJYvPn62/mWuCyEYsqWPnPgErnzhqpaA9A8JCn/hu10cJQL7TM286jzQZ+0j4LvTLZbMPwI8
        pkuKqxJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k92pJ-0007SJ-5z; Fri, 21 Aug 2020 08:55:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 890BC306E56;
        Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0B7B02B64991D; Fri, 21 Aug 2020 10:54:50 +0200 (CEST)
Message-ID: <20200821085348.723775490@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 21 Aug 2020 10:47:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org
Cc:     npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        peterz@infradead.org
Subject: [PATCH v2 10/11] lockdep: Only trace IRQ edges
References: <20200821084738.508092956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

Problem:

	raw_local_irq_save();
	local_irq_save();
	...
	local_irq_restore();
	raw_local_irq_restore();

existing instances:

 - lock_acquire()
     raw_local_irq_save()
     __lock_acquire()
       arch_spin_lock(&graph_lock)
         pv_wait() := kvm_wait() (same or worse for Xen/HyperV)
           local_irq_save()

 - trace_clock_global()
     raw_local_irq_save()
     arch_spin_lock()
       pv_wait() := kvm_wait()
	 local_irq_save()

 - apic_retrigger_irq()
     raw_local_irq_save()
     apic->send_IPI() := default_send_IPI_single_phys()
       local_irq_save()

Possible solutions:

 A) make it work by enabling the tracing inside raw_*()
 B) make it work by keeping tracing disabled inside raw_*()

Now, given that the only reason to use the raw_* variant is because you don't
want tracing, A) seems like a weird option (although it can be done), so we
pick B) and declare any code that ends up doing:

	raw_local_irq_save()
	local_irq_save()
	lockdep_assert_irqs_disabled();

broken. AFAICT this problem has existed forever, the only reason it came
up is because I changed IRQ tracing vs lockdep recursion and the first
instance is fairly common, the other cases hardly ever happen.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[rewrote changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200723105615.1268126-1-npiggin@gmail.com
---

 arch/powerpc/include/asm/hw_irq.h |   11 ++++-------
 include/linux/irqflags.h          |   15 +++++++--------
 2 files changed, 11 insertions(+), 15 deletions(-)

--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(vo
 #define powerpc_local_irq_pmu_save(flags)			\
 	 do {							\
 		raw_local_irq_pmu_save(flags);			\
-		trace_hardirqs_off();				\
+		if (!raw_irqs_disabled_flags(flags))		\
+			trace_hardirqs_off();			\
 	} while(0)
 #define powerpc_local_irq_pmu_restore(flags)			\
 	do {							\
-		if (raw_irqs_disabled_flags(flags)) {		\
-			raw_local_irq_pmu_restore(flags);	\
-			trace_hardirqs_off();			\
-		} else {					\
+		if (!raw_irqs_disabled_flags(flags))		\
 			trace_hardirqs_on();			\
-			raw_local_irq_pmu_restore(flags);	\
-		}						\
+		raw_local_irq_pmu_restore(flags);		\
 	} while(0)
 #else
 #define powerpc_local_irq_pmu_save(flags)			\
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -191,25 +191,24 @@ do {						\
 
 #define local_irq_disable()				\
 	do {						\
+		bool was_disabled = raw_irqs_disabled();\
 		raw_local_irq_disable();		\
-		trace_hardirqs_off();			\
+		if (!was_disabled)			\
+			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_save(flags)				\
 	do {						\
 		raw_local_irq_save(flags);		\
-		trace_hardirqs_off();			\
+		if (!raw_irqs_disabled_flags(flags))	\
+			trace_hardirqs_off();		\
 	} while (0)
 
 #define local_irq_restore(flags)			\
 	do {						\
-		if (raw_irqs_disabled_flags(flags)) {	\
-			raw_local_irq_restore(flags);	\
-			trace_hardirqs_off();		\
-		} else {				\
+		if (!raw_irqs_disabled_flags(flags))	\
 			trace_hardirqs_on();		\
-			raw_local_irq_restore(flags);	\
-		}					\
+		raw_local_irq_restore(flags);		\
 	} while (0)
 
 #define safe_halt()				\


