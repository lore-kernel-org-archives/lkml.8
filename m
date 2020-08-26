Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C55520707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r8Mygcta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgHZLqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:46:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbgHZLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:32:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBSn5N130689;
        Wed, 26 Aug 2020 11:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=5Ht1XuRh4b+8zpTwbLUQhePD4bsTWs0tlQTAg2dpUqs=;
 b=r8MygctazbXYkPghqAMvpnufGNDjB9TXLOBFzDVvsL7gUj0qMZsh5yzEpF0/sTXpqo1B
 kgSJFaad6h2DJLgtk2VJmjuj+hobPb6o8RdVxBDnZwNoWfx1NiLfcOl23EdrWG9FpIno
 uCouHzDi4heZQeRezddeEJEAwKklseApDBUOINok7SyN9wxaWJPJt1qHjpMi2ibcTnB4
 mGuDKRF0BNFvUNgme/6u21SqRQWXl0vFkNcEr2wbSo5+z4vnu/joke8Qwu6Xg3vDt15/
 FHUZJf2kbDw/sTItp3/S2l0NsXz8NXD7C6tsj1lI2rnosrolR4TZMehJ4ufVI9eXzKK7 wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 335gw81nty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 11:32:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBUofp098051;
        Wed, 26 Aug 2020 11:32:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 333r9m1s7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:32:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07QBWLwi019420;
        Wed, 26 Aug 2020 11:32:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 04:32:20 -0700
Date:   Wed, 26 Aug 2020 14:32:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] afs: Remove erroneous fallthough annotation
Message-ID: <20200826113214.GB393664@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fall through annotation comes after a return statement so it's not
reachable.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/afs/flock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index eff82a6839e4..cb3054c7843e 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -376,7 +376,6 @@ void afs_lock_work(struct work_struct *work)
 		spin_unlock(&vnode->lock);
 		return;
 
-		fallthrough;
 	default:
 		/* Looks like a lock request was withdrawn. */
 		spin_unlock(&vnode->lock);
-- 
2.28.0

