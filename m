Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8CE21531
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgE3J50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgE3J5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B628CC03E969;
        Sat, 30 May 2020 02:57:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEy-0002qw-DA; Sat, 30 May 2020 11:57:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 07F551C032F;
        Sat, 30 May 2020 11:57:20 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:19 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Optimize local_db_save() for virt
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.187833200@infradead.org>
References: <20200529213321.187833200@infradead.org>
MIME-Version: 1.0
Message-ID: <159083263988.17951.3760177189894827282.tip-bot2@tip-bot2>
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

Commit-ID:     299a9a21bf913717c0f28ef4ae8b2f0668c7f00a
Gitweb:        https://git.kernel.org/tip/299a9a21bf913717c0f28ef4ae8b2f0668c7f00a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:08 +02:00

x86/entry: Optimize local_db_save() for virt

Because DRn access is 'difficult' with virt; but the DR7 read is cheaper
than a cacheline miss on native, add a virt specific fast path to
local_db_save(), such that when breakpoints are not in use to avoid
touching DRn entirely.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.187833200@infradead.org

---
 arch/x86/include/asm/debugreg.h |  5 ++++-
 arch/x86/kernel/hw_breakpoint.c | 26 ++++++++++++++++++++++----
 arch/x86/kvm/vmx/nested.c       |  2 +-
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 4ef8690..3e1c502 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -85,7 +85,7 @@ static inline void hw_breakpoint_disable(void)
 	set_debugreg(0UL, 3);
 }
 
-static inline int hw_breakpoint_active(void)
+static inline bool hw_breakpoint_active(void)
 {
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }
@@ -117,6 +117,9 @@ static __always_inline unsigned long local_db_save(void)
 {
 	unsigned long dr7;
 
+	if (static_cpu_has(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
+		return 0;
+
 	get_debugreg(dr7, 7);
 	dr7 &= ~0x400; /* architecturally set bit */
 	if (dr7)
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index fc1743a..8cdf29f 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,8 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	unsigned long *dr7;
 	int i;
 
+	lockdep_assert_irqs_disabled();
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
@@ -117,6 +119,12 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	dr7 = this_cpu_ptr(&cpu_dr7);
 	*dr7 |= encode_dr7(i, info->len, info->type);
 
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
 	set_debugreg(*dr7, 7);
 	if (info->mask)
 		set_dr_addr_mask(info->mask, i);
@@ -136,9 +144,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
+	unsigned long dr7;
 	int i;
 
+	lockdep_assert_irqs_disabled();
+
 	for (i = 0; i < HBP_NUM; i++) {
 		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
 
@@ -151,12 +161,20 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
 		return;
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 &= ~__encode_dr7(i, info->len, info->type);
+	dr7 = this_cpu_read(cpu_dr7);
+	dr7 &= ~__encode_dr7(i, info->len, info->type);
 
-	set_debugreg(*dr7, 7);
+	set_debugreg(dr7, 7);
 	if (info->mask)
 		set_dr_addr_mask(0, i);
+
+	/*
+	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	this_cpu_write(cpu_dr7, dr7);
 }
 
 static int arch_bp_generic_len(int x86_len)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e44f33c..9b40c6a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3028,9 +3028,9 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 	/*
 	 * VMExit clears RFLAGS.IF and DR7, even on a consistency check.
 	 */
-	local_irq_enable();
 	if (hw_breakpoint_active())
 		set_debugreg(__this_cpu_read(cpu_dr7), 7);
+	local_irq_enable();
 	preempt_enable();
 
 	/*
