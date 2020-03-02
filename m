Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D598C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D96424697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCBFYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:24:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgCBFYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:24:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0225JRqE072361
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 00:24:30 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfjf3crnu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:24:30 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 2 Mar 2020 05:24:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 05:24:22 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0225OLaY51773638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 05:24:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5A5B5204E;
        Mon,  2 Mar 2020 05:24:20 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AFD365204F;
        Mon,  2 Mar 2020 05:24:17 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, peterz@infradead.org, mpe@ellerman.id.au,
        paulus@samba.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        alexey.budankov@linux.intel.com, yao.jin@linux.intel.com,
        robert.richter@amd.com, kim.phillips@amd.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: [RFC 01/11] powerpc/perf: Simplify ISA207_SIER macros
Date:   Mon,  2 Mar 2020 10:53:45 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030205-0008-0000-0000-000003583689
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030205-0009-0000-0000-00004A7960AF
Message-Id: <20200302052355.36365-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-01_09:2020-02-28,2020-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=583 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having separate macros for MASK and SHIFT, and using
them to derive the bits, let's have simple macro to do the job.
Also, remove ISA207_ prefix because some of the SIER bits which
are extracted with these macros are not defined in ISA, example
DATA_SRC bits.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/perf/isa207-common.c |  8 ++++----
 arch/powerpc/perf/isa207-common.h | 11 +++--------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 4c86da5eb28a..07026bbd292b 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -215,10 +215,10 @@ void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 	}
 
 	sier = mfspr(SPRN_SIER);
-	val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
+	val = SIER_TYPE(sier);
 	if (val == 1 || val == 2) {
-		idx = (sier & ISA207_SIER_LDST_MASK) >> ISA207_SIER_LDST_SHIFT;
-		sub_idx = (sier & ISA207_SIER_DATA_SRC_MASK) >> ISA207_SIER_DATA_SRC_SHIFT;
+		idx = SIER_LDST(sier);
+		sub_idx = SIER_DATA_SRC(sier);
 
 		dsrc->val = isa207_find_source(idx, sub_idx);
 		dsrc->val |= (val == 1) ? P(OP, LOAD) : P(OP, STORE);
@@ -231,7 +231,7 @@ void isa207_get_mem_weight(u64 *weight)
 	u64 exp = MMCRA_THR_CTR_EXP(mmcra);
 	u64 mantissa = MMCRA_THR_CTR_MANT(mmcra);
 	u64 sier = mfspr(SPRN_SIER);
-	u64 val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
+	u64 val = SIER_TYPE(sier);
 
 	if (val == 0 || val == 7)
 		*weight = 0;
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 63fd4f3f6013..7027eb9f3e40 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -202,14 +202,9 @@
 #define MAX_ALT				2
 #define MAX_PMU_COUNTERS		6
 
-#define ISA207_SIER_TYPE_SHIFT		15
-#define ISA207_SIER_TYPE_MASK		(0x7ull << ISA207_SIER_TYPE_SHIFT)
-
-#define ISA207_SIER_LDST_SHIFT		1
-#define ISA207_SIER_LDST_MASK		(0x7ull << ISA207_SIER_LDST_SHIFT)
-
-#define ISA207_SIER_DATA_SRC_SHIFT	53
-#define ISA207_SIER_DATA_SRC_MASK	(0x7ull << ISA207_SIER_DATA_SRC_SHIFT)
+#define SIER_DATA_SRC(sier)		(((sier) >> (63 - 10)) & 0x7ull)
+#define SIER_TYPE(sier)			(((sier) >> (63 - 48)) & 0x7ull)
+#define SIER_LDST(sier)			(((sier) >> (63 - 62)) & 0x7ull)
 
 #define P(a, b)				PERF_MEM_S(a, b)
 #define PH(a, b)			(P(LVL, HIT) | P(a, b))
-- 
2.21.1

