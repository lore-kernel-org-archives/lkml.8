Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A6C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EE320777
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCYFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:34:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:31776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCYFe5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:34:57 -0400
IronPort-SDR: rj+lCr6mhWumEiY0Wlo9edIxEpGhVV5PR9HAdWURcMO4Ixpdz7YWOdtY4MLL8CmEnjFgHZda3l
 dDwj4lvU2igw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 22:34:57 -0700
IronPort-SDR: igvLrnb2oYoGC+XBinBi2wi1Yv1bCgvnvMtuSiMPwfXZQWdvJ98jFZClj/1An5RwZUUWCdOD1R
 KiRWPKYNSAcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; 
   d="scan'208";a="393523099"
Received: from kbl-ppc.sh.intel.com ([10.239.159.24])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 22:34:54 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf top: support hotkey to change sort order
Date:   Wed, 25 Mar 2020 06:07:11 +0800
Message-Id: <20200324220711.6025-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324220711.6025-1-yao.jin@linux.intel.com>
References: <20200324220711.6025-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice if we can use a hotkey in perf top browser to
select a event for sorting.

For example,
perf top --group -e cycles,instructions,cache-misses

Samples
                Overhead  Shared Object             Symbol
  40.03%  45.71%   0.03%  div                       [.] main
  20.46%  14.67%   0.21%  libc-2.27.so              [.] __random_r
  20.01%  19.54%   0.02%  libc-2.27.so              [.] __random
   9.68%  10.68%   0.00%  div                       [.] compute_flag
   4.32%   4.70%   0.00%  libc-2.27.so              [.] rand
   3.84%   3.43%   0.00%  div                       [.] rand@plt
   0.05%   0.05%   2.33%  libc-2.27.so              [.] __strcmp_sse2_unaligned
   0.04%   0.08%   2.43%  perf                      [.] perf_hpp__is_dynamic_en
   0.04%   0.02%   6.64%  perf                      [.] rb_next
   0.04%   0.01%   3.87%  perf                      [.] dso__find_symbol
   0.04%   0.04%   1.77%  perf                      [.] sort__dso_cmp

When user press hotkey '2' (event index, starting from 0), it indicates
to sort output by the third event in group (cache-misses).

Samples
                Overhead  Shared Object               Symbol
   4.07%   1.28%   6.68%  perf                        [.] rb_next
   3.57%   3.98%   4.11%  perf                        [.] __hists__insert_output
   3.67%  11.24%   3.60%  perf                        [.] perf_hpp__is_dynamic_e
   3.67%   3.20%   3.20%  perf                        [.] hpp__sort_overhead
   0.81%   0.06%   3.01%  perf                        [.] dso__find_symbol
   1.62%   5.47%   2.51%  perf                        [.] hists__match
   2.70%   1.86%   2.47%  libc-2.27.so                [.] _int_malloc
   0.19%   0.00%   2.29%  [kernel]                    [k] copy_page
   0.41%   0.32%   1.98%  perf                        [.] hists__decay_entries
   1.84%   3.67%   1.68%  perf                        [.] sort__dso_cmp
   0.16%   0.00%   1.63%  [kernel]                    [k] clear_page_erms

Now the output is sorted by cache-misses.

 v2:
 ---
 Zero the history if hotkey is pressed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-top.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 494c7b9a1022..29ddae7e1805 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -616,6 +616,7 @@ static void *display_thread_tui(void *arg)
 		.arg		= top,
 		.refresh	= top->delay_secs,
 	};
+	int ret;
 
 	/* In order to read symbols from other namespaces perf to  needs to call
 	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
@@ -626,6 +627,7 @@ static void *display_thread_tui(void *arg)
 
 	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
 
+repeat:
 	perf_top__sort_new_samples(top);
 
 	/*
@@ -638,13 +640,18 @@ static void *display_thread_tui(void *arg)
 		hists->uid_filter_str = top->record_opts.target.uid_str;
 	}
 
-	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
+	ret = perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
 				      top->min_percent,
 				      &top->session->header.env,
 				      !top->record_opts.overwrite,
 				      &top->annotation_opts);
 
-	stop_top();
+	if (ret == K_RELOAD) {
+		top->zero = true;
+		goto repeat;
+	} else
+		stop_top();
+
 	return NULL;
 }
 
-- 
2.17.1

