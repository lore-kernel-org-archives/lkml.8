Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17ACC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DBB2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F/7cIlwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgHZLtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:49:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbgHZLsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:48:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QBWVUD027720;
        Wed, 26 Aug 2020 07:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=9yOlRrvt+jXe2hijORro92DQijLsOll6jL1QLjbaH1o=;
 b=F/7cIlwicmoWlO0j0NyzN4AEswxClsk5B+rGjscTdIUItMdLK71uBW4J3N+V6pCUUjhS
 YIwcpgDyn5aiWIov92SDo1UCxX6vGoIe15udM99teLVHY+Mgb4n9BFizv56Fx2BWLDE+
 3i6X7VxJPqLg93SY2EDbmOSclWlnQ9mbzS2B/q5QU1KJ3VLKZX18mBUZcB68d8S4KEw6
 JaF9sFwffUIkFWjAXQUHpti8vRrYh2kT+lWa5asmObL+zkGJPOiqCnsaRkaE6r4ki30P
 E3x/s/hfRceaUzDHvPlpcK+622VGOKBjOZdrzWrBWFpBQw3h1oMX9yMsFxL6OfteBq5N Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335mwhcatr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:48:35 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QBXKes030390;
        Wed, 26 Aug 2020 07:48:35 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335mwhcasr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 07:48:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QBgAHE022975;
        Wed, 26 Aug 2020 11:48:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujkvgyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 11:48:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QBmUq030277994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:48:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 210A052050;
        Wed, 26 Aug 2020 11:48:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C409052051;
        Wed, 26 Aug 2020 11:48:29 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, irogers@google.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Perf test 67 address sanitizer issue
Date:   Wed, 26 Aug 2020 13:48:23 +0200
Message-Id: <20200826114823.58907-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_08:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 -> V2: Added Fixes tag and Acked-by statement, changed title
          and added Ian Rogers email.

Linux 5.9 introduced perf test case "Parse and process metrics" and
on s390 this test case always dumps core:

[root@t35lp67 perf]# ./perf test -vvvv -F 67
67: Parse and process metrics                             :
--- start ---
metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
parsing metric: inst_retired.any / cpu_clk_unhalted.thread
Segmentation fault (core dumped)
[root@t35lp67 perf]#

I debugged this core dump and gdb shows this call chain:

(gdb) where
 #0  0x000003ffabc3192a in __strnlen_c_1 () from /lib64/libc.so.6
 #1  0x000003ffabc293de in strcasestr () from /lib64/libc.so.6
 #2  0x0000000001102ba2 in match_metric(list=0x1e6ea20 "inst_retired.any",
          n=<optimized out>)
     at util/metricgroup.c:368
 #3  find_metric (map=<optimized out>, map=<optimized out>,
         metric=0x1e6ea20 "inst_retired.any")
    at util/metricgroup.c:765
 #4  __resolve_metric (ids=0x0, map=<optimized out>, metric_list=0x0,
         metric_no_group=<optimized out>, m=<optimized out>)
    at util/metricgroup.c:844
 #5  resolve_metric (ids=0x0, map=0x0, metric_list=0x0,
        metric_no_group=<optimized out>)
    at util/metricgroup.c:881
 #6  metricgroup__add_metric (metric=<optimized out>,
      metric_no_group=metric_no_group@entry=false, events=<optimized out>,
      events@entry=0x3ffd84fb878, metric_list=0x0,
      metric_list@entry=0x3ffd84fb868, map=0x0)
    at util/metricgroup.c:943
 #7  0x00000000011034ae in metricgroup__add_metric_list (map=0x13f9828 <map>,
      metric_list=0x3ffd84fb868, events=0x3ffd84fb878,
      metric_no_group=<optimized out>, list=<optimized out>)
    at util/metricgroup.c:988
 #8  parse_groups (perf_evlist=perf_evlist@entry=0x1e70260,
        str=str@entry=0x12f34b2 "IPC", metric_no_group=<optimized out>,
        metric_no_merge=<optimized out>,
        fake_pmu=fake_pmu@entry=0x1462f18 <perf_pmu.fake>,
        metric_events=0x3ffd84fba58, map=0x1)
    at util/metricgroup.c:1040
 #9  0x0000000001103eb2 in metricgroup__parse_groups_test(
	evlist=evlist@entry=0x1e70260, map=map@entry=0x13f9828 <map>,
	str=str@entry=0x12f34b2 "IPC",
	metric_no_group=metric_no_group@entry=false,
	metric_no_merge=metric_no_merge@entry=false,
	metric_events=0x3ffd84fba58)
    at util/metricgroup.c:1082
 #10 0x00000000010c84d8 in __compute_metric (ratio2=0x0, name2=0x0,
        ratio1=<synthetic pointer>, name1=0x12f34b2 "IPC",
	vals=0x3ffd84fbad8, name=0x12f34b2 "IPC")
    at tests/parse-metric.c:159
 #11 compute_metric (ratio=<synthetic pointer>, vals=0x3ffd84fbad8,
	name=0x12f34b2 "IPC")
    at tests/parse-metric.c:189
 #12 test_ipc () at tests/parse-metric.c:208
.....
..... omitted many more lines

This test case was added with
commit 218ca91df477 ("perf tests: Add parse metric test for frontend metric").

When I compile with make DEBUG=y it works fine and I do not get a
core dump.
It turned out that the above listed function call chain worked on
a struct pmu_event array which requires a trailing element with zeroes
which was missing. The marco map_for_each_event() loops over that
array tests for members metric_expr/metric_name/metric_group
being non-NULL. Adding this element fixes the issue.

Output after:
  [root@t35lp46 perf]# ./perf test 67
  67: Parse and process metrics                             : Ok
  [root@t35lp46 perf]#

According  to Ian Rogers (complete quoted from his email):
 This also shows up with address sanitizer on all architectures
 (perhaps change the patch title) and perhaps add a "Fixes: <commit>"
 tag.
 =================================================================
 ==4718==ERROR: AddressSanitizer: global-buffer-overflow on address
 0x55c93b4d59e8 at pc 0x55c93a1541e2 bp 0x7ffd24327c60 sp
 0x7ffd24327c58
 READ of size 8 at 0x55c93b4d59e8 thread T0
    #0 0x55c93a1541e1 in find_metric tools/perf/util/metricgroup.c:764:2
    #1 0x55c93a153e6c in __resolve_metric tools/perf/util/metricgroup.c:844:9
    #2 0x55c93a152f18 in resolve_metric tools/perf/util/metricgroup.c:881:9
    #3 0x55c93a1528db in metricgroup__add_metric
 tools/perf/util/metricgroup.c:943:9
    #4 0x55c93a151996 in metricgroup__add_metric_list
 tools/perf/util/metricgroup.c:988:9
    #5 0x55c93a1511b9 in parse_groups tools/perf/util/metricgroup.c:1040:8
    #6 0x55c93a1513e1 in metricgroup__parse_groups_test
 tools/perf/util/metricgroup.c:1082:9
    #7 0x55c93a0108ae in __compute_metric tools/perf/tests/parse-metric.c:159:8
    #8 0x55c93a010744 in compute_metric tools/perf/tests/parse-metric.c:189:9
    #9 0x55c93a00f5ee in test_ipc tools/perf/tests/parse-metric.c:208:2
    #10 0x55c93a00f1e8 in test__parse_metric
 tools/perf/tests/parse-metric.c:345:2
    #11 0x55c939fd7202 in run_test tools/perf/tests/builtin-test.c:410:9
    #12 0x55c939fd6736 in test_and_print tools/perf/tests/builtin-test.c:440:9
    #13 0x55c939fd58c3 in __cmd_test tools/perf/tests/builtin-test.c:661:4
    #14 0x55c939fd4e02 in cmd_test tools/perf/tests/builtin-test.c:807:9
    #15 0x55c939e4763d in run_builtin tools/perf/perf.c:313:11
    #16 0x55c939e46475 in handle_internal_command tools/perf/perf.c:365:8
    #17 0x55c939e4737e in run_argv tools/perf/perf.c:409:2
    #18 0x55c939e45f7e in main tools/perf/perf.c:539:3

 0x55c93b4d59e8 is located 0 bytes to the right of global variable
 'pme_test' defined in 'tools/perf/tests/parse-metric.c:17:25'
 (0x55c93b4d54a0) of size 1352
 SUMMARY: AddressSanitizer: global-buffer-overflow
 tools/perf/util/metricgroup.c:764:2 in find_metric
 Shadow bytes around the buggy address:
   0x0ab9a7692ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x0ab9a7692af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x0ab9a7692b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x0ab9a7692b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x0ab9a7692b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 =>0x0ab9a7692b30: 00 00 00 00 00 00 00 00 00 00 00 00 00[f9]f9 f9
   0x0ab9a7692b40: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
   0x0ab9a7692b50: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
   0x0ab9a7692b60: f9 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
   0x0ab9a7692b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x0ab9a7692b80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 Shadow byte legend (one shadow byte represents 8 application bytes):
   Addressable:           00
   Partially addressable: 01 02 03 04 05 06 07
   Heap left redzone:       fa
   Freed heap region:       fd
   Stack left redzone:      f1
   Stack mid redzone:       f2
   Stack right redzone:     f3
   Stack after return:      f5
   Stack use after scope:   f8
   Global redzone:          f9
   Global init order:       f6
   Poisoned by user:        f7
   Container overflow:      fc
   Array cookie:            ac
   Intra object redzone:    bb
   ASan internal:           fe
   Left alloca redzone:     ca
   Right alloca redzone:    cb
   Shadow gap:              cc
End of quote

Fixes: 0a507af9c681a ("perf tests: Add parse metric test for ipc metric")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-metric.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index fc0838a7abc2..80c71a10999d 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -70,6 +70,11 @@ static struct pmu_event pme_test[] = {
 {
 	.metric_expr	= "1/m3",
 	.metric_name	= "M3",
+},
+{
+	.metric_expr	= NULL,
+	.metric_name	= NULL,
+	.metric_group	= NULL
 }
 };
 
-- 
2.26.2

