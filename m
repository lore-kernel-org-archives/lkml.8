Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB57C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8165207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="reQJpdgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgERLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:32:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgERLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:32:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IBR8En030210;
        Mon, 18 May 2020 11:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Nf4Rh2W7FuA5dcxB52Yb3a1cDcQWNzGxXYU7kpXcYOs=;
 b=reQJpdgKciM7tKTDXmtbEwWYIBsfiLz5q0YT3X14iPZz7K/GfjX8lEWRBFCqcsR9LX+i
 KKS9hLMm3Yxm95bKmOC17YhIBcm9frl/1HaS42mJzoLHMOuvGSKkhqeLeHFHGPj6MYIE
 woE/F9Odues1s1B2meS6bluwBuYbeGmy6DAG22T7QFVeHGLMJqFFJMFrqS+OebYYE7fo
 cfoN5XCqV9mgVaFIKqnZvDRgNbnh/WRhc0zZn0c4WvTeNlJDITcJfuD1G4LZoYp2DTDj
 ZxqDpe/v+Lf2EbEwuDgOBef67eoIJIlmi2M8K1m5icqF8s8t3NjH1ffCZ2swvqSJSYij OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3127kqx7tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 11:32:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04IBSuGt121191;
        Mon, 18 May 2020 11:30:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 312t30m2qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 11:30:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04IBUTmb001719;
        Mon, 18 May 2020 11:30:29 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 May 2020 04:30:29 -0700
Date:   Mon, 18 May 2020 14:30:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] of: drop a reference on error in __of_attach_node_sysfs()
Message-ID: <20200518113021.GB48709@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a new of_node_get() to this function, but we should drop the
reference if kobject_add().

Fixes: 5b2c2f5a0ea3 ("of: overlay: add missing of_node_get() in __of_attach_node_sysfs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Maybe we should just call of_node_get() right
before we return 0?

 drivers/of/kobj.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index c72eef988041..a90dc4b3b060 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -138,8 +138,10 @@ int __of_attach_node_sysfs(struct device_node *np)
 
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
-	if (rc)
+	if (rc) {
+		of_node_put(np);
 		return rc;
+	}
 
 	for_each_property_of_node(np, pp)
 		__of_add_property_sysfs(np, pp);
-- 
2.26.2

