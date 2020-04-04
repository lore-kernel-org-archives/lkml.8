Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D742720CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgDDInT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:43:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgDDImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNS-0001CP-7i; Sat, 04 Apr 2020 10:42:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFD8D1C081A;
        Sat,  4 Apr 2020 10:41:56 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:56 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf jevents: Support test events folder
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584442939-8911-3-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <158598971644.28353.16674126587372574726.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d84478088780acdecfcf50a0e52b71cc4ab7c520
Gitweb:        https://git.kernel.org/tip/d84478088780acdecfcf50a0e52b71cc4ab7c520
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Tue, 17 Mar 2020 19:02:14 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:59 -03:00

perf jevents: Support test events folder

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
index 3c4236a..fa86c5f 100644
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
 
