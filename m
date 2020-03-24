Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C676EC54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E892080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgCXWcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46435 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgCXWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5v-0006vF-Tr; Tue, 24 Mar 2020 23:32:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 852DE1C0475;
        Tue, 24 Mar 2020 23:32:18 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] platform/x86: Convert to new CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.766573641@linutronix.de>
References: <20200320131509.766573641@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913821.28353.4486859215980454998.tip-bot2@tip-bot2>
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

Commit-ID:     a69b3b1d4cf061d9197d835dcf539d2dd7b9e46f
Gitweb:        https://git.kernel.org/tip/a69b3b1d4cf061d9197d835dcf539d2dd7b9e46f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:56 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:33:00 +01:00

platform/x86: Convert to new CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.766573641@linutronix.de
---
 drivers/platform/x86/intel-uncore-frequency.c                 | 14 +---
 drivers/platform/x86/intel_int0002_vgpio.c                    |  4 +-
 drivers/platform/x86/intel_mid_powerbtn.c                     |  4 +-
 drivers/platform/x86/intel_pmc_core.c                         | 24 +++----
 drivers/platform/x86/intel_pmc_core_pltdrv.c                  | 16 ++---
 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c |  4 +-
 drivers/platform/x86/intel_telemetry_debugfs.c                |  5 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c                 |  7 +--
 drivers/platform/x86/intel_turbo_max_3.c                      |  6 +--
 9 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/intel-uncore-frequency.c b/drivers/platform/x86/intel-uncore-frequency.c
index 2b1a073..8592720 100644
--- a/drivers/platform/x86/intel-uncore-frequency.c
+++ b/drivers/platform/x86/intel-uncore-frequency.c
@@ -358,15 +358,13 @@ static struct notifier_block uncore_pm_nb = {
 	.notifier_call = uncore_pm_notify,
 };
 
-#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
-	ICPU(INTEL_FAM6_BROADWELL_G),
-	ICPU(INTEL_FAM6_BROADWELL_X),
-	ICPU(INTEL_FAM6_BROADWELL_D),
-	ICPU(INTEL_FAM6_SKYLAKE_X),
-	ICPU(INTEL_FAM6_ICELAKE_X),
-	ICPU(INTEL_FAM6_ICELAKE_D),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index f14e2c5..7b23efc 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -148,8 +148,8 @@ static struct irq_chip int0002_cht_irqchip = {
 };
 
 static const struct x86_cpu_id int0002_cpu_ids[] = {
-	INTEL_CPU_FAM6(ATOM_SILVERMONT, int0002_byt_irqchip),	/* Valleyview, Bay Trail  */
-	INTEL_CPU_FAM6(ATOM_AIRMONT, int0002_cht_irqchip),	/* Braswell, Cherry Trail */
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&int0002_byt_irqchip),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&int0002_cht_irqchip),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_mid_powerbtn.c b/drivers/platform/x86/intel_mid_powerbtn.c
index 6f43683..9c9f209 100644
--- a/drivers/platform/x86/intel_mid_powerbtn.c
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@ -113,8 +113,8 @@ static const struct mid_pb_ddata mrfld_ddata = {
 };
 
 static const struct x86_cpu_id mid_pb_cpu_ids[] = {
-	INTEL_CPU_FAM6(ATOM_SALTWELL_MID,	mfld_ddata),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	mrfld_ddata),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL_MID,	&mfld_ddata),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&mrfld_ddata),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 144faa8..3df33ff 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -871,18 +871,18 @@ static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 #endif /* CONFIG_DEBUG_FS */
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	INTEL_CPU_FAM6(SKYLAKE_L, spt_reg_map),
-	INTEL_CPU_FAM6(SKYLAKE, spt_reg_map),
-	INTEL_CPU_FAM6(KABYLAKE_L, spt_reg_map),
-	INTEL_CPU_FAM6(KABYLAKE, spt_reg_map),
-	INTEL_CPU_FAM6(CANNONLAKE_L, cnp_reg_map),
-	INTEL_CPU_FAM6(ICELAKE_L, icl_reg_map),
-	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
-	INTEL_CPU_FAM6(COMETLAKE, cnp_reg_map),
-	INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
-	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
-	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
-	INTEL_CPU_FAM6(ATOM_TREMONT, tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&spt_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&spt_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&spt_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&spt_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&cnp_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&cnp_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&cnp_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&tgl_reg_map),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index e1266f5..7312818 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -38,14 +38,14 @@ static struct platform_device pmc_core_device = {
  * other list may grow, but this list should not.
  */
 static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
-	INTEL_CPU_FAM6(SKYLAKE_L, pmc_core_device),
-	INTEL_CPU_FAM6(SKYLAKE, pmc_core_device),
-	INTEL_CPU_FAM6(KABYLAKE_L, pmc_core_device),
-	INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
-	INTEL_CPU_FAM6(CANNONLAKE_L, pmc_core_device),
-	INTEL_CPU_FAM6(ICELAKE_L, pmc_core_device),
-	INTEL_CPU_FAM6(COMETLAKE, pmc_core_device),
-	INTEL_CPU_FAM6(COMETLAKE_L, pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&pmc_core_device),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
index 89b042a..1b6eab0 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
@@ -160,10 +160,8 @@ static struct notifier_block isst_pm_nb = {
 	.notifier_call = isst_pm_notify,
 };
 
-#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 static const struct x86_cpu_id isst_if_cpu_ids[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_X),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, isst_if_cpu_ids);
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index 8e3fb55..8a53d3b 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -308,11 +308,10 @@ static struct telemetry_debugfs_conf telem_apl_debugfs_conf = {
 };
 
 static const struct x86_cpu_id telemetry_debugfs_cpu_ids[] = {
-	INTEL_CPU_FAM6(ATOM_GOLDMONT, telem_apl_debugfs_conf),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, telem_apl_debugfs_conf),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&telem_apl_debugfs_conf),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&telem_apl_debugfs_conf),
 	{}
 };
-
 MODULE_DEVICE_TABLE(x86cpu, telemetry_debugfs_cpu_ids);
 
 static int telemetry_debugfs_check_evts(void)
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index c4c742b..987a24e 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -67,9 +67,6 @@
 #define TELEM_CLEAR_VERBOSITY_BITS(x)	((x) &= ~(BIT(27) | BIT(28)))
 #define TELEM_SET_VERBOSITY_BITS(x, y)	((x) |= ((y) << 27))
 
-#define TELEM_CPU(model, data) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&data }
-
 enum telemetry_action {
 	TELEM_UPDATE = 0,
 	TELEM_ADD,
@@ -183,8 +180,8 @@ static struct telemetry_plt_config telem_glk_config = {
 };
 
 static const struct x86_cpu_id telemetry_cpu_ids[] = {
-	TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT, telem_apl_config),
-	TELEM_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, telem_glk_config),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&telem_apl_config),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&telem_glk_config),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_turbo_max_3.c b/drivers/platform/x86/intel_turbo_max_3.c
index 7b9cc84..892140b 100644
--- a/drivers/platform/x86/intel_turbo_max_3.c
+++ b/drivers/platform/x86/intel_turbo_max_3.c
@@ -113,11 +113,9 @@ static int itmt_legacy_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 static const struct x86_cpu_id itmt_legacy_cpu_ids[] = {
-	ICPU(INTEL_FAM6_BROADWELL_X),
-	ICPU(INTEL_FAM6_SKYLAKE_X),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
 	{}
 };
 
