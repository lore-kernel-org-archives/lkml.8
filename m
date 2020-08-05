Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2AA207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZvvPs2Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHEA2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:28:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHEA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:28:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0750M2GO066371;
        Wed, 5 Aug 2020 00:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=QsgWMFelLsddVnAZaR0j7Bo4BN8h108wBgEFRMsApPs=;
 b=ZvvPs2Oa5TnhcAxZNw+cKDbWNq7LbnP3GxWmHnhWmOS2wDjC1YaNCcQNMRJ8n70L7xYv
 qF/LWEtrqKKlOXTtb7n63+mZopwQbEJBbLcLnvdrsqukxzpY+RRPq46OCECgiLRNAYfk
 TNf4a3piT6ZO1ySz+dDRWLcekfMRr0/3tH9zOghNpN0UURneLxA83COfR6CiBF80A1IW
 /F1JB5uGtjRpe+mxeDHqkbRKUFmgukWV7yFpRuMVR325YCNYbk6upAzKulhEVREwCPRV
 h+swfiXNeSdntzEwVlaUVelM0bphBqRTWy0Q9ERI56lFvXO63Q+ntl7c8y916+Js2P17 ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11n77fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 00:28:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0750MxMS019155;
        Wed, 5 Aug 2020 00:28:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32pdhd4j48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 00:28:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0750SWI7015711;
        Wed, 5 Aug 2020 00:28:32 GMT
Received: from dhcp-10-159-241-148.vpn.oracle.com (/10.159.241.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 17:28:32 -0700
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     linux-raid@vger.kernel.org
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org
Subject: [PATCH] md: get sysfs entry after redundancy attr group create
Date:   Tue,  4 Aug 2020 17:27:18 -0700
Message-Id: <20200805002718.50839-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=21
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=21 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"sync_completed" and "degraded" belongs to redundancy attr group,
it was not exist yet when md device was created.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: e1a86dbbbd6a ("md: fix deadlock causing by sysfs_notify")
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 drivers/md/md.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fee8943ead7b..60d2142c4693 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -846,7 +846,13 @@ void mddev_unlock(struct mddev *mddev)
 				sysfs_remove_group(&mddev->kobj, &md_redundancy_group);
 				if (mddev->sysfs_action)
 					sysfs_put(mddev->sysfs_action);
+				if (mddev->sysfs_completed)
+					sysfs_put(mddev->sysfs_completed);
+				if (mddev->sysfs_degraded)
+					sysfs_put(mddev->sysfs_degraded);
 				mddev->sysfs_action = NULL;
+				mddev->sysfs_completed = NULL;
+				mddev->sysfs_degraded = NULL;
 			}
 		}
 		mddev->sysfs_active = 0;
@@ -4036,6 +4042,8 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 			pr_warn("md: cannot register extra attributes for %s\n",
 				mdname(mddev));
 		mddev->sysfs_action = sysfs_get_dirent(mddev->kobj.sd, "sync_action");
+		mddev->sysfs_completed = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_completed");
+		mddev->sysfs_degraded = sysfs_get_dirent_safe(mddev->kobj.sd, "degraded");
 	}
 	if (oldpers->sync_request != NULL &&
 	    pers->sync_request == NULL) {
@@ -5542,14 +5550,9 @@ static void md_free(struct kobject *ko)
 
 	if (mddev->sysfs_state)
 		sysfs_put(mddev->sysfs_state);
-	if (mddev->sysfs_completed)
-		sysfs_put(mddev->sysfs_completed);
-	if (mddev->sysfs_degraded)
-		sysfs_put(mddev->sysfs_degraded);
 	if (mddev->sysfs_level)
 		sysfs_put(mddev->sysfs_level);
 
-
 	if (mddev->gendisk)
 		del_gendisk(mddev->gendisk);
 	if (mddev->queue)
@@ -5710,8 +5713,6 @@ static int md_alloc(dev_t dev, char *name)
 	if (!error && mddev->kobj.sd) {
 		kobject_uevent(&mddev->kobj, KOBJ_ADD);
 		mddev->sysfs_state = sysfs_get_dirent_safe(mddev->kobj.sd, "array_state");
-		mddev->sysfs_completed = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_completed");
-		mddev->sysfs_degraded = sysfs_get_dirent_safe(mddev->kobj.sd, "degraded");
 		mddev->sysfs_level = sysfs_get_dirent_safe(mddev->kobj.sd, "level");
 	}
 	mddev_put(mddev);
@@ -5991,6 +5992,8 @@ int md_run(struct mddev *mddev)
 			pr_warn("md: cannot register extra attributes for %s\n",
 				mdname(mddev));
 		mddev->sysfs_action = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_action");
+		mddev->sysfs_completed = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_completed");
+		mddev->sysfs_degraded = sysfs_get_dirent_safe(mddev->kobj.sd, "degraded");
 	} else if (mddev->ro == 2) /* auto-readonly not meaningful */
 		mddev->ro = 0;
 
-- 
2.20.1 (Apple Git-117)

