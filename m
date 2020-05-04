Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E368C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E83206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="JZxRh85f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEDH4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:56:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgEDH4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:56:38 -0400
Received: from zn.tnic (p200300EC2F08AF00C4649254004FA87E.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:af00:c464:9254:4f:a87e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A69B1EC02E0;
        Mon,  4 May 2020 09:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588578997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FNswbSLShkSSm6/XeKHlv3IrKjXpEIO0MzJBqv9/ikY=;
        b=JZxRh85fIp+CIA/d0bABauZMJ3XvUUi+2KgWLS6viLqXXmdtewiwC+9lQlHIcxBkxNCBWX
        legGUUr2MTOxSGKWFx1cOJC4xLu7XfnFVBiYzkswCk2acD4asWC3UDNPU+dfnuj9WiTSLo
        rSa1FPajThztaeEEbpAelZeYXpTLxa4=
Date:   Mon, 4 May 2020 09:56:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM
 counter width
Message-ID: <20200504075632.GB15046@zn.tnic>
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
 <20200429181149.GE16407@zn.tnic>
 <6fb58472-88f2-925b-3a4e-4692957a9582@intel.com>
 <20200430095913.GA3996@zn.tnic>
 <4288b11f-d4da-d311-7112-fa05887f50b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4288b11f-d4da-d311-7112-fa05887f50b4@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 03, 2020 at 11:51:00AM -0700, Reinette Chatre wrote:
> I am struggling with what should follow ...

Since a diff is better than a thousand words :-) see below.

It builds here with my .config but I'm sure it still needs work but you
get the idea. When you do the final version, please split it properly as
in:

- one patch does this:

rename from arch/x86/include/asm/resctrl_sched.h
rename to arch/x86/include/asm/resctrl.h

- the other adds resctrl_cpu_detect()

- last one removes init_cqm() and x86_init_cache_qos(), etc.

Thx.

---
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 3eeaaeb75638..29ee0c088009 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -113,9 +113,10 @@ struct cpuinfo_x86 {
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
-	/* Cache QoS architectural values: */
+	/* Cache QoS architectural values, valid only on the BSP: */
 	int			x86_cache_max_rmid;	/* max index */
 	int			x86_cache_occ_scale;	/* scale to bytes */
+	int			x86_cache_mbm_width_offset;
 	int			x86_power;
 	unsigned long		loops_per_jiffy;
 	/* cpuid returned max cores value: */
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl.h
similarity index 95%
rename from arch/x86/include/asm/resctrl_sched.h
rename to arch/x86/include/asm/resctrl.h
index f6b7fe2833cc..c8a27cbbdae2 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -84,9 +84,12 @@ static inline void resctrl_sched_in(void)
 		__resctrl_sched_in();
 }
 
+void resctrl_cpu_detect(struct cpuinfo_x86 *c);
+
 #else
 
 static inline void resctrl_sched_in(void) {}
+static inline void resctrl_cpu_detect(struct cpuinfo_x86 *c) {}
 
 #endif /* CONFIG_X86_CPU_RESCTRL */
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 547ad7bbf0e0..c36e89930965 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -18,6 +18,7 @@
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
 #include <asm/debugreg.h>
+#include <asm/resctrl.h>
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
@@ -597,6 +598,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eab3ebd22927..74682b8d09b0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -877,30 +877,6 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
 	}
 }
 
-static void init_cqm(struct cpuinfo_x86 *c)
-{
-	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
-		c->x86_cache_max_rmid  = -1;
-		c->x86_cache_occ_scale = -1;
-		return;
-	}
-
-	/* will be overridden if occupancy monitoring exists */
-	c->x86_cache_max_rmid = cpuid_ebx(0xf);
-
-	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
-		u32 eax, ebx, ecx, edx;
-
-		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
-		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
-
-		c->x86_cache_max_rmid  = ecx;
-		c->x86_cache_occ_scale = ebx;
-	}
-}
-
 void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
@@ -968,7 +944,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
-	init_cqm(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
@@ -1400,20 +1375,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void x86_init_cache_qos(struct cpuinfo_x86 *c)
-{
-	/*
-	 * The heavy lifting of max_rmid and cache_occ_scale are handled
-	 * in get_cpu_cap().  Here we just set the max_rmid for the boot_cpu
-	 * in case CQM bits really aren't there in this CPU.
-	 */
-	if (c != &boot_cpu_data) {
-		boot_cpu_data.x86_cache_max_rmid =
-			min(boot_cpu_data.x86_cache_max_rmid,
-			    c->x86_cache_max_rmid);
-	}
-}
-
 /*
  * Validate that ACPI/mptables have the same information about the
  * effective APIC id and update the package map.
@@ -1526,7 +1487,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 
 	x86_init_rdrand(c);
-	x86_init_cache_qos(c);
 	setup_pku(c);
 
 	/*
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a19a680542ce..166d7c355896 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -22,6 +22,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cmdline.h>
 #include <asm/traps.h>
+#include <asm/resctrl.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -322,6 +323,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		detect_ht_early(c);
 }
 
+static void bsp_init_intel(struct cpuinfo_x86 *c)
+{
+	resctrl_cpu_detect(c);
+}
+
 #ifdef CONFIG_X86_32
 /*
  *	Early probe support logic for ppro memory erratum #50
@@ -961,6 +967,7 @@ static const struct cpu_dev intel_cpu_dev = {
 #endif
 	.c_detect_tlb	= intel_detect_tlb,
 	.c_early_init   = early_init_intel,
+	.c_bsp_init	= bsp_init_intel,
 	.c_init		= init_intel,
 	.c_x86_vendor	= X86_VENDOR_INTEL,
 };
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d8cc5223b7ce..5e5955aa6593 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
 #include <linux/cpuhotplug.h>
 
 #include <asm/intel-family.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include "internal.h"
 
 /* Mutex to protect rdtgroup access. */
@@ -958,6 +958,35 @@ static __init void rdt_init_res_defs(void)
 
 static enum cpuhp_state rdt_online;
 
+/* Runs once on the BSP during boot. */
+void resctrl_cpu_detect(struct cpuinfo_x86 *c)
+{
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		c->x86_cache_max_rmid  = -1;
+		c->x86_cache_occ_scale = -1;
+		c->x86_cache_mbm_width_offset = -1;
+		return;
+	}
+
+	/* will be overridden if occupancy monitoring exists */
+	c->x86_cache_max_rmid = cpuid_ebx(0xf);
+
+	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+		u32 eax, ebx, ecx, edx;
+
+		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
+		cpuid_count(0xf, 1, &eax, &ebx, &ecx, &edx);
+
+		c->x86_cache_max_rmid  = ecx;
+		c->x86_cache_occ_scale = ebx;
+
+		if (c->x86_vendor == X86_VENDOR_INTEL)
+			c->x86_cache_mbm_width_offset = eax & 0xff;
+	}
+}
+
 static int __init resctrl_late_init(void)
 {
 	struct rdt_resource *r;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d7623e1b927d..4bd28b388a1a 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -24,7 +24,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5a359d9fcc05..6276ae015945 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -29,7 +29,7 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5ef9d8f25b0e..0c169a5687e1 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
