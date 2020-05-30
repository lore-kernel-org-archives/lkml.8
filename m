Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52CA214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgE3J5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgE3J5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97827C03E969;
        Sat, 30 May 2020 02:57:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEu-0002oK-HS; Sat, 30 May 2020 11:57:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 225C41C032F;
        Sat, 30 May 2020 11:57:16 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:16 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idt: Cleanup trap_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528145522.992376498@linutronix.de>
References: <20200528145522.992376498@linutronix.de>
MIME-Version: 1.0
Message-ID: <159083263601.17951.6137387139288210222.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     88dbb6cfb9be0eaaa95c15a4b6d7f49044a2e1b7
Gitweb:        https://git.kernel.org/tip/88dbb6cfb9be0eaaa95c15a4b6d7f49044a2e1b7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 May 2020 16:53:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 11:50:12 +02:00

x86/idt: Cleanup trap_init()

No point in having all the IDT cruft in trap_init(). Move it into the IDT
code and fixup the comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200528145522.992376498@linutronix.de

---
 arch/x86/kernel/idt.c   | 18 ++++++++++++++++++
 arch/x86/kernel/traps.c |  9 ---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index b6e1a87..902cdd0 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -4,6 +4,7 @@
  */
 #include <linux/interrupt.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/proto.h>
 #include <asm/desc.h>
@@ -281,6 +282,19 @@ void __init idt_setup_ist_traps(void)
 }
 #endif
 
+static void __init idt_map_in_cea(void)
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
@@ -307,6 +321,10 @@ void __init idt_setup_apic_and_irq_gates(void)
 		set_intr_gate(i, entry);
 	}
 #endif
+	/* Map IDT into CPU entry area and reload it. */
+	idt_map_in_cea();
+	load_idt(&idt_descr);
+
 	idt_setup_done = true;
 }
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 79af913..5566fe5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1056,15 +1056,6 @@ void __init trap_init(void)
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
