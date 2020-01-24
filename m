Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29371C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07607206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgAXOj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:39:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9674 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388988AbgAXOjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5116C6EDBC484FAE0A6D;
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
Subject: [PATCH RFC 5/7] perf pmu: Support matching by sysid
Date:   Fri, 24 Jan 2020 22:35:03 +0800
Message-ID: <1579876505-113251-6-git-send-email-john.garry@huawei.com>
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

Match system or uncore PMU aliases by system id, SYSID.

We use a SYSID read from sysfs or from an env variable to match against
uncore or system PMU events.

For x86, they want to match uncore events with cpuid - this still works
fine for x86 as it would not have system event tables for uncore PMUs.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 105 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 569aba4cec89..4d4fe0c1ae22 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -672,11 +672,78 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 	return cpuid;
 }
 
+static char *get_sysid_str(void)
+{
+	char *buf = NULL;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	FILE *file;
+	int s, i;
+
+	if (!sysfs)
+		return NULL;
+
+	buf = malloc(PATH_MAX);
+	if (!buf) {
+		pr_err("%s alloc failed\n", __func__);
+		return NULL;
+	}
+
+	scnprintf(path, PATH_MAX, "%s/devices/soc0/machine", sysfs);
+
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("fopen failed for file %s\n", path);
+		free(buf);
+		return NULL;
+	}
+
+	if (!fgets(buf, PATH_MAX, file)) {
+		fclose(file);
+		pr_debug("gets failed for file %s\n", path);
+		free(buf);
+		return NULL;
+	}
+	fclose(file);
+
+	/* Remove any whitespace, this could be from ACPI HID */
+	s = strlen(buf);
+	for (i = 0; i < s; i++) {
+		if (buf[i] == ' ') {
+			buf[i] = 0;
+			break;
+		};
+	}
+
+	return buf;
+}
+
+static char *perf_pmu__getsysid(void)
+{
+	char *sysid;
+	static bool printed;
+
+	sysid = getenv("PERF_SYSID");
+	if (sysid)
+		sysid = strdup(sysid);
+
+	if (!sysid)
+		sysid = get_sysid_str();
+	if (!sysid)
+		return NULL;
+
+	if (!printed) {
+		pr_debug("Using SYSID %s\n", sysid);
+		printed = true;
+	}
+	return sysid;
+}
+
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 {
-	struct pmu_events_map *map;
+	struct pmu_events_map *map, *found_map = NULL;
 	char *cpuid = perf_pmu__getcpuid(pmu);
-	int i;
+	char *sysid;
 
 	/* on some platforms which uses cpus map, cpuid can be NULL for
 	 * PMUs other than CORE PMUs.
@@ -684,19 +751,35 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	if (!cpuid)
 		return NULL;
 
-	i = 0;
-	for (;;) {
-		map = &pmu_events_map[i++];
-		if (!map->table) {
-			map = NULL;
-			break;
+	sysid = perf_pmu__getsysid();
+
+	/*
+	 * Match sysid as first perference for uncore/sys PMUs.
+	 *
+	 * x86 uncore events match by cpuid, but we would not have map->socid
+	 * set for that arch (so any matching here would fail for that).
+	 */
+	if (pmu && pmu_is_uncore_or_sys(pmu->name) &&
+	    !is_arm_pmu_core(pmu->name) && sysid) {
+		for (map = &pmu_events_map[0]; map->table; map++) {
+			if (map->sysid && !strcmp(map->sysid, sysid)) {
+				found_map = map;
+				goto out;
+			}
 		}
+	}
 
-		if (!strcmp_cpuid_str(map->cpuid, cpuid))
-			break;
+	for (map = &pmu_events_map[0]; map->table; map++) {
+		if (map->cpuid && cpuid &&
+		    !strcmp_cpuid_str(map->cpuid, cpuid)) {
+			found_map = map;
+			goto out;
+		}
 	}
+out:
 	free(cpuid);
-	return map;
+	free(sysid); /* Can safely handle is sysid is NULL */
+	return found_map;
 }
 
 static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
-- 
2.17.1

