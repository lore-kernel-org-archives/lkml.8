Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9200C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BF420801
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgEPMfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:35:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:33866 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgEPMfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:35:34 -0400
IronPort-SDR: aOldtExv3sgzEI7Bj5eyMQBV6vXasZYocuADCUdNhb9PD2b9xzzRUW/CZbCKbhFz5H+98qw5KD
 wnlUwjr8D83Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 05:35:33 -0700
IronPort-SDR: b0Z9cSQDLiK/eM6XOXkvTUMhH6qRlppSQIxK6oM1pBzjvuFC4bY3aXLAtWvpYUTq14QDaatk2L
 7+6LbETvcYFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="465049816"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2020 05:35:31 -0700
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org> <20200514150601.GS4897@embeddedor>
 <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
 <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
 <20200515001025.GU4897@embeddedor> <20200515164153.GD9335@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2540ed9a-89f1-6d59-10c9-a66cc90db5d2@intel.com>
Date:   Sat, 16 May 2020 15:35:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515164153.GD9335@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/20 7:41 pm, Arnaldo Carvalho de Melo wrote:
> Sorry for the top post: Adrian, can you take a look at this?
> 
> Adrian Hunter was not CCed, Adrian?

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Sat, 16 May 2020 15:12:28 +0300
Subject: [PATCH] perf intel-pt: Use allocated branch stack for PEBS sample

To avoid having struct branch_stack as a non-last structure member,
use allocated branch stack for PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f17b1e769ae4..e4dd8bf610ce 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -913,11 +913,11 @@ static void intel_pt_add_callchain(struct intel_pt *pt,
 	sample->callchain = pt->chain;
 }
 
-static struct branch_stack *intel_pt_alloc_br_stack(struct intel_pt *pt)
+static struct branch_stack *intel_pt_alloc_br_stack(unsigned int entry_cnt)
 {
 	size_t sz = sizeof(struct branch_stack);
 
-	sz += pt->br_stack_sz * sizeof(struct branch_entry);
+	sz += entry_cnt * sizeof(struct branch_entry);
 	return zalloc(sz);
 }
 
@@ -930,7 +930,7 @@ static int intel_pt_br_stack_init(struct intel_pt *pt)
 			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
 	}
 
-	pt->br_stack = intel_pt_alloc_br_stack(pt);
+	pt->br_stack = intel_pt_alloc_br_stack(pt->br_stack_sz);
 	if (!pt->br_stack)
 		return -ENOMEM;
 
@@ -951,6 +951,9 @@ static void intel_pt_add_br_stack(struct intel_pt *pt,
 	sample->branch_stack = pt->br_stack;
 }
 
+/* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
+#define LBRS_MAX (INTEL_PT_BLK_ITEM_ID_CNT * 3U)
+
 static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 						   unsigned int queue_nr)
 {
@@ -968,8 +971,10 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 			goto out_free;
 	}
 
-	if (pt->synth_opts.last_branch) {
-		ptq->last_branch = intel_pt_alloc_br_stack(pt);
+	if (pt->synth_opts.last_branch || pt->synth_opts.other_events) {
+		unsigned int entry_cnt = max(LBRS_MAX, pt->br_stack_sz);
+
+		ptq->last_branch = intel_pt_alloc_br_stack(entry_cnt);
 		if (!ptq->last_branch)
 			goto out_free;
 	}
@@ -1720,9 +1725,6 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
 	}
 }
 
-/* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
-#define LBRS_MAX (INTEL_PT_BLK_ITEM_ID_CNT * 3)
-
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1798,25 +1800,18 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
-		struct {
-			struct branch_stack br_stack;
-			struct branch_entry entries[LBRS_MAX];
-		} br;
-
 		if (items->mask[INTEL_PT_LBR_0_POS] ||
 		    items->mask[INTEL_PT_LBR_1_POS] ||
 		    items->mask[INTEL_PT_LBR_2_POS]) {
-			intel_pt_add_lbrs(&br.br_stack, items);
-			sample.branch_stack = &br.br_stack;
+			intel_pt_add_lbrs(ptq->last_branch, items);
 		} else if (pt->synth_opts.last_branch) {
 			thread_stack__br_sample(ptq->thread, ptq->cpu,
 						ptq->last_branch,
 						pt->br_stack_sz);
-			sample.branch_stack = ptq->last_branch;
 		} else {
-			br.br_stack.nr = 0;
-			sample.branch_stack = &br.br_stack;
+			ptq->last_branch->nr = 0;
 		}
+		sample.branch_stack = ptq->last_branch;
 	}
 
 	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
-- 
2.17.1



