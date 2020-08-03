Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82338C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959E62076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jSQkvukp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgHCWmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:42:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41828 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:42:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MfwKS108628;
        Mon, 3 Aug 2020 22:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=llfIzVl2uO/IbrgQPCFcYaQ1pe+oTOCxEp4v2US4r74=;
 b=jSQkvukpm1dFU5cYaLB7ggoYGE5BuYDedCivDXJGLsF9/tFuGGdDaikzt1sTLpOwh7ek
 /jqkCuQSb/d+oDRxrIAw/QSoB82Je2vv2bt7mZE2n29Mam+AdTwkQznKPv0pV82sjW+i
 +NlT1XhgktjmlcdxUKfizyOjea7btNMrtuoeKc/gV/tXKBjJkbrOpTV40b5xQJyGZcrn
 gGyU1Sn83OTgL5K1qBe1ug2f2SNgd1qaYhSoNPX2uDidiOU+NQ52aza5ETw3pAIGVHQZ
 RZgC+BkfNB3/tfs7dQmPJO/RyBJex518m2anTaNrFXA06Z/ybHcQg1p9eBz3FDjs6tE1 +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11n13a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 22:41:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MctTP078337;
        Mon, 3 Aug 2020 22:41:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32pdhb31hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 22:41:52 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073MfpTk024903;
        Mon, 3 Aug 2020 22:41:51 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 15:41:51 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     jane.chu@oracle.com
Subject: [PATCH v2 3/3] libnvdimm/security: ensure sysfs poll thread woke up and fetch updated attr
Date:   Mon,  3 Aug 2020 16:41:39 -0600
Message-Id: <1596494499-9852-3-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
adds a sysfs_notify_dirent() to wake up userspace poll thread when the "overwrite"
operation has completed. But the notification is issued before the internal
dimm security state and flags have been updated, so the userspace poll thread
wakes up and fetches the not-yet-updated attr and falls back to sleep, forever.
But if user from another terminal issue "ndctl wait-overwrite nmemX" again,
the command returns instantly.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/security.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 8f3971c..4b80150 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	else
 		dev_dbg(&nvdimm->dev, "overwrite completed\n");
 
-	if (nvdimm->sec.overwrite_state)
-		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
+	/*
+	 * Mark the overwrite work done and update dimm security flags,
+	 * then send a sysfs event notification to wake up userspace
+	 * poll threads to picked up the changed state.
+	 */
 	nvdimm->sec.overwrite_tmo = 0;
 	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
 	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
-	put_device(&nvdimm->dev);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	if (nvdimm->sec.overwrite_state)
+		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
+	put_device(&nvdimm->dev);
 }
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
-- 
1.8.3.1

