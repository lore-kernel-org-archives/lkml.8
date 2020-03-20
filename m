Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53133C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2711220754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgCTNRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:17:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35737 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgCTNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:35 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVo-00049t-IB
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:32 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CFFE11040C5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:27 +0100 (CET)
Message-Id: <20200320131510.193755545@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:14:00 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [patch 15/22] intel_idle: Convert to new X86 CPU match macros
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
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/idle/intel_idle.c |   79 ++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1068,51 +1068,48 @@ static const struct idle_cpu idle_cpu_dn
 };
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
-	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(NEHALEM,			idle_cpu_nehalem),
-	INTEL_CPU_FAM6(NEHALEM_G,		idle_cpu_nehalem),
-	INTEL_CPU_FAM6(WESTMERE,		idle_cpu_nehalem),
-	INTEL_CPU_FAM6(WESTMERE_EP,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(NEHALEM_EX,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(ATOM_BONNELL,		idle_cpu_atom),
-	INTEL_CPU_FAM6(ATOM_BONNELL_MID,	idle_cpu_lincroft),
-	INTEL_CPU_FAM6(WESTMERE_EX,		idle_cpu_nhx),
-	INTEL_CPU_FAM6(SANDYBRIDGE,		idle_cpu_snb),
-	INTEL_CPU_FAM6(SANDYBRIDGE_X,		idle_cpu_snx),
-	INTEL_CPU_FAM6(ATOM_SALTWELL,		idle_cpu_atom),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT,		idle_cpu_byt),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	idle_cpu_tangier),
-	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
-	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
-	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
-	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsx),
-	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_G,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_D,	idle_cpu_avn),
-	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_G,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdx),
-	INTEL_CPU_FAM6(BROADWELL_D,		idle_cpu_bdx),
-	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
-	INTEL_CPU_FAM6(SKYLAKE,			idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE_L,		idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE,		idle_cpu_skl),
-	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
-	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
-	INTEL_CPU_FAM6(XEON_PHI_KNM,		idle_cpu_knl),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT,		idle_cpu_bxt),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_D,		idle_cpu_dnv),
-	INTEL_CPU_FAM6(ATOM_TREMONT_D,		idle_cpu_dnv),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&idle_cpu_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_G,		&idle_cpu_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&idle_cpu_nehalem),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL,	&idle_cpu_atom),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_BONNELL_MID,	&idle_cpu_lincroft),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&idle_cpu_nhx),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&idle_cpu_snb),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&idle_cpu_snx),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SALTWELL,	&idle_cpu_atom),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&idle_cpu_byt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&idle_cpu_tangier),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&idle_cpu_cht),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&idle_cpu_ivb),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&idle_cpu_ivt),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&idle_cpu_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&idle_cpu_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&idle_cpu_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&idle_cpu_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&idle_cpu_avn),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&idle_cpu_bdw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&idle_cpu_bdw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&idle_cpu_bdx),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&idle_cpu_bdx),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&idle_cpu_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_dnv),
 	{}
 };
 
-#define INTEL_CPU_FAM6_MWAIT \
-	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_MWAIT, 0 }
-
 static const struct x86_cpu_id intel_mwait_ids[] __initconst = {
-	INTEL_CPU_FAM6_MWAIT,
+	X86_MATCH_VENDOR_FAM_FEATURE(INTEL, 6, X86_FEATURE_MWAIT, NULL),
 	{}
 };
 

