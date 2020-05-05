Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFFC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5C120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgEEOXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729509AbgEEOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD62C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKR-0000gL-Rd; Tue, 05 May 2020 16:13:48 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5F41FFFC8D;
        Tue,  5 May 2020 16:13:47 +0200 (CEST)
Message-Id: <20200505134100.771491291@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:29 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [patch V4 part 1 27/36] arm64: Prepare arch_nmi_enter() for recursion
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/hardirq.h |   78 +++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 19 deletions(-)

--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -32,30 +32,70 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
 
 struct nmi_ctx {
 	u64 hcr;
+	unsigned int cnt;
 };
 
 DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
-#define arch_nmi_enter()							\
-	do {									\
-		if (is_kernel_in_hyp_mode()) {					\
-			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
-			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
-			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
-				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
-				isb();						\
-			}							\
-		}								\
-	} while (0)
+#define arch_nmi_enter()						\
+do {									\
+	struct nmi_ctx *___ctx;						\
+	u64 ___hcr;							\
+									\
+	if (!is_kernel_in_hyp_mode())					\
+		break;							\
+									\
+	___ctx = this_cpu_ptr(&nmi_contexts);				\
+	if (___ctx->cnt) {						\
+		___ctx->cnt++;						\
+		break;							\
+	}								\
+									\
+	___hcr = read_sysreg(hcr_el2);					\
+	if (!(___hcr & HCR_TGE)) {					\
+		write_sysreg(___hcr | HCR_TGE, hcr_el2);		\
+		isb();							\
+	}								\
+	/*								\
+	 * Make sure the sysreg write is performed before ___ctx->cnt	\
+	 * is set to 1. NMIs that see cnt == 1 will rely on us.		\
+	 */								\
+	barrier();							\
+	___ctx->cnt = 1;                                                \
+	/*								\
+	 * Make sure ___ctx->cnt is set before we save ___hcr. We	\
+	 * don't want ___ctx->hcr to be overwritten.			\
+	 */								\
+	barrier();							\
+	___ctx->hcr = ___hcr;						\
+} while (0)
 
-#define arch_nmi_exit()								\
-	do {									\
-		if (is_kernel_in_hyp_mode()) {					\
-			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
-			if (!(nmi_ctx->hcr & HCR_TGE))				\
-				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
-		}								\
-	} while (0)
+#define arch_nmi_exit()							\
+do {									\
+	struct nmi_ctx *___ctx;						\
+	u64 ___hcr;							\
+									\
+	if (!is_kernel_in_hyp_mode())					\
+		break;							\
+									\
+	___ctx = this_cpu_ptr(&nmi_contexts);				\
+	___hcr = ___ctx->hcr;						\
+	/*								\
+	 * Make sure we read ___ctx->hcr before we release		\
+	 * ___ctx->cnt as it makes ___ctx->hcr updatable again.		\
+	 */								\
+	barrier();							\
+	___ctx->cnt--;							\
+	/*								\
+	 * Make sure ___ctx->cnt release is visible before we		\
+	 * restore the sysreg. Otherwise a new NMI occurring		\
+	 * right after write_sysreg() can be fooled and think		\
+	 * we secured things for it.					\
+	 */								\
+	barrier();							\
+	if (!___ctx->cnt && !(___hcr & HCR_TGE))			\
+		write_sysreg(___hcr, hcr_el2);				\
+} while (0)
 
 static inline void ack_bad_irq(unsigned int irq)
 {

