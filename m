Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898A4C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3772072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCSU2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:28:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:60493 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSU2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:28:47 -0400
IronPort-SDR: WzIKhnBdUcW3V67zmZOlegRmXJOKR/jzeUTUK1ghKgua/TOBYTxaN07icUxVbMfg0eV1625EmD
 1sUPYcT5+AqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 13:28:47 -0700
IronPort-SDR: WIbqsNo/FcX73rWaKX1Am8ZiyCPEXOGM8TKCcLWEaDrxy/+ccd3zt6Xr4lgbCJPJBgXxN1hCVC
 NVxon2uPuKeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="239031203"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2020 13:28:47 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 01/17] perf pmu: Add support for PMU capabilities
Date:   Thu, 19 Mar 2020 13:25:01 -0700
Message-Id: <20200319202517.23423-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319202517.23423-1-kan.liang@linux.intel.com>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The PMU capabilities information, which is located at
/sys/bus/event_source/devices/<dev>/caps, is required by perf tool.
For example, the max LBR information is required to stitch LBR call
stack.

Add perf_pmu__caps_parse() to parse the PMU capabilities information.
The information is stored in a list.

The following patch will store the capabilities information in perf
header.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 82 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  9 +++++
 2 files changed, 91 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b99fd312aae..b3b975ad2ea2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -844,6 +844,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
@@ -1565,3 +1566,84 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 	va_end(args);
 	return ret;
 }
+
+static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
+{
+	struct perf_pmu_caps *caps = zalloc(sizeof(*caps));
+
+	if (!caps)
+		return -ENOMEM;
+
+	caps->name = strdup(name);
+	if (!caps->name)
+		goto free_caps;
+	caps->value = strndup(value, strlen(value) - 1);
+	if (!caps->value)
+		goto free_name;
+	list_add_tail(&caps->list, list);
+	return 0;
+
+free_name:
+	zfree(caps->name);
+free_caps:
+	free(caps);
+
+	return -ENOMEM;
+}
+
+/*
+ * Reading/parsing the given pmu capabilities, which should be located at:
+ * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
+ * Return the number of capabilities
+ */
+int perf_pmu__caps_parse(struct perf_pmu *pmu)
+{
+	struct stat st;
+	char caps_path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	DIR *caps_dir;
+	struct dirent *evt_ent;
+	int nr_caps = 0;
+
+	if (!sysfs)
+		return -1;
+
+	snprintf(caps_path, PATH_MAX,
+		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
+
+	if (stat(caps_path, &st) < 0)
+		return 0;	/* no error if caps does not exist */
+
+	caps_dir = opendir(caps_path);
+	if (!caps_dir)
+		return -EINVAL;
+
+	while ((evt_ent = readdir(caps_dir)) != NULL) {
+		char path[PATH_MAX + NAME_MAX + 1];
+		char *name = evt_ent->d_name;
+		char value[128];
+		FILE *file;
+
+		if (!strcmp(name, ".") || !strcmp(name, ".."))
+			continue;
+
+		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
+
+		file = fopen(path, "r");
+		if (!file)
+			continue;
+
+		if (!fgets(value, sizeof(value), file) ||
+		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
+			fclose(file);
+			continue;
+		}
+
+		nr_caps++;
+		fclose(file);
+	}
+
+	closedir(caps_dir);
+
+	return nr_caps;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6737e3d5d568..854e1b8de746 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -21,6 +21,12 @@ enum {
 
 struct perf_event_attr;
 
+struct perf_pmu_caps {
+	char *name;
+	char *value;
+	struct list_head list;
+};
+
 struct perf_pmu {
 	char *name;
 	__u32 type;
@@ -32,6 +38,7 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 };
 
@@ -102,4 +109,6 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
+int perf_pmu__caps_parse(struct perf_pmu *pmu);
+
 #endif /* __PMU_H */
-- 
2.17.1

