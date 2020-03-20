Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E1C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609CB20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCTNR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:17:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:32 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVm-00049M-J6
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:30 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 63E3B104084
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:27 +0100 (CET)
Message-Id: <20200320131509.967017771@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:58 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 13/22] thermal: Convert to new X86 CPU match macros
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

Get rid the of the local QUARK defines and use the proper ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/intel/intel_powerclamp.c        |    2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c |    5 +----
 drivers/thermal/intel/intel_soc_dts_thermal.c   |    3 +--
 drivers/thermal/intel/x86_pkg_temp_thermal.c    |    2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -651,7 +651,7 @@ static struct thermal_cooling_device_ops
 };
 
 static const struct x86_cpu_id __initconst intel_powerclamp_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_MWAIT },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_MWAIT, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -64,9 +64,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/iosf_mbi.h>
 
-#define X86_FAMILY_QUARK	0x5
-#define X86_MODEL_QUARK_X1000	0x9
-
 /* DTS reset is programmed via QRK_MBI_UNIT_SOC */
 #define QRK_DTS_REG_OFFSET_RESET	0x34
 #define QRK_DTS_RESET_BIT		BIT(0)
@@ -433,7 +430,7 @@ static struct soc_sensor_entry *alloc_so
 }
 
 static const struct x86_cpu_id qrk_thermal_ids[] __initconst  = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_QUARK, X86_MODEL_QUARK_X1000 },
+	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, qrk_thermal_ids);
--- a/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -36,8 +36,7 @@ static irqreturn_t soc_irq_thread_fn(int
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_SILVERMONT, 0,
-		BYT_SOC_DTS_APIC_IRQ},
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -478,7 +478,7 @@ static int pkg_thermal_cpu_online(unsign
 }
 
 static const struct x86_cpu_id __initconst pkg_temp_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_PTS },
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_PTS, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, pkg_temp_thermal_ids);

