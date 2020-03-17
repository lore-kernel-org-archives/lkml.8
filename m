Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC208C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B814920752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480795;
	bh=qdMd3hcyn2K9bK21ctRvEVWI6Hl/LGO+cg4o/b+yBTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sn6YcfrS3CeKgxnwZOtuds45IYNgNdBNCl92AF42f1xPlcqG/4xm3jqxqvPaauM/d
	 iRYJkzCpVFwOgYj9UuMWXxHmc2NxK+n3k1IYE2O6O/tQF9iZtjkIGNB3/MxmlWym88
	 MwQNVEobZ3apu5sYDrThZ1775tvJHzftVJ14w7HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCQVdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQVdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:33:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150F520757;
        Tue, 17 Mar 2020 21:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480792;
        bh=qdMd3hcyn2K9bK21ctRvEVWI6Hl/LGO+cg4o/b+yBTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ma6q2WehU+mK6bwGI+wvDkB2LDN5Am33fisUHO9v0w4hPp5fbMdFHKFmbfq79/kpA
         hKy5zyNsCGuMbsNqLUY0KlL6EBYIuw8TsPbWbPEOl3Y4HsBzg/YUjRi7G+urdv8kcY
         TDf1at+3PTF1kvocIQiEZyJyIQtPpLZ+ALunZGzc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/23] perf vendor events s390: Add new deflate counters for IBM z15
Date:   Tue, 17 Mar 2020 18:32:37 -0300
Message-Id: <20200317213259.15494-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Add support for new deflate counters:

- Counter 247: cycles CPU spent obtaining access to Deflate unit
- Counter 252: cycles CPU is using Deflate unit
- Counter 264: Increments by one for every DEFLATE CONVERSION CALL
	    instruction executed.
- Counter 265: Increments by one for every DEFLATE CONVERSION CALL
	    instruction executed that ended in Condition Codes
	    0, 1 or 2.

Also adjust the some crypto counter description to latest documentation.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200310142937.32045-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/s390/cf_z15/crypto6.json  |  8 ++---
 .../pmu-events/arch/s390/cf_z15/extended.json | 30 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
index 5e36bc2468d0..c998e4f1d1d2 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
@@ -4,27 +4,27 @@
 		"EventCode": "80",
 		"EventName": "ECC_FUNCTION_COUNT",
 		"BriefDescription": "ECC Function Count",
-		"PublicDescription": "Long ECC function Count"
+		"PublicDescription": "This counter counts the total number of the elliptic-curve cryptography (ECC) functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "81",
 		"EventName": "ECC_CYCLES_COUNT",
 		"BriefDescription": "ECC Cycles Count",
-		"PublicDescription": "Long ECC Function cycles count"
+		"PublicDescription": "This counter counts the total number of CPU cycles when the ECC coprocessor is busy performing the elliptic-curve cryptography (ECC) functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "82",
 		"EventName": "ECC_BLOCKED_FUNCTION_COUNT",
 		"BriefDescription": "Ecc Blocked Function Count",
-		"PublicDescription": "Long ECC blocked function count"
+		"PublicDescription": "This counter counts the total number of the elliptic-curve cryptography (ECC) functions that are issued by the CPU and are blocked because the ECC coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "83",
 		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
 		"BriefDescription": "ECC Blocked Cycles Count",
-		"PublicDescription": "Long ECC blocked cycles count"
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the elliptic-curve cryptography (ECC) functions issued by the CPU because the ECC coprocessor is busy performing a function issued by another CPU."
 	},
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
index 89e070727e1b..2df2e231e9ee 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
@@ -25,7 +25,7 @@
 		"EventCode": "131",
 		"EventName": "DTLB2_HPAGE_WRITES",
 		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done"
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page"
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -356,6 +356,34 @@
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
 	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "247",
+		"EventName": "DFLT_ACCESS",
+		"BriefDescription": "Cycles CPU spent obtaining access to Deflate unit",
+		"PublicDescription": "Cycles CPU spent obtaining access to Deflate unit"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "252",
+		"EventName": "DFLT_CYCLES",
+		"BriefDescription": "Cycles CPU is using Deflate unit",
+		"PublicDescription": "Cycles CPU is using Deflate unit"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "264",
+		"EventName": "DFLT_CC",
+		"BriefDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed",
+		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "265",
+		"EventName": "DFLT_CCERROR",
+		"BriefDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2",
+		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2"
+	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "448",
-- 
2.21.1

