Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ABAC433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCFF22D08
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGQOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:07:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:11841 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbgGQOHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:30 -0400
IronPort-SDR: vyBZ3kDviRRuF5jpvco7rseKl0r2ChBUoxDPGEh/sGIwpQ3+/aDww2POCEtIOAZZ4gNygrH1YO
 sAsPCzeJl4yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722826"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:29 -0700
IronPort-SDR: RobGYLJiNl2K7tzjIoMMQyMjaPHO/H1hhH1/E1dyZMN7OXvhHb6f0ZCmVbazqKqKvdWA2Hr3EW
 11hb2+3nu9Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856500"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:29 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 11/14] perf/x86/intel: Disable sample-read the slots and metrics events
Date:   Fri, 17 Jul 2020 07:05:51 -0700
Message-Id: <20200717140554.22863-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Users fail to sample-read the slots and metrics events, e.g.,
perf record -e '{slots, topdown-retiring}:S'.

When reading the metrics event, the fixed counter 3 (slots) has to be
reset, which impacts the sampling of the slots event.

Add a specific validate_group() support to reject the case and error out
for Ice Lake.

An alternative fix may unconditionally disable slots sampling, but it's
not a decent fix. Users may want to only sample the slot events
without the topdown metrics events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  4 ++++
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c25dde095bca..7a4c26b89cbf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2176,7 +2176,11 @@ static int validate_group(struct perf_event *event)
 
 	fake_cpuc->n_events = 0;
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
+	if (ret)
+		goto out;
 
+	if (x86_pmu.validate_group)
+		ret = x86_pmu.validate_group(fake_cpuc, n);
 out:
 	free_fake_cpuc(fake_cpuc);
 	return ret;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dd3d9f3f2162..bcd96d7fb6ec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4576,6 +4576,25 @@ static __init void intel_ht_bug(void)
 	x86_pmu.stop_scheduling = intel_stop_scheduling;
 }
 
+static int icl_validate_group(struct cpu_hw_events *cpuc, int n)
+{
+	bool has_sampling_slots = false, has_metrics = false;
+	struct perf_event *e;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		e = cpuc->event_list[i];
+		if (is_slots_event(e) && is_sampling_event(e))
+			has_sampling_slots = true;
+
+		if (is_metric_event(e))
+			has_metrics = true;
+	}
+	if (unlikely(has_sampling_slots && has_metrics))
+		return -EINVAL;
+	return 0;
+}
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_hsw,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_hsw,	"event=0xd0,umask=0x82")
 
@@ -5437,6 +5456,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		x86_pmu.validate_group = icl_validate_group;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8100c21205e8..acd85baeabd8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -677,6 +677,8 @@ struct x86_pmu {
 	int		perfctr_second_write;
 	u64		(*limit_period)(struct perf_event *event, u64 l);
 
+	int		(*validate_group)(struct cpu_hw_events *cpuc, int n);
+
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
 			enabled_ack		:1,
-- 
2.17.1

