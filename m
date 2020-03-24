Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3688C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43E3208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgCXWcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgCXWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5u-0006wu-Jd; Tue, 24 Mar 2020 23:32:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B3B4B1C0451;
        Tue, 24 Mar 2020 23:32:20 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/kernel: Convert to new CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.250559388@linutronix.de>
References: <20200320131509.250559388@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508914036.28353.9138582674034400797.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     adefe55e725821e8ae23207992ded5994f1650a9
Gitweb:        https://git.kernel.org/tip/adefe55e725821e8ae23207992ded5994f1650a9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:51 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:28:26 +01:00

x86/kernel: Convert to new CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.250559388@linutronix.de
---
 arch/x86/kernel/apic/apic.c | 32 +++++++++++++-------------------
 arch/x86/kernel/smpboot.c   |  2 +-
 arch/x86/kernel/tsc_msr.c   | 14 +++++++-------
 arch/x86/power/cpu.c        | 16 ++--------------
 4 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5f973fe..81b9c63 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -546,12 +546,6 @@ static struct clock_event_device lapic_clockevent = {
 };
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
-#define DEADLINE_MODEL_MATCH_FUNC(model, func)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&func }
-
-#define DEADLINE_MODEL_MATCH_REV(model, rev)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)rev }
-
 static u32 hsx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
@@ -588,23 +582,23 @@ static u32 skx_deadline_rev(void)
 }
 
 static const struct x86_cpu_id deadline_match[] = {
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_HASWELL_X,	hsx_deadline_rev),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_X,	0x0b000020),
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_D,	bdx_deadline_rev),
-	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_X,		&skx_deadline_rev),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL,		0x22),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_L,	0x20),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_G,	0x17),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
+	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_G,		0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_G,	0x17),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL,		0x25),
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_G,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_L,	0xb2),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
+	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_L,		0xb2),
+	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE,		0xb2),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_L,	0x52),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
+	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE_L,		0x52),
+	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE,		0x52),
 
 	{},
 };
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2..3076ef0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -466,7 +466,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  */
 
 static const struct x86_cpu_id snc_cpu[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X },
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
 	{}
 };
 
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index e0cbe4f..bf528aa 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -63,13 +63,13 @@ static const struct freq_desc freq_desc_lgm = {
 };
 
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
-	INTEL_CPU_FAM6(ATOM_SALTWELL_MID,	freq_desc_pnw),
-	INTEL_CPU_FAM6(ATOM_SALTWELL_TABLET,	freq_desc_clv),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT,		freq_desc_byt),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	freq_desc_tng),
-	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
-	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	freq_desc_ann),
-	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		freq_desc_lgm),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,	&freq_desc_pnw),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_TABLET,&freq_desc_clv),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&freq_desc_byt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&freq_desc_tng),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&freq_desc_cht),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&freq_desc_ann),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_NP,	&freq_desc_lgm),
 	{}
 };
 
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 915bb16..aaff9ed 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -475,20 +475,8 @@ static int msr_save_cpuid_features(const struct x86_cpu_id *c)
 }
 
 static const struct x86_cpu_id msr_save_cpu_table[] = {
-	{
-		.vendor = X86_VENDOR_AMD,
-		.family = 0x15,
-		.model = X86_MODEL_ANY,
-		.feature = X86_FEATURE_ANY,
-		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
-	},
-	{
-		.vendor = X86_VENDOR_AMD,
-		.family = 0x16,
-		.model = X86_MODEL_ANY,
-		.feature = X86_FEATURE_ANY,
-		.driver_data = (kernel_ulong_t)msr_save_cpuid_features,
-	},
+	X86_MATCH_VENDOR_FAM(AMD, 0x15, &msr_save_cpuid_features),
+	X86_MATCH_VENDOR_FAM(AMD, 0x16, &msr_save_cpuid_features),
 	{}
 };
 
