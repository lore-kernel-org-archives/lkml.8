Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505DC24697
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBFYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:24:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26856 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCBFYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:24:39 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0225N2Wh126552
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 00:24:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfkn93ceq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:24:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 2 Mar 2020 05:24:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 05:24:29 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0225OSBV55705696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 05:24:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E91F52054;
        Mon,  2 Mar 2020 05:24:28 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BC75752050;
        Mon,  2 Mar 2020 05:24:24 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, peterz@infradead.org, mpe@ellerman.id.au,
        paulus@samba.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        alexey.budankov@linux.intel.com, yao.jin@linux.intel.com,
        robert.richter@amd.com, kim.phillips@amd.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC 03/11] powerpc/perf: Arch specific definitions for pipeline
Date:   Mon,  2 Mar 2020 10:53:47 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030205-0012-0000-0000-0000038C0D7F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030205-0013-0000-0000-000021C8BEFE
Message-Id: <20200302052355.36365-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_01:2020-02-28,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=1 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Create powerpc specific definitions for pipeline hazard and stalls.
This information is available in SIER register on powerpc. Current
definitions are based on IBM PowerPC SIER specification available
in ISA[1] and Performance Monitor Unit User’s Guide[2].

[1]: Book III, Section 9.4.10:
     https://openpowerfoundation.org/?resource_lib=power-isa-version-3-0
[2]: https://wiki.raptorcs.com/w/images/6/6b/POWER9_PMU_UG_v12_28NOV2018_pub.pdf#G9.1106986

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../include/uapi/asm/perf_pipeline_haz.h      | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_pipeline_haz.h

diff --git a/arch/powerpc/include/uapi/asm/perf_pipeline_haz.h b/arch/powerpc/include/uapi/asm/perf_pipeline_haz.h
new file mode 100644
index 000000000000..de8857ec31dd
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/perf_pipeline_haz.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_POWERPC_PERF_PIPELINE_HAZ_H
+#define _UAPI_ASM_POWERPC_PERF_PIPELINE_HAZ_H
+
+enum perf_inst_type {
+	PERF_HAZ__ITYPE_LOAD = 1,
+	PERF_HAZ__ITYPE_STORE,
+	PERF_HAZ__ITYPE_BRANCH,
+	PERF_HAZ__ITYPE_FP,
+	PERF_HAZ__ITYPE_FX,
+	PERF_HAZ__ITYPE_CR_OR_SC,
+};
+
+enum perf_inst_cache {
+	PERF_HAZ__ICACHE_L1_HIT = 1,
+	PERF_HAZ__ICACHE_L2_HIT,
+	PERF_HAZ__ICACHE_L3_HIT,
+	PERF_HAZ__ICACHE_L3_MISS,
+};
+
+enum perf_pipeline_stage {
+	PERF_HAZ__PIPE_STAGE_IFU = 1,
+	PERF_HAZ__PIPE_STAGE_IDU,
+	PERF_HAZ__PIPE_STAGE_ISU,
+	PERF_HAZ__PIPE_STAGE_LSU,
+	PERF_HAZ__PIPE_STAGE_BRU,
+	PERF_HAZ__PIPE_STAGE_FXU,
+	PERF_HAZ__PIPE_STAGE_FPU,
+	PERF_HAZ__PIPE_STAGE_VSU,
+	PERF_HAZ__PIPE_STAGE_OTHER,
+};
+
+enum perf_haz_bru_reason {
+	PERF_HAZ__HAZ_BRU_MPRED_DIR = 1,
+	PERF_HAZ__HAZ_BRU_MPRED_TA,
+};
+
+enum perf_haz_isu_reason {
+	PERF_HAZ__HAZ_ISU_SRC = 1,
+	PERF_HAZ__HAZ_ISU_COL = 1,
+};
+
+enum perf_haz_lsu_reason {
+	PERF_HAZ__HAZ_LSU_ERAT_MISS = 1,
+	PERF_HAZ__HAZ_LSU_LMQ,
+	PERF_HAZ__HAZ_LSU_LHS,
+	PERF_HAZ__HAZ_LSU_MPRED,
+	PERF_HAZ__HAZ_DERAT_MISS,
+	PERF_HAZ__HAZ_LSU_LMQ_DERAT_MISS,
+	PERF_HAZ__HAZ_LSU_LHS_DERAT_MISS,
+	PERF_HAZ__HAZ_LSU_MPRED_DERAT_MISS,
+};
+
+enum perf_stall_lsu_reason {
+	PERF_HAZ__STALL_LSU_DCACHE_MISS = 1,
+	PERF_HAZ__STALL_LSU_LD_FIN,
+	PERF_HAZ__STALL_LSU_ST_FWD,
+	PERF_HAZ__STALL_LSU_ST,
+};
+
+enum perf_stall_fxu_reason {
+	PERF_HAZ__STALL_FXU_MC = 1,
+	PERF_HAZ__STALL_FXU_FC,
+};
+
+enum perf_stall_bru_reason {
+	PERF_HAZ__STALL_BRU_FIN_MPRED = 1,
+	PERF_HAZ__STALL_BRU_FC,
+};
+
+enum perf_stall_vsu_reason {
+	PERF_HAZ__STALL_VSU_MC = 1,
+	PERF_HAZ__STALL_VSU_FC,
+};
+
+enum perf_stall_other_reason {
+	PERF_HAZ__STALL_NTC,
+};
+
+#endif /* _UAPI_ASM_POWERPC_PERF_PIPELINE_HAZ_H */
-- 
2.21.1

