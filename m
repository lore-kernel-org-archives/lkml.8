Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860B7C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759B720735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgEFSIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgEFSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:08:33 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A1C061A0F;
        Wed,  6 May 2020 11:08:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWOT7-0001F4-2S; Wed, 06 May 2020 20:08:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ABC7A1C03AB;
        Wed,  6 May 2020 20:08:28 +0200 (CEST)
Date:   Wed, 06 May 2020 18:08:28 -0000
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Query LLC monitoring properties once
 during boot
Cc:     Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C6d74a6ac3e69f4b7a8b4115835f9455faf0f468d=2E15887?=
 =?utf-8?q?15690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C6d74a6ac3e69f4b7a8b4115835f9455faf0f468d=2E158871?=
 =?utf-8?q?5690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158878850866.8414.16098704880730041750.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     923f3a2b48bdccb6a1d1f0dd48de03de7ad936d9
Gitweb:        https://git.kernel.org/tip/923f3a2b48bdccb6a1d1f0dd48de03de7ad936d9
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 05 May 2020 15:36:15 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 17:58:08 +02:00

x86/resctrl: Query LLC monitoring properties once during boot

Cache and memory bandwidth monitoring are features that are part of
x86 CPU resource control that is supported by the resctrl subsystem.
The monitoring properties are obtained via CPUID from every CPU
and only used within the resctrl subsystem where the properties are
only read from boot_cpu_data.

Obtain the monitoring properties once, placed in boot_cpu_data, via the
->c_bsp_init() helpers of the vendors that support X86_FEATURE_CQM_LLC.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/6d74a6ac3e69f4b7a8b4115835f9455faf0f468d.1588715690.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/amd.c          | 3 +++
 arch/x86/kernel/cpu/common.c       | 2 --
 arch/x86/kernel/cpu/intel.c        | 7 +++++++
 arch/x86/kernel/cpu/resctrl/core.c | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 547ad7b..c36e899 100644
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
index 556a96d..d078092 100644
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
index a19a680..166d7c3 100644
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
index 861c6d1..d597907 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -958,6 +958,7 @@ static __init void rdt_init_res_defs(void)
 
 static enum cpuhp_state rdt_online;
 
+/* Runs once on the BSP during boot. */
 void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 {
 	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
