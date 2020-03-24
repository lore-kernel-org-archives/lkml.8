Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A4C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7B820836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgCXWck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgCXWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5y-0006xh-Nu; Tue, 24 Mar 2020 23:32:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8BDD71C0494;
        Tue, 24 Mar 2020 23:32:21 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:21 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/perf/events: Convert to new CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131509.029267418@linutronix.de>
References: <20200320131509.029267418@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508914121.28353.2313141662666262683.tip-bot2@tip-bot2>
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

Commit-ID:     ef37219ab828c9ead544589ed33cd94f9273d7c7
Gitweb:        https://git.kernel.org/tip/ef37219ab828c9ead544589ed33cd94f9273d7c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:13:49 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:22:28 +01:00

x86/perf/events: Convert to new CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Get rid the of the local macro wrappers for consistency.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131509.029267418@linutronix.de
---
 arch/x86/events/amd/power.c    |  2 +-
 arch/x86/events/intel/cstate.c | 83 +++++++++++++++------------------
 arch/x86/events/intel/rapl.c   | 58 ++++++++++-------------
 arch/x86/events/intel/uncore.c | 63 +++++++++++--------------
 4 files changed, 97 insertions(+), 109 deletions(-)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index abef513..43b09e9 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -259,7 +259,7 @@ static int power_cpu_init(unsigned int cpu)
 }
 
 static const struct x86_cpu_id cpu_match[] = {
-	{ .vendor = X86_VENDOR_AMD, .family = 0x15 },
+	X86_MATCH_VENDOR_FAM(AMD, 0x15, NULL),
 	{},
 };
 
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4814c96..e4aa20c 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -594,63 +594,60 @@ static const struct cstate_model glm_cstates __initconst = {
 };
 
 
-#define X86_CSTATES_MODEL(model, states)				\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long) &(states) }
-
 static const struct x86_cpu_id intel_cstates_match[] __initconst = {
-	X86_CSTATES_MODEL(INTEL_FAM6_NEHALEM,    nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_NEHALEM_EP, nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_NEHALEM_EX, nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EX,		&nhm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_WESTMERE,    nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_WESTMERE_EP, nhm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_WESTMERE_EX, nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EP,		&nhm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(WESTMERE_EX,		&nhm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SANDYBRIDGE,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SANDYBRIDGE_X, snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_IVYBRIDGE_X, snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_X, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_G, snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_HASWELL_L, hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT,   slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_SILVERMONT_D, slm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_AIRMONT,      slm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&slm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	&slm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&slm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_D, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_G, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X, snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_L, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,   snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&snb_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_L, hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,   hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE_L, hswult_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_COMETLAKE, hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&hswult_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_L, cnl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&cnl_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&knl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&knl_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT,   glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_D, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT_D, glm_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_TREMONT, glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&glm_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_L, icl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,   icl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE_L, icl_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_TIGERLAKE, icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 0991312..a5dbd25 100644
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
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 86467f8..ac93705 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1392,10 +1392,6 @@ err:
 	return ret;
 }
 
-
-#define X86_UNCORE_MODEL_MATCH(model, init)	\
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&init }
-
 struct intel_uncore_init_fun {
 	void	(*cpu_init)(void);
 	int	(*pci_init)(void);
@@ -1477,38 +1473,37 @@ static const struct intel_uncore_init_fun snr_uncore_init __initconst = {
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
