Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F7C207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="n5Ym3f6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFJLAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:00:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42928 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgFJLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:00:51 -0400
Received: from zn.tnic (p200300ec2f0c190029f750dc462a5b02.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:29f7:50dc:462a:5b02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93F761EC0347;
        Wed, 10 Jun 2020 13:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591786849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mrrtrJEto/n0mJzHwLFsBSdm+CacaPxAonaeyKO5W4=;
        b=n5Ym3f6VzD9E6Pteq5LXcMBEEcEw29xkprHrRTbatMdnlqU/e03/fQTkCod6CeYaLdafFl
        qpPR+edjtK7BuoAlEXgl/ITmgEHGpkT0lGinFNoPpuUNB/i/bYFD6FyOWrk+TFG1sYk/Xa
        JeorFePoNvHkmwdNbCHxp0GfrGSM1WU=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Morton <Eric.Morton@amd.com>
Subject: [PATCH 3/3] x86/msr: Add an MSR write callback
Date:   Wed, 10 Jun 2020 13:00:37 +0200
Message-Id: <20200610110037.11853-4-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610110037.11853-1-bp@alien8.de>
References: <20200610110037.11853-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add a callback which gets executed after a MSR is written from
userspace. This is needed because in the case of AMD's MSR_AMD64_LS_CFG
MSR which gets cached in the kernel, the cached value needs to be
updated after the write, otherwise latter doesn't stick.

Reported-by: Eric Morton <Eric.Morton@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/msr.h   |  2 ++
 arch/x86/kernel/cpu/bugs.c   |  2 +-
 arch/x86/kernel/cpu/common.c | 31 +++++++++++++++++++++++++++++++
 arch/x86/kernel/msr.c        |  3 +++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 71393a4c2104..d151eb8cbd51 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -335,6 +335,8 @@ void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
+void msr_write_callback(int cpu, u32 reg, u32 low, u32 hi);
+
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c39..bfaf303d6965 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -57,7 +57,7 @@ static u64 __ro_after_init x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
  * AMD specific MSR info for Speculative Store Bypass control.
  * x86_amd_ls_cfg_ssbd_mask is initialized in identify_boot_cpu().
  */
-u64 __ro_after_init x86_amd_ls_cfg_base;
+u64 x86_amd_ls_cfg_base;
 u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
 /* Control conditional STIBP in switch_to() */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb83fe24..8d6fa73940a3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -55,6 +55,7 @@
 #include <asm/microcode_intel.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/spec-ctrl.h>
 #include <asm/uv/uv.h>
 
 #include "cpu.h"
@@ -1960,3 +1961,33 @@ void arch_smt_update(void)
 	/* Check whether IPI broadcasting can be enabled */
 	apic_smt_update();
 }
+
+void msr_write_callback(int cpu, u32 reg, u32 lo, u32 hi)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
+	if (reg == MSR_AMD64_LS_CFG) {
+		u64 new = ((u64)hi << 32) | lo;
+		cpumask_var_t tmp_mask;
+
+		if (new == x86_amd_ls_cfg_base)
+			return;
+
+		if (WARN_ON_ONCE(!alloc_cpumask_var(&tmp_mask, GFP_KERNEL)))
+			return;
+
+		/*
+		 * Remove the @cpu it was just written to from the mask
+		 * so that it doesn't get written to again pointlessly.
+		 */
+		cpumask_xor(tmp_mask, cpu_online_mask, cpumask_of(cpu));
+
+		x86_amd_ls_cfg_base = new;
+
+		wrmsrl_val_on_cpus(tmp_mask, MSR_AMD64_LS_CFG, new);
+
+		free_cpumask_var(tmp_mask);
+	}
+}
+EXPORT_SYMBOL_GPL(msr_write_callback);
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 1547be359d7f..167125088eda 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -95,6 +95,9 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
 		if (err)
 			break;
+
+		msr_write_callback(cpu, reg, data[0], data[1]);
+
 		tmp += 2;
 		bytes += 8;
 	}
-- 
2.21.0

