Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1846C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D553D20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgCQLGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:06:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728610AbgCQLGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:06:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7822B3339D68EAD5AD6B;
        Tue, 17 Mar 2020 19:06:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Mar 2020 19:06:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/7] perf jevents: Support test events folder
Date:   Tue, 17 Mar 2020 19:02:14 +0800
Message-ID: <1584442939-8911-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
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

These test events can be used for testing generation of pmu-event tables
and alias creation for any arch.

When running the pmu-events test case, these test events will be used
as the platform-agnostic events, so aliases can be created per-PMU and
validated against known expected values.

To support the test events, add a "testcpu" entry in pmu_events_map[].
The pmu-events test will be able to lookup the events map for "testcpu",
to verify the generated tables against expected values.

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
	.cpuid = "testcpu",
	.version = "v1",
	.type = "core",
	.table = pme_test_cpu,
},
{
	.cpuid = 0,
	.version = 0,
	.type = 0,
	.table = 0,
},
};

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 27b4da80f751..3343ba27271b 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -764,6 +764,19 @@ static void print_mapping_table_suffix(FILE *outfp)
 	fprintf(outfp, "};\n");
 }
 
+static void print_mapping_test_table(FILE *outfp)
+{
+	/*
+	 * Print the terminating, NULL entry.
+	 */
+	fprintf(outfp, "{\n");
+	fprintf(outfp, "\t.cpuid = \"testcpu\",\n");
+	fprintf(outfp, "\t.version = \"v1\",\n");
+	fprintf(outfp, "\t.type = \"core\",\n");
+	fprintf(outfp, "\t.table = pme_test_cpu,\n");
+	fprintf(outfp, "},\n");
+}
+
 static int process_mapfile(FILE *outfp, char *fpath)
 {
 	int n = 16384;
@@ -841,6 +854,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	}
 
 out:
+	print_mapping_test_table(outfp);
 	print_mapping_table_suffix(outfp);
 	fclose(mapfp);
 	free(line);
@@ -1161,6 +1175,22 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	}
 
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
 	if (close_table)
 		print_events_table_suffix(eventsfp);
 
-- 
2.12.3

