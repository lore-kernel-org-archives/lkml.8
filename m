Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BE8207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgE1GtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgE1GtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:49:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC3CC05BD1E;
        Wed, 27 May 2020 23:49:04 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeCLe-0008Av-ID; Thu, 28 May 2020 08:49:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 44A201C032F;
        Thu, 28 May 2020 08:49:02 +0200 (CEST)
Date:   Thu, 28 May 2020 06:49:02 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Refactor to share the RAPL code
 between Intel and AMD CPUs
Cc:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527224659.206129-3-eranian@google.com>
References: <20200527224659.206129-3-eranian@google.com>
MIME-Version: 1.0
Message-ID: <159064854216.17951.3364407263267206784.tip-bot2@tip-bot2>
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

Commit-ID:     5c95c68949880035b68e5c48fdf4899ec0989631
Gitweb:        https://git.kernel.org/tip/5c95c68949880035b68e5c48fdf4899ec0989631
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 27 May 2020 15:46:56 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 07:58:55 +02:00

perf/x86/rapl: Refactor to share the RAPL code between Intel and AMD CPUs

This patch modifies the rapl_model struct to include architecture specific
knowledge in this previously Intel specific structure, and in particular
it adds the MSR for POWER_UNIT and the rapl_msrs array.

No functional changes.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200527224659.206129-3-eranian@google.com
---
 arch/x86/events/rapl.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 3e6c01b..f29935e 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -131,7 +131,9 @@ struct rapl_pmus {
 };
 
 struct rapl_model {
+	struct perf_msr *rapl_msrs;
 	unsigned long	events;
+	unsigned int	msr_power_unit;
 	bool		apply_quirk;
 };
 
@@ -141,7 +143,7 @@ static struct rapl_pmus *rapl_pmus;
 static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr rapl_msrs[];
+static struct perf_msr *rapl_msrs;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
@@ -516,7 +518,7 @@ static bool test_msr(int idx, void *data)
 	return test_bit(idx, (unsigned long *) data);
 }
 
-static struct perf_msr rapl_msrs[] = {
+static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr },
 	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr },
 	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr },
@@ -578,13 +580,13 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_check_hw_unit(bool apply_quirk)
+static int rapl_check_hw_unit(struct rapl_model *rm)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(MSR_RAPL_POWER_UNIT, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
@@ -595,7 +597,7 @@ static int rapl_check_hw_unit(bool apply_quirk)
 	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
-	if (apply_quirk)
+	if (rm->apply_quirk)
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 
 	/*
@@ -676,6 +678,8 @@ static struct rapl_model model_snb = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_snbep = {
@@ -683,6 +687,8 @@ static struct rapl_model model_snbep = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsw = {
@@ -691,6 +697,8 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsx = {
@@ -698,12 +706,16 @@ static struct rapl_model model_hsx = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.apply_quirk	= true,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_knl = {
 	.events		= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.apply_quirk	= true,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_skl = {
@@ -713,6 +725,8 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -760,10 +774,13 @@ static int __init rapl_pmu_init(void)
 		return -ENODEV;
 
 	rm = (struct rapl_model *) id->driver_data;
+
+	rapl_msrs = rm->rapl_msrs;
+
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
 					false, (void *) &rm->events);
 
-	ret = rapl_check_hw_unit(rm->apply_quirk);
+	ret = rapl_check_hw_unit(rm);
 	if (ret)
 		return ret;
 
