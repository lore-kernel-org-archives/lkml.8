Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC81C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5547820716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHJV23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:28:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:25819 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgHJV1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:45 -0400
IronPort-SDR: 1qxGJppf2D1C2acbZmaKQ3uScNTStJkG3eS+mTRFcSCbuoWGuXQgTt51ut0cNIvcKk+0VgarsX
 E1sYY3lqoiTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665946"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665946"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:44 -0700
IronPort-SDR: 12c7MpZ42jVw6iY6t6Ijf5AcckNKoNzh2bDcB8jhBggbqhJeyaZQ32bbyrANTDGS9hYyhmptBo
 FawdOyZY6EDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196771"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:44 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 04/16] tools headers UAPI: Update tools's copy of linux/perf_event.h
Date:   Mon, 10 Aug 2020 14:24:24 -0700
Message-Id: <20200810212436.8026-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in:
   ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
   ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")

This silences this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h
include/uapi/linux/perf_event.h

This update is a prerequisite to adding support for the HW index of raw
branch records.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7b2d6fc9e6ed..4666405adce6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -143,8 +143,10 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
+	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 
-	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -878,6 +880,8 @@ enum perf_event_type {
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
-- 
2.17.1

