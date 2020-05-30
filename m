Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D956F208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgE3J5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgE3J5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE02C03E969;
        Sat, 30 May 2020 02:57:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEv-0002ou-F6; Sat, 30 May 2020 11:57:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 138D11C032F;
        Sat, 30 May 2020 11:57:17 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:16 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idt: Add comments about early #PF handling
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528145522.807135882@linutronix.de>
References: <20200528145522.807135882@linutronix.de>
MIME-Version: 1.0
Message-ID: <159083263692.17951.2671790138858000362.tip-bot2@tip-bot2>
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

Commit-ID:     66d2e706c0cecd09b1f3de4844574d30e5469c28
Gitweb:        https://git.kernel.org/tip/66d2e706c0cecd09b1f3de4844574d30e5469c28
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 May 2020 16:53:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 11:50:11 +02:00

x86/idt: Add comments about early #PF handling

The difference between 32 and 64 bit vs. early #PF handling is not
documented. Replace the FIXME at idt_setup_early_pf() with proper comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200528145522.807135882@linutronix.de

---
 arch/x86/kernel/idt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 4b99f7b..5ef82fc 100644
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
@@ -256,8 +260,10 @@ void __init idt_setup_traps(void)
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
