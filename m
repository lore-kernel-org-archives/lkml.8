Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5426EC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3F520754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCTNRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:17:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35734 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgCTNQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:34 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVo-00048x-8M
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:32 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B2BB11039FF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:26 +0100 (CET)
Message-Id: <20200320131509.673579000@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:55 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 10/22] EDAC: Convert to new X86 CPU match macros
References: <20200320131345.635023594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-edac@vger.kernel.org
---
 drivers/edac/amd64_edac.c |   14 +++++++-------
 drivers/edac/i10nm_base.c |    8 ++++----
 drivers/edac/pnd2_edac.c  |    4 ++--
 drivers/edac/sb_edac.c    |   14 +++++++-------
 drivers/edac/skx_base.c   |    2 +-
 5 files changed, 21 insertions(+), 21 deletions(-)

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
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3420,13 +3420,13 @@ static int sbridge_register_mci(struct s
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
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -158,7 +158,7 @@ static int get_all_munits(const struct m
 }
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_SKYLAKE_X, 0, 0 },
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);

