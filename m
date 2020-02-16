Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCB7C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4332084E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBPUJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:09:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgBPUJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:09:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3QDr-0006Z4-CS; Sun, 16 Feb 2020 21:08:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C32E01C208C;
        Sun, 16 Feb 2020 21:08:57 +0100 (CET)
Date:   Sun, 16 Feb 2020 20:08:57 -0000
From:   "tip-bot2 for Martin Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix a handful of typos
Cc:     Martin Molnar <martin.molnar.programming@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
References: <0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com>
MIME-Version: 1.0
Message-ID: <158188373741.13786.11592756723123695998.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4d1d0977a2156a1dafe8f1cd890ab918c803485b
Gitweb:        https://git.kernel.org/tip/4d1d0977a2156a1dafe8f1cd890ab918c803485b
Author:        Martin Molnar <martin.molnar.programming@gmail.com>
AuthorDate:    Sun, 16 Feb 2020 16:17:39 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 16 Feb 2020 20:58:06 +01:00

x86: Fix a handful of typos

Fix a couple of typos in code comments.

 [ bp: While at it: s/IRQ's/IRQs/. ]

Signed-off-by: Martin Molnar <martin.molnar.programming@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/0819a044-c360-44a4-f0b6-3f5bafe2d35c@gmail.com
---
 arch/x86/kernel/irqinit.c  | 2 +-
 arch/x86/kernel/nmi.c      | 4 ++--
 arch/x86/kernel/reboot.c   | 2 +-
 arch/x86/kernel/smpboot.c  | 2 +-
 arch/x86/kernel/tsc.c      | 2 +-
 arch/x86/kernel/tsc_sync.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 16919a9..1e5ad12 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -84,7 +84,7 @@ void __init init_IRQ(void)
 	 * On cpu 0, Assign ISA_IRQ_VECTOR(irq) to IRQ 0..15.
 	 * If these IRQ's are handled by legacy interrupt-controllers like PIC,
 	 * then this configuration will likely be static after the boot. If
-	 * these IRQ's are handled by more mordern controllers like IO-APIC,
+	 * these IRQs are handled by more modern controllers like IO-APIC,
 	 * then this vector space can be freed and re-used dynamically as the
 	 * irq's migrate etc.
 	 */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 54c21d6..6407ea2 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -403,9 +403,9 @@ static void default_do_nmi(struct pt_regs *regs)
 	 * a 'real' unknown NMI.  For example, while processing
 	 * a perf NMI another perf NMI comes in along with a
 	 * 'real' unknown NMI.  These two NMIs get combined into
-	 * one (as descibed above).  When the next NMI gets
+	 * one (as described above).  When the next NMI gets
 	 * processed, it will be flagged by perf as handled, but
-	 * noone will know that there was a 'real' unknown NMI sent
+	 * no one will know that there was a 'real' unknown NMI sent
 	 * also.  As a result it gets swallowed.  Or if the first
 	 * perf NMI returns two events handled then the second
 	 * NMI will get eaten by the logic below, again losing a
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0cc7c0b..3ca43be 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -531,7 +531,7 @@ static void emergency_vmx_disable_all(void)
 
 	/*
 	 * We need to disable VMX on all CPUs before rebooting, otherwise
-	 * we risk hanging up the machine, because the CPU ignore INIT
+	 * we risk hanging up the machine, because the CPU ignores INIT
 	 * signals when VMX is enabled.
 	 *
 	 * We can't take any locks and we may be on an inconsistent
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2..3feaeee 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1434,7 +1434,7 @@ early_param("possible_cpus", _setup_possible_cpus);
 /*
  * cpu_possible_mask should be static, it cannot change as cpu's
  * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and dont expect to
+ * are allocated by some modules at init time, and don't expect to
  * do this dynamically on cpu arrival/departure.
  * cpu_present_mask on the other hand can change dynamically.
  * In case when cpu_hotplug is not compiled, then we resort to current
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2..0109b9d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -477,7 +477,7 @@ static unsigned long pit_calibrate_tsc(u32 latch, unsigned long ms, int loopmin)
  * transition from one expected value to another with a fairly
  * high accuracy, and we didn't miss any events. We can thus
  * use the TSC value at the transitions to calculate a pretty
- * good value for the TSC frequencty.
+ * good value for the TSC frequency.
  */
 static inline int pit_verify_msb(unsigned char val)
 {
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 32a8187..3d3c761 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -295,7 +295,7 @@ static cycles_t check_tsc_warp(unsigned int timeout)
  * But as the TSC is per-logical CPU and can potentially be modified wrongly
  * by the bios, TSC sync test for smaller duration should be able
  * to catch such errors. Also this will catch the condition where all the
- * cores in the socket doesn't get reset at the same time.
+ * cores in the socket don't get reset at the same time.
  */
 static inline unsigned int loop_timeout(int cpu)
 {
