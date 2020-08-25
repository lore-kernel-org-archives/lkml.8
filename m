Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6144CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E92E2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SV98I55Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgHYHMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:12:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729257AbgHYHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:12:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P73PGK100642;
        Tue, 25 Aug 2020 03:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=sYosxN51CEmg+dGQbyjxfkrZUljrMe1CwaWY76iyDeg=;
 b=SV98I55YIJZTIGLb427ewuauYWw/Rl/EEFb6DKK3E7svRbL06knYIVaOOWsm1t89B1hD
 Xottc7EnhCC+DiuaOkVjiHFJqxRC5cqrDBUtSwrzhVCmm6JIW3Hz4ZBkV0IbwuNRJcST
 rF7THJ+vTJE/eBON6/EPXCwhir6mu2ETf6I+1aco6H0iaLjg+mnVD+pxpcEGOccqgUVM
 +BNjM2jDvPDe1qpMeZPLc8o8Qftr4PkAjs2YR9D3Xa9+04rWX5iJOhVmepHp4zdXCtdK
 JPSy81T6BXPwoBXExEFFryQH2TIB77ITxO1Dvy+JPIlkYZ/HXh5fe6bnECbAyK4Y6Nwx yw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334vr2t4gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 03:12:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P7419w002220;
        Tue, 25 Aug 2020 07:12:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 332ujjsx2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 07:12:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P7CLkN27853218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 07:12:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA76552054;
        Tue, 25 Aug 2020 07:12:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7DD5F5204E;
        Tue, 25 Aug 2020 07:12:21 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Perf test 67 dumps core on s390
Date:   Tue, 25 Aug 2020 09:12:11 +0200
Message-Id: <20200825071211.16959-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
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

