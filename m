Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486172075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="COT7GNMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbgE1ORR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390866AbgE1ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:17:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC3BC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nex81dxzQZJzQnMnwEs4seEGxqf8q87WEB5IDNq7254=; b=COT7GNMKs2d6OWqDGCv7Yc0hzI
        GJT/OBJjxo9fjlvrExkeh47+/CaCpvdy6q0uZFgP2tryAiDfYMEh+mIomyZOn4tLvbnqlUYunQ97I
        H2ZdlBw7w/ryIj7YfRI83URwW8wYAivnzFE/Oe8h2N5JkbA+jkZLsJ0e5+QfSS4F7a7JnAF26KAO3
        9kFe+xRop4dzccjReMn3KPxl1qMNo7IxRKUcd0uQ+QBjM+Q+CnU+0p4AxQA/CLeKrLxRpmrOxysD3
        Sles4qYJRmstgKuuJzhfX4FzpWKL5tGCgYCgy+yiir2m6h37rSx+NV11Vp/RRDdQLPgtyMResZzFO
        0OIK+cBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeJLI-0007Zs-Q2; Thu, 28 May 2020 14:17:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28DA03062EA;
        Thu, 28 May 2020 16:17:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D55C7201479A3; Thu, 28 May 2020 16:17:06 +0200 (CEST)
Message-ID: <20200528140946.679503356@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 16:05:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH v2 1/6] x86/entry: Clarify irq_{enter,exit}_rcu()
References: <20200528140535.206916549@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because:

  irq_enter_rcu() includes lockdep_hardirq_enter()
  irq_exit_rcu() does *NOT* include lockdep_hardirq_exit()

Which resulted in two 'stray' lockdep_hardirq_exit() calls in
idtentry.h, and me spending a long time trying to find the matching
enter calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/idtentry.h |    2 --
 kernel/softirq.c                |   19 +++++++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -206,7 +206,6 @@ __visible noinstr void func(struct pt_re
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
-	lockdep_hardirq_exit();						\
 	instrumentation_end();						\
 	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
@@ -249,7 +248,6 @@ __visible noinstr void func(struct pt_re
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_on_irqstack_cond(__##func, regs, regs);			\
 	irq_exit_rcu();							\
-	lockdep_hardirq_exit();						\
 	instrumentation_end();						\
 	idtentry_exit_cond_rcu(regs, rcu_exit);				\
 }									\
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -404,12 +404,7 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
-/**
- * irq_exit_rcu() - Exit an interrupt context without updating RCU
- *
- * Also processes softirqs if needed and possible.
- */
-void irq_exit_rcu(void)
+static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
 	local_irq_disable();
@@ -425,6 +420,18 @@ void irq_exit_rcu(void)
 }
 
 /**
+ * irq_exit_rcu() - Exit an interrupt context without updating RCU
+ *
+ * Also processes softirqs if needed and possible.
+ */
+void irq_exit_rcu(void)
+{
+	__irq_exit_rcu();
+	 /* must be last! */
+	lockdep_hardirq_exit();
+}
+
+/**
  * irq_exit - Exit an interrupt context, update RCU and lockdep
  *
  * Also processes softirqs if needed and possible.


