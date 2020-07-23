Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D7C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA67522BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgGWRMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:12:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:6614 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbgGWRLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:50 -0400
IronPort-SDR: qq0mtHZZQI5DYKLfxFOf0XqnPgpOl+HZmkm1PFXUS0RWep089jRD5gZ9AcUCiE8b06NPh6dt25
 AIw4c+T99kLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456811"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:50 -0700
IronPort-SDR: A4L2pHgH9/ipRircwVSktSzo3ExRr/mR2KFKZGa+OhgjaLCrQniMb7+ZRFFMEeDH7kksUucs2N
 HF4Smk9jgFAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904296"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:49 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 09/14] perf/x86: Add a macro for RDPMC offset of fixed counters
Date:   Thu, 23 Jul 2020 10:11:12 -0700
Message-Id: <20200723171117.9918-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The RDPMC base offset of fixed counters is hard-code. Use a meaningful
name to replace the magic number to improve the readability of the code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c            | 3 ++-
 arch/x86/include/asm/perf_event.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 53fcf0a2b025..ebf723f33794 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1151,7 +1151,8 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
 				(idx - INTEL_PMC_IDX_FIXED);
-		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) | 1<<30;
+		hwc->event_base_rdpmc = (idx - INTEL_PMC_IDX_FIXED) |
+					INTEL_PMC_FIXED_RDPMC_BASE;
 		break;
 
 	default:
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 000cab7818b5..964ba312c249 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -196,6 +196,9 @@ struct x86_pmu_capability {
  * Fixed-purpose performance events:
  */
 
+/* RDPMC offset for Fixed PMCs */
+#define INTEL_PMC_FIXED_RDPMC_BASE		(1 << 30)
+
 /*
  * All the fixed-mode PMCs are configured via this single MSR:
  */
-- 
2.17.1

