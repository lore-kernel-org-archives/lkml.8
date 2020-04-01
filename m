Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8226C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABCC2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgDAKSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:18:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732299AbgDAKSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:18:04 -0400
IronPort-SDR: NfvXKn7HxQzMvqEo2nF/2pDtqgGo50V6HQ74S7Ar/J1V+tVTsgkMsMiQRY8aqA1b9q9F8Y08k5
 3lY/RvI6ciOw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:18:02 -0700
IronPort-SDR: KOxMh6BDZWhdEvjG0+98QrgCQxbrdI2uVjN99WL2peT+0AbE1R2ng6vk+rYq6H5mZL74HmLT6c
 sOv2cFLgjQcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925635"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:18:02 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/16] perf tools: Add support for leader-sampling with AUX area events
Date:   Wed,  1 Apr 2020 13:16:13 +0300
Message-Id: <20200401101613.6201-17-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When AUX area events are used in sampling mode, they must be the group
leader, but the group leader is also used for leader-sampling. However,
it is not desirable to use an AUX area event as the leader for
leader-sampling, because it doesn't have any samples of its own. To support
leader-sampling with AUX area events, use the 2nd event of the group as the
"leader" for the purposes of leader-sampling.

Example:

 # perf record --kcore --aux-sample -e '{intel_pt//,cycles,instructions}:S' -c 10000 uname
 [ perf record: Woken up 3 times to write data ]
 [ perf record: Captured and wrote 0.786 MB perf.data ]
 # perf report
 Samples: 380  of events 'anon group { cycles, instructions }', Event count (approx.): 3026164
           Children              Self  Command  Shared Object      Symbol
 +   38.76%  42.65%     0.00%   0.00%  uname    [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
 +   35.82%  31.33%     0.00%   0.00%  uname    ld-2.28.so         [.] _dl_start_user
 +   34.29%  29.74%     0.55%   0.47%  uname    ld-2.28.so         [.] _dl_start
 +   33.73%  28.62%     1.60%   0.97%  uname    ld-2.28.so         [.] dl_main
 +   33.19%  29.04%     0.52%   0.32%  uname    ld-2.28.so         [.] _dl_sysdep_start
 +   27.83%  33.74%     0.00%   0.00%  uname    [kernel.kallsyms]  [k] do_syscall_64
 +   26.76%  33.29%     0.00%   0.00%  uname    [kernel.kallsyms]  [k] entry_SYSCALL_64_after_hwframe
 +   23.78%  20.33%     5.97%   5.25%  uname    [kernel.kallsyms]  [k] page_fault
 +   23.18%  24.60%     0.00%   0.00%  uname    libc-2.28.so       [.] __libc_start_main
 +   22.64%  24.37%     0.00%   0.00%  uname    uname              [.] _start
 +   21.04%  23.27%     0.00%   0.00%  uname    uname              [.] main
 +   19.48%  18.08%     3.72%   3.64%  uname    ld-2.28.so         [.] _dl_relocate_object
 +   19.47%  21.81%     0.00%   0.00%  uname    libc-2.28.so       [.] setlocale
 +   19.44%  21.56%     0.52%   0.61%  uname    libc-2.28.so       [.] _nl_find_locale
 +   17.87%  19.66%     0.00%   0.00%  uname    libc-2.28.so       [.] _nl_load_locale_from_archive
 +   15.71%  13.73%     0.53%   0.52%  uname    [kernel.kallsyms]  [k] do_page_fault
 +   15.18%  13.21%     1.03%   0.68%  uname    [kernel.kallsyms]  [k] handle_mm_fault
 +   14.15%  12.53%     1.01%   1.12%  uname    [kernel.kallsyms]  [k] __handle_mm_fault
 +   12.03%   9.67%     0.54%   0.32%  uname    ld-2.28.so         [.] _dl_map_object
 +   10.55%   8.48%     0.00%   0.00%  uname    ld-2.28.so         [.] openaux
 +   10.55%  20.20%     0.52%   0.61%  uname    libc-2.28.so       [.] __run_exit_handlers

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-list.txt |  3 ++
 tools/perf/util/record.c               | 43 +++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 6345db33c533..cb23667531ab 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -258,6 +258,9 @@ Normally all events in an event group sample, but with :S only
 the first event (the leader) samples, and it only reads the values of the
 other events in the group.
 
+However, in the case AUX area events (e.g. Intel PT or CoreSight), the AUX
+area event must be the leader, so then the second event samples, not the first.
+
 OPTIONS
 -------
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 924c58b3fc36..6d3e3df6e2a1 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -167,17 +167,46 @@ bool perf_can_aux_sample(void)
 	return true;
 }
 
-static void perf_evsel__config_leader_sampling(struct evsel *evsel)
+/*
+ * perf_evsel__config_leader_sampling() uses special rules for leader sampling.
+ * However, if the leader is an AUX area event, then assume the event to sample
+ * is the next event.
+ */
+static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
+					      struct evlist *evlist)
+{
+	struct evsel *leader = evsel->leader;
+
+	if (perf_evsel__is_aux_event(leader)) {
+		evlist__for_each_entry(evlist, evsel) {
+			if (evsel->leader == leader && evsel != evsel->leader)
+				return evsel;
+		}
+	}
+
+	return leader;
+}
+
+static void perf_evsel__config_leader_sampling(struct evsel *evsel,
+					       struct evlist *evlist)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
+	struct evsel *read_sampler;
+
+	if (!leader->sample_read)
+		return;
+
+	read_sampler = perf_evsel__read_sampler(evsel, evlist);
 
-	if (leader == evsel || !leader->sample_read)
+	if (evsel == read_sampler)
 		return;
 
 	/*
-	 * Disable sampling for all group members other
-	 * than leader in case leader 'leads' the sampling.
+	 * Disable sampling for all group members other than the leader in
+	 * case the leader 'leads' the sampling, except when the leader is an
+	 * AUX area event, in which case the 2nd event in the group is the one
+	 * that 'leads' the sampling.
 	 */
 	attr->freq           = 0;
 	attr->sample_freq    = 0;
@@ -188,8 +217,12 @@ static void perf_evsel__config_leader_sampling(struct evsel *evsel)
 	 * We don't get a sample for slave events, we make them when delivering
 	 * the group leader sample. Set the slave event to follow the master
 	 * sample_type to ease up reporting.
+	 * An AUX area event also has sample_type requirements, so also include
+	 * the sample type bits from the leader's sample_type to cover that
+	 * case.
 	 */
-	attr->sample_type = leader->core.attr.sample_type;
+	attr->sample_type = read_sampler->core.attr.sample_type |
+			    leader->core.attr.sample_type;
 }
 
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
-- 
2.17.1

