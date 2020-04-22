Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2658CC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6A42098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgDVMWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728522AbgDVMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386FEC08E859;
        Wed, 22 Apr 2020 05:17:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJa-0007gr-E1; Wed, 22 Apr 2020 14:17:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A9A01C02FC;
        Wed, 22 Apr 2020 14:17:18 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:17 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf pmu: Add support for PMU capabilities
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Pavel Gerasimov <pavel.gerasimov@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319202517.23423-2-kan.liang@linux.intel.com>
References: <20200319202517.23423-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158755783766.28353.14559613759688456419.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9fbc61f832ebf432326a90e28184dade05ee34a8
Gitweb:        https://git.kernel.org/tip/9fbc61f832ebf432326a90e28184dade05ee34a8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 19 Mar 2020 13:25:01 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf pmu: Add support for PMU capabilities

The PMU capabilities information, which is located at
/sys/bus/event_source/devices/<dev>/caps, is required by perf tool.  For
example, the max LBR information is required to stitch LBR call stack.

Add perf_pmu__caps_parse() to parse the PMU capabilities information.
The information is stored in a list.

The following patch will store the capabilities information in perf
header.

Committer notes:

Here's an example of such directories and its files in an i5 7th gen
machine:

  [root@seventh ~]# ls -lad /sys/bus/event_source/devices/*/caps
  drwxr-xr-x. 2 root root 0 Apr 14 13:33 /sys/bus/event_source/devices/cpu/caps
  drwxr-xr-x. 2 root root 0 Apr 14 13:33 /sys/bus/event_source/devices/intel_pt/caps
  [root@seventh ~]# ls -la /sys/bus/event_source/devices/intel_pt/caps
  total 0
  drwxr-xr-x. 2 root root    0 Apr 14 13:33 .
  drwxr-xr-x. 5 root root    0 Apr 14 13:12 ..
  -r--r--r--. 1 root root 4096 Apr 16 13:10 cr3_filtering
  -r--r--r--. 1 root root 4096 Apr 16 11:42 cycle_thresholds
  -r--r--r--. 1 root root 4096 Apr 16 13:10 ip_filtering
  -r--r--r--. 1 root root 4096 Apr 16 13:10 max_subleaf
  -r--r--r--. 1 root root 4096 Apr 14 13:33 mtc
  -r--r--r--. 1 root root 4096 Apr 14 13:33 mtc_periods
  -r--r--r--. 1 root root 4096 Apr 16 13:10 num_address_ranges
  -r--r--r--. 1 root root 4096 Apr 16 13:10 output_subsys
  -r--r--r--. 1 root root 4096 Apr 16 13:10 payloads_lip
  -r--r--r--. 1 root root 4096 Apr 16 13:10 power_event_trace
  -r--r--r--. 1 root root 4096 Apr 14 13:33 psb_cyc
  -r--r--r--. 1 root root 4096 Apr 14 13:33 psb_periods
  -r--r--r--. 1 root root 4096 Apr 16 13:10 ptwrite
  -r--r--r--. 1 root root 4096 Apr 16 13:10 single_range_output
  -r--r--r--. 1 root root 4096 Apr 16 12:03 topa_multiple_entries
  -r--r--r--. 1 root root 4096 Apr 16 13:10 topa_output
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/topa_output
  1
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/topa_multiple_entries
  1
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/mtc
  1
  [root@seventh ~]# cat /sys/bus/event_source/devices/intel_pt/caps/power_event_trace
  0
  [root@seventh ~]#

  [root@seventh ~]# ls -la /sys/bus/event_source/devices/cpu/caps/
  total 0
  drwxr-xr-x. 2 root root    0 Apr 14 13:33 .
  drwxr-xr-x. 6 root root    0 Apr 14 13:12 ..
  -r--r--r--. 1 root root 4096 Apr 16 13:10 branches
  -r--r--r--. 1 root root 4096 Apr 14 13:33 max_precise
  -r--r--r--. 1 root root 4096 Apr 16 13:10 pmu_name
  [root@seventh ~]# cat /sys/bus/event_source/devices/cpu/caps/max_precise
  3
  [root@seventh ~]# cat /sys/bus/event_source/devices/cpu/caps/branches
  32
  [root@seventh ~]# cat /sys/bus/event_source/devices/cpu/caps/pmu_name
  skylake
  [root@seventh ~]#

Wow, first time I've heard about
/sys/bus/event_source/devices/cpu/caps/max_precise, I think I'll use it!
:-)

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pavel Gerasimov <pavel.gerasimov@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Link: http://lore.kernel.org/lkml/20200319202517.23423-2-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 82 ++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/pmu.h |  9 +++++-
 2 files changed, 91 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bc912a8..d9f89ed 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -850,6 +850,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
 	list_splice(&format, &pmu->format);
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
@@ -1594,3 +1595,84 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
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
index 5fb3f16..1edd214 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -22,6 +22,12 @@ enum {
 
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
@@ -33,6 +39,7 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 };
 
@@ -107,4 +114,6 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
+int perf_pmu__caps_parse(struct perf_pmu *pmu);
+
 #endif /* __PMU_H */
