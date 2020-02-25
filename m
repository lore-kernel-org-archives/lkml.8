Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E07C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CCD21927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgBYXZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:25:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55453 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgBYXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:43 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jZw-0004W3-Op; Wed, 26 Feb 2020 00:25:29 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4CFB1104083;
        Wed, 26 Feb 2020 00:25:28 +0100 (CET)
Message-Id: <20200225220216.428188397@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:39 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 03/10] x86/entry/32: Force MCE through do_mce()
References: <20200225213636.689276920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the pointless difference between 32 and 64 bit to make further
unifications simpler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S          |    2 +-
 arch/x86/include/asm/mce.h         |    3 ---
 arch/x86/kernel/cpu/mce/internal.h |    3 +++
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1365,7 +1365,7 @@ SYM_CODE_END(divide_error)
 SYM_CODE_START(machine_check)
 	ASM_CLAC
 	pushl	$0
-	pushl	machine_check_vector
+	pushl	$do_mce
 	jmp	common_exception
 SYM_CODE_END(machine_check)
 #endif
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -238,9 +238,6 @@ extern void mce_disable_bank(int bank);
 /*
  * Exception handler
  */
-
-/* Call the installed machine check handler for this CPU setup. */
-extern void (*machine_check_vector)(struct pt_regs *, long error_code);
 void do_machine_check(struct pt_regs *, long);
 
 /*
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -8,6 +8,9 @@
 #include <linux/device.h>
 #include <asm/mce.h>
 
+/* Pointer to the installed machine check handler for this CPU setup. */
+extern void (*machine_check_vector)(struct pt_regs *, long error_code);
+
 enum severity_level {
 	MCE_NO_SEVERITY,
 	MCE_DEFERRED_SEVERITY,

