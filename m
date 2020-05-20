Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98982207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kGPLLIX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgETMEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:04:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34804 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:04:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC1RLG176850;
        Wed, 20 May 2020 12:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=DsT4BnuEUbk/nScFx27b5DkH7xTb4qeH1YVdy3VSSQM=;
 b=kGPLLIX0Prt6BXOx7Mq8sb8tZW75xBnRbwRphQfNern9VyDgqwBdqxL99NFA0eA5UgwY
 Si9XdEnGFuccYUymIqm/oTyIl4vtrDLx6HHxF3mKhNjAfA4NVB2KFFOFUG/tae0cxhx0
 +khMwq8mXgNiz9KYc67DO99gnSJ2IFcpA7JfbAzTCIToHlzMZxt2pBhw6OG2/e2V07W/
 D7U+WcjzOsjwDEuOF4hkYMgGq8L19e0KpbGKNFRLX9SwHeF8IllT+bCE+CZ8MthredYm
 StqmlblPMWdt11tzUhZPhC/+v0Gqp3Gpxcqew+yix4PC2TlXUrPU1jMkzxo14T0QSyGD pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31501r97fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 12:04:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KC2cs7119695;
        Wed, 20 May 2020 12:04:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 313gj3dxae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 12:04:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KC4LBe014899;
        Wed, 20 May 2020 12:04:21 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 05:04:20 -0700
Date:   Wed, 20 May 2020 15:04:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] of: Fix a refcounting bug in __of_attach_node_sysfs()
Message-ID: <20200520120414.GE172354@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dx69az4.fsf@mpe.ellerman.id.au>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem in this code is that if kobject_add() fails, then it should
call of_node_put(np) to drop the reference count.  I've actually moved
the of_node_get(np) later in the function to avoid needing to do clean
up.

Fixes: 5b2c2f5a0ea3 ("of: overlay: add missing of_node_get() in __of_attach_node_sysfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: move the of_node_get() instead of doing clean up.  Also the v1 had a
    confusing typo in the commit message.

 drivers/of/kobj.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index c72eef988041..a32e60b024b8 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -134,8 +134,6 @@ int __of_attach_node_sysfs(struct device_node *np)
 	if (!name)
 		return -ENOMEM;
 
-	of_node_get(np);
-
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -144,6 +142,7 @@ int __of_attach_node_sysfs(struct device_node *np)
 	for_each_property_of_node(np, pp)
 		__of_add_property_sysfs(np, pp);
 
+	of_node_get(np);
 	return 0;
 }
 
-- 
2.26.2

