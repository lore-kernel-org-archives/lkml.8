Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA28C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D5A20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgDAUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:35:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733049AbgDAUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:34:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031KYMmL100450
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 16:34:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304sws7mc5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:34:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Wed, 1 Apr 2020 21:34:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 21:34:42 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031KYmuX23462132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 20:34:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A914A4054;
        Wed,  1 Apr 2020 20:34:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 081A2A405B;
        Wed,  1 Apr 2020 20:34:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.38.236])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 20:34:42 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v8 5/7] perf/tests/expr: Added test for runtime param in metric expression
Date:   Thu,  2 Apr 2020 02:03:38 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200401203340.31402-1-kjain@linux.ibm.com>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040120-0012-0000-0000-0000039C7DB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040120-0013-0000-0000-000021D98EE8
Message-Id: <20200401203340.31402-6-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added test case for parsing  "?" in metric expression.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/expr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 516504cf0ea5..f9e8e5628836 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -59,6 +59,14 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
 
+	TEST_ASSERT_VAL("find other",
+			expr__find_other("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@", NULL,
+				   &other, &num_other, 3) == 0);
+	TEST_ASSERT_VAL("find other", num_other == 2);
+	TEST_ASSERT_VAL("find other", !strcmp(other[0], "EVENT1,param=3/"));
+	TEST_ASSERT_VAL("find other", !strcmp(other[1], "EVENT2,param=3/"));
+	TEST_ASSERT_VAL("find other", other[2] == NULL);
+
 	for (i = 0; i < num_other; i++)
 		zfree(&other[i]);
 	free((void *)other);
-- 
2.21.0

