Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D45F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgF3NkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:40:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:31774 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387436AbgF3NkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:40:20 -0400
IronPort-SDR: Xu5+rj1INv2FSyJLFxcPyO1z8dL85ntSQFWrEyDZqC4JHWaHJEXfwMaMkpgZgQA9XfGbKMOrUi
 br89fQTlRwZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145302186"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="145302186"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 06:40:19 -0700
IronPort-SDR: WhmhY/uTaHjqbMXqU5dHE5uThuyZUu8NJQ4UG0NjYKLyGTZfhIE83j80Dv/0//8rPfw0cZnDCR
 bpY33Rv5trqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="425207212"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 06:40:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 3/3] perf intel-pt: Fix PEBS sample for XMM registers
Date:   Tue, 30 Jun 2020 16:39:35 +0300
Message-Id: <20200630133935.11150-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630133935.11150-1-adrian.hunter@intel.com>
References: <20200630133935.11150-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition to add XMM registers was missing, the regs array needed to be
in the outer scope, and the size of the regs array was too small.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 143d34a6b387b ("perf intel-pt: Add XMM registers to synthesized PEBS sample")
---
 tools/perf/util/intel-pt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e4dd8bf610ce..cb3c1e569a2d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1735,6 +1735,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 id = evsel->core.id[0];
 	u8 cpumode;
+	u64 regs[8 * sizeof(sample.intr_regs.mask)];
 
 	if (intel_pt_skip_event(pt))
 		return 0;
@@ -1784,8 +1785,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR &&
-	    items->mask[INTEL_PT_GP_REGS_POS]) {
-		u64 regs[sizeof(sample.intr_regs.mask)];
+	    (items->mask[INTEL_PT_GP_REGS_POS] ||
+	     items->mask[INTEL_PT_XMM_POS])) {
 		u64 regs_mask = evsel->core.attr.sample_regs_intr;
 		u64 *pos;
 
-- 
2.17.1

