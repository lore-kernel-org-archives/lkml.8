Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C86CC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF9224984
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgEASWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730693AbgEASWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4C7C061A0C;
        Fri,  1 May 2020 11:22:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIr-0003eG-08; Fri, 01 May 2020 20:22:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 91C071C0085;
        Fri,  1 May 2020 20:22:19 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:19 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86: Simplify retpoline declaration
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428191700.091696925@infradead.org>
References: <20200428191700.091696925@infradead.org>
MIME-Version: 1.0
Message-ID: <158835733956.8414.14836642152180567436.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ca3f0d80dd57c8828bfb5bc0bc79750ea7a1ba26
Gitweb:        https://git.kernel.org/tip/ca3f0d80dd57c8828bfb5bc0bc79750ea7a1ba26
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 22 Apr 2020 17:03:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:34 +02:00

x86: Simplify retpoline declaration

Because of how KSYM works, we need one declaration per line. Seeing
how we're going to be doubling the amount of retpoline symbols,
simplify the machinery in order to avoid having to copy/paste even
more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200428191700.091696925@infradead.org
---
 arch/x86/include/asm/GEN-for-each-reg.h | 25 ++++++++++++++++-
 arch/x86/include/asm/asm-prototypes.h   | 28 +++++-------------
 arch/x86/lib/retpoline.S                | 37 ++++++++++--------------
 3 files changed, 49 insertions(+), 41 deletions(-)
 create mode 100644 arch/x86/include/asm/GEN-for-each-reg.h

diff --git a/arch/x86/include/asm/GEN-for-each-reg.h b/arch/x86/include/asm/GEN-for-each-reg.h
new file mode 100644
index 0000000..1b07fb1
--- /dev/null
+++ b/arch/x86/include/asm/GEN-for-each-reg.h
@@ -0,0 +1,25 @@
+#ifdef CONFIG_64BIT
+GEN(rax)
+GEN(rbx)
+GEN(rcx)
+GEN(rdx)
+GEN(rsi)
+GEN(rdi)
+GEN(rbp)
+GEN(r8)
+GEN(r9)
+GEN(r10)
+GEN(r11)
+GEN(r12)
+GEN(r13)
+GEN(r14)
+GEN(r15)
+#else
+GEN(eax)
+GEN(ebx)
+GEN(ecx)
+GEN(edx)
+GEN(esi)
+GEN(edi)
+GEN(ebp)
+#endif
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index ce92c4a..aa7585e 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -17,24 +17,12 @@ extern void cmpxchg8b_emu(void);
 #endif
 
 #ifdef CONFIG_RETPOLINE
-#ifdef CONFIG_X86_32
-#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_e ## reg(void);
-#else
-#define INDIRECT_THUNK(reg) extern asmlinkage void __x86_indirect_thunk_r ## reg(void);
-INDIRECT_THUNK(8)
-INDIRECT_THUNK(9)
-INDIRECT_THUNK(10)
-INDIRECT_THUNK(11)
-INDIRECT_THUNK(12)
-INDIRECT_THUNK(13)
-INDIRECT_THUNK(14)
-INDIRECT_THUNK(15)
-#endif
-INDIRECT_THUNK(ax)
-INDIRECT_THUNK(bx)
-INDIRECT_THUNK(cx)
-INDIRECT_THUNK(dx)
-INDIRECT_THUNK(si)
-INDIRECT_THUNK(di)
-INDIRECT_THUNK(bp)
+
+#define DECL_INDIRECT_THUNK(reg) \
+	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
+
+#undef GEN
+#define GEN(reg) DECL_INDIRECT_THUNK(reg)
+#include <asm/GEN-for-each-reg.h>
+
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 363ec13..9cc5480 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -24,25 +24,20 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
  * only see one instance of "__x86_indirect_thunk_\reg" rather
  * than one per register with the correct names. So we do it
  * the simple and nasty way...
+ *
+ * Worse, you can only have a single EXPORT_SYMBOL per line,
+ * and CPP can't insert newlines, so we have to repeat everything
+ * at least twice.
  */
-#define __EXPORT_THUNK(sym) _ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
-#define GENERATE_THUNK(reg) THUNK reg ; EXPORT_THUNK(reg)
-
-GENERATE_THUNK(_ASM_AX)
-GENERATE_THUNK(_ASM_BX)
-GENERATE_THUNK(_ASM_CX)
-GENERATE_THUNK(_ASM_DX)
-GENERATE_THUNK(_ASM_SI)
-GENERATE_THUNK(_ASM_DI)
-GENERATE_THUNK(_ASM_BP)
-#ifdef CONFIG_64BIT
-GENERATE_THUNK(r8)
-GENERATE_THUNK(r9)
-GENERATE_THUNK(r10)
-GENERATE_THUNK(r11)
-GENERATE_THUNK(r12)
-GENERATE_THUNK(r13)
-GENERATE_THUNK(r14)
-GENERATE_THUNK(r15)
-#endif
+
+#define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
+#define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+
+#undef GEN
+#define GEN(reg) THUNK reg
+#include <asm/GEN-for-each-reg.h>
+
+#undef GEN
+#define GEN(reg) EXPORT_THUNK(reg)
+#include <asm/GEN-for-each-reg.h>
+
