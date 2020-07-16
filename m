Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02045C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2842063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgGPPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:19:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:53787 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgGPPTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:19:09 -0400
IronPort-SDR: ZznJA+yO2UEgpm1NrWjosJfCO1KcJJJL2j5hUCC+2vxiu8U6kJdrF/ioL8oPqXpeiZh0vvfl9N
 Sl/wywB4k9MA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136856006"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="136856006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 08:19:08 -0700
IronPort-SDR: PK+xRiXdY0911E0R/9x3WABMpD1ZNP5Q2V+LAzXlU7D4PFL5WpIpSebiomL69Imw5BHMbWVLTz
 s3qWCqQVbUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="486138548"
Received: from thuang6-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.173.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 08:19:05 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        len.brown@intel.com
Subject: [PATCH 3/3] perf/x86/rapl: Add support for Intel SPR platform
Date:   Thu, 16 Jul 2020 23:18:59 +0800
Message-Id: <20200716151859.6854-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716151859.6854-1-rui.zhang@intel.com>
References: <20200716151859.6854-1-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel SPR platform uses fixed 16 bit energy unit for DRAM RAPL domain,
and fixed 0 bit energy unit for Psys RAPL domain.
After this, on SPR platform the energy counters appear in perf list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/rapl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 5b3e11299c8d..731e3a32f723 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -133,6 +133,7 @@ struct rapl_pmus {
 enum rapl_unit_quirk {
 	RAPL_UNIT_QUIRK_NONE,
 	RAPL_UNIT_QUIRK_INTEL_HSW,
+	RAPL_UNIT_QUIRK_INTEL_SPR,
 };
 
 struct rapl_model {
@@ -627,6 +628,14 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
+	/*
+	 * SPR shares the same DRAM domain energy unit as HSW, plus it
+	 * also has a fixed energy unit for Psys domain.
+	 */
+	case RAPL_UNIT_QUIRK_INTEL_SPR:
+		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
+		break;
 	default:
 		break;
 	}
@@ -757,6 +766,16 @@ static struct rapl_model model_skl = {
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
+static struct rapl_model model_spr = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PSYS),
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
+};
+
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
@@ -793,6 +812,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &model_amd_fam17h),
 	{},
 };
-- 
2.17.1

