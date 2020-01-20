Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08975C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E1221835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgATNgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:36:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgATNgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:36:03 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KDIelB113894
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:20:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmfyxsmq7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:20:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 20 Jan 2020 13:20:20 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 13:20:18 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KDKHlq60293158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 13:20:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C92BA405F;
        Mon, 20 Jan 2020 13:20:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0A0A4054;
        Mon, 20 Jan 2020 13:20:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 13:20:16 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Fix test case Merge cpu map
Date:   Mon, 20 Jan 2020 14:20:09 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20012013-0012-0000-0000-0000037F0F8E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012013-0013-0000-0000-000021BB4C7D
Message-Id: <20200120132011.64698-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=2
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2: Added Reviewed-by statement

Commit a2408a70368a ("perf evlist: Maintain evlist->all_cpus")
introduces a test case for cpumap merge operation, see functions
perf_cpu_map__merge() and test__cpu_map_merge().

The test case fails on s390 with this error message:
 [root@m35lp76 perf]# ./perf test -Fvvvvv 52
 52: Merge cpu map                                         :
 --- start ---
 cpumask list: 1-2,4-5,7
 perf: /root/linux/tools/include/linux/refcount.h:131:\
          refcount_sub_and_test: Assertion `!(new > val)' failed.
 Aborted (core dumped)
 [root@m35lp76 perf]#

The root cause is in the function test__cpu_map_merge():
It creates two cpu_maps named 'a' and 'b':

  struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
  struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");

and creates a third map named 'c' which is the result of
the merge of maps a and b:

  struct perf_cpu_map *c = perf_cpu_map__merge(a, b);

After some verifaction of the merged cpu_map all three
of them are have their reference count reduced and are
freed:

   perf_cpu_map__put(a); (1)
   perf_cpu_map__put(b);
   perf_cpu_map__put(c);

The release of perf_cpu_map__put(a) is wrong. The map
is already released and free'ed as part of the function

  perf_cpu_map__merge(struct perf_cpu_map *orig,
  |	              struct perf_cpu_map *other)
  +--> perf_cpu_map__put(orig);
       |
       +--> cpu_map__delete(orig)

At the end perf_cpu_map_put() is called for map 'orig'
alias 'a' and since the reference count is 1, the map
is deleted, as can be seen by the following gdb trace:

 (gdb) where
 #0  tcache_put (tc_idx=0, chunk=0x156cc30) at malloc.c:2940
 #1  _int_free (av=0x3fffd49ee80 <main_arena>, p=0x156cc30,
		     have_lock=<optimized out>) at malloc.c:4222
 #2  0x00000000012d5e78 in cpu_map__delete (map=0x156cc40) at cpumap.c:31
 #3  0x00000000012d5f7a in perf_cpu_map__put (map=0x156cc40) at cpumap.c:45
 #4  0x00000000012d723a in perf_cpu_map__merge (orig=0x156cc40,
     other=0x156cc60) at cpumap.c:343
 #5  0x000000000110cdd0 in test__cpu_map_merge (
     test=0x14ea6c8 <generic_tests+2856>, subtest=-1) at tests/cpumap.c:128

Thus the perf_cpu_map__put(a) (see (1) above) frees map 'a'
a second time and causes the failure. Fix this be removing that
function call.

Output after:
  [root@m35lp76 perf]# ./perf test -Fvvvvv 52
  52: Merge cpu map                                         :
  --- start ---
  cpumask list: 1-2,4-5,7
  ---- end ----
  Merge cpu map: Ok
  [root@m35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/tests/cpumap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 4ac56741ac5f..29c793ac7d10 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -131,7 +131,6 @@ int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
-	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
 	return 0;
-- 
2.21.0

