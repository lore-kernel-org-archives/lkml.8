Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A9DC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6584206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgAaM2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:28:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgAaM2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:28:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ixVPB-00048x-GT; Fri, 31 Jan 2020 13:28:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 12A231C1B3C;
        Fri, 31 Jan 2020 13:28:13 +0100 (CET)
Date:   Fri, 31 Jan 2020 12:28:12 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/timer: Don't skip PIT setup when APIC is
 disabled or in legacy mode
Cc:     Anthony Buckley <tony.buckley000@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Drake <drake@endlessm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87sgk6tmk2.fsf@nanos.tec.linutronix.de>
References: <87sgk6tmk2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158047369280.396.809676542150582676.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     979923871f69a4dc926658f9f9a1a4c1bde57552
Gitweb:        https://git.kernel.org/tip/979923871f69a4dc926658f9f9a1a4c1bde57552
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jan 2020 12:54:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 29 Jan 2020 12:50:12 +01:00

x86/timer: Don't skip PIT setup when APIC is disabled or in legacy mode

Tony reported a boot regression caused by the recent workaround for systems
which have a disabled (clock gate off) PIT.

On his machine the kernel fails to initialize the PIT because
apic_needs_pit() does not take into account whether the local APIC
interrupt delivery mode will actually allow to setup and use the local
APIC timer. This should be easy to reproduce with acpi=off on the
command line which also disables HPET.

Due to the way the PIT/HPET and APIC setup ordering works (APIC setup can
require working PIT/HPET) the information is not available at the point
where apic_needs_pit() makes this decision.

To address this, split out the interrupt mode selection from
apic_intr_mode_init(), invoke the selection before making the decision
whether PIT is required or not, and add the missing checks into
apic_needs_pit().

Fixes: c8c4076723da ("x86/timer: Skip PIT initialization on modern chipsets")
Reported-by: Anthony Buckley <tony.buckley000@gmail.com>
Tested-by: Anthony Buckley <tony.buckley000@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Daniel Drake <drake@endlessm.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206125
Link: https://lore.kernel.org/r/87sgk6tmk2.fsf@nanos.tec.linutronix.de
---
 arch/x86/include/asm/apic.h     |  2 ++
 arch/x86/include/asm/x86_init.h |  2 ++
 arch/x86/kernel/apic/apic.c     | 23 ++++++++++++++++++-----
 arch/x86/kernel/time.c          | 12 ++++++++++--
 arch/x86/kernel/x86_init.c      |  1 +
 arch/x86/xen/enlighten_pv.c     |  1 +
 6 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 2ebc17d..be0b9cf 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -140,6 +140,7 @@ extern void apic_soft_disable(void);
 extern void lapic_shutdown(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
+extern void apic_intr_mode_select(void);
 extern void apic_intr_mode_init(void);
 extern void init_apic_mappings(void);
 void register_lapic_address(unsigned long address);
@@ -188,6 +189,7 @@ static inline void disable_local_APIC(void) { }
 # define setup_secondary_APIC_clock x86_init_noop
 static inline void lapic_update_tsc_freq(void) { }
 static inline void init_bsp_APIC(void) { }
+static inline void apic_intr_mode_select(void) { }
 static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 1943585..96d9cd2 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -51,12 +51,14 @@ struct x86_init_resources {
  *				are set up.
  * @intr_init:			interrupt init code
  * @trap_init:			platform specific trap setup
+ * @intr_mode_select:		interrupt delivery mode selection
  * @intr_mode_init:		interrupt delivery mode setup
  */
 struct x86_init_irqs {
 	void (*pre_vector_init)(void);
 	void (*intr_init)(void);
 	void (*trap_init)(void);
+	void (*intr_mode_select)(void);
 	void (*intr_mode_init)(void);
 };
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 28446fa..4b0f911 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -830,8 +830,17 @@ bool __init apic_needs_pit(void)
 	if (!tsc_khz || !cpu_khz)
 		return true;
 
-	/* Is there an APIC at all? */
-	if (!boot_cpu_has(X86_FEATURE_APIC))
+	/* Is there an APIC at all or is it disabled? */
+	if (!boot_cpu_has(X86_FEATURE_APIC) || disable_apic)
+		return true;
+
+	/*
+	 * If interrupt delivery mode is legacy PIC or virtual wire without
+	 * configuration, the local APIC timer wont be set up. Make sure
+	 * that the PIT is initialized.
+	 */
+	if (apic_intr_mode == APIC_PIC ||
+	    apic_intr_mode == APIC_VIRTUAL_WIRE_NO_CONFIG)
 		return true;
 
 	/* Virt guests may lack ARAT, but still have DEADLINE */
@@ -1322,7 +1331,7 @@ void __init sync_Arb_IDs(void)
 
 enum apic_intr_mode_id apic_intr_mode __ro_after_init;
 
-static int __init apic_intr_mode_select(void)
+static int __init __apic_intr_mode_select(void)
 {
 	/* Check kernel option */
 	if (disable_apic) {
@@ -1384,6 +1393,12 @@ static int __init apic_intr_mode_select(void)
 	return APIC_SYMMETRIC_IO;
 }
 
+/* Select the interrupt delivery mode for the BSP */
+void __init apic_intr_mode_select(void)
+{
+	apic_intr_mode = __apic_intr_mode_select();
+}
+
 /*
  * An initial setup of the virtual wire mode.
  */
@@ -1440,8 +1455,6 @@ void __init apic_intr_mode_init(void)
 {
 	bool upmode = IS_ENABLED(CONFIG_UP_LATE_INIT);
 
-	apic_intr_mode = apic_intr_mode_select();
-
 	switch (apic_intr_mode) {
 	case APIC_PIC:
 		pr_info("APIC: Keep in PIC mode(8259)\n");
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 7ce29ce..d8673d8 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -91,10 +91,18 @@ void __init hpet_time_init(void)
 
 static __init void x86_late_time_init(void)
 {
+	/*
+	 * Before PIT/HPET init, select the interrupt mode. This is required
+	 * to make the decision whether PIT should be initialized correct.
+	 */
+	x86_init.irqs.intr_mode_select();
+
+	/* Setup the legacy timers */
 	x86_init.timers.timer_init();
+
 	/*
-	 * After PIT/HPET timers init, select and setup
-	 * the final interrupt mode for delivering IRQs.
+	 * After PIT/HPET timers init, set up the final interrupt mode for
+	 * delivering IRQs.
 	 */
 	x86_init.irqs.intr_mode_init();
 	tsc_init();
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ce89430..9a89261 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -80,6 +80,7 @@ struct x86_init_ops x86_init __initdata = {
 		.pre_vector_init	= init_ISA_irqs,
 		.intr_init		= native_init_IRQ,
 		.trap_init		= x86_init_noop,
+		.intr_mode_select	= apic_intr_mode_select,
 		.intr_mode_init		= apic_intr_mode_init
 	},
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index ae4a41c..1f756ff 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1205,6 +1205,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
 
 	x86_init.resources.memory_setup = xen_memory_setup;
+	x86_init.irqs.intr_mode_select	= x86_init_noop;
 	x86_init.irqs.intr_mode_init	= x86_init_noop;
 	x86_init.oem.arch_setup = xen_arch_setup;
 	x86_init.oem.banner = xen_banner;
