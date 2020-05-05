Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD79C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74672206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgEEOPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729800AbgEEOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:15:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B224C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:15:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLX-0001GX-0e; Tue, 05 May 2020 16:14:55 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 838F5FFC8D;
        Tue,  5 May 2020 16:14:54 +0200 (CEST)
Message-Id: <20200505134903.531534675@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:43:57 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 3 03/29] x86/entry: Disable interrupts for
 native_load_gs_index() in C code
References: <20200505134354.774943181@linutronix.de>
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

There is absolutely no point in doing this in ASM code. Move it to C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S            |   19 +++++++------------
 arch/x86/include/asm/special_insns.h |   14 ++++++++++++--
 2 files changed, 19 insertions(+), 14 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1036,27 +1036,22 @@ idtentry alignment_check		do_alignment_c
 idtentry simd_coprocessor_error		do_simd_coprocessor_error	has_error_code=0
 
 
-	/*
-	 * Reload gs selector with exception handling
-	 * edi:  new selector
-	 */
+/*
+ * Reload gs selector with exception handling
+ * edi:  new selector
+ */
 .pushsection .text, "ax"
-SYM_FUNC_START(native_load_gs_index)
+SYM_FUNC_START(asm_native_load_gs_index)
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
+SYM_FUNC_END(asm_native_load_gs_index)
+EXPORT_SYMBOL(asm_native_load_gs_index)
 .popsection
 
 	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
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
+extern asmlinkage void asm_native_load_gs_index(unsigned int selector);
+
+static inline void native_load_gs_index(unsigned int selector)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	asm_native_load_gs_index(selector);
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

