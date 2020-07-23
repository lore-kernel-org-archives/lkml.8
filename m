Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E1EC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1199522CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGWRMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:12:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:6620 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbgGWRMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:12:00 -0400
IronPort-SDR: Wl5yuD45WskL4lhuse5VdPaYNT1gMT1iIOG9X70mDuGh1oGGzz7g5VxNUpQFFLAMuKdq3Ax2oV
 LmmfVbrp37/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456880"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456880"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:55 -0700
IronPort-SDR: 5kALMA9XdNjpg2/BQaifeWNnRDX3BVy9b/gZb86aBnEMLegmHDBCT+20QLl1iNnwwlNsNCPjI4
 SE5TvR+2Jt+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904323"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:55 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 13/14] perf, tools, stat: Check Topdown Metric group
Date:   Thu, 23 Jul 2020 10:11:16 -0700
Message-Id: <20200723171117.9918-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The slots event is required in a Topdown Metric group.

Add a check to examine the Topdown Metric group. Error out if there is
no slots event detected.

Only check the group on the platform which using topdown_metric_attrs,
e.g. Ice Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 078ea1485317..9886aef78440 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1441,6 +1441,72 @@ static int topdown_filter_events(const char **attr, char **str, bool use_group)
 	return 0;
 }
 
+/* Event encoding for Topdown Metric events */
+#define TOPDOWN_SLOTS		0x0400
+#define TOPDOWN_RETIRE		0x8000
+#define TOPDOWN_BAD_SPEC	0x8100
+#define TOPDOWN_FE_BOUND	0x8200
+#define TOPDOWN_BE_BOUND	0x8300
+
+static bool is_topdown_metric_event(struct evsel *counter)
+{
+	if (!counter->pmu_name)
+		return false;
+
+	if (strcmp(counter->pmu_name, "cpu"))
+		return false;
+
+	if ((counter->core.attr.config == TOPDOWN_RETIRE) ||
+	    (counter->core.attr.config == TOPDOWN_BAD_SPEC) ||
+	    (counter->core.attr.config == TOPDOWN_FE_BOUND) ||
+	    (counter->core.attr.config == TOPDOWN_BE_BOUND))
+		return true;
+
+	return false;
+}
+
+static bool is_topdown_slots_event(struct evsel *counter)
+{
+	if (!counter->pmu_name)
+		return false;
+
+	if (strcmp(counter->pmu_name, "cpu"))
+		return false;
+
+	if (counter->core.attr.config == TOPDOWN_SLOTS)
+		return true;
+
+	return false;
+}
+
+static bool topdown_check_group_member(void)
+{
+	struct evsel *counter, *leader, *member;
+	bool has_slots;
+
+	if (!pmu_have_event("cpu", topdown_metric_attrs[0]))
+		return true;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		if (!is_topdown_metric_event(counter))
+			continue;
+
+		leader = counter->leader;
+		has_slots = false;
+
+		for_each_group_evsel(member, leader) {
+			if (is_topdown_slots_event(member))
+				has_slots = true;
+			counter = member;
+		}
+
+		if (!has_slots)
+			return false;
+	}
+
+	return true;
+}
+
 __weak bool arch_topdown_check_group(bool *warn)
 {
 	*warn = false;
@@ -2024,6 +2090,12 @@ int cmd_stat(int argc, const char **argv)
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
 	perf_stat__collect_metric_expr(evsel_list);
+
+	if (!topdown_check_group_member()) {
+		fprintf(stderr, "Topdown group must include slots event\n");
+		goto out;
+	}
+
 	perf_stat__init_shadow_stats();
 
 	if (stat_config.csv_sep) {
-- 
2.17.1

