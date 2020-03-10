Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D42C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8404227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCJO3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:29:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgCJO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:29:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AEThDp040470
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:29:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ynra49cf1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:29:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Tue, 10 Mar 2020 14:29:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Mar 2020 14:29:46 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02AETivC47710400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 14:29:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC1C24C046;
        Tue, 10 Mar 2020 14:29:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C7A44C04E;
        Tue, 10 Mar 2020 14:29:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Mar 2020 14:29:44 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/s390/json: Add new deflate counters for IBM z15
Date:   Tue, 10 Mar 2020 15:29:37 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20031014-0028-0000-0000-000003E2BE16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031014-0029-0000-0000-000024A7FF48
Message-Id: <20200310142937.32045-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_08:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new deflate counters:
- Counter 247: cycles CPU spent obtaining access to Deflate unit
- Counter 252: cycles CPU is using Deflate unit
- Counter 264: Increments by one for every DEFLATE CONVERSION CALL
	    instruction executed.
- Counter 265: Increments by one for every DEFLATE CONVERSION CALL
	    instruction executed that ended in Condition Codes
	    0, 1 or 2.

Also adjust the some crypto counter description to latest
documentation.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
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
2.23.0

