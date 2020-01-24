Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E76C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECF7206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+sXul6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbgAXKQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:16:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbgAXKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:16:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OAE0Zr055558;
        Fri, 24 Jan 2020 10:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=cVQtWFJTwo+bQ4fJ1+0B4WO3kZcnxRAQMDZGeSg5h08=;
 b=T+sXul6eg4ELRGH0KED6mFMjbOOFn79OfQ603e46p75OLvBJkb4hk0qQIE8ZqvHMbVCv
 4GKyr8cLsIUba/rOZnGmAOnHCzLMSi3nyFTm1jSVJXeGHKr9wnskHJTv+9IOkjDhrbH7
 S4qJD76iICOePXwV2/3dGDsOvmGGeCzN5JJ+6XUCnBNbv+WMXFS01T1CKW9Xnb33pa/s
 eu0qrIN6cmPpvvSLpN+Cq8h48lJ4cNrqLlrqVnvfgbd8aVHX0fufrfsFkaxN78svvDYJ
 VKKI2e5AIM2qmK/Tg/vrfe+KjqV0Fna8m4y6My32H6G/t7r1jLUXeJBHFLbphS4yNHRW +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xktnrqyh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 10:15:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OAE17p013863;
        Fri, 24 Jan 2020 10:15:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xqmuyn5pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 10:15:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00OAFkd0006163;
        Fri, 24 Jan 2020 10:15:48 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 02:15:45 -0800
Date:   Fri, 24 Jan 2020 13:15:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/adfs: bigdir: Fix an error code in adfs_fplus_read()
Message-ID: <20200124101537.z6n242eovocfbdha@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=809 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code accidentally returns success, but it should return the
-EIO error code from adfs_fplus_validate_header().

Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/adfs/dir_fplus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 48ea299b6ece..4a15924014da 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -114,7 +114,8 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 		return ret;
 
 	dir->bighead = h = (void *)dir->bhs[0]->b_data;
-	if (adfs_fplus_validate_header(h)) {
+	ret = adfs_fplus_validate_header(h);
+	if (ret) {
 		adfs_error(sb, "dir %06x has malformed header", indaddr);
 		goto out;
 	}
-- 
2.11.0

