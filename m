Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45750C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191D5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgCQOKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:10:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65409 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbgCQOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:10:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HE1x1b057784
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:10:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrr5fb3p8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:10:31 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Tue, 17 Mar 2020 14:10:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Mar 2020 14:10:27 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02HEAQE254001694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 14:10:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3608B11C066;
        Tue, 17 Mar 2020 14:10:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF4D611C054;
        Tue, 17 Mar 2020 14:10:24 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.199.61.203])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 14:10:24 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        psampat@in.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v5 3/3] powerpc/powernv: Parse device tree, population of SPR support
Date:   Tue, 17 Mar 2020 19:40:18 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317141018.42380-1-psampat@linux.ibm.com>
References: <20200317141018.42380-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031714-4275-0000-0000-000003ADD593
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031714-4276-0000-0000-000038C2FEA2
Message-Id: <20200317141018.42380-4-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the device tree for nodes self-save, self-restore and populate
support for the preferred SPRs based what was advertised by the device
tree.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
---
 .../bindings/powerpc/opal/power-mgt.txt       | 10 +++
 arch/powerpc/platforms/powernv/idle.c         | 78 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
index 9d619e955576..093cb5fe3d2d 100644
--- a/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
+++ b/Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt
@@ -116,3 +116,13 @@ otherwise. The length of all the property arrays must be the same.
 	which of the fields of the PMICR are set in the corresponding
 	entries in ibm,cpu-idle-state-pmicr. This is an optional
 	property on POWER8 and is absent on POWER9.
+
+- self-restore:
+ Array of unsigned 64-bit values containing a property for sprn-mask
+ with each bit indicating the index of the supported SPR for the
+ functionality. This is an optional property for both Power8 and Power9
+
+- self-save:
+  Array of unsigned 64-bit values containing a property for sprn-mask
+  with each bit indicating the index of the supported SPR for the
+  functionality. This is an optional property for both Power8 and Power9
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 97aeb45e897b..c39111b338ff 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -1436,6 +1436,81 @@ static void __init pnv_probe_idle_states(void)
 		supported_cpuidle_states |= pnv_idle_states[i].flags;
 }
 
+/*
+ * Extracts and populates the self save or restore capabilities
+ * passed from the device tree node
+ */
+static int extract_save_restore_state_dt(struct device_node *np, int type)
+{
+	int nr_sprns = 0, i, bitmask_index;
+	u64 *temp_u64;
+	u64 bit_pos;
+
+	nr_sprns = of_property_count_u64_elems(np, "sprn-bitmask");
+	if (nr_sprns <= 0)
+		return -EINVAL;
+	temp_u64 = kcalloc(nr_sprns, sizeof(u64), GFP_KERNEL);
+	if (of_property_read_u64_array(np, "sprn-bitmask",
+				       temp_u64, nr_sprns)) {
+		pr_warn("cpuidle-powernv: failed to find registers in DT\n");
+		kfree(temp_u64);
+		return -EINVAL;
+	}
+	/*
+	 * Populate acknowledgment of support for the sprs in the global vector
+	 * gotten by the registers supplied by the firmware.
+	 * The registers are in a bitmask, bit index within
+	 * that specifies the SPR
+	 */
+	for (i = 0; i < nr_preferred_sprs; i++) {
+		bitmask_index = BIT_WORD(preferred_sprs[i].spr);
+		bit_pos = BIT_MASK(preferred_sprs[i].spr);
+		if ((temp_u64[bitmask_index] & bit_pos) == 0) {
+			if (type == SELF_RESTORE_TYPE)
+				preferred_sprs[i].supported_mode &=
+					~SELF_RESTORE_STRICT;
+			else
+				preferred_sprs[i].supported_mode &=
+					~SELF_SAVE_STRICT;
+			continue;
+		}
+		if (type == SELF_RESTORE_TYPE) {
+			preferred_sprs[i].supported_mode |=
+				SELF_RESTORE_STRICT;
+		} else {
+			preferred_sprs[i].supported_mode |=
+				SELF_SAVE_STRICT;
+		}
+	}
+
+	kfree(temp_u64);
+	return 0;
+}
+
+static int pnv_parse_deepstate_dt(void)
+{
+	struct device_node *np;
+	int rc = 0, i;
+
+	/* Self restore register population */
+	np = of_find_compatible_node(NULL, NULL, "ibm,opal-self-restore");
+	if (np) {
+		rc = extract_save_restore_state_dt(np, SELF_RESTORE_TYPE);
+		if (rc != 0)
+			return rc;
+	}
+	/* Self save register population */
+	np = of_find_compatible_node(NULL, NULL, "ibm,opal-self-save");
+	if (!np) {
+		for (i = 0; i < nr_preferred_sprs; i++)
+			preferred_sprs[i].supported_mode &= ~SELF_SAVE_STRICT;
+	} else {
+		rc = extract_save_restore_state_dt(np, SELF_SAVE_TYPE);
+	}
+	of_node_put(np);
+	return rc;
+}
+
 /*
  * This function parses device-tree and populates all the information
  * into pnv_idle_states structure. It also sets up nr_pnv_idle_states
@@ -1584,6 +1659,9 @@ static int __init pnv_init_idle_states(void)
 		return rc;
 	pnv_probe_idle_states();
 
+	rc = pnv_parse_deepstate_dt();
+	if (rc)
+		return rc;
 	if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
 		if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 			power7_fastsleep_workaround_entry = false;
-- 
2.17.1

