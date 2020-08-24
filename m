Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82FEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43FD2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wlfq3RmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgHXJAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:00:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53066 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgHXJAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:00:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07O8xGgL108162;
        Mon, 24 Aug 2020 09:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=50Jbb+FZDBmchEzeKcBDaq35Jtp/5qrQQQ+5JWM9qFE=;
 b=Wlfq3RmSrQAIAthguqvPDfG7sBdRY3N7DDHb44Uv8sSseK1oVipq12+fD9zca/i2EMxT
 wa4cdpSgjgCpbgHcj4QQca+ZoK96OXlhzGFeeKmv7aVOuHFQ4XD8smrY+r8deFTdAi3H
 GHL6N4uaUL1Gp8Q3YIQ1BCIErgJcImPHFw3vm/3ENHc2lHVop5USXbJE8RLtmBCOX+XF
 6hezLKuD7o05jq165EULFaO7wLWzlcdDkYzUMwOcf+zmyPS8eRumXhIdtwAuwQpJPkku
 GERC5tZ+DhICby+R1blzCFzP1YwCHl6NKo09//aXctT1QifRmgMoqvZJ69uUsJN5HRZe SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6thw1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 09:00:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07O8o7OI015269;
        Mon, 24 Aug 2020 08:58:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 333ru480n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 08:58:19 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07O8wIct009724;
        Mon, 24 Aug 2020 08:58:18 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 01:58:18 -0700
Date:   Mon, 24 Aug 2020 11:58:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] afs: Fix a use after free in afs_xattr_get_acl()
Message-ID: <20200824085812.GB208317@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "op" pointer is freed earlier when we call afs_put_operation().

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/afs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 84f3c4f57531..38884d6c57cd 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -85,7 +85,7 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
 			if (acl->size <= size)
 				memcpy(buffer, acl->data, acl->size);
 			else
-				op->error = -ERANGE;
+				ret = -ERANGE;
 		}
 	}
 
-- 
2.28.0

