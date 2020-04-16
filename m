Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E764C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5E120784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439918AbgDPHzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:55:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440159AbgDPHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:54:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G7c8Ai091814
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:54:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30eh6e3gs7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:54:08 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Thu, 16 Apr 2020 08:53:38 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 08:53:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03G7s3P954722658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 07:54:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 107EBAE057;
        Thu, 16 Apr 2020 07:54:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ACAFAE056;
        Thu, 16 Apr 2020 07:54:01 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.79.182.109])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 07:54:01 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, skiboot@lists.ozlabs.org, oohall@gmail.com,
        ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        pratik.r.sampat@gmail.com, psampat@linux.ibm.com
Subject: [PATCH v7 1/3] powerpc/powernv: Introduce interface for self-restore support
Date:   Thu, 16 Apr 2020 13:23:56 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416075358.75155-1-psampat@linux.ibm.com>
References: <20200416075358.75155-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041607-0008-0000-0000-000003719D98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041607-0009-0000-0000-00004A93546C
Message-Id: <20200416075358.75155-2-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_02:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces an interface that helps determine support for the
self-restore API. The commit is isomorphic to the original interface of
declaring SPRs to self-restore.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 200 +++++++++++++++++++-------
 1 file changed, 152 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 78599bca66c2..858ceb86394d 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -32,10 +32,67 @@
 #define P9_STOP_SPR_MSR 2000
 #define P9_STOP_SPR_PSSCR      855
 
+/*
+ * Type of support for each SPR
+ * FIRMWARE_RESTORE: firmware restoration supported: calls self-restore OPAL API
+ */
+#define UNSUPPORTED           0x0
+#define FIRMWARE_RESTORE      0x1
+
 static u32 supported_cpuidle_states;
 struct pnv_idle_states_t *pnv_idle_states;
 int nr_pnv_idle_states;
 
+struct preferred_sprs {
+	u64 spr;
+	u32 supported_mode;
+};
+
+/*
+ * Supported mode: Default support. Can be overwritten during system
+ *		   initialization
+ */
+struct preferred_sprs preferred_sprs[] = {
+	{
+		.spr = SPRN_HSPRG0,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = SPRN_LPCR,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = SPRN_HMEER,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = SPRN_HID0,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = P9_STOP_SPR_MSR,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = P9_STOP_SPR_PSSCR,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = SPRN_HID1,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = SPRN_HID4,
+		.supported_mode = FIRMWARE_RESTORE,
+	},
+	{
+		.spr = SPRN_HID5,
+		.supported_mode = FIRMWARE_RESTORE,
+	}
+};
+
+const int nr_preferred_sprs = ARRAY_SIZE(preferred_sprs);
+
 /*
  * The default stop state that will be used by ppc_md.power_save
  * function on platforms that support stop instruction.
@@ -61,78 +118,125 @@ static bool deepest_stop_found;
 
 static unsigned long power7_offline_type;
 
-static int pnv_save_sprs_for_deep_states(void)
+static int pnv_self_restore_sprs(u64 pir, int cpu, u64 spr)
 {
-	int cpu;
+	u64 reg_val;
 	int rc;
 
-	/*
-	 * hid0, hid1, hid4, hid5, hmeer and lpcr values are symmetric across
-	 * all cpus at boot. Get these reg values of current cpu and use the
-	 * same across all cpus.
-	 */
-	uint64_t lpcr_val	= mfspr(SPRN_LPCR);
-	uint64_t hid0_val	= mfspr(SPRN_HID0);
-	uint64_t hid1_val	= mfspr(SPRN_HID1);
-	uint64_t hid4_val	= mfspr(SPRN_HID4);
-	uint64_t hid5_val	= mfspr(SPRN_HID5);
-	uint64_t hmeer_val	= mfspr(SPRN_HMEER);
-	uint64_t msr_val = MSR_IDLE;
-	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
-
-	for_each_present_cpu(cpu) {
-		uint64_t pir = get_hard_smp_processor_id(cpu);
-		uint64_t hsprg0_val = (uint64_t)paca_ptrs[cpu];
-
-		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, hsprg0_val);
+	switch (spr) {
+	case SPRN_HSPRG0:
+		reg_val = (uint64_t)paca_ptrs[cpu];
+		rc = opal_slw_set_reg(pir, SPRN_HSPRG0, reg_val);
 		if (rc != 0)
 			return rc;
-
-		rc = opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
+		break;
+	case SPRN_LPCR:
+		reg_val = mfspr(SPRN_LPCR);
+		rc = opal_slw_set_reg(pir, SPRN_LPCR, reg_val);
 		if (rc != 0)
 			return rc;
-
+		break;
+	case P9_STOP_SPR_MSR:
+		reg_val = MSR_IDLE;
 		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-			rc = opal_slw_set_reg(pir, P9_STOP_SPR_MSR, msr_val);
+			rc = opal_slw_set_reg(pir, P9_STOP_SPR_MSR, reg_val);
 			if (rc)
 				return rc;
-
-			rc = opal_slw_set_reg(pir,
-					      P9_STOP_SPR_PSSCR, psscr_val);
-
+		}
+		break;
+	case P9_STOP_SPR_PSSCR:
+		reg_val = pnv_deepest_stop_psscr_val;
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			rc = opal_slw_set_reg(pir, P9_STOP_SPR_PSSCR, reg_val);
 			if (rc)
 				return rc;
 		}
-
-		/* HIDs are per core registers */
+		break;
+	case SPRN_HMEER:
+		reg_val = mfspr(SPRN_HMEER);
 		if (cpu_thread_in_core(cpu) == 0) {
-
-			rc = opal_slw_set_reg(pir, SPRN_HMEER, hmeer_val);
-			if (rc != 0)
+			rc = opal_slw_set_reg(pir, SPRN_HMEER, reg_val);
+			if (rc)
 				return rc;
-
-			rc = opal_slw_set_reg(pir, SPRN_HID0, hid0_val);
-			if (rc != 0)
+		}
+		break;
+	case SPRN_HID0:
+		reg_val = mfspr(SPRN_HID0);
+		if (cpu_thread_in_core(cpu) == 0) {
+			rc = opal_slw_set_reg(pir, SPRN_HID0, reg_val);
+			if (rc)
 				return rc;
+		}
+		break;
+	case SPRN_HID1:
+		reg_val = mfspr(SPRN_HID1);
+		if (!cpu_has_feature(CPU_FTR_ARCH_300) &&
+		    cpu_thread_in_core(cpu) == 0) {
+			rc = opal_slw_set_reg(pir, SPRN_HID1, reg_val);
+			if (rc)
+				return rc;
+		}
+		break;
+	case SPRN_HID4:
+		reg_val = mfspr(SPRN_HID4);
+		if (!cpu_has_feature(CPU_FTR_ARCH_300) &&
+		    cpu_thread_in_core(cpu) == 0) {
+			rc = opal_slw_set_reg(pir, SPRN_HID4, reg_val);
+			if (rc)
+				return rc;
+		}
+		break;
+	case SPRN_HID5:
+		reg_val = mfspr(SPRN_HID5);
+		if (!cpu_has_feature(CPU_FTR_ARCH_300) &&
+		    cpu_thread_in_core(cpu) == 0) {
+			rc = opal_slw_set_reg(pir, SPRN_HID5, reg_val);
+			if (rc)
+				return rc;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
 
-			/* Only p8 needs to set extra HID regiters */
-			if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
-
-				rc = opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
-				if (rc != 0)
-					return rc;
-
-				rc = opal_slw_set_reg(pir, SPRN_HID4, hid4_val);
-				if (rc != 0)
-					return rc;
+static int pnv_self_save_restore_sprs(void)
+{
+	int rc, index, cpu;
+	u64 pir;
+	struct preferred_sprs curr_spr;
 
-				rc = opal_slw_set_reg(pir, SPRN_HID5, hid5_val);
+	for_each_present_cpu(cpu) {
+		pir = get_hard_smp_processor_id(cpu);
+		for (index = 0; index < nr_preferred_sprs; index++) {
+			curr_spr = preferred_sprs[index];
+			/* HIDs are per core register */
+			if (cpu_thread_in_core(cpu) != 0 &&
+			    (curr_spr.spr == SPRN_HMEER ||
+			     curr_spr.spr == SPRN_HID0  ||
+			     curr_spr.spr == SPRN_HID1  ||
+			     curr_spr.spr == SPRN_HID4  ||
+			     curr_spr.spr == SPRN_HID5))
+				continue;
+			if (curr_spr.supported_mode & FIRMWARE_RESTORE) {
+				rc = pnv_self_restore_sprs(pir, cpu,
+							   curr_spr.spr);
 				if (rc != 0)
 					return rc;
 			}
 		}
 	}
+	return 0;
+}
 
+static int pnv_save_sprs_for_deep_states(void)
+{
+	int rc;
+
+	rc = pnv_self_save_restore_sprs();
+	if (rc != 0)
+		return rc;
 	return 0;
 }
 
-- 
2.17.1

