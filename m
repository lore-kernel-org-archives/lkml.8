Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99303C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69899206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDDIoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41508 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgDDIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNA-0000xY-Bj; Sat, 04 Apr 2020 10:41:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 101081C047B;
        Sat,  4 Apr 2020 10:41:43 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:42 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf top: Support hotkey to change sort order
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324220711.6025-2-yao.jin@linux.intel.com>
References: <20200324220711.6025-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158598970272.28353.13117327640198031967.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2605af0f32d1bf434dd6819732c7851a97f5cbc0
Gitweb:        https://git.kernel.org/tip/2605af0f32d1bf434dd6819732c7851a97f5cbc0
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 25 Mar 2020 06:07:11 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf top: Support hotkey to change sort order

It would be nice if we can use a hotkey in perf top browser to select a
event for sorting.

For example:

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
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200324220711.6025-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9ff7943..289cf83 100644
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
 
