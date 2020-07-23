Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEACFC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37EF22D70
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgGWRL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:11:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:6574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbgGWRLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:44 -0400
IronPort-SDR: F1kQxuNhtp3go6R02yWdhdxdcX3sVoMsErAMIkrkljacqT98w5/ZOFOaePAZ72Z0ooL9whqP7H
 9gA6Mtr6G9eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456724"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:43 -0700
IronPort-SDR: IV4ZqdwLeoS3rJd18OTVjYEn3oOIlJ9Jg9iUifeU1xsKH+lk5Lg+HZ7D5s7p3b3irICIuGWJch
 ZbI5vVmaDpqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904260"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 04/14] perf/x86/intel: Move BTS index to 47
Date:   Thu, 23 Jul 2020 10:11:07 -0700
Message-Id: <20200723171117.9918-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The bit 48 in the PERF_GLOBAL_STATUS is used to indicate the overflow
status of the PERF_METRICS counters.

Move the BTS index to the bit 47.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fe8110a8c75b..58419e50ff98 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -238,11 +238,11 @@ struct x86_pmu_capability {
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
- * We choose a value in the middle of the fixed event range, since lower
+ * We choose the value 47 for the fixed index of BTS, since lower
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 15)
 
 #define GLOBAL_STATUS_COND_CHG			BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF_BIT		62
-- 
2.17.1

