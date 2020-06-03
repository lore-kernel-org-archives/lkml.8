Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBFEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBE22068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFCRup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFCRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B6DC08C5C0;
        Wed,  3 Jun 2020 10:50:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX4-0005xJ-46; Wed, 03 Jun 2020 19:50:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 31E841C0081;
        Wed,  3 Jun 2020 19:50:29 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:28 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry, cpumask: Provide non-instrumented variant
 of cpu_is_offline()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603114052.300804240@infradead.org>
References: <20200603114052.300804240@infradead.org>
MIME-Version: 1.0
Message-ID: <159120662899.17951.13235553717544258833.tip-bot2@tip-bot2>
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

Commit-ID:     02da62886d81c6683fbd6a09aec02b2c050d5827
Gitweb:        https://git.kernel.org/tip/02da62886d81c6683fbd6a09aec02b2c050d5827
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:39 +02:00

x86/entry, cpumask: Provide non-instrumented variant of cpu_is_offline()

vmlinux.o: warning: objtool: exc_nmi()+0x12: call to cpumask_test_cpu.constprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x12: call to cpumask_test_cpu.constprop.0()leaves .noinstr.text section

  cpumask_test_cpu()
    test_bit()
      instrument_atomic_read()
      arch_test_bit()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200603114052.300804240@infradead.org

---
 arch/x86/kernel/cpu/mce/core.c |  2 +-
 arch/x86/kernel/nmi.c          |  2 +-
 include/linux/cpumask.h        | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b9cb381..310c2b3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1104,7 +1104,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (cpu_is_offline(cpu) ||
+	if (arch_cpu_is_offline(cpu) ||
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4a43934..8bd5dfd 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -482,7 +482,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
 {
-	if (IS_ENABLED(CONFIG_SMP) && cpu_is_offline(smp_processor_id()))
+	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
 
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d..d0f0e34 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -888,7 +888,20 @@ static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
 	return to_cpumask(p);
 }
 
-#define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
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
+#define cpu_is_offline(cpu)		unlikely(!cpu_online(cpu))
 
 #if NR_CPUS <= BITS_PER_LONG
 #define CPU_BITS_ALL						\
