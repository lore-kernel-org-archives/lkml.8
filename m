Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6353EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF422073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGFJoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:44:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgGFJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:44:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0669VvlI071107;
        Mon, 6 Jul 2020 05:44:23 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322p984t1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 05:44:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0669aCHE009890;
        Mon, 6 Jul 2020 09:44:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 322hd825g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 09:44:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0669h37Y63897726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 09:43:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2766452051;
        Mon,  6 Jul 2020 09:43:03 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.151.4])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D0A1E5204F;
        Mon,  6 Jul 2020 09:43:02 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 3/3] perf bench numa: fix wrong benchmark configuration
Date:   Mon,  6 Jul 2020 11:42:54 +0200
Message-Id: <ec0af179404329c21923f6da3f490ae4418efc1f.1594028311.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1594028310.git.agordeev@linux.ibm.com>
References: <cover.1594028310.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_07:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=1 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update fixes a wrong number of processes for one
benchmark and consolidates two others in a unified way.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 6574004..c4b24d8 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -1753,7 +1753,7 @@ static int run_bench_numa(const char *name, const char **argv)
    { " 1x3-convergence,", "mem",  "-p",  "1", "-t",  "3", "-P",  "512", OPT_CONV },
    { " 1x4-convergence,", "mem",  "-p",  "1", "-t",  "4", "-P",  "512", OPT_CONV },
    { " 1x6-convergence,", "mem",  "-p",  "1", "-t",  "6", "-P", "1020", OPT_CONV },
-   { " 2x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
+   { " 2x3-convergence,", "mem",  "-p",  "2", "-t",  "3", "-P", "1020", OPT_CONV },
    { " 3x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
    { " 4x4-convergence,", "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_CONV },
    { " 4x4-convergence-NOTHP,",
@@ -1782,6 +1782,8 @@ static int run_bench_numa(const char *name, const char **argv)
    { " 1x8-bw-thread,",   "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
    { "1x16-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
    { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
+   { "1x32-bw-thread-NOTHP,",
+			  "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW_NOTHP },
 
    { " 2x3-bw-process,",  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
    { " 4x4-bw-process,",  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
@@ -1795,9 +1797,6 @@ static int run_bench_numa(const char *name, const char **argv)
    { "2x16-bw-process,",  "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
    { "1x32-bw-process,",  "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
 
-   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
-   { "1x32-bw-thread-NOTHP,",
-			  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
    { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
    { "2x16-bw-thread-NOTHP,",
 			  "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW_NOTHP },
-- 
1.8.3.1

