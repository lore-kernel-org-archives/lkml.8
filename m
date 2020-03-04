Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE9DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3756206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQj6frz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgCDAtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:49:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42158 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgCDAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:49:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id u3so198268plr.9;
        Tue, 03 Mar 2020 16:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z1E8CVWRRd1w+fQWqwVFIlXMyS2ywFY/FF+9vGIQA0g=;
        b=ZQj6frz1mb/5ttv4+VU9RwjiVP1sZuVXEwJoZ13T0il+VY+x+Gvmrj1eDW0O6RmL59
         ZheMNr01JeqC/CQPQUmsQV3f7E4G8/iDpTRuTINDs1fLZ3yTcuNWTRYWVUAtSPHUOUt5
         EwhcXjtz3TcKQYHfj3iqGbvYqDHFCZyyfAdEPTram+IDJjQmcfMmR09M4TabfcYmDWfP
         X9imWni9TzsML95nYXxmjyeYYD3lsWCSPma57brsqd9Qr4kcDgYRoMkSRt+seK0lrHZ5
         JAIshMm5MfFGZSVQzkVcRjW6qKUNWHkd8LYB4DOy4jvQNRrd965hyOVFss64gyHb1PUu
         CZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z1E8CVWRRd1w+fQWqwVFIlXMyS2ywFY/FF+9vGIQA0g=;
        b=joeacsuqZ2zKLuOmZqCyeXRY2YbbqgoxdQ27MeMTwTWm5ZU+f2AAfiZRNLGrrKH4v/
         pRBNLmvJyLpnEQuO58Y0NZa316ZQWKAVqqExGlHgEZe1NsmpsP0Kjhu3gNOcuExNvrX7
         Gsd5HSbWWBBuADqoi3yMTF3TcgrZzd4W1HYRYsYe0R/jrQwWBfjBz8uuvwyNjI9qFGKh
         9UkSn9RuEUr5905qMEYqWE4xaoh7JTuJQUsaj1zIaj6y3GizWL17cypfHLXAn4pbRVdd
         eyp3za7Ph8fXWAL9aQw3Zl3hW++dbhfMuDIXYeNpnV5tZtx9WhmgscG2ErE6G5+t9xwk
         gHUA==
X-Gm-Message-State: ANhLgQ1Bfff9567PXwg9sY7+owicisgmdbTPHWAx4koL0++UipMsrg6V
        G2Kl9f+nCUWfVSj0hEWmz0BMduMz
X-Google-Smtp-Source: ADFU+vtlIhB7IG5LzNljrXCdTy+0ECTpb37i1OZRs8zz145ac82VAojSbfOzipRYj8SbaKbw7xI6Fw==
X-Received: by 2002:a17:90a:928c:: with SMTP id n12mr269037pjo.45.1583282981579;
        Tue, 03 Mar 2020 16:49:41 -0800 (PST)
Received: from localhost.localdomain ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id 144sm27332169pfc.45.2020.03.03.16.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:49:41 -0800 (PST)
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3] ia64: replace setup_irq() by request_irq()
Date:   Wed,  4 Mar 2020 06:19:36 +0530
Message-Id: <20200304004936.4955-1-afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
Hi ia64 maintainers,

if okay w/ this change, please consider taking it thr' your tree, else please
let me know.

Regards
afzal

Link to v2 & v1,
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/ia64/kernel/irq_ia64.c | 42 +++++++++++--------------------
 arch/ia64/kernel/mca.c      | 49 ++++++++++---------------------------
 2 files changed, 27 insertions(+), 64 deletions(-)

diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
index 8e91c86e8072..8bde6e350acb 100644
--- a/arch/ia64/kernel/irq_ia64.c
+++ b/arch/ia64/kernel/irq_ia64.c
@@ -351,11 +351,6 @@ static irqreturn_t smp_irq_move_cleanup_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction irq_move_irqaction = {
-	.handler =	smp_irq_move_cleanup_interrupt,
-	.name =		"irq_move"
-};
-
 static int __init parse_vector_domain(char *arg)
 {
 	if (!arg)
@@ -586,28 +581,15 @@ static irqreturn_t dummy_handler (int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction ipi_irqaction = {
-	.handler =	handle_IPI,
-	.name =		"IPI"
-};
-
 /*
  * KVM uses this interrupt to force a cpu out of guest mode
  */
-static struct irqaction resched_irqaction = {
-	.handler =	dummy_handler,
-	.name =		"resched"
-};
-
-static struct irqaction tlb_irqaction = {
-	.handler =	dummy_handler,
-	.name =		"tlb_flush"
-};
 
 #endif
 
 void
-ia64_native_register_percpu_irq (ia64_vector vec, struct irqaction *action)
+ia64_native_register_percpu_irq(ia64_vector vec, const char *name,
+				irq_handler_t handler)
 {
 	unsigned int irq;
 
@@ -615,8 +597,9 @@ ia64_native_register_percpu_irq (ia64_vector vec, struct irqaction *action)
 	BUG_ON(bind_irq_vector(irq, vec, CPU_MASK_ALL));
 	irq_set_status_flags(irq, IRQ_PER_CPU);
 	irq_set_chip(irq, &irq_type_ia64_lsapic);
-	if (action)
-		setup_irq(irq, action);
+	if (handler)
+		if (request_irq(irq, handler, 0, name, NULL))
+			pr_err("Failed to request irq %u (%s)\n", irq, name);
 	irq_set_handler(irq, handle_percpu_irq);
 }
 
@@ -624,9 +607,10 @@ void __init
 ia64_native_register_ipi(void)
 {
 #ifdef CONFIG_SMP
-	register_percpu_irq(IA64_IPI_VECTOR, &ipi_irqaction);
-	register_percpu_irq(IA64_IPI_RESCHEDULE, &resched_irqaction);
-	register_percpu_irq(IA64_IPI_LOCAL_TLB_FLUSH, &tlb_irqaction);
+	register_percpu_irq(IA64_IPI_VECTOR, "IPI", handle_IPI);
+	register_percpu_irq(IA64_IPI_RESCHEDULE, "resched", dummy_handler);
+	register_percpu_irq(IA64_IPI_LOCAL_TLB_FLUSH, "tlb_flush",
+			    dummy_handler);
 #endif
 }
 
@@ -635,10 +619,12 @@ init_IRQ (void)
 {
 	acpi_boot_init();
 	ia64_register_ipi();
-	register_percpu_irq(IA64_SPURIOUS_INT_VECTOR, NULL);
+	register_percpu_irq(IA64_SPURIOUS_INT_VECTOR, NULL, NULL);
 #ifdef CONFIG_SMP
-	if (vector_domain_type != VECTOR_DOMAIN_NONE)
-		register_percpu_irq(IA64_IRQ_MOVE_VECTOR, &irq_move_irqaction);
+	if (vector_domain_type != VECTOR_DOMAIN_NONE) {
+		register_percpu_irq(IA64_IRQ_MOVE_VECTOR, "irq_move",
+				    smp_irq_move_cleanup_interrupt);
+	}
 #endif
 #ifdef CONFIG_PERFMON
 	pfm_init_percpu();
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index bf2cb9294795..fc74b0251570 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1766,36 +1766,6 @@ ia64_mca_disable_cpe_polling(char *str)
 
 __setup("disable_cpe_poll", ia64_mca_disable_cpe_polling);
 
-static struct irqaction cmci_irqaction = {
-	.handler =	ia64_mca_cmc_int_handler,
-	.name =		"cmc_hndlr"
-};
-
-static struct irqaction cmcp_irqaction = {
-	.handler =	ia64_mca_cmc_int_caller,
-	.name =		"cmc_poll"
-};
-
-static struct irqaction mca_rdzv_irqaction = {
-	.handler =	ia64_mca_rendez_int_handler,
-	.name =		"mca_rdzv"
-};
-
-static struct irqaction mca_wkup_irqaction = {
-	.handler =	ia64_mca_wakeup_int_handler,
-	.name =		"mca_wkup"
-};
-
-static struct irqaction mca_cpe_irqaction = {
-	.handler =	ia64_mca_cpe_int_handler,
-	.name =		"cpe_hndlr"
-};
-
-static struct irqaction mca_cpep_irqaction = {
-	.handler =	ia64_mca_cpe_int_caller,
-	.name =		"cpe_poll"
-};
-
 /* Minimal format of the MCA/INIT stacks.  The pseudo processes that run on
  * these stacks can never sleep, they cannot return from the kernel to user
  * space, they do not appear in a normal ps listing.  So there is no need to
@@ -2056,18 +2026,23 @@ void __init ia64_mca_irq_init(void)
 	 *  Configure the CMCI/P vector and handler. Interrupts for CMC are
 	 *  per-processor, so AP CMC interrupts are setup in smp_callin() (smpboot.c).
 	 */
-	register_percpu_irq(IA64_CMC_VECTOR, &cmci_irqaction);
-	register_percpu_irq(IA64_CMCP_VECTOR, &cmcp_irqaction);
+	register_percpu_irq(IA64_CMC_VECTOR, "cmc_hndlr",
+			    ia64_mca_cmc_int_handler);
+	register_percpu_irq(IA64_CMCP_VECTOR, "cmc_poll",
+			    ia64_mca_cmc_int_caller);
 	ia64_mca_cmc_vector_setup();       /* Setup vector on BSP */
 
 	/* Setup the MCA rendezvous interrupt vector */
-	register_percpu_irq(IA64_MCA_RENDEZ_VECTOR, &mca_rdzv_irqaction);
+	register_percpu_irq(IA64_MCA_RENDEZ_VECTOR, "mca_rdzv",
+			    ia64_mca_rendez_int_handler);
 
 	/* Setup the MCA wakeup interrupt vector */
-	register_percpu_irq(IA64_MCA_WAKEUP_VECTOR, &mca_wkup_irqaction);
+	register_percpu_irq(IA64_MCA_WAKEUP_VECTOR, "mca_wkup",
+			    ia64_mca_wakeup_int_handler);
 
 	/* Setup the CPEI/P handler */
-	register_percpu_irq(IA64_CPEP_VECTOR, &mca_cpep_irqaction);
+	register_percpu_irq(IA64_CPEP_VECTOR, "cpe_poll",
+			    ia64_mca_cpe_int_caller);
 }
 
 /*
@@ -2108,7 +2083,9 @@ ia64_mca_late_init(void)
 			if (irq > 0) {
 				cpe_poll_enabled = 0;
 				irq_set_status_flags(irq, IRQ_PER_CPU);
-				setup_irq(irq, &mca_cpe_irqaction);
+				if (request_irq(irq, ia64_mca_cpe_int_handler,
+						0, "cpe_hndlr", NULL))
+					pr_err("Failed to register cpe_hndlr interrupt\n");
 				ia64_cpe_irq = irq;
 				ia64_mca_register_cpev(cpe_vector);
 				IA64_MCA_DEBUG("%s: CPEI/P setup and enabled.\n",
-- 
2.25.1

