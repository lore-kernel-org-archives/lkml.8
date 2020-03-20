Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C36C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBD120754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCTNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:16:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:29 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVi-00048J-8X
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:26 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 66FF21039FF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:25 +0100 (CET)
Message-Id: <20200320131509.029267418@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:13:49 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
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
Subject: [patch 04/22] x86/perf/events: Convert to new CPU match macros
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
---
 arch/x86/events/amd/power.c    |    2 
 arch/x86/events/intel/cstate.c |  109 +++++++++++++++++++----------------------
 arch/x86/events/intel/rapl.c   |   58 ++++++++++-----------
 arch/x86/events/intel/uncore.c |   63 ++++++++++-------------
 4 files changed, 110 insertions(+), 122 deletions(-)

--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -259,7 +259,7 @@ static int power_cpu_init(unsigned int c
 }
 
 static const struct x86_cpu_id cpu_match[] = {
-	{ .vendor = X86_VENDOR_AMD, .family = 0x15 },
+	X86_MATCH_VENDOR_FAM(AMD, 0x15, NULL),
 	{},
 };
 
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -594,63 +594,60 @@ static const struct cstate_model glm_cst
 };
 
 
-#define X86_CSTATES_MODEL(model, states)				\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long) &(states) }
-
 static const struct x86_cpu_id intel_cstates_match[] __initconst = {
-	X86_CSTATES_MODEL(INTEL_FAM6_NEHALEM,    nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_NEHALEM_EP, nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_NEHALEM_EX, nhm_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_WESTMERE,    nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_WESTMERE_EP, nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_WESTMERE_EX, nhm_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_SANDYBRIDGE,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SANDYBRIDGE_X, snb_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_G, snb_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_D, slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,      slm_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_D, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X, snb_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_L, hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,   hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE_L, hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE, hswult_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_L, cnl_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT_D, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT, glm_cstates),
-
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE_L, icl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE, icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&nhm_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&nhm_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&snb_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&snb_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&snb_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&hswult_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&slm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&slm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&slm_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&snb_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&snb_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&hswult_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&cnl_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&knl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&knl_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
+
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -668,9 +668,6 @@ static int __init init_rapl_pmus(void)
 	return 0;
 }
 
-#define X86_RAPL_MODEL_MATCH(model, init)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
-
 static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
@@ -716,36 +713,35 @@ static struct rapl_model model_skl = {
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,		model_snb),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,		model_snbep),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,		model_snb),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,		model_snbep),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_L,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_HASWELL_G,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_D,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_L,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_D,	model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_COMETLAKE_L,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_COMETLAKE,		model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&model_snb),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&model_snbep),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&model_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&model_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&model_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&model_knl),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&model_knl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&model_hsx),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&model_hsw),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
 	{},
 };
-
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 
 static int __init rapl_pmu_init(void)
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1392,10 +1392,6 @@ static int __init uncore_mmio_init(void)
 	return ret;
 }
 
-
-#define X86_UNCORE_MODEL_MATCH(model, init)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
-
 struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
@@ -1477,38 +1473,37 @@ static const struct intel_uncore_init_fu
 };
 
 static const struct x86_cpu_id intel_uncore_match[] __initconst = {
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EP,	  nhm_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM,	  nhm_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE,	  nhm_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EP,	  nhm_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE,	  snb_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE,	  ivb_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_L,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_G,	  hsw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL,	  bdw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_G,	  bdw_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SANDYBRIDGE_X,  snbep_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_NEHALEM_EX,	  nhmex_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_WESTMERE_EX,	  nhmex_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_IVYBRIDGE_X,	  ivbep_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_HASWELL_X,	  hswep_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,	  bdx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_D,	  bdx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_L,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_L,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_L,	  icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_D, snr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&nhm_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&nhm_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&snb_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&ivb_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&hsw_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&hsw_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&hsw_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&bdw_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&bdw_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&snbep_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&nhmex_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&nhmex_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&ivbep_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&hswep_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&bdx_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&bdx_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&knl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&knl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&skx_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&skl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
-
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
 
 static int __init intel_uncore_init(void)

