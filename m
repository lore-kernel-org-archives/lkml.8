Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F5BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EE62075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbgE1O4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403815AbgE1O4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:56:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2A2C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:56:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeJx7-0002QI-D2; Thu, 28 May 2020 16:56:14 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E267C100D01;
        Thu, 28 May 2020 16:56:12 +0200 (CEST)
Message-Id: <20200528145522.898591501@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 28 May 2020 16:53:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 3/5] x86/idt: Use proper constants for table sizes
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

Use the actual struct size to calculate the IDT table sizes instead of two
different hardcoded values.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/idt.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -51,6 +51,8 @@ struct idt_data {
 #define TSKG(_vector, _gdt)				\
 	G(_vector, NULL, DEFAULT_STACK, GATE_TASK, DPL0, _gdt << 3)
 
+#define IDT_TABLE_SIZE		(IDT_ENTRIES * sizeof(gate_desc))
+#define IDT_DEBUG_TABLE_SIZE	(16 * sizeof(gate_desc))
 
 static bool idt_setup_done __initdata;
 
@@ -176,7 +178,7 @@ static const __initconst struct idt_data
 gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
 
 struct desc_ptr idt_descr __ro_after_init = {
-	.size		= (IDT_ENTRIES * 2 * sizeof(unsigned long)) - 1,
+	.size		= IDT_TABLE_SIZE - 1,
 	.address	= (unsigned long) idt_table,
 };
 
@@ -202,7 +204,7 @@ static const __initconst struct idt_data
  * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
  */
 const struct desc_ptr debug_idt_descr = {
-	.size		= IDT_ENTRIES * 16 - 1,
+	.size		= IDT_DEBUG_TABLE_SIZE - 1,
 	.address	= (unsigned long) debug_idt_table,
 };
 #endif
@@ -304,9 +306,10 @@ void __init idt_setup_ist_traps(void)
  */
 void __init idt_setup_debugidt_traps(void)
 {
-	memcpy(&debug_idt_table, &idt_table, IDT_ENTRIES * 16);
+	memcpy(&debug_idt_table, &idt_table, IDT_DEBUG_TABLE_SIZE);
 
-	idt_setup_from_table(debug_idt_table, dbg_idts, ARRAY_SIZE(dbg_idts), false);
+	idt_setup_from_table(debug_idt_table, dbg_idts, ARRAY_SIZE(dbg_idts),
+			     false);
 }
 #endif
 

