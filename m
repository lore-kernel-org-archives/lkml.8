Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AE5C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A52072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 10:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCVK0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 06:26:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39621 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgCVK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 06:26:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFxnr-0006VV-0Z; Sun, 22 Mar 2020 11:25:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 26AA61C001F;
        Sun, 22 Mar 2020 11:25:58 +0100 (CET)
Date:   Sun, 22 Mar 2020 10:25:57 -0000
From:   "tip-bot2 for Wei Huang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Add PPIN support for AMD MCE
Cc:     Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321193800.3666964-1-wei.huang2@amd.com>
References: <20200321193800.3666964-1-wei.huang2@amd.com>
MIME-Version: 1.0
Message-ID: <158487275776.28353.17966552354241526971.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     077168e241ec5a3b273652acb1e85f8bc1dc2d81
Gitweb:        https://git.kernel.org/tip/077168e241ec5a3b273652acb1e85f8bc1dc2d81
Author:        Wei Huang <wei.huang2@amd.com>
AuthorDate:    Sat, 21 Mar 2020 14:38:00 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 22 Mar 2020 11:03:47 +01:00

x86/mce/amd: Add PPIN support for AMD MCE

Newer AMD CPUs support a feature called protected processor
identification number (PPIN). This feature can be detected via
CPUID_Fn80000008_EBX[23].

However, CPUID alone is not enough to read the processor identification
number - MSR_AMD_PPIN_CTL also needs to be configured properly. If, for
any reason, MSR_AMD_PPIN_CTL[PPIN_EN] can not be turned on, such as
disabled in BIOS, the CPU capability bit X86_FEATURE_AMD_PPIN needs to
be cleared.

When the X86_FEATURE_AMD_PPIN capability is available, the
identification number is issued together with the MCE error info in
order to keep track of the source of MCE errors.

 [ bp: Massage. ]

Co-developed-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200321193800.3666964-1-wei.huang2@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +-
 arch/x86/kernel/cpu/amd.c          | 30 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/core.c     |  2 ++-
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb..4b263ff 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,6 +299,7 @@
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
+#define X86_FEATURE_AMD_PPIN		(13*32+23) /* Protected Processor Inventory Number */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ac83a0f..a2cd870 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -393,6 +393,35 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
 }
 
+static void amd_detect_ppin(struct cpuinfo_x86 *c)
+{
+	unsigned long long val;
+
+	if (!cpu_has(c, X86_FEATURE_AMD_PPIN))
+		return;
+
+	/* When PPIN is defined in CPUID, still need to check PPIN_CTL MSR */
+	if (rdmsrl_safe(MSR_AMD_PPIN_CTL, &val))
+		goto clear_ppin;
+
+	/* PPIN is locked in disabled mode, clear feature bit */
+	if ((val & 3UL) == 1UL)
+		goto clear_ppin;
+
+	/* If PPIN is disabled, try to enable it */
+	if (!(val & 2UL)) {
+		wrmsrl_safe(MSR_AMD_PPIN_CTL,  val | 2UL);
+		rdmsrl_safe(MSR_AMD_PPIN_CTL, &val);
+	}
+
+	/* If PPIN_EN bit is 1, return from here; otherwise fall through */
+	if (val & 2UL)
+		return;
+
+clear_ppin:
+	clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);
+}
+
 u16 amd_get_nb_id(int cpu)
 {
 	return per_cpu(cpu_llc_id, cpu);
@@ -940,6 +969,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	amd_detect_cmp(c);
 	amd_get_topology(c);
 	srat_detect_node(c);
+	amd_detect_ppin(c);
 
 	init_amd_cacheinfo(c);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index fe3983d..dd06fce 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -142,6 +142,8 @@ void mce_setup(struct mce *m)
 
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		rdmsrl(MSR_PPIN, m->ppin);
+	else if (this_cpu_has(X86_FEATURE_AMD_PPIN))
+		rdmsrl(MSR_AMD_PPIN, m->ppin);
 
 	m->microcode = boot_cpu_data.microcode;
 }
