Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE65DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963CC207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgESTw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgESTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26BC08C5C2;
        Tue, 19 May 2020 12:52:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I5-0007sR-Nx; Tue, 19 May 2020 21:52:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E6671C0480;
        Tue, 19 May 2020 21:52:36 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:36 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] arm64: Prepare arch_nmi_enter() for recursion
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.771491291@linutronix.de>
References: <20200505134100.771491291@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795623.17951.5424104075328395169.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     28f6bf9e247fe23d177cfdbf7e709270e8cc7fa6
Gitweb:        https://git.kernel.org/tip/28f6bf9e247fe23d177cfdbf7e709270e8cc7fa6
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 27 Feb 2020 09:51:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:17 +02:00

arm64: Prepare arch_nmi_enter() for recursion

When using nmi_enter() recursively, arch_nmi_enter() must also be recursion
safe. In particular, it must be ensured that HCR_TGE is always set while in
NMI context when in HYP mode, and be restored to it's former state when
done.

The current code fails this when interleaved wrong. Notably it overwrites
the original hcr state on nesting.

Introduce a nesting counter to make sure to store the original value.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lkml.kernel.org/r/20200505134100.771491291@linutronix.de


---
 arch/arm64/include/asm/hardirq.h | 78 +++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 87ad961..985493a 100644
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
