Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9469DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F41B20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHJV2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:28:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:25830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgHJV1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:51 -0400
IronPort-SDR: B0kvFI+9PnIB6B/dfKtKlAaHqfT3zdD0NcHEJIgwzW6FLso/9s68Egtt7KhFfDueLhDbyTUoOb
 OZEhVkk7wIxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665963"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:50 -0700
IronPort-SDR: xMe3jyCZj/joz9f30KU7lgVjPSmutRAkG8MGRq1Gy7ba3vtLUTLSByDpwX+euNo2rXZamPOntI
 Wzj6bQV05laQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196811"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:50 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 10/16] perf mem: Clean up output format
Date:   Mon, 10 Aug 2020 14:24:30 -0700
Message-Id: <20200810212436.8026-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, "--phys-data" is the only option which impacts the output format.
A simple "if else" is enough to handle the option. But there will be
more options added, e.g. "--data-page-size", which also impact the
output format. The code will become too complex to be maintained.

Divide the big printf into several small pieces. Output the specific
piece only if the related option is applied.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 93 ++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 7fb04f41cd99..200ff7c9d7b7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -147,7 +147,7 @@ dump_raw_samples(struct perf_tool *tool,
 {
 	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
 	struct addr_location al;
-	const char *fmt;
+	const char *fmt, *field_sep;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -161,60 +161,41 @@ dump_raw_samples(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
-	if (mem->phys_addr) {
-		if (symbol_conf.field_sep) {
-			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
-			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
-		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
-			      "%s%s:%s\n";
-			symbol_conf.field_sep = " ";
-		}
-
-		printf(fmt,
-			sample->pid,
-			symbol_conf.field_sep,
-			sample->tid,
-			symbol_conf.field_sep,
-			sample->ip,
-			symbol_conf.field_sep,
-			sample->addr,
-			symbol_conf.field_sep,
-			sample->phys_addr,
-			symbol_conf.field_sep,
-			sample->weight,
-			symbol_conf.field_sep,
-			sample->data_src,
-			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-			al.sym ? al.sym->name : "???");
+	field_sep = symbol_conf.field_sep;
+	if (field_sep) {
+		fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s";
 	} else {
-		if (symbol_conf.field_sep) {
-			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
-			      "%s0x%"PRIx64"%s%s:%s\n";
-		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
-			symbol_conf.field_sep = " ";
-		}
+		fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64"%s";
+		symbol_conf.field_sep = " ";
+	}
+	printf(fmt,
+		sample->pid,
+		symbol_conf.field_sep,
+		sample->tid,
+		symbol_conf.field_sep,
+		sample->ip,
+		symbol_conf.field_sep,
+		sample->addr,
+		symbol_conf.field_sep);
 
-		printf(fmt,
-			sample->pid,
-			symbol_conf.field_sep,
-			sample->tid,
-			symbol_conf.field_sep,
-			sample->ip,
-			symbol_conf.field_sep,
-			sample->addr,
-			symbol_conf.field_sep,
-			sample->weight,
-			symbol_conf.field_sep,
-			sample->data_src,
-			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-			al.sym ? al.sym->name : "???");
+	if (mem->phys_addr) {
+		printf("0x%016"PRIx64"%s",
+			sample->phys_addr,
+			symbol_conf.field_sep);
 	}
+
+	if (field_sep)
+		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
+	else
+		fmt = "%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
+
+	printf(fmt,
+		sample->weight,
+		symbol_conf.field_sep,
+		sample->data_src,
+		symbol_conf.field_sep,
+		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+		al.sym ? al.sym->name : "???");
 out_put:
 	addr_location__put(&al);
 	return 0;
@@ -254,10 +235,12 @@ static int report_raw_events(struct perf_mem *mem)
 	if (ret < 0)
 		goto out_delete;
 
+	printf("# PID, TID, IP, ADDR, ");
+
 	if (mem->phys_addr)
-		printf("# PID, TID, IP, ADDR, PHYS ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
-	else
-		printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
+		printf("PHYS ADDR, ");
+
+	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
 
-- 
2.17.1

