Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F6122D2C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgG2Nx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:53:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40454 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgG2Nx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:53:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TDWXnQ044942;
        Wed, 29 Jul 2020 09:53:24 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jqrt03hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 09:53:24 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TDpuZn031806;
        Wed, 29 Jul 2020 13:53:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx556c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 13:53:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06TDrKVM27656604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 13:53:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0590AE051;
        Wed, 29 Jul 2020 13:53:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96F51AE045;
        Wed, 29 Jul 2020 13:53:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jul 2020 13:53:19 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf tests: Fix test 68 zstd compression for s390
Date:   Wed, 29 Jul 2020 15:53:14 +0200
Message-Id: <20200729135314.91281-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_07:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5aa98879efe7 ("s390/cpum_sf: prohibit callchain data collection")
prohibits call graph sampling for hardware events on s390. The
information recorded is out of context and does not match.

On s390 this commit now breaks test case 68
Zstd perf.data compression/decompression.

Therefore omit call graph sampling on s390 in this test.

Output before:
  [root@t35lp46 perf]# ./perf test -Fv 68
  68: Zstd perf.data compression/decompression              :
  --- start ---
  Collecting compressed record file:
  Error:
  cycles: PMU Hardware doesn't support sampling/overflow-interrupts.
                                Try 'perf stat'
  ---- end ----
  Zstd perf.data compression/decompression: FAILED!
  [root@t35lp46 perf]#

Output after:
[root@t35lp46 perf]# ./perf test -Fv 68
  68: Zstd perf.data compression/decompression              :
  --- start ---
  Collecting compressed record file:
  500+0 records in
  500+0 records out
  256000 bytes (256 kB, 250 KiB) copied, 0.00615638 s, 41.6 MB/s
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.004 MB /tmp/perf.data.X3M,
                        compressed (original 0.002 MB, ratio is 3.609) ]
  Checking compressed events stats:
  # compressed : Zstd, level = 1, ratio = 4
        COMPRESSED events:          1
  2ELIFREPh---- end ----
  Zstd perf.data compression/decompression: Ok
  [root@t35lp46 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 63a91ec473bb..045723b3d992 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -12,7 +12,8 @@ skip_if_no_z_record() {
 
 collect_z_record() {
 	echo "Collecting compressed record file:"
-	$perf_tool record -o $trace_file -g -z -F 5000 -- \
+	[[ "$(uname -m)" != s390x ]] && gflag='-g'
+	$perf_tool record -o $trace_file $gflag -z -F 5000 -- \
 		dd count=500 if=/dev/urandom of=/dev/null
 }
 
-- 
2.26.2

