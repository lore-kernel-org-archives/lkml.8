Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796C9208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgCXWcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgCXWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5w-0006vk-N9; Tue, 24 Mar 2020 23:32:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 59EE81C0481;
        Tue, 24 Mar 2020 23:32:19 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] cpufreq: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87eetheu88.fsf@nanos.tec.linutronix.de>
References: <87eetheu88.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913903.28353.509214109286248076.tip-bot2@tip-bot2>
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

Commit-ID:     b11d77fa300d98704519238a2161bc6352c28245
Gitweb:        https://git.kernel.org/tip/b11d77fa300d98704519238a2161bc6352c28245
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 24 Mar 2020 14:51:51 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:31:27 +01:00

cpufreq: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of most local macro wrappers for consistency. The ones which
make sense for readability are renamed to X86_MATCH*.

In the centrino driver this also removes the two extra duplicates of family
6 model 13 which have no value at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/87eetheu88.fsf@nanos.tec.linutronix.de
---
 drivers/cpufreq/acpi-cpufreq.c         |  4 +-
 drivers/cpufreq/amd_freq_sensitivity.c |  2 +-
 drivers/cpufreq/e_powersaver.c         |  2 +-
 drivers/cpufreq/elanfreq.c             |  2 +-
 drivers/cpufreq/intel_pstate.c         | 71 ++++++++++++-------------
 drivers/cpufreq/longhaul.c             |  2 +-
 drivers/cpufreq/longrun.c              |  3 +-
 drivers/cpufreq/p4-clockmod.c          |  2 +-
 drivers/cpufreq/powernow-k6.c          |  4 +-
 drivers/cpufreq/powernow-k7.c          |  2 +-
 drivers/cpufreq/powernow-k8.c          |  2 +-
 drivers/cpufreq/sc520_freq.c           |  2 +-
 drivers/cpufreq/speedstep-centrino.c   | 14 +----
 drivers/cpufreq/speedstep-ich.c        | 10 +---
 drivers/cpufreq/speedstep-smi.c        | 10 +---
 15 files changed, 59 insertions(+), 73 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7ff6595..289e8ce 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -992,8 +992,8 @@ late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
 
 static const struct x86_cpu_id acpi_cpufreq_ids[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_ACPI),
-	X86_FEATURE_MATCH(X86_FEATURE_HW_PSTATE),
+	X86_MATCH_FEATURE(X86_FEATURE_ACPI, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_HW_PSTATE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 5107cbe..f7c4206 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -145,7 +145,7 @@ static void __exit amd_freq_sensitivity_exit(void)
 module_exit(amd_freq_sensitivity_exit);
 
 static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PROC_FEEDBACK),
+	X86_MATCH_FEATURE(X86_FEATURE_PROC_FEEDBACK, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, amd_freq_sensitivity_ids);
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 45c18c6..776a58b 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -385,7 +385,7 @@ static struct cpufreq_driver eps_driver = {
 /* This driver will work only on Centaur C7 processors with
  * Enhanced SpeedStep/PowerSaver registers */
 static const struct x86_cpu_id eps_cpu_id[] = {
-	{ X86_VENDOR_CENTAUR, 6, X86_MODEL_ANY, X86_FEATURE_EST },
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_EST, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, eps_cpu_id);
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 2242541..4ce5eb3 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -198,7 +198,7 @@ static struct cpufreq_driver elanfreq_driver = {
 };
 
 static const struct x86_cpu_id elan_id[] = {
-	{ X86_VENDOR_AMD, 4, 10, },
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 10, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, elan_id);
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c81e1ff..780c387 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1908,51 +1908,51 @@ static const struct pstate_funcs knl_funcs = {
 	.get_val = core_get_val,
 };
 
-#define ICPU(model, policy) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
-			(unsigned long)&policy }
+#define X86_MATCH(model, policy)					 \
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+					   X86_FEATURE_APERFMPERF, &policy)
 
 static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
-	ICPU(INTEL_FAM6_SANDYBRIDGE,		core_funcs),
-	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT,	silvermont_funcs),
-	ICPU(INTEL_FAM6_IVYBRIDGE,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL,		core_funcs),
-	ICPU(INTEL_FAM6_IVYBRIDGE_X,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_L,		core_funcs),
-	ICPU(INTEL_FAM6_HASWELL_G,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_G,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_L,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_D,		core_funcs),
-	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
-	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS,     core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_X,		core_funcs),
+	X86_MATCH(SANDYBRIDGE,		core_funcs),
+	X86_MATCH(SANDYBRIDGE_X,	core_funcs),
+	X86_MATCH(ATOM_SILVERMONT,	silvermont_funcs),
+	X86_MATCH(IVYBRIDGE,		core_funcs),
+	X86_MATCH(HASWELL,		core_funcs),
+	X86_MATCH(BROADWELL,		core_funcs),
+	X86_MATCH(IVYBRIDGE_X,		core_funcs),
+	X86_MATCH(HASWELL_X,		core_funcs),
+	X86_MATCH(HASWELL_L,		core_funcs),
+	X86_MATCH(HASWELL_G,		core_funcs),
+	X86_MATCH(BROADWELL_G,		core_funcs),
+	X86_MATCH(ATOM_AIRMONT,		airmont_funcs),
+	X86_MATCH(SKYLAKE_L,		core_funcs),
+	X86_MATCH(BROADWELL_X,		core_funcs),
+	X86_MATCH(SKYLAKE,		core_funcs),
+	X86_MATCH(BROADWELL_D,		core_funcs),
+	X86_MATCH(XEON_PHI_KNL,		knl_funcs),
+	X86_MATCH(XEON_PHI_KNM,		knl_funcs),
+	X86_MATCH(ATOM_GOLDMONT,	core_funcs),
+	X86_MATCH(ATOM_GOLDMONT_PLUS,	core_funcs),
+	X86_MATCH(SKYLAKE_X,		core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
-	ICPU(INTEL_FAM6_BROADWELL_D, core_funcs),
-	ICPU(INTEL_FAM6_BROADWELL_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
+	X86_MATCH(BROADWELL_D,		core_funcs),
+	X86_MATCH(BROADWELL_X,		core_funcs),
+	X86_MATCH(SKYLAKE_X,		core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
-	ICPU(INTEL_FAM6_KABYLAKE, core_funcs),
+	X86_MATCH(KABYLAKE,		core_funcs),
 	{}
 };
 
 static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE, core_funcs),
+	X86_MATCH(SKYLAKE_X,		core_funcs),
+	X86_MATCH(SKYLAKE,		core_funcs),
 	{}
 };
 
@@ -2725,13 +2725,14 @@ static inline void intel_pstate_request_control_from_smm(void) {}
 
 #define INTEL_PSTATE_HWP_BROADWELL	0x01
 
-#define ICPU_HWP(model, hwp_mode) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_HWP, hwp_mode }
+#define X86_MATCH_HWP(model, hwp_mode)					\
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+					   X86_FEATURE_APERFMPERF, hwp_mode)
 
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
-	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
-	ICPU_HWP(INTEL_FAM6_BROADWELL_D, INTEL_PSTATE_HWP_BROADWELL),
-	ICPU_HWP(X86_MODEL_ANY, 0),
+	X86_MATCH_HWP(BROADWELL_X,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(BROADWELL_D,	INTEL_PSTATE_HWP_BROADWELL),
+	X86_MATCH_HWP(ANY,		0),
 	{}
 };
 
diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 92d92e6..123fb00 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -910,7 +910,7 @@ static struct cpufreq_driver longhaul_driver = {
 };
 
 static const struct x86_cpu_id longhaul_id[] = {
-	{ X86_VENDOR_CENTAUR, 6 },
+	X86_MATCH_VENDOR_FAM(CENTAUR, 6, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, longhaul_id);
diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 0b08be8..1caaec7 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -281,8 +281,7 @@ static struct cpufreq_driver longrun_driver = {
 };
 
 static const struct x86_cpu_id longrun_ids[] = {
-	{ X86_VENDOR_TRANSMETA, X86_FAMILY_ANY, X86_MODEL_ANY,
-	  X86_FEATURE_LONGRUN },
+	X86_MATCH_VENDOR_FEATURE(TRANSMETA, X86_FEATURE_LONGRUN, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, longrun_ids);
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index efc0b46..bb61677 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -231,7 +231,7 @@ static struct cpufreq_driver p4clockmod_driver = {
 };
 
 static const struct x86_cpu_id cpufreq_p4_id[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_ACC },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_ACC, NULL),
 	{}
 };
 
diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index 0196f81..41eefef 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -258,8 +258,8 @@ static struct cpufreq_driver powernow_k6_driver = {
 };
 
 static const struct x86_cpu_id powernow_k6_ids[] = {
-	{ X86_VENDOR_AMD, 5, 12 },
-	{ X86_VENDOR_AMD, 5, 13 },
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 5, 12, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 5, 13, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, powernow_k6_ids);
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 5e5171d..5d515fc 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -109,7 +109,7 @@ static int check_fsb(unsigned int fsbspeed)
 }
 
 static const struct x86_cpu_id powernow_k7_cpuids[] = {
-	{ X86_VENDOR_AMD, 6, },
+	X86_MATCH_VENDOR_FAM(AMD, 6, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, powernow_k7_cpuids);
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 2db2f17..3984959 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -452,7 +452,7 @@ static int core_voltage_post_transition(struct powernow_k8_data *data,
 
 static const struct x86_cpu_id powernow_k8_ids[] = {
 	/* IO based frequency switching */
-	{ X86_VENDOR_AMD, 0xf },
+	X86_MATCH_VENDOR_FAM(AMD, 0xf, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, powernow_k8_ids);
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index c6f647b..73a2085 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -95,7 +95,7 @@ static struct cpufreq_driver sc520_freq_driver = {
 };
 
 static const struct x86_cpu_id sc520_ids[] = {
-	{ X86_VENDOR_AMD, 4, 9 },
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 4, 9, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, sc520_ids);
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index b49f494..75b10ec 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,18 +520,12 @@ static struct cpufreq_driver centrino_driver = {
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 9, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 6, 13, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 6, 13, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 6, 13, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 15, 3, X86_FEATURE_EST },
-	{ X86_VENDOR_INTEL, 15, 4, X86_FEATURE_EST },
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
 	{}
 };
-#if 0
-/* Autoload or not? Do not for now. */
-MODULE_DEVICE_TABLE(x86cpu, centrino_ids);
-#endif
 
 /**
  * centrino_init - initializes the Enhanced SpeedStep CPUFreq driver
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index 547fd7a..f2076d7 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -319,15 +319,11 @@ static struct cpufreq_driver speedstep_driver = {
 };
 
 static const struct x86_cpu_id ss_smi_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 0xb, },
-	{ X86_VENDOR_INTEL, 6, 0x8, },
-	{ X86_VENDOR_INTEL, 15, 2 },
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
 	{}
 };
-#if 0
-/* Autoload or not? Do not for now. */
-MODULE_DEVICE_TABLE(x86cpu, ss_smi_ids);
-#endif
 
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index eeb31bc..0ce9d4b 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -299,15 +299,11 @@ static struct cpufreq_driver speedstep_driver = {
 };
 
 static const struct x86_cpu_id ss_smi_ids[] = {
-	{ X86_VENDOR_INTEL, 6, 0xb, },
-	{ X86_VENDOR_INTEL, 6, 0x8, },
-	{ X86_VENDOR_INTEL, 15, 2 },
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0x8, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL,  6, 0xb, 0),
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 15, 0x2, 0),
 	{}
 };
-#if 0
-/* Not auto loaded currently */
-MODULE_DEVICE_TABLE(x86cpu, ss_smi_ids);
-#endif
 
 /**
  * speedstep_init - initializes the SpeedStep CPUFreq driver
