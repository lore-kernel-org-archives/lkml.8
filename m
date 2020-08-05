Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED79C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB922311F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 15:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHEPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 11:54:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgHEPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 11:48:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075DMYiJ001183;
        Wed, 5 Aug 2020 09:35:09 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qwkcrar0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:35:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075DZ7d8014782;
        Wed, 5 Aug 2020 13:35:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 32n018aq0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 13:35:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075DZ4aO26280306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 13:35:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA59C11C058;
        Wed,  5 Aug 2020 13:35:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 992E911C064;
        Wed,  5 Aug 2020 13:35:03 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.52.198])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 13:35:03 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     mpe@ellerman.id.au, nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        benh@kernel.crashing.org
Subject: [PATCH v2] powerpc/drmem: Don't compute the NUMA node for each LMB
Date:   Wed,  5 Aug 2020 15:35:02 +0200
Message-Id: <20200805133502.33723-1-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <202008051807.Vi8NDJtX%lkp@intel.com>
References: <202008051807.Vi8NDJtX%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_09:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008050108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the LMB from the same set of ibm,dynamic-memory-v2 property are
sharing the same NUMA node. Don't compute that node for each one.

Tested on a system with 1022 LMBs spread on 4 NUMA nodes, only 4 calls to
lmb_set_nid() have been made instead of 1022.

This should prevent some soft lockups when starting large guests

Code has meaning only if CONFIG_MEMORY_HOTPLUG is set, otherwise the nid
field is not present in the drmem_lmb structure.

Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/mm/drmem.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index b2eeea39684c..c11b6ec99ea3 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -402,6 +402,9 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 	const __be32 *p;
 	u32 i, j, lmb_sets;
 	int lmb_index;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	struct drmem_lmb *first = NULL;
+#endif
 
 	lmb_sets = of_read_number(prop++, 1);
 	if (lmb_sets == 0)
@@ -426,6 +429,15 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 	for (i = 0; i < lmb_sets; i++) {
 		read_drconf_v2_cell(&dr_cell, &p);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+		/*
+		 * Fetch the NUMA node id for the fist set or if the
+		 * associativity index is different from the previous set.
+		 */
+		if (first && dr_cell.aa_index != first->aa_index)
+			first = NULL;
+#endif
+
 		for (j = 0; j < dr_cell.seq_lmbs; j++) {
 			lmb = &drmem_info->lmbs[lmb_index++];
 
@@ -438,7 +450,18 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 			lmb->aa_index = dr_cell.aa_index;
 			lmb->flags = dr_cell.flags;
 
-			lmb_set_nid(lmb);
+#ifdef CONFIG_MEMORY_HOTPLUG
+			/*
+			 * All the LMB in the set share the same NUMA
+			 * associativity property. So read that node only once.
+			 */
+			if (!first) {
+				lmb_set_nid(lmb);
+				first = lmb;
+			} else {
+				lmb->nid = first->nid;
+			}
+#endif
 		}
 	}
 }
-- 
2.28.0

