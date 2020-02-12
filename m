Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFC4C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8614620661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1n6T4kJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgBLIDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:03:23 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34247 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLIDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:03:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so800351pgi.1;
        Wed, 12 Feb 2020 00:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mh5ve1clOQdwoBlgvdFQOY/xr1cX6ZXuLGLTs9NtboA=;
        b=n1n6T4kJFtsezqzjNTIJbiRdniLbBs7C7ifuY43SPeXCeKrPCBcJIpIojykSSlc74F
         6X31qwVyjoQpkgGL7Ss984xf9nq0ejM97+9gH4ERYkslfwcdeDW9Xtrbv2OG1tO9Ocy5
         Z9dTEYxJbLgFbn8fZ2xm1LsUChLhjeNAMju3xYYIoCGY3WxN7R/J6d/9elf1jJvUXrZb
         anG+hdr1w695BArD+Zs46e9/kqdwF8t9OVPcH/hTx54BwWhI4o3rwl+wHUDURvdXS1Bf
         4BOB/Z7NZX2tIGA3AKhmiLolDsw7OiJ5BwiSRDec/vagWEjz4RPfCQ57wxnW6PfnW0Ks
         8OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mh5ve1clOQdwoBlgvdFQOY/xr1cX6ZXuLGLTs9NtboA=;
        b=BnJvJ1N8BB3pA7zPD9LG6Ndgpw5K3F/xraOeyrdLtFPF5sO5T+Vz1EEvyV7bJk3t1X
         t6Br7i2GQYIp6ctr8g9U5UXdXjzmAuxIs31YRBoMRNG1XRDGZY4yNHhenLfnH6YvFv5L
         Mrx4DOxsmvzv5xoGoAN+f7KKIPwiQYsPMzVyc2uZNok9TsVDFhj5usDntw/7EYK4e3bW
         RW3WDqhg2I/iVdHb0eFAw6Ieq8sOOEe/yQwXmJ3lLbNoi0kU0MGb08DuuIn2TS/SrcFZ
         FYCuVyjebmPwNTdaTymp6WIUkuhZMw8AStmWIxV8kUSE3+Ev2C5dnVeV6kpew0U39rYK
         3LHA==
X-Gm-Message-State: APjAAAXAUv6qElHY7WSX0miYa354yFiz6pzngl/j2NCHLZWOrRfISJxi
        3xCotWx15D3BJy832ruDMxQmWare+0k=
X-Google-Smtp-Source: APXvYqztRdA51Z5cTO1fj9v1qIKorccJrstXzYWk4VTQxZ/dZfUMeYPgz4nwPxP2vZq5zB+r7JmEhg==
X-Received: by 2002:a63:ed01:: with SMTP id d1mr10151600pgi.95.1581494601503;
        Wed, 12 Feb 2020 00:03:21 -0800 (PST)
Received: from localhost ([106.51.21.91])
        by smtp.gmail.com with ESMTPSA id g7sm7056749pfq.33.2020.02.12.00.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:03:21 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:33:19 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Tom Vaden <tom.vaden@hpe.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/18] ia64: replace setup_irq() by request_irq()
Message-ID: <14bfa52a434351ea6612d514b033e9dbb73a9727.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/ia64/kernel/irq_ia64.c | 42 ++++++++++--------------------
 arch/ia64/kernel/mca.c      | 51 +++++++++++--------------------------
 2 files changed, 29 insertions(+), 64 deletions(-)

diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
index 8e91c86e8072..166a38dae663 100644
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
+			pr_err("request_irq() for %s failed", name);
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
index bf2cb9294795..f4be4ad7bf0d 100644
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
@@ -2108,7 +2083,11 @@ ia64_mca_late_init(void)
 			if (irq > 0) {
 				cpe_poll_enabled = 0;
 				irq_set_status_flags(irq, IRQ_PER_CPU);
-				setup_irq(irq, &mca_cpe_irqaction);
+				if (request_irq(irq, ia64_mca_cpe_int_handler,
+						0, "cpe_hndlr", NULL)) {
+					pr_err("request_irq() on %s failed\n",
+					       "cpe_hndlr");
+				}
 				ia64_cpe_irq = irq;
 				ia64_mca_register_cpev(cpe_vector);
 				IA64_MCA_DEBUG("%s: CPEI/P setup and enabled.\n",
-- 
2.24.1

