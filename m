Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2558C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADFD2467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgA0UIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:08:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgA0UIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:08:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RK6JDY123466;
        Mon, 27 Jan 2020 15:08:42 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrfej6b3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 15:08:42 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00RK7wCv128893;
        Mon, 27 Jan 2020 15:08:42 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrfej6b2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 15:08:42 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00RK6bCv031284;
        Mon, 27 Jan 2020 20:08:40 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 2xrda63tdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jan 2020 20:08:40 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RK8dn242992052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 20:08:40 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC441BE051;
        Mon, 27 Jan 2020 20:08:39 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A549BE053;
        Mon, 27 Jan 2020 20:08:39 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 20:08:39 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Fontenont <ndfont@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Rick Lindley <ricklind@linux.vnet.ibm.com>
Subject: [PATCH] pseries/hotplug-memory: remove dlpar_memory_{add,remove}_by_index() functions
Date:   Mon, 27 Jan 2020 14:08:39 -0600
Message-Id: <20200127200839.12441-1-cheloha@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_07:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dlpar_memory_{add,remove}_by_index() functions are just special
cases of their dlpar_memory_{add,remove}_by_ic() counterparts where
the LMB count is 1.  There is no need to maintain separate code.

In addition, there is a NULL dereference bug in the *_by_index()
functions if the LMB in question is not found.  This bug is not
present in their *_by_ic() counterparts.

Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
---
 .../platforms/pseries/hotplug-memory.c        | 74 +------------------
 1 file changed, 2 insertions(+), 72 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c126b94d1943..df7854c5c1f2 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -473,38 +473,6 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 	return rc;
 }
 
-static int dlpar_memory_remove_by_index(u32 drc_index)
-{
-	struct drmem_lmb *lmb;
-	int lmb_found;
-	int rc;
-
-	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
-
-	lmb_found = 0;
-	for_each_drmem_lmb(lmb) {
-		if (lmb->drc_index == drc_index) {
-			lmb_found = 1;
-			rc = dlpar_remove_lmb(lmb);
-			if (!rc)
-				dlpar_release_drc(lmb->drc_index);
-
-			break;
-		}
-	}
-
-	if (!lmb_found)
-		rc = -EINVAL;
-
-	if (rc)
-		pr_info("Failed to hot-remove memory at %llx\n",
-			lmb->base_addr);
-	else
-		pr_info("Memory at %llx was hot-removed\n", lmb->base_addr);
-
-	return rc;
-}
-
 static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	struct drmem_lmb *lmb;
@@ -631,10 +599,6 @@ static int dlpar_memory_remove_by_count(u32 lmbs_to_remove)
 {
 	return -EOPNOTSUPP;
 }
-static int dlpar_memory_remove_by_index(u32 drc_index)
-{
-	return -EOPNOTSUPP;
-}
 static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	return -EOPNOTSUPP;
@@ -762,40 +726,6 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
 	return rc;
 }
 
-static int dlpar_memory_add_by_index(u32 drc_index)
-{
-	struct drmem_lmb *lmb;
-	int rc, lmb_found;
-
-	pr_info("Attempting to hot-add LMB, drc index %x\n", drc_index);
-
-	lmb_found = 0;
-	for_each_drmem_lmb(lmb) {
-		if (lmb->drc_index == drc_index) {
-			lmb_found = 1;
-			rc = dlpar_acquire_drc(lmb->drc_index);
-			if (!rc) {
-				rc = dlpar_add_lmb(lmb);
-				if (rc)
-					dlpar_release_drc(lmb->drc_index);
-			}
-
-			break;
-		}
-	}
-
-	if (!lmb_found)
-		rc = -EINVAL;
-
-	if (rc)
-		pr_info("Failed to hot-add memory, drc index %x\n", drc_index);
-	else
-		pr_info("Memory at %llx (drc index %x) was hot-added\n",
-			lmb->base_addr, drc_index);
-
-	return rc;
-}
-
 static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index)
 {
 	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
@@ -887,7 +817,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_INDEX:
 			drc_index = hp_elog->_drc_u.drc_index;
-			rc = dlpar_memory_add_by_index(drc_index);
+			rc = dlpar_memory_add_by_ic(1, drc_index);
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_IC:
 			count = hp_elog->_drc_u.ic.count;
@@ -908,7 +838,7 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_INDEX:
 			drc_index = hp_elog->_drc_u.drc_index;
-			rc = dlpar_memory_remove_by_index(drc_index);
+			rc = dlpar_memory_remove_by_ic(1, drc_index);
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_IC:
 			count = hp_elog->_drc_u.ic.count;
-- 
2.24.1

