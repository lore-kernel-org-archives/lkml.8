Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F91D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C5wiUZj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbgEMXju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:39:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54528 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbgEMXju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:39:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DNaPAg065703;
        Wed, 13 May 2020 23:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=WUtDE1uvxFfqtxiGlboxCs/AC9GkRjxAc7zArX6xztU=;
 b=C5wiUZj9WYB1aqt+jnVi12+YGGDEW0nQ8LtsgPIZBkEAcyoj8ADZC37Pgb8kxnOh26fc
 V0Wu+Tja6vN9+8fzF34W6WSFaJS3MWmSIhSwRQ+vnzrXGROUojOCUVlARX/lOQqEVVD7
 k//V+rJYO0LxrgNN4BiAAEXcfnMofRusW62WfQTf32LIqb1LvXaCAnvddFb0CX/vEPEH
 qie2e4zIR7bYHTGuf5jjxqg3eXk0w/iK+w9w+TgtQyM8WtJWZnLsX5s8aApmUa+ZlGgS
 D+8jO2AAKohWG+jzWyQJEO5TVobD6JCTcyU2TMVMpq9Zi8e1UrPMM5Q7wQkbOseCgff5 qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3100yfydwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 23:39:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DNc3Fk100680;
        Wed, 13 May 2020 23:39:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3100yfk17f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 23:39:42 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DNde5Y017022;
        Wed, 13 May 2020 23:39:40 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 16:39:40 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, joe.jin@oracle.com, rose.wang@oracle.com
Subject: [PATCH 1/1] xen/manage: enable C_A_D to force reboot
Date:   Wed, 13 May 2020 16:34:10 -0700
Message-Id: <20200513233410.18120-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The systemd may be configured to mask ctrl-alt-del via "systemctl mask
ctrl-alt-del.target". As a result, the pv reboot would not work as signal
is ignored.

This patch always enables C_A_D before the call of ctrl_alt_del() in order
to force the reboot.

Reported-by: Rose Wang <rose.wang@oracle.com>
Cc: Joe Jin <joe.jin@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/xen/manage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index cd046684e0d1..3190d0ecb52e 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -204,6 +204,13 @@ static void do_poweroff(void)
 static void do_reboot(void)
 {
 	shutting_down = SHUTDOWN_POWEROFF; /* ? */
+	/*
+	 * The systemd may be configured to mask ctrl-alt-del via
+	 * "systemctl mask ctrl-alt-del.target". As a result, the pv reboot
+	 * would not work. To enable C_A_D would force the reboot.
+	 */
+	C_A_D = 1;
+
 	ctrl_alt_del();
 }
 
-- 
2.17.1

