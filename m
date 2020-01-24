Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C89C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806DB20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389079AbgAXOjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:39:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388993AbgAXOjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A8E2D5C149B98C0DB21;
        Fri, 24 Jan 2020 22:39:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 Jan 2020 22:38:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <ak@linux.intel.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 4/7] perf pmu: Rename uncore symbols to include system PMUs
Date:   Fri, 24 Jan 2020 22:35:02 +0800
Message-ID: <1579876505-113251-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to expand the perf PMU support to cover system PMUs, which are
essentially the same as uncore pmus (from a kernel sysfs perspective
anyway).

So rename pmu_is_uncore() et al to cover this.

Unfortunately we have no real way to detect if a PMU is uncore or system.
We could check the PMU name for "uncore_" prefix to detect if really uncore,
but this does not work for all uncore PMUs - maybe we should introduce
this kernel naming convention for future support.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/arch/arm64/util/arm-spe.c |  2 +-
 tools/perf/util/evsel.h              |  2 +-
 tools/perf/util/parse-events.c       | 12 ++++++------
 tools/perf/util/pmu.c                |  6 +++---
 tools/perf/util/pmu.h                |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..4241ad6c9fa0 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -223,7 +223,7 @@ struct perf_event_attr
 	}
 
 	arm_spe_pmu->selectable = true;
-	arm_spe_pmu->is_uncore = false;
+	arm_spe_pmu->is_uncore_or_sys = false;
 
 	return attr;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..d583b2a64d93 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -75,7 +75,7 @@ struct evsel {
 	bool			precise_max;
 	bool			ignore_missing_thread;
 	bool			forced_leader;
-	bool			use_uncore_alias;
+	bool			use_uncore_or_system_alias;
 	/* parse modifier helper */
 	int			exclude_GH;
 	int			sample_read;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ed7c008b9c8b..89105d5f0f0b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -367,7 +367,7 @@ __add_event(struct list_head *list, int *idx,
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
-	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
+	evsel->core.system_wide = pmu ? pmu->is_uncore_or_sys : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
 	if (name)
@@ -1404,7 +1404,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu;
 	struct evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
-	bool use_uncore_alias;
+	bool use_uncore_or_system_alias;
 	LIST_HEAD(config_terms);
 
 	pmu = perf_pmu__find(name);
@@ -1425,7 +1425,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		memset(&attr, 0, sizeof(attr));
 	}
 
-	use_uncore_alias = (pmu->is_uncore && use_alias);
+	use_uncore_or_system_alias = (pmu->is_uncore_or_sys && use_alias);
 
 	if (!head_config) {
 		attr.type = pmu->type;
@@ -1433,7 +1433,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 				    auto_merge_stats, NULL);
 		if (evsel) {
 			evsel->pmu_name = name;
-			evsel->use_uncore_alias = use_uncore_alias;
+			evsel->use_uncore_or_system_alias = use_uncore_or_system_alias;
 			return 0;
 		} else {
 			return -ENOMEM;
@@ -1481,7 +1481,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->metric_expr = info.metric_expr;
 		evsel->metric_name = info.metric_name;
 		evsel->pmu_name = name;
-		evsel->use_uncore_alias = use_uncore_alias;
+		evsel->use_uncore_or_system_alias = use_uncore_or_system_alias;
 		evsel->percore = config_term_percore(&evsel->config_terms);
 	}
 
@@ -1598,7 +1598,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	__evlist__for_each_entry(list, evsel) {
 
 		/* Only split the uncore group which members use alias */
-		if (!evsel->use_uncore_alias)
+		if (!evsel->use_uncore_or_system_alias)
 			goto out;
 
 		/* The events must be from the same uncore block */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b99fd312aae..569aba4cec89 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -623,7 +623,7 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 	return NULL;
 }
 
-static bool pmu_is_uncore(const char *name)
+static bool pmu_is_uncore_or_sys(const char *name)
 {
 	char path[PATH_MAX];
 	const char *sysfs;
@@ -769,7 +769,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		if (pmu_is_uncore(name) &&
+		if (pmu_is_uncore_or_sys(name) &&
 		    pmu_uncore_alias_match(pname, name))
 			goto new_alias;
 
@@ -838,7 +838,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->cpus = pmu_cpumask(name);
 	pmu->name = strdup(name);
 	pmu->type = type;
-	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->is_uncore_or_sys = pmu_is_uncore_or_sys(name);
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6737e3d5d568..67cf002c9458 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -25,7 +25,7 @@ struct perf_pmu {
 	char *name;
 	__u32 type;
 	bool selectable;
-	bool is_uncore;
+	bool is_uncore_or_sys;
 	bool auxtrace;
 	int max_precise;
 	struct perf_event_attr *default_config;
-- 
2.17.1

