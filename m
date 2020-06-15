Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1042C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D792074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgFOWbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:31:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A786C061A0E;
        Mon, 15 Jun 2020 15:31:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkxdo-0006xX-H7; Tue, 16 Jun 2020 00:31:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F3CC91C0478;
        Tue, 16 Jun 2020 00:31:43 +0200 (CEST)
Date:   Mon, 15 Jun 2020 22:31:43 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry, cpumask: Provide non-instrumented variant
 of cpu_is_offline()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159226030365.16989.15929458838816138903.tip-bot2@tip-bot2>
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

Commit-ID:     14d3b376b6c3f66d62559d457d32edf565472163
Gitweb:        https://git.kernel.org/tip/14d3b376b6c3f66d62559d457d32edf565472163
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:32:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:09 +02:00

x86/entry, cpumask: Provide non-instrumented variant of cpu_is_offline()

vmlinux.o: warning: objtool: exc_nmi()+0x12: call to cpumask_test_cpu.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x12: call to cpumask_test_cpu.constprop.0()leaves .noinstr.text section

  cpumask_test_cpu()
    test_bit()
      instrument_atomic_read()
      arch_test_bit()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cpumask.h | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/mce/core.c |  2 +-
 arch/x86/kernel/nmi.c          |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index 6722ffc..3afa990 100644
--- a/arch/x86/include/asm/cpumask.h
+++ b/arch/x86/include/asm/cpumask.h
@@ -11,5 +11,23 @@ extern cpumask_var_t cpu_sibling_setup_mask;
 
 extern void setup_cpu_local_masks(void);
 
+/*
+ * NMI and MCE exceptions need cpu_is_offline() _really_ early,
+ * provide an arch_ special for them to avoid instrumentation.
+ */
+#if NR_CPUS > 1
+static __always_inline bool arch_cpu_online(int cpu)
+{
+	return arch_test_bit(cpu, cpumask_bits(cpu_online_mask));
+}
+#else
+static __always_inline bool arch_cpu_online(int cpu)
+{
+	return cpu == 0;
+}
+#endif
+
+#define arch_cpu_is_offline(cpu)	unlikely(!arch_cpu_online(cpu))
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_CPUMASK_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce9120c..fbe89a9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1083,7 +1083,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (cpu_is_offline(cpu) ||
+	if (arch_cpu_is_offline(cpu) ||
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 2de365f..d7c5e44 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -478,7 +478,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
-	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
+	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
