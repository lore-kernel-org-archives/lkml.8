Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B461C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651822089D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgEST7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgEST66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92891C08C5C5;
        Tue, 19 May 2020 12:58:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O5-000056-RQ; Tue, 19 May 2020 21:58:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A2E731C0838;
        Tue, 19 May 2020 21:58:39 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:39 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Disable interrupts for
 native_load_gs_index() in C code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134903.531534675@linutronix.de>
References: <20200505134903.531534675@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991831956.17951.18381408933691356445.tip-bot2@tip-bot2>
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

Commit-ID:     800c8a1afb8e9d71ffb1ff54d6a2cf5c45dc50b5
Gitweb:        https://git.kernel.org/tip/800c8a1afb8e9d71ffb1ff54d6a2cf5c45dc50b5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 04 Mar 2020 23:32:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:53 +02:00

x86/entry: Disable interrupts for native_load_gs_index() in C code

There is absolutely no point in doing this in ASM code. Move it to C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505134903.531534675@linutronix.de


---
 arch/x86/entry/entry_64.S            | 11 +++--------
 arch/x86/include/asm/special_insns.h | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9866b54..be8ed3a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1041,22 +1041,17 @@ idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
  *
  * Is in entry.text as it shouldn't be instrumented.
  */
-SYM_FUNC_START(native_load_gs_index)
+SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
-	pushfq
-	DISABLE_INTERRUPTS(CLBR_ANY & ~CLBR_RDI)
-	TRACE_IRQS_OFF
 	SWAPGS
 .Lgs_change:
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
 	SWAPGS
-	TRACE_IRQS_FLAGS (%rsp)
-	popfq
 	FRAME_END
 	ret
-SYM_FUNC_END(native_load_gs_index)
-EXPORT_SYMBOL(native_load_gs_index)
+SYM_FUNC_END(asm_load_gs_index)
+EXPORT_SYMBOL(asm_load_gs_index)
 
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
 	.section .fixup, "ax"
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 6d37b8f..82436cb 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -7,6 +7,7 @@
 
 #include <asm/nops.h>
 #include <asm/processor-flags.h>
+#include <linux/irqflags.h>
 #include <linux/jump_label.h>
 
 /*
@@ -129,7 +130,16 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void native_load_gs_index(unsigned);
+extern asmlinkage void asm_load_gs_index(unsigned int selector);
+
+static inline void native_load_gs_index(unsigned int selector)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	asm_load_gs_index(selector);
+	local_irq_restore(flags);
+}
 
 static inline unsigned long __read_cr4(void)
 {
@@ -186,7 +196,7 @@ static inline void wbinvd(void)
 
 #ifdef CONFIG_X86_64
 
-static inline void load_gs_index(unsigned selector)
+static inline void load_gs_index(unsigned int selector)
 {
 	native_load_gs_index(selector);
 }
