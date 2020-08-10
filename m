Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6130FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6C1206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tMkmSa2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgHJGWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:22:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbgHJGWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:22:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A62DCg105479;
        Mon, 10 Aug 2020 02:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=Kf3jn81lbetCtWg+y7bY09xSaa9YPOxAbWPZtFf4uRE=;
 b=tMkmSa2/XS1ndLn4A2eAIzd5yMbpG/54R8hwoLBaO1qWrZkucxCWXpA2RcAmRNv3lOSp
 iPNonODqL5+nOro2xcD3m4z0qvdiib0NTWnN7SjmBEXiYbFtAp4yyqz6fQexMM1y55go
 +0zO2CJXzHEHxNvDr29Nsj2+/jx8WLCkna2kFpnba2FPS4BOX3M4pMLoS8mzje6CO4tk
 llY1pn3jwn5Ph1fJKNIwKjNHpviBlU5Gh0OwcVATJeukZynRI5+P/ogAFHLtn9v5hMlN
 SgN5z0QcRanhQwFiq57v6LqY3AIe4jdvS2y19iuaVbQ5bf/eYtkQCUtkwtsUj++knzHj rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr8k21a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:22:10 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07A62LId106262;
        Mon, 10 Aug 2020 02:22:09 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32sr8k2197-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:22:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07A6KDD1004791;
        Mon, 10 Aug 2020 06:22:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp81x1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 06:22:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07A6Kb7l61014426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 06:20:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B2CA4051;
        Mon, 10 Aug 2020 06:22:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C6F1A4040;
        Mon, 10 Aug 2020 06:22:04 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.20.209])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 06:22:04 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 3/3] perf bench numa: fix benchmark names
Date:   Mon, 10 Aug 2020 08:22:00 +0200
Message-Id: <6b6f2084f132ee8e9203dc7c32f9deb209b87a68.1597004831.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1597004831.git.agordeev@linux.ibm.com>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_02:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 suspectscore=1
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standard benchmark names let users know the tests specifics.
For example "2x1-bw-process" name tells that two processes
one thread each are run and the RAM bandwidth is measured.

Several benchmarks names do not correspond to their actual
running configuration. Fix that and also some whitespace
and comment inconsistencies.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 90639c9..3b4b63f 100644
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
@@ -1779,24 +1778,24 @@ static int run_bench_numa(const char *name, const char **argv)
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
+   { "numa02-bw,",        "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW },
    { "numa02-bw-NOTHP,",  "mem",  "-p",  "1", "-t", "32", "-T",   "32", OPT_BW_NOTHP },
    { "numa01-bw-thread,", "mem",  "-p",  "2", "-t", "16", "-T",  "192", OPT_BW },
    { "numa01-bw-thread-NOTHP,",
-- 
1.8.3.1

