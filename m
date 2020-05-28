Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216932084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbgE1O4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403824AbgE1O4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:56:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B8C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:56:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeJx8-0002Qa-LL; Thu, 28 May 2020 16:56:15 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2471BFF834;
        Thu, 28 May 2020 16:56:14 +0200 (CEST)
Message-Id: <20200528145522.992376498@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 28 May 2020 16:53:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 4/5] x86/idt: Cleanup trap_init()
References: <20200528145315.727724091@linutronix.de>
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

No point in having all the IDT cruft in trap_init(). Move it into the IDT
code, get rid of the extra global function and fixup the comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/desc.h |    2 --
 arch/x86/kernel/idt.c       |   26 +++++++++++++++++++-------
 arch/x86/kernel/traps.c     |   11 -----------
 3 files changed, 19 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -438,11 +438,9 @@ extern void idt_setup_apic_and_irq_gates
 #ifdef CONFIG_X86_64
 extern void idt_setup_early_pf(void);
 extern void idt_setup_ist_traps(void);
-extern void idt_setup_debugidt_traps(void);
 #else
 static inline void idt_setup_early_pf(void) { }
 static inline void idt_setup_ist_traps(void) { }
-static inline void idt_setup_debugidt_traps(void) { }
 #endif
 
 extern void idt_invalidate(void *addr);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -4,6 +4,7 @@
  */
 #include <linux/interrupt.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/proto.h>
 #include <asm/desc.h>
@@ -299,20 +300,27 @@ void __init idt_setup_early_pf(void)
 void __init idt_setup_ist_traps(void)
 {
 	idt_setup_from_table(idt_table, ist_idts, ARRAY_SIZE(ist_idts), true);
-}
 
-/**
- * idt_setup_debugidt_traps - Initialize the debug idt table with debug traps
- */
-void __init idt_setup_debugidt_traps(void)
-{
+	/* All traps set up: Initialize the debug IDT table. */
 	memcpy(&debug_idt_table, &idt_table, IDT_DEBUG_TABLE_SIZE);
-
 	idt_setup_from_table(debug_idt_table, dbg_idts, ARRAY_SIZE(dbg_idts),
 			     false);
 }
 #endif
 
+static void idt_map_in_cea(void)
+{
+	/*
+	 * Set the IDT descriptor to a fixed read-only location in the cpu
+	 * entry area, so that the "sidt" instruction will not leak the
+	 * location of the kernel, and to defend the IDT against arbitrary
+	 * memory write vulnerabilities.
+	 */
+	cea_set_pte(CPU_ENTRY_AREA_RO_IDT_VADDR, __pa_symbol(idt_table),
+		    PAGE_KERNEL_RO);
+	idt_descr.address = CPU_ENTRY_AREA_RO_IDT;
+}
+
 /**
  * idt_setup_apic_and_irq_gates - Setup APIC/SMP and normal interrupt gates
  */
@@ -339,6 +347,10 @@ void __init idt_setup_apic_and_irq_gates
 		set_intr_gate(i, entry);
 	}
 #endif
+	/* Map IDT into CPU entry area and reload it. */
+	idt_map_in_cea();
+	load_current_idt();
+
 	idt_setup_done = true;
 }
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1077,20 +1077,9 @@ void __init trap_init(void)
 	idt_setup_traps();
 
 	/*
-	 * Set the IDT descriptor to a fixed read-only location, so that the
-	 * "sidt" instruction will not leak the location of the kernel, and
-	 * to defend the IDT against arbitrary memory write vulnerabilities.
-	 * It will be reloaded in cpu_init() */
-	cea_set_pte(CPU_ENTRY_AREA_RO_IDT_VADDR, __pa_symbol(idt_table),
-		    PAGE_KERNEL_RO);
-	idt_descr.address = CPU_ENTRY_AREA_RO_IDT;
-
-	/*
 	 * Should be a barrier for any external CPU state:
 	 */
 	cpu_init();
 
 	idt_setup_ist_traps();
-
-	idt_setup_debugidt_traps();
 }

