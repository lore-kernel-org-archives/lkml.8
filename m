Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5BFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965F020781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vk4YppJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHCOg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:36:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:36:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073ER9PR179146;
        Mon, 3 Aug 2020 14:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=TF4MGJ/Ms0le1y+/gzziKK6qij+gK//xIkWZPfpk0xA=;
 b=Vk4YppJ6tYB46U33ZFNb6IeYXfY5wKa1po2Q+pbzUxUMxBJFoJSVeE1v6JniLzkJrDo6
 IsLazfDHL2R9aAutn37c0PrZ5UxXG86yuM2ZGbbGOhyAKx8X7A2+xNV8Ywqvar/qd9E/
 yWargURilCk/cVRvBSGOCgIYRySFiMD8aFJhIKrlWI/Z18EA3kovWi1Jz8Lge82kHqCe
 NlQsA9eKt0oKB8qEldFCqWI7rsbhmG7ns7fcwJriJPMzL+UezeEPBEHMfglVYLRJlIc9
 7bYkLK3hZqIbgfaNp4S1lPGHTq94FI0IWGE9wrueolnoaE7HTiNNKk9HbFtCvLQUMJcF Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32pdnq23cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 14:36:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073EWna7082250;
        Mon, 3 Aug 2020 14:36:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32pdnng4fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 14:36:17 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073EaDKB004660;
        Mon, 3 Aug 2020 14:36:14 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 07:36:13 -0700
Date:   Mon, 3 Aug 2020 17:36:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] memory: jz4780_nemc: Fix an error pointer vs NULL check in
 probe()
Message-ID: <20200803143607.GC346925@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap() function returns NULL on error, it doesn't return
error pointers.  This bug could lead to an Oops during probe.

Fixes: f046e4a3f0b9 ("memory: jz4780_nemc: Only request IO memory the driver will use")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/memory/jz4780-nemc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index 3ec5cb0fce1e..608ae925e641 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -304,9 +304,9 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	}
 
 	nemc->base = devm_ioremap(dev, res->start, NEMC_REG_LEN);
-	if (IS_ERR(nemc->base)) {
+	if (!nemc->base) {
 		dev_err(dev, "failed to get I/O memory\n");
-		return PTR_ERR(nemc->base);
+		return -ENOMEM;
 	}
 
 	writel(0, nemc->base + NEMC_NFCSR);
-- 
2.27.0

