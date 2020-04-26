Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF72EC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3F720A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDZSnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgDZSnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:43:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE9C061A0F;
        Sun, 26 Apr 2020 11:43:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmF0-0007E9-2P; Sun, 26 Apr 2020 20:42:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B1C041C03A9;
        Sun, 26 Apr 2020 20:42:54 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:54 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/cpu: Uninline CR4 accessors
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092558.939985695@linutronix.de>
References: <20200421092558.939985695@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657431.28353.5998160034997742089.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d8f0b35331c4423e033f81f10eb5e0c7e4e1dcec
Gitweb:        https://git.kernel.org/tip/d8f0b35331c4423e033f81f10eb5e0c7e4e1dcec
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 24 Apr 2020 18:46:42 +02:00

x86/cpu: Uninline CR4 accessors

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

The various CR4 accessors require cpu_tlbstate as the CR4 shadow cache
is located there.

In preparation for unexporting cpu_tlbstate, create a builtin function
for manipulating CR4 and rework the various helpers to use it.

No functional change.

 [ bp: push the export of native_write_cr4() only when CONFIG_LKTDM=m to
   the last patch in the series. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092558.939985695@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 36 ++++----------------------------
 arch/x86/kernel/cpu/common.c    | 23 +++++++++++++++++++-
 arch/x86/kernel/process.c       | 11 ++++++++++-
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6f66d84..d804030 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -276,37 +276,25 @@ static inline bool nmi_uaccess_okay(void)
 
 #define nmi_uaccess_okay nmi_uaccess_okay
 
+void cr4_update_irqsoff(unsigned long set, unsigned long clear);
+unsigned long cr4_read_shadow(void);
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
 	this_cpu_write(cpu_tlbstate.cr4, __read_cr4());
 }
 
-static inline void __cr4_set(unsigned long cr4)
-{
-	lockdep_assert_irqs_disabled();
-	this_cpu_write(cpu_tlbstate.cr4, cr4);
-	__write_cr4(cr4);
-}
-
 /* Set in this cpu's CR4. */
 static inline void cr4_set_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	if ((cr4 | mask) != cr4)
-		__cr4_set(cr4 | mask);
+	cr4_update_irqsoff(mask, 0);
 }
 
 /* Clear in this cpu's CR4. */
 static inline void cr4_clear_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	if ((cr4 & ~mask) != cr4)
-		__cr4_set(cr4 & ~mask);
+	cr4_update_irqsoff(0, mask);
 }
 
 /* Set in this cpu's CR4. */
@@ -329,20 +317,6 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
 
-static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
-{
-	unsigned long cr4;
-
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	__cr4_set(cr4 ^ mask);
-}
-
-/* Read the CR4 shadow. */
-static inline unsigned long cr4_read_shadow(void)
-{
-	return this_cpu_read(cpu_tlbstate.cr4);
-}
-
 /*
  * Mark all other ASIDs as invalid, preserves the current.
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb8..82042f4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -387,7 +387,28 @@ set_register:
 			  bits_missing);
 	}
 }
-EXPORT_SYMBOL(native_write_cr4);
+EXPORT_SYMBOL_GPL(native_write_cr4);
+
+void cr4_update_irqsoff(unsigned long set, unsigned long clear)
+{
+	unsigned long newval, cr4 = this_cpu_read(cpu_tlbstate.cr4);
+
+	lockdep_assert_irqs_disabled();
+
+	newval = (cr4 & ~clear) | set;
+	if (newval != cr4) {
+		this_cpu_write(cpu_tlbstate.cr4, newval);
+		__write_cr4(newval);
+	}
+}
+EXPORT_SYMBOL(cr4_update_irqsoff);
+
+/* Read the CR4 shadow. */
+unsigned long cr4_read_shadow(void)
+{
+	return this_cpu_read(cpu_tlbstate.cr4);
+}
+EXPORT_SYMBOL_GPL(cr4_read_shadow);
 
 void cr4_init(void)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b2..f2eab49 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -612,6 +612,17 @@ void speculation_ctrl_update_current(void)
 	preempt_enable();
 }
 
+static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
+{
+	unsigned long newval, cr4 = this_cpu_read(cpu_tlbstate.cr4);
+
+	newval = cr4 ^ mask;
+	if (newval != cr4) {
+		this_cpu_write(cpu_tlbstate.cr4, newval);
+		__write_cr4(newval);
+	}
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	unsigned long tifp, tifn;
