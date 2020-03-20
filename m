Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78262C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5EB20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCTNQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35752 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgCTNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:40 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVu-0004AK-JD
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:38 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7CF291040C9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:28 +0100 (CET)
Message-Id: <20200320131510.501728797@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:14:03 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
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
Subject: [patch 18/22] powercap/intel_rapl: Convert to new X86 CPU match
 macros
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

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl_common.c |   81 +++++++++++++++++------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -951,52 +951,51 @@ static const struct rapl_defaults rapl_d
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	INTEL_CPU_FAM6(SANDYBRIDGE, rapl_defaults_core),
-	INTEL_CPU_FAM6(SANDYBRIDGE_X, rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
 
-	INTEL_CPU_FAM6(IVYBRIDGE, rapl_defaults_core),
-	INTEL_CPU_FAM6(IVYBRIDGE_X, rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&rapl_defaults_core),
 
-	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_G, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
-
-	INTEL_CPU_FAM6(BROADWELL, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_G, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_D, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
-
-	INTEL_CPU_FAM6(SKYLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(SKYLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(SKYLAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(KABYLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(KABYLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(CANNONLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(COMETLAKE_L, rapl_defaults_core),
-	INTEL_CPU_FAM6(COMETLAKE, rapl_defaults_core),
-	INTEL_CPU_FAM6(TIGERLAKE_L, rapl_defaults_core),
-
-	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
-	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID, rapl_defaults_tng),
-	INTEL_CPU_FAM6(ATOM_AIRMONT_MID, rapl_defaults_ann),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_D, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_TREMONT_D, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_TREMONT_L, rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
+
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
 
-	INTEL_CPU_FAM6(XEON_PHI_KNL, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(XEON_PHI_KNM, rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 	{}
 };
-
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
 
 /* Read once for all raw primitive data for domains */

