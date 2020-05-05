Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD18C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B1C207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgEEOQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730100AbgEEOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0592C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:24 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMh-00026f-2k; Tue, 05 May 2020 16:16:07 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8ECA9FFC8D;
        Tue,  5 May 2020 16:16:06 +0200 (CEST)
Message-Id: <20200505135315.084882104@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:44 +0200
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
Subject: [patch V4 part 4 18/24] x86/entry: Provide IDTRENTRY_NOIST variants
 for #DB and #MC
References: <20200505134926.578885807@linutronix.de>
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

Provide NOIST entry point macros which allows to implement NOIST variants
of the C entry points. These are invoked when #DB or #MC enter from user
space. This allows explicit handling of the difference between user mode
and kernel mode entry later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/idtentry.h |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -138,10 +138,12 @@ static __always_inline void __##func(str
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Maps to DECLARE_IDTENTRY_RAW
+ * Maps to DECLARE_IDTENTRY_RAW, but declares also the NOIST C handler
+ * which is called from the ASM entry point on user mode entry
  */
 #define DECLARE_IDTENTRY_IST(vector, func)				\
-	DECLARE_IDTENTRY_RAW(vector, func)
+	DECLARE_IDTENTRY_RAW(vector, func);				\
+	__visible void noist_##func(struct pt_regs *regs)
 
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
@@ -152,6 +154,17 @@ static __always_inline void __##func(str
 #define DEFINE_IDTENTRY_IST(func)					\
 	DEFINE_IDTENTRY_RAW(func)
 
+/**
+ * DEFINE_IDTENTRY_NOIST - Emit code for NOIST entry points which
+ *			   belong to a IST entry point (MCE, DB)
+ * @func:	Function name of the entry point. Must be the same as
+ *		the function name of the corresponding IST variant
+ *
+ * Maps to DEFINE_IDTENTRY_RAW().
+ */
+#define DEFINE_IDTENTRY_NOIST(func)					\
+	DEFINE_IDTENTRY_RAW(noist_##func)
+
 #else	/* CONFIG_X86_64 */
 /* Maps to a regular IDTENTRY on 32bit for now */
 # define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
@@ -161,12 +174,14 @@ static __always_inline void __##func(str
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
 
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
 
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
 
 /**
  * DECLARE_IDTENTRY_XEN - Declare functions for XEN redirect IDT entry points

