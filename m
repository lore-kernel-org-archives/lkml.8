Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53145C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21217206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k1jxv+Yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCGGIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:08:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:08:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0276358C089498;
        Sat, 7 Mar 2020 06:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=VckGqFLyDLDkJpl9TRtd9e+eKXWj/DJN3P6dOtzp2hA=;
 b=k1jxv+Yx8NNLKrr61B0nYGu2PBA0KGXnHUAJ6hY6rllQDUR2qKQaAlBMVybH5+9VVEHC
 IExbZVc86IpLa6vRCxZsX1CaHoOdq3JG4IBpK+WQ769Lu08RokxVyWWTiXO857hnhLXu
 WqkGney9hFZ1+sCw5+DJH0LWdbji2V8+De1zT2yu7emulwLNSkrYYxH+kSOU7wJrWQJO
 4U2WHNeMvBPGVDKwTWoUtoqDaJDlchxwUlYrN/ZdqtMsx1Vt8trbmBh/Z4buaCsBGaci
 8FnKHEbOZhlZkhQb9+r0wQi+bpzE4IogTyRDImbgmCFG748gt/2hgq/LH+5lAsLOb4Nm hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ym48sg5kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 06:08:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02762qDc128971;
        Sat, 7 Mar 2020 06:08:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ym3e652uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Mar 2020 06:08:15 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02768DuG024639;
        Sat, 7 Mar 2020 06:08:13 GMT
Received: from kili.mountain (/41.210.146.162)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 22:08:13 -0800
Date:   Sat, 7 Mar 2020 09:08:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] bfs: prevent underflow in bfs_find_entry()
Message-ID: <20200307060808.6nfyqnp2woq7d3cv@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=940 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003070044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003070044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We check if "namelen" is larger than BFS_NAMELEN but we don't check
if it's less than zero so it causes a static checker.

    fs/bfs/dir.c:346 bfs_find_entry() warn: no lower bound on 'namelen'

It's nicer to make it unsigned anyway.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/bfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index d8dfe3a0cb39..46a2663e5eb2 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -326,7 +326,7 @@ static struct buffer_head *bfs_find_entry(struct inode *dir,
 	struct buffer_head *bh = NULL;
 	struct bfs_dirent *de;
 	const unsigned char *name = child->name;
-	int namelen = child->len;
+	unsigned int namelen = child->len;
 
 	*res_dir = NULL;
 	if (namelen > BFS_NAMELEN)
-- 
2.11.0

