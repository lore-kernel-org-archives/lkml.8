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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC780C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EC12076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KL8cTaCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgHCWl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:41:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCWl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:41:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073MbQVp072566;
        Mon, 3 Aug 2020 22:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=lFsx27GcMAb6M+HPbhV7YgCeHD9h46fDEAYwzzxawRY=;
 b=KL8cTaCZbKMpTXoTjUQ0Dn9Dt/bgySKmrn7zt6fTe1R7oIF4vC+O/HK7gjt8oFMfiivT
 lKG27MtYue9kOE/AoqP6nJfAv4k2pqDzRGqtPk16Z+x5NHZAcXw7N+FS8O1WZphMc3gq
 6Xa4CUqMFhrN0YLnZj0CssaOvyZ9/YJQUv2oRqrqn2QOWNjDEmkN1uv/e3mgxfoffrNW
 wODbIjyiKVyDYGb+fe8s881po36GasIn6Pdy15Pu14nLwWlej5d+/pkZhC73z7cbTkMK
 PKgJrreYLFTxMl1nhonQ4f35q0zzzqqBznWhpTXfe3eZJxu9WLGHP/cVyZh0TNuUJUiu Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnq4dts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 22:41:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073McntC063213;
        Mon, 3 Aug 2020 22:41:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 32pdnp07d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 22:41:51 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073Mfo26026448;
        Mon, 3 Aug 2020 22:41:50 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 15:41:50 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     jane.chu@oracle.com
Subject: [PATCH v2 1/3] libnvdimm/security: fix a typo
Date:   Mon,  3 Aug 2020 16:41:37 -0600
Message-Id: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
introduced a typo, causing a 'nvdimm->sec.flags' update being overwritten
by the subsequent update meant for 'nvdimm->sec.ext_flags'.

Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4cef69b..8f3971c 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
 	put_device(&nvdimm->dev);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
-	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
 }
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
-- 
1.8.3.1

