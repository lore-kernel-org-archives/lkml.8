Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7846420734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHJV20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:28:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:25825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgHJV1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:48 -0400
IronPort-SDR: r2VCthkUg5dssn3ug8WfC5H8OiPQKLhZnrAnlGLp34NeXR/WTPQxDT/bvv99J5Br07k/MfUKcf
 whKRb7x8yEyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665950"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:46 -0700
IronPort-SDR: 5xnCfLbSEBer/Alf8XO9kF0AM4MgnJxlX3XlUJ9DgzTvUus+KQOSEyohfmmbQKRIMefw7B+NbS
 WmEQTwl9lS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196781"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:46 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 06/16] perf script: Use ULL for enum perf_output_field
Date:   Mon, 10 Aug 2020 14:24:26 -0700
Message-Id: <20200810212436.8026-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bitwise-Shift operator (1U << ) is used in the enum
perf_output_field, which has already reached its capacity (32 items).
If more items are added, a compile error will be triggered.

Change the U to ULL, which extend the capacity to 64 items.

The enum perf_output_field is only used to calculate a value for the
'fields' in the output structure. The 'fields' is u64. The change
doesn't break anything.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-script.c | 64 ++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 447457786362..214bec350971 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -82,38 +82,38 @@ static bool			native_arch;
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
 enum perf_output_field {
-	PERF_OUTPUT_COMM            = 1U << 0,
-	PERF_OUTPUT_TID             = 1U << 1,
-	PERF_OUTPUT_PID             = 1U << 2,
-	PERF_OUTPUT_TIME            = 1U << 3,
-	PERF_OUTPUT_CPU             = 1U << 4,
-	PERF_OUTPUT_EVNAME          = 1U << 5,
-	PERF_OUTPUT_TRACE           = 1U << 6,
-	PERF_OUTPUT_IP              = 1U << 7,
-	PERF_OUTPUT_SYM             = 1U << 8,
-	PERF_OUTPUT_DSO             = 1U << 9,
-	PERF_OUTPUT_ADDR            = 1U << 10,
-	PERF_OUTPUT_SYMOFFSET       = 1U << 11,
-	PERF_OUTPUT_SRCLINE         = 1U << 12,
-	PERF_OUTPUT_PERIOD          = 1U << 13,
-	PERF_OUTPUT_IREGS	    = 1U << 14,
-	PERF_OUTPUT_BRSTACK	    = 1U << 15,
-	PERF_OUTPUT_BRSTACKSYM	    = 1U << 16,
-	PERF_OUTPUT_DATA_SRC	    = 1U << 17,
-	PERF_OUTPUT_WEIGHT	    = 1U << 18,
-	PERF_OUTPUT_BPF_OUTPUT	    = 1U << 19,
-	PERF_OUTPUT_CALLINDENT	    = 1U << 20,
-	PERF_OUTPUT_INSN	    = 1U << 21,
-	PERF_OUTPUT_INSNLEN	    = 1U << 22,
-	PERF_OUTPUT_BRSTACKINSN	    = 1U << 23,
-	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
-	PERF_OUTPUT_SYNTH           = 1U << 25,
-	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
-	PERF_OUTPUT_UREGS	    = 1U << 27,
-	PERF_OUTPUT_METRIC	    = 1U << 28,
-	PERF_OUTPUT_MISC            = 1U << 29,
-	PERF_OUTPUT_SRCCODE	    = 1U << 30,
-	PERF_OUTPUT_IPC             = 1U << 31,
+	PERF_OUTPUT_COMM            = 1ULL << 0,
+	PERF_OUTPUT_TID             = 1ULL << 1,
+	PERF_OUTPUT_PID             = 1ULL << 2,
+	PERF_OUTPUT_TIME            = 1ULL << 3,
+	PERF_OUTPUT_CPU             = 1ULL << 4,
+	PERF_OUTPUT_EVNAME          = 1ULL << 5,
+	PERF_OUTPUT_TRACE           = 1ULL << 6,
+	PERF_OUTPUT_IP              = 1ULL << 7,
+	PERF_OUTPUT_SYM             = 1ULL << 8,
+	PERF_OUTPUT_DSO             = 1ULL << 9,
+	PERF_OUTPUT_ADDR            = 1ULL << 10,
+	PERF_OUTPUT_SYMOFFSET       = 1ULL << 11,
+	PERF_OUTPUT_SRCLINE         = 1ULL << 12,
+	PERF_OUTPUT_PERIOD          = 1ULL << 13,
+	PERF_OUTPUT_IREGS	    = 1ULL << 14,
+	PERF_OUTPUT_BRSTACK	    = 1ULL << 15,
+	PERF_OUTPUT_BRSTACKSYM	    = 1ULL << 16,
+	PERF_OUTPUT_DATA_SRC	    = 1ULL << 17,
+	PERF_OUTPUT_WEIGHT	    = 1ULL << 18,
+	PERF_OUTPUT_BPF_OUTPUT	    = 1ULL << 19,
+	PERF_OUTPUT_CALLINDENT	    = 1ULL << 20,
+	PERF_OUTPUT_INSN	    = 1ULL << 21,
+	PERF_OUTPUT_INSNLEN	    = 1ULL << 22,
+	PERF_OUTPUT_BRSTACKINSN	    = 1ULL << 23,
+	PERF_OUTPUT_BRSTACKOFF	    = 1ULL << 24,
+	PERF_OUTPUT_SYNTH           = 1ULL << 25,
+	PERF_OUTPUT_PHYS_ADDR       = 1ULL << 26,
+	PERF_OUTPUT_UREGS	    = 1ULL << 27,
+	PERF_OUTPUT_METRIC	    = 1ULL << 28,
+	PERF_OUTPUT_MISC            = 1ULL << 29,
+	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
+	PERF_OUTPUT_IPC             = 1ULL << 31,
 };
 
 struct output_option {
-- 
2.17.1

