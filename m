Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D573C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD46206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sF/WzAAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGXEKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 00:10:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39566 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGXEKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 00:10:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06O4704N152894;
        Fri, 24 Jul 2020 04:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=8Gltyy5Q0emZXFOvfJiBtdyXuUrWqWmZCZch3+k4QHI=;
 b=sF/WzAAeagOla1WxfnrS2LPPOnPcywO6Ez3TcgnJvinppOuRKZWNwXN4NLZhgjmNgvVr
 PgAdRdUv0B5Q8MCNdRmifKyozehgYSUz+5zABmomE3OlQaV9NP/DjtVQ8y/mWsfGXor5
 ZLUmjmEh+uyg345oI3dVpIdynTnQtfdvvWg8W81nKpzGzKx6KW5XRBlJMbUtydVlV7zP
 +JrRsERh8V7Kj7DAThCESldWSsZ1QrJjGFMoChwYcOnjYR/HJAZyHkEb1p3FINmfX0Bz
 BMtUk+vVKA83w/6HNTn7rRVr9n2kSR+Lh6tP0GKrpMlMKxYzJUuIXnrVk36xM/lDX+vK KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32brgrw1m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 04:10:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06O44KcD005464;
        Fri, 24 Jul 2020 04:10:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32fp76x0bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 04:10:36 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06O4AZMv006742;
        Fri, 24 Jul 2020 04:10:35 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 04:10:34 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     jane.chu@oracle.com
Subject: [PATCH 1/2] libnvdimm/security: 'security' attr never show 'overwrite' state
Date:   Thu, 23 Jul 2020 22:10:24 -0600
Message-Id: <1595563824-16913-2-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595563824-16913-1-git-send-email-jane.chu@oracle.com>
References: <1595563824-16913-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since
commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute"),
when issue

then immediately check the 'security' attribute,

unlocked

Actually the attribute stays 'unlocked' through out the entire overwrite
operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
that has both bits set indicating 'overwrite' and 'unlocked'.
But security_show() checks the mutually exclusive bits before it checks
the 'overwrite' bit at last. The order should be reversed.

The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
assignment is replaced with 'nvdimm->sec.flags' assignment for
the NVDIMM_MASTER type.

Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/dimm_devs.c | 4 ++--
 drivers/nvdimm/security.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b7b77e8..5d72026 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
+	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
+		return sprintf(buf, "overwrite\n");
 	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
 		return sprintf(buf, "disabled\n");
 	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
 		return sprintf(buf, "unlocked\n");
 	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
 		return sprintf(buf, "locked\n");
-	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
-		return sprintf(buf, "overwrite\n");
 	return -ENOTTY;
 }
 
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

