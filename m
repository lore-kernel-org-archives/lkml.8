Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7E7C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D1920836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgCXWdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:33:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgCXWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5t-0006w7-SJ; Tue, 24 Mar 2020 23:32:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 454C71C048C;
        Tue, 24 Mar 2020 23:32:20 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/platform: Convert to new CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.359448901@linutronix.de>
References: <20200320131509.359448901@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913993.28353.3261043578325562399.tip-bot2@tip-bot2>
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

Commit-ID:     9595198f8dc4111f8cab39de2c0c4432787bc690
Gitweb:        https://git.kernel.org/tip/9595198f8dc4111f8cab39de2c0c4432787bc690
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:52 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:29:38 +01:00

x86/platform: Convert to new CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.359448901@linutronix.de
---
 arch/x86/platform/atom/punit_atom_debug.c             | 13 ++++------
 arch/x86/platform/efi/quirks.c                        |  7 +----
 arch/x86/platform/intel-mid/device_libs/platform_bt.c |  5 +----
 arch/x86/platform/intel-quark/imr.c                   |  2 +-
 arch/x86/platform/intel-quark/imr_selftest.c          |  2 +-
 5 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index ee6b078..f8ed5f6 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -117,17 +117,16 @@ static void punit_dbgfs_unregister(void)
 	debugfs_remove_recursive(punit_dbg_file);
 }
 
-#define ICPU(model, drv_data) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT,\
-	  (kernel_ulong_t)&drv_data }
+#define X86_MATCH(model, data)						 \
+	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6, INTEL_FAM6_##model, \
+					   X86_FEATURE_MWAIT, data)
 
 static const struct x86_cpu_id intel_punit_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT, punit_device_byt),
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,  punit_device_tng),
-	ICPU(INTEL_FAM6_ATOM_AIRMONT,	  punit_device_cht),
+	X86_MATCH(ATOM_SILVERMONT,		&punit_device_byt),
+	X86_MATCH(ATOM_SILVERMONT_MID,		&punit_device_tng),
+	X86_MATCH(ATOM_AIRMONT,			&punit_device_cht),
 	{}
 };
-
 MODULE_DEVICE_TABLE(x86cpu, intel_punit_cpu_ids);
 
 static int __init punit_atom_debug_init(void)
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 88d32c0..c000e03 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -659,12 +659,9 @@ static int qrk_capsule_setup_info(struct capsule_info *cap_info, void **pkbuff,
 	return 1;
 }
 
-#define ICPU(family, model, quirk_handler) \
-	{ X86_VENDOR_INTEL, family, model, X86_FEATURE_ANY, \
-	  (unsigned long)&quirk_handler }
-
 static const struct x86_cpu_id efi_capsule_quirk_ids[] = {
-	ICPU(5, 9, qrk_capsule_setup_info),	/* Intel Quark X1000 */
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000,
+				   &qrk_capsule_setup_info),
 	{ }
 };
 
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bt.c b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
index e3f4bfc..31dda18 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -60,11 +60,8 @@ static struct bt_sfi_data tng_bt_sfi_data __initdata = {
 	.setup	= tng_bt_sfi_setup,
 };
 
-#define ICPU(model, ddata)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (kernel_ulong_t)&ddata }
-
 static const struct x86_cpu_id bt_sfi_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID, tng_bt_sfi_data),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&tng_bt_sfi_data),
 	{}
 };
 
diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index e9d97d5..0286fe1 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -569,7 +569,7 @@ static void __init imr_fixup_memmap(struct imr_device *idev)
 }
 
 static const struct x86_cpu_id imr_ids[] __initconst = {
-	{ X86_VENDOR_INTEL, 5, 9 },	/* Intel Quark SoC X1000. */
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
 	{}
 };
 
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 4307830..570e306 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -105,7 +105,7 @@ static void __init imr_self_test(void)
 }
 
 static const struct x86_cpu_id imr_ids[] __initconst = {
-	{ X86_VENDOR_INTEL, 5, 9 },	/* Intel Quark SoC X1000. */
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
 	{}
 };
 
