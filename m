Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B32EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33ABF2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgGPPTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:19:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:53787 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgGPPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:19:06 -0400
IronPort-SDR: Bt8I6kIBpzTowwjq1YN9eNhxpH5stVEO6U3ZB+rkEyvX7Zy6GrKSoic7zGCpriB8wIpmpHvZd2
 Wsc6Z29mMhSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136856002"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="136856002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 08:19:05 -0700
IronPort-SDR: x1bXB+sEXh6WQvtw51ZYF406wQzP7DcQ5vzUDfdUf4vpkQDy6ZxDc7oeM76Xu1nrooe9E+FS2Y
 ELsOf34gKzYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="486138535"
Received: from thuang6-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.173.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 08:19:03 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        len.brown@intel.com
Subject: [PATCH 2/3] perf/x86/rapl: Support multiple rapl unit quirks
Date:   Thu, 16 Jul 2020 23:18:58 +0800
Message-Id: <20200716151859.6854-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716151859.6854-1-rui.zhang@intel.com>
References: <20200716151859.6854-1-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There will be more platforms with different fixed energy units.
Enhance the code to support different rapl unit quirks for different
platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/rapl.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 51ff9a3618c9..5b3e11299c8d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -130,11 +130,16 @@ struct rapl_pmus {
 	struct rapl_pmu		*pmus[];
 };
 
+enum rapl_unit_quirk {
+	RAPL_UNIT_QUIRK_NONE,
+	RAPL_UNIT_QUIRK_INTEL_HSW,
+};
+
 struct rapl_model {
 	struct perf_msr *rapl_msrs;
 	unsigned long	events;
 	unsigned int	msr_power_unit;
-	bool		apply_quirk;
+	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
@@ -612,14 +617,20 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	switch (rm->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
 	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
-	if (rm->apply_quirk)
+	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		break;
+	default:
+		break;
+	}
+
 
 	/*
 	 * Calculate the timer rate:
@@ -698,7 +709,6 @@ static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -707,7 +717,6 @@ static struct rapl_model model_snbep = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -717,7 +726,6 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -726,7 +734,7 @@ static struct rapl_model model_hsx = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -734,7 +742,7 @@ static struct rapl_model model_hsx = {
 static struct rapl_model model_knl = {
 	.events		= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -745,14 +753,12 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
-- 
2.17.1

