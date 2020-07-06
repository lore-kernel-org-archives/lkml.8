Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A180AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CCD2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgGFJnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:43:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728024AbgGFJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:43:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0669XfAA041117;
        Mon, 6 Jul 2020 05:43:08 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 322pakvy66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 05:43:07 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0669bJG4021313;
        Mon, 6 Jul 2020 09:43:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h24gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 09:43:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0669h2V13342656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 09:43:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B72265204E;
        Mon,  6 Jul 2020 09:43:02 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.151.4])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 69EF152052;
        Mon,  6 Jul 2020 09:43:02 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/3] perf bench numa: fix benchmark names
Date:   Mon,  6 Jul 2020 11:42:53 +0200
Message-Id: <e4c639c4ad7f77d47ed46dfc28ec213ff83de5da.1594028311.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1594028310.git.agordeev@linux.ibm.com>
References: <cover.1594028310.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_07:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=1 mlxlogscore=999 adultscore=0 clxscore=1015 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several benchmarks have names that do not correspond to
their configuration. Fix that and also some whitespace
inconsistencies.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 23e224e..6574004 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -812,12 +812,12 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
 			}
 		}
 	} else if (!g->p.data_backwards || (nr + loop) & 1) {
+		/* Process data forwards: */
 
 		d0 = data + off;
 		d  = data + off + 1;
 		d1 = data + words;
 
-		/* Process data forwards: */
 		for (;;) {
 			if (unlikely(d >= d1))
 				d = data;
@@ -835,7 +835,6 @@ static u64 do_work(u8 *__data, long bytes, int nr, int nr_max, int loop, u64 val
 		d  = data + off - 1;
 		d1 = data + words;
 
-		/* Process data forwards: */
 		for (;;) {
 			if (unlikely(d < data))
 				d = data + words-1;
@@ -1732,12 +1731,12 @@ static int run_bench_numa(const char *name, const char **argv)
  */
 static const char *tests[][MAX_ARGS] = {
    /* Basic single-stream NUMA bandwidth measurements: */
-   { "RAM-bw-local,",	  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
+   { "RAM-bw-local,",     "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
 			  "-C" ,   "0", "-M",   "0", OPT_BW_RAM },
    { "RAM-bw-local-NOTHP,",
 			  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
 			  "-C" ,   "0", "-M",   "0", OPT_BW_RAM_NOTHP },
-   { "RAM-bw-remote,",	  "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
+   { "RAM-bw-remote,",    "mem",  "-p",  "1",  "-t",  "1", "-P", "1024",
 			  "-C" ,   "0", "-M",   "1", OPT_BW_RAM },
 
    /* 2-stream NUMA bandwidth measurements: */
@@ -1779,27 +1778,28 @@ static int run_bench_numa(const char *name, const char **argv)
 			  "mem",  "-p",  "8", "-t",  "1", "-P", " 512", OPT_BW_NOTHP },
    { "16x1-bw-process,",  "mem",  "-p", "16", "-t",  "1", "-P",  "256", OPT_BW },
 
-   { " 4x1-bw-thread,",	  "mem",  "-p",  "1", "-t",  "4", "-T",  "256", OPT_BW },
-   { " 8x1-bw-thread,",	  "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
-   { "16x1-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
-   { "32x1-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
+   { " 1x4-bw-thread,",   "mem",  "-p",  "1", "-t",  "4", "-T",  "256", OPT_BW },
+   { " 1x8-bw-thread,",   "mem",  "-p",  "1", "-t",  "8", "-T",  "256", OPT_BW },
+   { "1x16-bw-thread,",   "mem",  "-p",  "1", "-t", "16", "-T",  "128", OPT_BW },
+   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "64", OPT_BW },
 
-   { " 2x3-bw-thread,",	  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
-   { " 4x4-bw-thread,",	  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
-   { " 4x6-bw-thread,",	  "mem",  "-p",  "4", "-t",  "6", "-P",  "512", OPT_BW },
-   { " 4x8-bw-thread,",	  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW },
-   { " 4x8-bw-thread-NOTHP,",
+   { " 2x3-bw-process,",  "mem",  "-p",  "2", "-t",  "3", "-P",  "512", OPT_BW },
+   { " 4x4-bw-process,",  "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_BW },
+   { " 4x6-bw-process,",  "mem",  "-p",  "4", "-t",  "6", "-P",  "512", OPT_BW },
+   { " 4x8-bw-process,",  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW },
+   { " 4x8-bw-process-NOTHP,",
 			  "mem",  "-p",  "4", "-t",  "8", "-P",  "512", OPT_BW_NOTHP },
-   { " 3x3-bw-thread,",	  "mem",  "-p",  "3", "-t",  "3", "-P",  "512", OPT_BW },
-   { " 5x5-bw-thread,",	  "mem",  "-p",  "5", "-t",  "5", "-P",  "512", OPT_BW },
+   { " 3x3-bw-process,",  "mem",  "-p",  "3", "-t",  "3", "-P",  "512", OPT_BW },
+   { " 5x5-bw-process,",  "mem",  "-p",  "5", "-t",  "5", "-P",  "512", OPT_BW },
 
-   { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
-   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
+   { "2x16-bw-process,",  "mem",  "-p",  "2", "-t", "16", "-P",  "512", OPT_BW },
+   { "1x32-bw-process,",  "mem",  "-p",  "1", "-t", "32", "-P", "2048", OPT_BW },
 
-   { "numa02-bw,",	  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
-   { "numa02-bw-NOTHP,",  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
-   { "numa01-bw-thread,", "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
-   { "numa01-bw-thread-NOTHP,",
+   { "1x32-bw-thread,",   "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
+   { "1x32-bw-thread-NOTHP,",
+			  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
+   { "2x16-bw-thread,",   "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
+   { "2x16-bw-thread-NOTHP,",
 			  "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW_NOTHP },
 };
 
-- 
1.8.3.1

