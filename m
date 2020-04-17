Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA458C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952082137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AluqYVhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgDQH5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgDQH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:57:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E29C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:57:46 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DA8008DA98E92B4F5B53B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a800:8da9:8e92:b4f5:b53b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 06A3E1EC0D05;
        Fri, 17 Apr 2020 09:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587110264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zuEo7svkjrMtI2OullVs2TYs+y2TT7+L22ms+w42ubo=;
        b=AluqYVhE2FzTFdXUeT4xeP8Zqbda3m78zs7OAlMcnAi+6WBNp1ceDsd6keLqHn0nwuthvX
        ZlotGM4DmPg6brZch9pfEg4Cbg/OnSbp0NkBnkBt7leIyqs8BI2Kd0rh08QSYpqptNrYTb
        7Z9mP/tTgmtACpZFe+aplNPkz2vHB9A=
Date:   Fri, 17 Apr 2020 09:57:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200417075739.GA7322@zn.tnic>
References: <20200326223501.GK11398@zn.tnic>
 <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415231930.19755bc7@sf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:19:30PM +0100, Sergei Trofimovich wrote:
> Ah, that makes sense. Borislav, should I send a fix forward against
> x86 tree to move -fno-stack-protector as it was in v1 patch?
> Or you'll revert v2 and apply v1 ~as is? Or should I send those myself?

Yeah, Peter and I have been discussing something like the below
yesterday. I don't like the additional exports too much but would
disable stack protector only for the one function...

---
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3bcf27caf6c9..e258a6a21674 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -990,4 +990,8 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
+extern int enable_start_cpu0;
+void smp_callin(void);
+void notrace start_secondary(void *unused);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 92e1261ec4ec..7130ca9edc50 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -87,7 +87,13 @@ obj-$(CONFIG_PCI)		+= early-quirks.o
 apm-y				:= apm_32.o
 obj-$(CONFIG_APM)		+= apm.o
 obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_SMP)		+= smpboot.o
+
+nostackprot := $(call cc-option, -fno-stack-protector)
+CFLAGS_smpboot_aux.o := $(nostackprot)
+
+smpboot_all-y			:= smpboot.o smpboot_aux.o
+obj-$(CONFIG_SMP)		+= smpboot_all.o
+
 obj-$(CONFIG_X86_TSC)		+= tsc_sync.o
 obj-$(CONFIG_SMP)		+= setup_percpu.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3b9bf8c7e29d..1ce6280999f9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -153,7 +153,7 @@ static void init_freq_invariance(void);
  * Report back to the Boot Processor during boot time or to the caller processor
  * during CPU online.
  */
-static void smp_callin(void)
+void smp_callin(void)
 {
 	int cpuid;
 
@@ -208,65 +208,7 @@ static void smp_callin(void)
 }
 
 static int cpu0_logical_apicid;
-static int enable_start_cpu0;
-/*
- * Activate a secondary processor.
- */
-static void notrace start_secondary(void *unused)
-{
-	/*
-	 * Don't put *anything* except direct CPU state initialization
-	 * before cpu_init(), SMP booting is too fragile that we want to
-	 * limit the things done here to the most necessary things.
-	 */
-	cr4_init();
-
-#ifdef CONFIG_X86_32
-	/* switch away from the initial page table */
-	load_cr3(swapper_pg_dir);
-	__flush_tlb_all();
-#endif
-	load_current_idt();
-	cpu_init();
-	x86_cpuinit.early_percpu_clock_init();
-	preempt_disable();
-	smp_callin();
-
-	enable_start_cpu0 = 0;
-
-	/* otherwise gcc will move up smp_processor_id before the cpu_init */
-	barrier();
-	/*
-	 * Check TSC synchronization with the boot CPU:
-	 */
-	check_tsc_sync_target();
-
-	speculative_store_bypass_ht_init();
-
-	/*
-	 * Lock vector_lock, set CPU online and bring the vector
-	 * allocator online. Online must be set with vector_lock held
-	 * to prevent a concurrent irq setup/teardown from seeing a
-	 * half valid vector space.
-	 */
-	lock_vector_lock();
-	set_cpu_online(smp_processor_id(), true);
-	lapic_online();
-	unlock_vector_lock();
-	cpu_set_state_online(smp_processor_id());
-	x86_platform.nmi_init();
-
-	/* enable local interrupts */
-	local_irq_enable();
-
-	/* to prevent fake stack check failure in clock setup */
-	boot_init_stack_canary();
-
-	x86_cpuinit.setup_percpu_clockev();
-
-	wmb();
-	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
-}
+int enable_start_cpu0;
 
 /**
  * topology_is_primary_thread - Check whether CPU is the primary SMT thread
diff --git a/arch/x86/kernel/smpboot_aux.c b/arch/x86/kernel/smpboot_aux.c
new file mode 100644
index 000000000000..8863fde54eed
--- /dev/null
+++ b/arch/x86/kernel/smpboot_aux.c
@@ -0,0 +1,70 @@
+#include <linux/cpu.h>
+
+#include <asm/desc.h>
+#include <asm/hw_irq.h>
+#include <asm/spec-ctrl.h>
+#include <asm/processor.h>
+#include <asm/stackprotector.h>
+
+/*
+ * Activate a secondary processor.
+ *
+ * Note: boot_init_stack_canary() sets up the canary value so omit the stack
+ * canary creation for this function only by keeping it in a separate
+ * compilation unit.
+ */
+void notrace start_secondary(void *unused)
+{
+	/*
+	 * Don't put *anything* except direct CPU state initialization
+	 * before cpu_init(), SMP booting is too fragile that we want to
+	 * limit the things done here to the most necessary things.
+	 */
+	cr4_init();
+
+#ifdef CONFIG_X86_32
+	/* switch away from the initial page table */
+	load_cr3(swapper_pg_dir);
+	__flush_tlb_all();
+#endif
+	load_current_idt();
+	cpu_init();
+	x86_cpuinit.early_percpu_clock_init();
+	preempt_disable();
+	smp_callin();
+
+	enable_start_cpu0 = 0;
+
+	/* otherwise gcc will move up smp_processor_id before the cpu_init */
+	barrier();
+	/*
+	 * Check TSC synchronization with the boot CPU:
+	 */
+	check_tsc_sync_target();
+
+	speculative_store_bypass_ht_init();
+
+	/*
+	 * Lock vector_lock, set CPU online and bring the vector
+	 * allocator online. Online must be set with vector_lock held
+	 * to prevent a concurrent irq setup/teardown from seeing a
+	 * half valid vector space.
+	 */
+	lock_vector_lock();
+	set_cpu_online(smp_processor_id(), true);
+	lapic_online();
+	unlock_vector_lock();
+	cpu_set_state_online(smp_processor_id());
+	x86_platform.nmi_init();
+
+	/* enable local interrupts */
+	local_irq_enable();
+
+	/* to prevent fake stack check failure in clock setup */
+	boot_init_stack_canary();
+
+	x86_cpuinit.setup_percpu_clockev();
+
+	wmb();
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
