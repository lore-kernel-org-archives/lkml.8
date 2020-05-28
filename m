Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D754BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F982084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403889AbgE1O4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403813AbgE1O4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:56:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3FC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:56:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeJx6-0002QG-PO; Thu, 28 May 2020 16:56:13 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id AD680FF834;
        Thu, 28 May 2020 16:56:11 +0200 (CEST)
Message-Id: <20200528145522.807135882@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 28 May 2020 16:53:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 2/5] x86/idt: Add comments about early #PF handling
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

The difference between 32 and 64 bit vs. early #PF handling is not
documented. Replace the FIXME at idt_setup_early_pf() with proper comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/idt.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -61,7 +61,11 @@ static bool idt_setup_done __initdata;
 static const __initconst struct idt_data early_idts[] = {
 	INTG(X86_TRAP_DB,		asm_exc_debug),
 	SYSG(X86_TRAP_BP,		asm_exc_int3),
+
 #ifdef CONFIG_X86_32
+	/*
+	 * Not possible on 64-bit. See idt_setup_early_pf() for details.
+	 */
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 #endif
 };
@@ -276,8 +280,10 @@ void __init idt_setup_traps(void)
  * cpu_init() is invoked and sets up TSS. The IST variant is installed
  * after that.
  *
- * FIXME: Why is 32bit and 64bit installing the PF handler at different
- * places in the early setup code?
+ * Note, that X86_64 cannot install the real #PF handler in
+ * idt_setup_early_traps() because the memory intialization needs the #PF
+ * handler from the early_idt_handler_array to initialize the early page
+ * tables.
  */
 void __init idt_setup_early_pf(void)
 {

