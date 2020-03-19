Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BD7C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6012137B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgCSONB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:13:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60890 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgCSOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsp-0002AN-LS; Thu, 19 Mar 2020 15:10:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D9781C22AC;
        Thu, 19 Mar 2020 15:10:48 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:48 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events s390: Add new deflate counters
 for IBM z15
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200310142937.32045-1-tmricht@linux.ibm.com>
References: <20200310142937.32045-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158462704825.28353.9911538394750476383.tip-bot2@tip-bot2>
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

Commit-ID:     e7950166e40271c025e0eec348cdf5c63ac734fa
Gitweb:        https://git.kernel.org/tip/e7950166e40271c025e0eec348cdf5c63ac734fa
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Tue, 10 Mar 2020 15:29:37 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Mar 2020 11:40:21 -03:00

perf vendor events s390: Add new deflate counters for IBM z15

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
 tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json  |  8 +--
 tools/perf/pmu-events/arch/s390/cf_z15/extended.json | 30 ++++++++++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
index 5e36bc2..c998e4f 100644
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
index 89e0707..2df2e23 100644
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
@@ -358,6 +358,34 @@
 	},
 	{
 		"Unit": "CPU-M-CF",
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
+	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "448",
 		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
 		"BriefDescription": "Cycle count with one thread active",
