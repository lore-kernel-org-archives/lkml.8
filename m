Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E70C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B8E2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgCXWch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgCXWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5r-0006vc-C5; Tue, 24 Mar 2020 23:32:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E85991C0451;
        Tue, 24 Mar 2020 23:32:18 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:18 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] EDAC: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.673579000@linutronix.de>
References: <20200320131509.673579000@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913862.28353.8960878520716086709.tip-bot2@tip-bot2>
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

Commit-ID:     298426211c4b36e1e2475deb941f8fa59d6686c6
Gitweb:        https://git.kernel.org/tip/298426211c4b36e1e2475deb941f8fa59d6686c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:55 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:32:28 +01:00

EDAC: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200320131509.673579000@linutronix.de
---
 drivers/edac/amd64_edac.c | 14 +++++++-------
 drivers/edac/i10nm_base.c |  8 ++++----
 drivers/edac/pnd2_edac.c  |  4 ++--
 drivers/edac/sb_edac.c    | 14 +++++++-------
 drivers/edac/skx_base.c   |  2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9fbad90..f91f3bc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3626,13 +3626,13 @@ static void setup_pci_device(void)
 }
 
 static const struct x86_cpu_id amd64_cpuids[] = {
-	{ X86_VENDOR_AMD, 0xF,	X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
-	{ X86_VENDOR_AMD, 0x10, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
-	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
-	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
-	{ X86_VENDOR_AMD, 0x17, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
-	{ X86_VENDOR_HYGON, 0x18, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
-	{ X86_VENDOR_AMD, 0x19, X86_MODEL_ANY,	X86_FEATURE_ANY, 0 },
+	X86_MATCH_VENDOR_FAM(AMD,	0x0F, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,	0x10, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,	0x15, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,	0x16, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,	0x17, NULL),
+	X86_MATCH_VENDOR_FAM(HYGON,	0x18, NULL),
+	X86_MATCH_VENDOR_FAM(AMD,	0x19, NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 059eccf..df08de9 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -123,10 +123,10 @@ static int i10nm_get_all_munits(void)
 }
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_TREMONT_D, 0, 0 },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_X, 0, 0 },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_D, 0, 0 },
-	{ }
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		NULL),
+	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
 
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f772..bc47328 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1537,8 +1537,8 @@ static struct dunit_ops dnv_ops = {
 };
 
 static const struct x86_cpu_id pnd2_cpuids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT, 0, (kernel_ulong_t)&apl_ops },
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_GOLDMONT_D, 0, (kernel_ulong_t)&dnv_ops },
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&apl_ops),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&dnv_ops),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 4957e8e..7d51c82 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3420,13 +3420,13 @@ fail0:
 }
 
 static const struct x86_cpu_id sbridge_cpuids[] = {
-	INTEL_CPU_FAM6(SANDYBRIDGE_X,	  pci_dev_descr_sbridge_table),
-	INTEL_CPU_FAM6(IVYBRIDGE_X,	  pci_dev_descr_ibridge_table),
-	INTEL_CPU_FAM6(HASWELL_X,	  pci_dev_descr_haswell_table),
-	INTEL_CPU_FAM6(BROADWELL_X,	  pci_dev_descr_broadwell_table),
-	INTEL_CPU_FAM6(BROADWELL_D,	  pci_dev_descr_broadwell_table),
-	INTEL_CPU_FAM6(XEON_PHI_KNL,	  pci_dev_descr_knl_table),
-	INTEL_CPU_FAM6(XEON_PHI_KNM,	  pci_dev_descr_knl_table),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X, &pci_dev_descr_sbridge_table),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,	  &pci_dev_descr_ibridge_table),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,	  &pci_dev_descr_haswell_table),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	  &pci_dev_descr_broadwell_table),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	  &pci_dev_descr_broadwell_table),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,  &pci_dev_descr_knl_table),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,  &pci_dev_descr_knl_table),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 83545b4..46a3a34 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -158,7 +158,7 @@ fail:
 }
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X, 0, 0 },
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
