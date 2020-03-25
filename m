Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B32AC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA4F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140167;
	bh=Sqh0QRnk5ug49LgoDCJo7fAfb5SoaJ8dyxKFQn2IToM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKfR7lD3hwCnQRQMi1EiTMdkxOmY9NCOvIf4OC1tO4OE6s6NII4QjemCdqyhefsA+
	 g/wbS8s45thRz12r0M0AipVspSjTnULzhIymc/taR0SWKoujCb7MyOOCUSqGfkv6Ne
	 4UpNMlHRHqDzZ/HVoUU5ZBU9PxMB0DWMjgFc+hsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCYMmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbgCYMmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206E6207FC;
        Wed, 25 Mar 2020 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140162;
        bh=Sqh0QRnk5ug49LgoDCJo7fAfb5SoaJ8dyxKFQn2IToM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKbLVH2XUHO9gSCU+ZeOYZEVOIl+ZOOX6jcHjUf3gBpF9ISAVeET9WA7LAGWVLlUy
         4jg5kynJzzXuk985E/Lg/ZcGYIOsoojK0fDoCdeKjJ9UNPgwnYyRmbfIBaceLuFu5s
         9AfU5j5ckLXWYRJj3/9jUC7ZPEZDDPw8jhOtPMDA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/24] perf jevents: Support test events folder
Date:   Wed, 25 Mar 2020 09:41:17 -0300
Message-Id: <20200325124124.32648-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

With the goal of supporting pmu-events test case, introduce support for
a test events folder.

These test events can be used for testing generation of pmu-event tables
and alias creation for any arch.

When running the pmu-events test case, these test events will be used as
the platform-agnostic events, so aliases can be created per-PMU and
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-3-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 3c4236a5bad8..fa86c5f997cc 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -771,6 +771,19 @@ static void print_mapping_table_suffix(FILE *outfp)
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
@@ -848,6 +861,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	}
 
 out:
+	print_mapping_test_table(outfp);
 	print_mapping_table_suffix(outfp);
 	fclose(mapfp);
 	free(line);
@@ -1168,6 +1182,22 @@ int main(int argc, char *argv[])
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
2.21.1

