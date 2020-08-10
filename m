Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EFFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D76420734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHJV2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:28:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:25818 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgHJV1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:42 -0400
IronPort-SDR: Ns2bN3eGM7hWu+4sSZ6L4IqizbGf0Hj3gtz2jpk9mDymWajHUirS7M/VVb5phWs3c4KcIy6FAn
 wxW26XF5Adgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665941"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665941"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:41 -0700
IronPort-SDR: Kw5NUCT6Z36LJfRCGvNUPnRkAL0H9RoB6skIlyK8p01C1JFzJfP8PsNAm+HveDnYvuew6iJoq1
 RwV1HIlz9OKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196760"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:41 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 02/16] perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Mon, 10 Aug 2020 14:24:22 -0700
Message-Id: <20200810212436.8026-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
address. Update the data->addr if the sample type is set.

The large PEBS is disabled with the sample type, because perf doesn't
support munmap tracking yet. The PEBS buffer for large PEBS cannot be
flushed for each munmap. Wrong page size may be calculated. The large
PEBS can be enabled later separately when munmap tracking is supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 86848c57b55e..861cb5178cb6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -961,7 +961,8 @@ static void adaptive_pebs_record_size_update(void)
 
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
-				PERF_SAMPLE_TRANSACTION)
+				PERF_SAMPLE_TRANSACTION |		     \
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 
 static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 {
@@ -1337,6 +1338,10 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+#define PERF_SAMPLE_ADDR_TYPE	(PERF_SAMPLE_ADDR |		\
+				 PERF_SAMPLE_PHYS_ADDR |	\
+				 PERF_SAMPLE_DATA_PAGE_SIZE)
+
 static void setup_pebs_fixed_sample_data(struct perf_event *event,
 				   struct pt_regs *iregs, void *__pebs,
 				   struct perf_sample_data *data,
@@ -1451,7 +1456,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	}
 
 
-	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
+	if ((sample_type & PERF_SAMPLE_ADDR_TYPE) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
 		data->addr = pebs->dla;
 
@@ -1579,7 +1584,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
 			data->data_src.val = get_data_src(event, meminfo->aux);
 
-		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
-- 
2.17.1

