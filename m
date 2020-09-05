Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23516C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECBD20738
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 12:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hsRvLyBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgIEMtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:49:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgIEMtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 08:49:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085CjOpl030332;
        Sat, 5 Sep 2020 12:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=G4+GbgDCsHYGyOXoI611kX7yl70Nr2V2wI9IWoby88Y=;
 b=hsRvLyBd2kvq4qkTbo1WXzsKIZ24bipf90Rwsaj5GdfbYqTfB+hEGqVTHo+5628XM4NS
 XknVZcbC1LhCwJV/DCqWlfXRQ66UKz4Q8GzDWaQ5RlMQ2m5f2DdX3SGZ4Cg9QoiiUbil
 aGJPChVIuGcyks6iQ3I4CR5pATjhZOAzC+ySfaHVjRFtPZAeFYOTgrV0/WblIL8JEBt4
 CqklKLqLIvON10DnyWQ51a1yh5APUUeLPeJnieg5sTL3cy2kH/ZHoJYswk5/gJ2IxfJg
 AXcP9HUJ8jC1asNG3OBgmO5VnX5awNzcw1pA1DcVaKoljs1ftraKSNu98e0mb3pYwe5c DA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33c2mkh56b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 05 Sep 2020 12:48:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 085CjGIk108243;
        Sat, 5 Sep 2020 12:46:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33c20hr6u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Sep 2020 12:46:57 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 085CktJc032361;
        Sat, 5 Sep 2020 12:46:56 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 05 Sep 2020 05:46:54 -0700
Date:   Sat, 5 Sep 2020 15:46:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] phy: ti: am654: Fix a leak in serdes_am654_probe()
Message-ID: <20200905124648.GA183976@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009050122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_phy_create() fails then we need to call of_clk_del_provider(node)
to undo the call to of_clk_add_provider().

Fixes: 71e2f5c5c224 ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/phy/ti/phy-am654-serdes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 6f3c11bd65d5..2ff56ce77b30 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -822,8 +822,10 @@ static int serdes_am654_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	phy = devm_phy_create(dev, NULL, &ops);
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		goto clk_err;
+	}
 
 	phy_set_drvdata(phy, am654_phy);
 	phy_provider = devm_of_phy_provider_register(dev, serdes_am654_xlate);
-- 
2.28.0

