Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52FFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B83B208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 11:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCELMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:12:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbgCELMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:12:35 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 66338FF46DB04497AEBC;
        Thu,  5 Mar 2020 19:12:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 19:12:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 2/6] perf jevents: Support test events folder
Date:   Thu, 5 Mar 2020 19:08:02 +0800
Message-ID: <1583406486-154841-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the goal of supporting pmu-events test case, introduce support for a
test events folder.

These test events can be used for testing alias creation for any arch.

When running the pmu-events test case, these test events will be used
as the platform-agnostic events, so aliases can be created per-PMU and
validated against known expected values.

To support the test events, create a new table of events in generated
pmu-events.c, outside the existing pmu_events_map[] table. The table
of test events will not have any matching against a CPUID.

The resultant generated pmu-events.c will now look like the following:

struct pmu_event pme_ampere_emag[] = {
{
	.name = "ldrex_spec",
	.event = "event=0x6c",
	.desc = "Exclusive operation spe...",
	.topic = "intrinsic",
	.long_desc = "Exclusive operation ...",
},
...
};
struct pmu_events_map pmu_events_map[] = {
...
{
	.cpuid = "0x00000000500f0000",
	.version = "v1",
	.type = "core",
	.table = pme_ampere_emag
},
...
{
	.cpuid = 0,
	.version = 0,
	.type = 0,
	.table = 0,
},
};

struct pmu_event pme_test_cpu[] = {
{
	.name = "uncore_hisi_ddrc.flux_wcmd",
	.event = "event=0x2",
	.desc = "DDRC write commands. Unit: hisi_sccl,ddrc ",
	.topic = "uncore",
	.long_desc = "DDRC write commands",
	.pmu = "hisi_sccl,ddrc",
},
{
	.name = "unc_cbo_xsnp_response.miss_eviction",
	.event = "umask=0x81,event=0x22",
	.desc = "Unit: uncore_cbox A cross-core snoop resulted ...",
	.topic = "uncore",
	.long_desc = "A cross-core snoop resulted from L3 ...",
	.pmu = "uncore_cbox",
},
{
	.name = "eist_trans",
	.event = "umask=0x0,period=200000,event=0x3a",
	.desc = "Number of Enhanced Intel SpeedStep(R) ...",
	.topic = "other",
},
{
	.name = 0,
},
};

struct pmu_events_map pmu_events_map_test = {
	.table = pme_test_cpu,
};

Structure pmu_events_map_test will be used in pmu-events test as the events
to create and validate aliases for.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c    | 46 +++++++++++++++++++++++++++++-
 tools/perf/pmu-events/pmu-events.h |  4 +++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 27b4da80f751..21b7fd83c8b8 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -53,6 +53,8 @@
 int verbose;
 char *prog;
 
+const char *start_dirname;
+
 int eprintf(int level, int var, const char *fmt, ...)
 {
 
@@ -764,6 +766,25 @@ static void print_mapping_table_suffix(FILE *outfp)
 	fprintf(outfp, "};\n");
 }
 
+static void print_test_event_tables_prefix(FILE *outfp)
+{
+	fprintf(outfp, "\nstruct pmu_events_map pmu_events_map_test = {\n");
+}
+
+static void print_test_event_tables_suffix(FILE *outfp)
+{
+	fprintf(outfp, "};\n");
+}
+
+static void process_test_event_tables(FILE *outfp)
+{
+	struct test_event_table *test_event_table;
+
+	print_test_event_tables_prefix(outfp);
+	fprintf(outfp, "\t.table = pme_test_cpu,\n");
+	print_test_event_tables_suffix(outfp);
+}
+
 static int process_mapfile(FILE *outfp, char *fpath)
 {
 	int n = 16384;
@@ -868,6 +889,8 @@ static void create_empty_mapping(const char *output_file)
 	fprintf(outfp, "#include \"pmu-events/pmu-events.h\"\n");
 	print_mapping_table_prefix(outfp);
 	print_mapping_table_suffix(outfp);
+	print_test_event_tables_prefix(outfp);
+	print_test_event_tables_suffix(outfp);
 	fclose(outfp);
 }
 
@@ -1085,9 +1108,9 @@ int main(int argc, char *argv[])
 	int rc, ret = 0;
 	int maxfds;
 	char ldirname[PATH_MAX];
+
 	const char *arch;
 	const char *output_file;
-	const char *start_dirname;
 	struct stat stbuf;
 
 	prog = basename(argv[0]);
@@ -1177,6 +1200,27 @@ int main(int argc, char *argv[])
 		ret = 1;
 	}
 
+	/* walk "test" folder, regardless of the arch */
+	sprintf(ldirname, "%s/test", start_dirname);
+
+	rc = nftw(ldirname, process_one_file, maxfds, 0);
+	if (rc && verbose) {
+		pr_info("%s: Error walking file tree %s rc=%d for test\n",
+			prog, ldirname, rc);
+		goto empty_map;
+	} else if (rc < 0) {
+		/* Make build fail */
+		free_arch_std_events();
+		ret = 1;
+		goto out_free_mapfile;
+	} else if (rc) {
+		goto empty_map;
+	}
+
+	if (close_table)
+		print_events_table_suffix(eventsfp);
+
+	process_test_event_tables(eventsfp);
 
 	goto out_free_mapfile;
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index caeb577d36c9..96fc60a481b1 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -36,10 +36,14 @@ struct pmu_events_map {
 	struct pmu_event *table;
 };
 
+struct pmu_test_events {
+	struct pmu_event *table;
+};
 /*
  * Global table mapping each known CPU for the architecture to its
  * table of PMU events.
  */
 extern struct pmu_events_map pmu_events_map[];
+extern struct pmu_events_map pmu_events_map_test;
 
 #endif
-- 
2.17.1

