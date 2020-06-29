Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75378C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD13204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgF2SqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:46:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728088AbgF2SqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TFZsCK187966;
        Mon, 29 Jun 2020 11:50:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycksfa3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:50:17 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TFa3TW188984;
        Mon, 29 Jun 2020 11:50:17 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ycksfa2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 11:50:17 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TFktZH001146;
        Mon, 29 Jun 2020 15:50:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcgs6hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 15:50:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TFoDIt50921500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 15:50:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37EB6AE045;
        Mon, 29 Jun 2020 15:50:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAF6AAE057;
        Mon, 29 Jun 2020 15:50:12 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.156.24])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Jun 2020 15:50:12 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 2/3] perf bench numa: fix benchmark names
Date:   Mon, 29 Jun 2020 17:50:08 +0200
Message-Id: <aee0cc30c77779673d2c473693cfb7abb3f1de58.1593445668.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593445668.git.agordeev@linux.ibm.com>
References: <cover.1593445668.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_15:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=1
 cotscore=-2147483648 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several benchmarks have names that do not correspond to
their configuration. Fix that and also some whitespace
inconsistencies.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 5497c74..7965a55 100644
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

