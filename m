Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D2C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4C72077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbgDAKSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:18:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbgDAKSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:18:02 -0400
IronPort-SDR: ClEis5qiTC/ulO5tuSDIfqPcTTYdV28b+S5hjBfCBSp0t1KUetIIAafl8IYy3i1qc8XfSS656X
 klCpfTeE+XFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:18:00 -0700
IronPort-SDR: eUFn/Xh1WQ8Rvifyj8FpGCsUDnbXQ+XErkDi6dfoCC3lpXetd5RIkEabet5U3O0bkbKNKPyvGD
 LxyjHsXsFoxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925610"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:18:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 15/16] perf tools: Allow multiple read formats
Date:   Wed,  1 Apr 2020 13:16:12 +0300
Message-Id: <20200401101613.6201-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tools find the correct evsel, and therefore read format, using the event
ID, so it isn't necessary for all read formats to be the same. In the case
of leader-sampling of AUX area events, dummy tracking events will have
a different read format, so relax the validation to become a debug message
only.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1548237b6558..82d9f9bb8975 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1131,8 +1131,10 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
 	u64 sample_type = first->core.attr.sample_type;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (read_format != pos->core.attr.read_format)
-			return false;
+		if (read_format != pos->core.attr.read_format) {
+			pr_debug("Read format differs %#" PRIx64 " vs %#" PRIx64 "\n",
+				 read_format, (u64)pos->core.attr.read_format);
+		}
 	}
 
 	/* PERF_SAMPLE_READ imples PERF_FORMAT_ID. */
-- 
2.17.1

