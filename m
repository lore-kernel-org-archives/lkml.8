Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B53C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCD0206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgEEWgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:36:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:41848 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbgEEWgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:46 -0400
IronPort-SDR: y1V6kTZu4sJaYutNa/S+4+uc9ADz+9oQBT7zjIvm4tCqv8DW1QreQ3J4aMPHiYvKntXYvoTXZH
 jBxgcEAimEEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:45 -0700
IronPort-SDR: LSbr1tLsgibNC4wHMtOQI2NZWQdAOeZLuIZswdtHO1Jz/UeOF7wbpfFOvugwMjdff64fxuoZ75
 VRjnckI399nA==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410833"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:44 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH V2 2/7] x86/cpu: Move resctrl CPUID code to resctrl
Date:   Tue,  5 May 2020 15:36:13 -0700
Message-Id: <38433b99f9d16c8f4ee796f8cc42b871531fa203.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function determining a platform's support and properties of cache
occupancy and memory bandwidth monitoring (properties of
X86_FEATURE_CQM_LLC) can be found among the common CPU code. After
the feature's properties is populated in the per-CPU data the resctrl
subsystem is the only consumer (via boot_cpu_data).

Move the function that obtains the CPU information used by resctrl to
the resctrl subsystem and rename it from init_cqm() to
resctrl_cpu_detect(). The function continues to be called from the
common CPU code. This move is done in preparation of the addition of some
vendor specific code.

No functional change.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/resctrl.h     |  3 +++
 arch/x86/kernel/cpu/common.c       | 27 ++-------------------------
 arch/x86/kernel/cpu/resctrl/core.c | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 99b5728e441d..07603064df8f 100644
--- a/arch/x86/include/asm/resctrl.h
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
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb83fe24..a8f0f22ee5c1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -56,6 +56,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -854,30 +855,6 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
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
@@ -945,7 +922,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
-	init_cqm(c);
+	resctrl_cpu_detect(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6f38c88226af..861c6d1ba9ab 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -958,6 +958,30 @@ static __init void rdt_init_res_defs(void)
 
 static enum cpuhp_state rdt_online;
 
+void resctrl_cpu_detect(struct cpuinfo_x86 *c)
+{
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+		c->x86_cache_max_rmid  = -1;
+		c->x86_cache_occ_scale = -1;
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
+	}
+}
+
 static int __init resctrl_late_init(void)
 {
 	struct rdt_resource *r;
-- 
2.21.0

