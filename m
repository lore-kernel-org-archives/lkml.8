Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0CEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4073207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgE1GtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1GtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:49:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB7C05BD1E;
        Wed, 27 May 2020 23:49:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeCLd-0008AN-Ar; Thu, 28 May 2020 08:49:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C3D491C0051;
        Thu, 28 May 2020 08:49:00 +0200 (CEST)
Date:   Thu, 28 May 2020 06:49:00 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add AMD Fam17h RAPL support
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527224659.206129-6-eranian@google.com>
References: <20200527224659.206129-6-eranian@google.com>
MIME-Version: 1.0
Message-ID: <159064854059.17951.6886415717644163423.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5cde265384cad739b162cf08afba6da8857778bd
Gitweb:        https://git.kernel.org/tip/5cde265384cad739b162cf08afba6da8857778bd
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 27 May 2020 15:46:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 07:58:56 +02:00

perf/x86/rapl: Add AMD Fam17h RAPL support

This patch enables AMD Fam17h RAPL support for the Package level metric.
The support is as per AMD Fam17h Model31h (Zen2) and model 00-ffh (Zen1) PPR.

The same output is available via the energy-pkg pseudo event:

  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200527224659.206129-6-eranian@google.com
---
 arch/x86/events/rapl.c           | 18 ++++++++++++++++++
 arch/x86/include/asm/msr-index.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8d17af4..0f2bf59 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -537,6 +537,16 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr },
 };
 
+/*
+ * Force to PERF_RAPL_MAX size due to:
+ * - perf_msr_probe(PERF_RAPL_MAX)
+ * - want to use same event codes across both architectures
+ */
+static struct perf_msr amd_rapl_msrs[PERF_RAPL_MAX] = {
+	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
+};
+
+
 static int rapl_cpu_offline(unsigned int cpu)
 {
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
@@ -740,6 +750,13 @@ static struct rapl_model model_skl = {
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
+static struct rapl_model model_amd_fam17h = {
+	.events		= BIT(PERF_RAPL_PKG),
+	.apply_quirk	= false,
+	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
+	.rapl_msrs      = amd_rapl_msrs,
+};
+
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
@@ -770,6 +787,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_VENDOR_FAM(AMD, 0x17, &model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 12c9684..ef452b8 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -301,6 +301,9 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
+#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
+#define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+
 /* Config TDP MSRs */
 #define MSR_CONFIG_TDP_NOMINAL		0x00000648
 #define MSR_CONFIG_TDP_LEVEL_1		0x00000649
