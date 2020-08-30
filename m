Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5082FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291EC20714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ztc7xOv2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UwuBvnbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgH3SEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgH3SEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:04:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805ABC061239
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:04:05 -0700 (PDT)
Date:   Sun, 30 Aug 2020 18:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598810644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PLov6OJyw4YYj20WEGy5Z9RMQxqag68Vmha/8svhml4=;
        b=ztc7xOv2RQEJIU5ZpTsu1OFTMSkDNMjEtkc3hceVQJNLQAnPXn51mTapCRBUimee2yXo2q
        aQLFOTmglTQNeU49e4UJrM5ckemKmQjY9o+g5Wv0n4g1PVAzwG2D50tltRV9byiyWkl0rj
        AlSU8aDRuQicsjiCO7VNut2RFJ/rW8SqPOsryAtLaVfILRpj1MaCV3x08CRmwUh0XQJADn
        VwXm2LsYMAh/GaCgsYtKwDQgFRZo40GqvjdG/SwLNPJKH+vxkdj9HlN9bqUSkV5rH4tv/f
        80VlHlrUsyuMWfeGM/O6X1ciD/kD8tgwxViGLCOZUQp0Jc/Ddk286ScXIP7kVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598810644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PLov6OJyw4YYj20WEGy5Z9RMQxqag68Vmha/8svhml4=;
        b=UwuBvnbwRfDe7/p3XX02bcLqHAmfpsFPf2F0w7kW0HVrRhTK/4gWnMe/UEh7PqlHXaw6ux
        7OgLqyrMvpycmADw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.9-rc2
References: <159881061564.27993.11909051048930389391.tglx@nanos>
Message-ID: <159881061925.27993.10669865438175129325.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-08-30

up to:  784a0830377d: genirq/matrix: Deal with the sillyness of for_each_cpu() on UP

Three interrupt related fixes for X86:

 - Move disabling of the local APIC after invoking fixup_irqs() to ensure
   that interrupts which are incoming are noted in the IRR and not ignored.

 - Unbreak affinity setting. The rework of the entry code reused the
   regular exception entry code for device interrupts. The vector number is
   pushed into the errorcode slot on the stack which is then lifted into an
   argument and set to -1 because that's regs->orig_ax which is used in
   quite some places to check whether the entry came from a syscall. But it
   was overlooked that orig_ax is used in the affinity cleanup code to
   validate whether the interrupt has arrived on the new target. It turned
   out that this vector check is pointless because interrupts are never
   moved from one vector to another on the same CPU. That check is a
   historical leftover from the time where x86 supported multi-CPU
   affinities, but not longer needed with the now strict single CPU
   affinity. Famous last words ...

 - Add a missing check for an empty cpumask into the matrix allocator. The
   affinity change added a warning to catch the case where an interrupt is
   moved on the same CPU to a different vector. This triggers because a
   condition with an empty cpumask returns an assignment from the allocator
   as the allocator uses for_each_cpu() without checking the cpumask for
   being empty. The historical inconsistent for_each_cpu() behaviour of
   ignoring the cpumask and unconditionally claiming that CPU0 is in the
   mask striked again. Sigh.

plus a new entry into the MAINTAINER file for the HPE/UV platform.

Thanks,

	tglx

------------------>
Ashok Raj (1):
      x86/hotplug: Silence APIC only after all interrupts are migrated

Steve Wahl (1):
      MAINTAINERS: Add entry for HPE Superdome Flex (UV) maintainers

Thomas Gleixner (2):
      x86/irq: Unbreak interrupt affinity setting
      genirq/matrix: Deal with the sillyness of for_each_cpu() on UP


 MAINTAINERS                   |  9 +++++++++
 arch/x86/kernel/apic/vector.c | 16 +++++++++-------
 arch/x86/kernel/smpboot.c     | 26 ++++++++++++++++++++------
 kernel/irq/matrix.c           |  7 +++++++
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b0a742ce8f2c..4c8a682eae7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18873,6 +18873,15 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	arch/x86/platform
 
+X86 PLATFORM UV HPE SUPERDOME FLEX
+M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
+R:	Russ Anderson <russ.anderson@hpe.com>
+S:	Supported
+F:	arch/x86/include/asm/uv/
+F:	arch/x86/kernel/apic/x2apic_uv_x.c
+F:	arch/x86/platform/uv/
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index dae32d948bf2..f8a56b5dc29f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -161,6 +161,7 @@ static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
 		apicd->move_in_progress = true;
 		apicd->prev_vector = apicd->vector;
 		apicd->prev_cpu = apicd->cpu;
+		WARN_ON_ONCE(apicd->cpu == newcpu);
 	} else {
 		irq_matrix_free(vector_matrix, apicd->cpu, apicd->vector,
 				managed);
@@ -910,7 +911,7 @@ void send_cleanup_vector(struct irq_cfg *cfg)
 		__send_cleanup_vector(apicd);
 }
 
-static void __irq_complete_move(struct irq_cfg *cfg, unsigned vector)
+void irq_complete_move(struct irq_cfg *cfg)
 {
 	struct apic_chip_data *apicd;
 
@@ -918,15 +919,16 @@ static void __irq_complete_move(struct irq_cfg *cfg, unsigned vector)
 	if (likely(!apicd->move_in_progress))
 		return;
 
-	if (vector == apicd->vector && apicd->cpu == smp_processor_id())
+	/*
+	 * If the interrupt arrived on the new target CPU, cleanup the
+	 * vector on the old target CPU. A vector check is not required
+	 * because an interrupt can never move from one vector to another
+	 * on the same CPU.
+	 */
+	if (apicd->cpu == smp_processor_id())
 		__send_cleanup_vector(apicd);
 }
 
-void irq_complete_move(struct irq_cfg *cfg)
-{
-	__irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
-}
-
 /*
  * Called from fixup_irqs() with @desc->lock held and interrupts disabled.
  */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 27aa04a95702..f5ef689dd62a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1594,14 +1594,28 @@ int native_cpu_disable(void)
 	if (ret)
 		return ret;
 
-	/*
-	 * Disable the local APIC. Otherwise IPI broadcasts will reach
-	 * it. It still responds normally to INIT, NMI, SMI, and SIPI
-	 * messages.
-	 */
-	apic_soft_disable();
 	cpu_disable_common();
 
+        /*
+         * Disable the local APIC. Otherwise IPI broadcasts will reach
+         * it. It still responds normally to INIT, NMI, SMI, and SIPI
+         * messages.
+         *
+         * Disabling the APIC must happen after cpu_disable_common()
+         * which invokes fixup_irqs().
+         *
+         * Disabling the APIC preserves already set bits in IRR, but
+         * an interrupt arriving after disabling the local APIC does not
+         * set the corresponding IRR bit.
+         *
+         * fixup_irqs() scans IRR for set bits so it can raise a not
+         * yet handled interrupt on the new destination CPU via an IPI
+         * but obviously it can't do so for IRR bits which are not set.
+         * IOW, interrupts arriving after disabling the local APIC will
+         * be lost.
+         */
+	apic_soft_disable();
+
 	return 0;
 }
 
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 30cc217b8631..651a4ad6d711 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -380,6 +380,13 @@ int irq_matrix_alloc(struct irq_matrix *m, const struct cpumask *msk,
 	unsigned int cpu, bit;
 	struct cpumap *cm;
 
+	/*
+	 * Not required in theory, but matrix_find_best_cpu() uses
+	 * for_each_cpu() which ignores the cpumask on UP .
+	 */
+	if (cpumask_empty(msk))
+		return -EINVAL;
+
 	cpu = matrix_find_best_cpu(m, msk);
 	if (cpu == UINT_MAX)
 		return -ENOSPC;

