Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C7C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C881324695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5I717WE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgB1JZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:25:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58678 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgB1JZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:25:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9MnCm165632;
        Fri, 28 Feb 2020 09:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=cTxkCTmeTQ5mXSDNq/o0RuRKl6qtIuvZXXmwfcRRWeg=;
 b=l5I717WE7MS1lhKrEYEyugYRQPDxscE1fUVvWvqpSl6f36kkK1eqbk+oOJScNehY9Xe0
 /PXoPaZwpsHeisKvWo0JzATiRd92giAih4Y14TKXtrR8vwxSuNmmWhtJajx5+MjziW7C
 yv6ifi0X/yaAsNUlU+WQxGbdotupTB+7i92QrnGnPgwePPyHWFc2pMxUVujXsYuYxfY1
 XxAWxFXAH1dcqxKLszn8dlssk/39N8eSPXtqQCP3zrfQGJpQwDS+MuJq6xJE7DkZFsve
 e8FQgoZn3cI69hF1faE1Ob3ksd9NacKY/o4eWQACF1t8tfAVNEjCCnOutm1/5RtK7QCh MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3hj7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:25:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S9MKeL161251;
        Fri, 28 Feb 2020 09:25:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ydcs806qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 09:25:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01S9P1ak018179;
        Fri, 28 Feb 2020 09:25:01 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 01:25:00 -0800
Date:   Fri, 28 Feb 2020 12:24:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] lib/test_kmod: remove a NULL test
Message-ID: <20200228092452.vwkhthsn77nrxdy6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "info" pointer has already been dereferenced so checking here is
too late.  Fortunately, we never pass NULL pointers to the
test_kmod_put_module() function so the test can simply be removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index 9cf77628fc91..e651c37d56db 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -204,7 +204,7 @@ static void test_kmod_put_module(struct kmod_test_device_info *info)
 	case TEST_KMOD_DRIVER:
 		break;
 	case TEST_KMOD_FS_TYPE:
-		if (info && info->fs_sync && info->fs_sync->owner)
+		if (info->fs_sync && info->fs_sync->owner)
 			module_put(info->fs_sync->owner);
 		break;
 	default:
-- 
2.11.0

