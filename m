Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40508C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E5F207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbgEYG6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:58:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:17380 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388630AbgEYG6G (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:58:06 -0400
IronPort-SDR: Qrwc2lJ9Tp12npd9hlTZ8kpGXZVPcQSg0hQCdeYB4SjrvZfV2M2pisJg09czcCZIk+xEDNUQ3A
 RLckHf1AxW9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 23:58:05 -0700
IronPort-SDR: SkvYm8hOeYu084Q+soLT1iY12dH2RNgQqPD7yZgtrQLOFcXepIAeh3vtZsHKNZR+adSgSYBCMR
 T49n9DB4AP2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="290784910"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2020 23:58:02 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu map
Date:   Mon, 25 May 2020 14:55:58 +0800
Message-Id: <20200525065559.6422-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric may consist of core event and uncore event (or other
per-socket event)

For example, the metric "C2_Pkg_Residency" consists of
"cstate_pkg/c2-residency" and "msr/tsc". The former is per-socket
event and the latter is per-cpu event.

"C2_Pkg_Residency" hits assertion failure on cascadelakex.

 # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
 perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
 Aborted

The root cause is one issue in get_group_fd(), access violation!

For a group mixed with per-socket event and per-cpu event and the
group leader is per-socket event, access violation will happen.

perf_evsel__alloc_fd allocates one FD member for per-socket event.
Only FD(evsel, 0, 0) is valid (suppose one-socket system).

But for per-cpu event, perf_evsel__alloc_fd allocates N FD members
(N = ncpus). For example, if ncpus is 8, FD(evsel, 0, 0) to
FD(evsel, 7, 0) are valid.

get_group_fd(struct evsel *evsel, int cpu, int thread)
{
       struct evsel *leader = evsel->leader;

       fd = FD(leader, cpu, thread);    /* access violation */
}

If leader is per-socket event, only FD(leader, 0, 0) is valid.
So when get_group_fd tries to access FD(leader, 1, 0), access
violation will happen.

This patch ensures that the grouped events with same cpu maps
before we go to get_group_fd.

If the cpu maps are not matched, we force to disable the group.

 v2:
 ---
 Process for the cases such as -e '{A,B}','{C,D,E}',F.

Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-stat.c |  3 +++
 tools/perf/util/evlist.c  | 49 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h  |  5 ++++
 3 files changed, 57 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 377e575f9645..5be1f9048a01 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -584,6 +584,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
+	if (!evlist__cpus_map_matched(evsel_list))
+		evlist__force_disable_group(evsel_list);
+
 	evlist__for_each_cpu (evsel_list, i, cpu) {
 		affinity__set(&affinity, cpu);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2a9de6491700..1161cffc0688 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1704,3 +1704,52 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	}
 	return leader;
 }
+
+static bool cpus_map_matched(struct evsel *prev, struct evsel *evsel)
+{
+	if (evsel->core.cpus->nr != prev->core.cpus->nr)
+		return false;
+
+	for (int i = 0; i < evsel->core.cpus->nr; i++) {
+		if (evsel->core.cpus->map[i] != prev->core.cpus->map[i])
+			return false;
+	}
+
+	return true;
+}
+
+bool evlist__cpus_map_matched(struct evlist *evlist)
+{
+	struct evsel *prev = evlist__first(evlist), *evsel = prev;
+	int nr_members = prev->core.nr_members;
+
+	evlist__for_each_entry_continue(evlist, evsel) {
+		if (nr_members <= 1) {
+			prev = evsel;
+			nr_members = evsel->core.nr_members;
+			continue;
+		}
+
+		nr_members--;
+
+		if (!cpus_map_matched(prev, evsel))
+			return false;
+
+		prev = evsel;
+	}
+
+	return true;
+}
+
+void evlist__force_disable_group(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	pr_warning("WARNING: event cpu maps are not fully matched, "
+		   "stop event grouping\n");
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->leader = evsel;
+		evsel->core.nr_members = 0;
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b6f325dfb4d2..b09c3fb2cad7 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -355,4 +355,9 @@ void perf_evlist__force_leader(struct evlist *evlist);
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
 						 struct evsel *evsel,
 						bool close);
+
+bool evlist__cpus_map_matched(struct evlist *evlist);
+
+void evlist__force_disable_group(struct evlist *evlist);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.17.1

