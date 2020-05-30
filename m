Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE71DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90704212CC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgE3J5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgE3J5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC36C03E969;
        Sat, 30 May 2020 02:57:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyF5-0002rm-0Y; Sat, 30 May 2020 11:57:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 934C01C0481;
        Sat, 30 May 2020 11:57:21 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:21 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Introduce local_db_{save,restore}()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.012060983@infradead.org>
References: <20200529213321.012060983@infradead.org>
MIME-Version: 1.0
Message-ID: <159083264144.17951.18340116301852941201.tip-bot2@tip-bot2>
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

Commit-ID:     57234891b3287b986e003876f906d95c9871e62e
Gitweb:        https://git.kernel.org/tip/57234891b3287b986e003876f906d95c9871e62e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:07 +02:00

x86/entry: Introduce local_db_{save,restore}()

In order to allow other exceptions than #DB to disable breakpoints,
provide common helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.012060983@infradead.org

---
 arch/x86/include/asm/debugreg.h | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c         | 18 ++----------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 1a8609a..4ef8690 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -113,6 +113,36 @@ static inline void debug_stack_usage_inc(void) { }
 static inline void debug_stack_usage_dec(void) { }
 #endif /* X86_64 */
 
+static __always_inline unsigned long local_db_save(void)
+{
+	unsigned long dr7;
+
+	get_debugreg(dr7, 7);
+	dr7 &= ~0x400; /* architecturally set bit */
+	if (dr7)
+		set_debugreg(0, 7);
+	/*
+	 * Ensure the compiler doesn't lower the above statements into
+	 * the critical section; disabling breakpoints late would not
+	 * be good.
+	 */
+	barrier();
+
+	return dr7;
+}
+
+static __always_inline void local_db_restore(unsigned long dr7)
+{
+	/*
+	 * Ensure the compiler doesn't raise this statement into
+	 * the critical section; enabling breakpoints early would
+	 * not be good.
+	 */
+	barrier();
+	if (dr7)
+		set_debugreg(dr7, 7);
+}
+
 #ifdef CONFIG_CPU_SUP_AMD
 extern void set_dr_addr_mask(unsigned long mask, int dr);
 #else
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 50fb9cd..bcb9dd9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -727,15 +727,7 @@ static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
 	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
 	 * includes the entry stack is excluded for everything.
 	 */
-	get_debugreg(*dr7, 7);
-	set_debugreg(0, 7);
-
-	/*
-	 * Ensure the compiler doesn't lower the above statements into
-	 * the critical section; disabling breakpoints late would not
-	 * be good.
-	 */
-	barrier();
+	*dr7 = local_db_save();
 
 	/*
 	 * The Intel SDM says:
@@ -756,13 +748,7 @@ static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
 
 static __always_inline void debug_exit(unsigned long dr7)
 {
-	/*
-	 * Ensure the compiler doesn't raise this statement into
-	 * the critical section; enabling breakpoints early would
-	 * not be good.
-	 */
-	barrier();
-	set_debugreg(dr7, 7);
+	local_db_restore(dr7);
 }
 
 /*
