Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DD920776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bR7hxX1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgE2Ve7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgE2Ve5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:34:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF179C08C5CA
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nex81dxzQZJzQnMnwEs4seEGxqf8q87WEB5IDNq7254=; b=bR7hxX1pVniGcgetOTS7fiA1Nv
        QJlrK58JNofk2wKW/PO8TWcvGJ1/B8ZfEnPqxTGnaVu1NM7LU/O9cizRG1ft5wHx840zD/ifDWK5P
        8uhSCJko94qgy1V2y1OP1V5y2N8vVjhx+bY8OPhIQZaX66Nv45LoYBLFW9xd3ME5WewJ3ziP7tUdm
        pwsiHluw/WbYQeaOG0LwSn9KV+ToPtdwKYwlLXUi98VNNHm6exh354MVuRjp29QNFNLQXN7kOBXiZ
        qLUUdk92VzIL9IpO7Sjxlk2v96wzLCFWXprOUcUN/RLUCAavAK5qCdqq8MY7SUa5ElNOnz5WG+BA/
        CkB4nqRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeL-0000Kt-FQ; Fri, 29 May 2020 21:34:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08198307767;
        Fri, 29 May 2020 23:34:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 40E732B9B1BC3; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.359433429@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 11/14] x86/entry: Clarify irq_{enter,exit}_rcu()
References: <20200529212728.795169701@infradead.org>
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


