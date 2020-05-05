Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E465CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB06420721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEEWhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:37:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:41850 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgEEWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:36:47 -0400
IronPort-SDR: zB4tunBa6DtX9jdZFvZSCa8rqLBptxPOveCOfbcGMr9ldTgqK0yMPXp60IyQx1rAU3VQR5W2xi
 mAb5SgPAFX9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:46 -0700
IronPort-SDR: pFyPHT74h7wJ7W82YQJXBkYLAcPbbOOro/phRgFKD42wMiZKdUony+8ur3RMv6vvc5TYgZPKYN
 VDeOoJ66BVLA==
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="284410847"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 15:36:46 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH V2 4/7] x86/resctrl: Query LLC monitoring properties once during boot
Date:   Tue,  5 May 2020 15:36:15 -0700
Message-Id: <6d74a6ac3e69f4b7a8b4115835f9455faf0f468d.1588715690.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588715690.git.reinette.chatre@intel.com>
References: <cover.1588715690.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache and memory bandwidth monitoring are features that are part of
x86 CPU resource control that is supported by the resctrl subsystem.
The monitoring properties are obtained via CPUID from every CPU
and only used within the resctrl subsystem where the properties are
only read from boot_cpu_data.

Obtain the monitoring properties once, placed in boot_cpu_data, via the
c_bsp_init helpers of the vendors that support X86_FEATURE_CQM_LLC.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/amd.c          | 3 +++
 arch/x86/kernel/cpu/common.c       | 2 --
 arch/x86/kernel/cpu/intel.c        | 7 +++++++
 arch/x86/kernel/cpu/resctrl/core.c | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

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
index 556a96d05a6c..d07809286b95 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -56,7 +56,6 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
-#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -922,7 +921,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
-	resctrl_cpu_detect(c);
 
 	/*
 	 * Clear/Set all flags overridden by options, after probe.
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
index 861c6d1ba9ab..d5979073301e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -958,6 +958,7 @@ static __init void rdt_init_res_defs(void)
 
 static enum cpuhp_state rdt_online;
 
+/* Runs once on the BSP during boot. */
 void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 {
 	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
-- 
2.21.0

