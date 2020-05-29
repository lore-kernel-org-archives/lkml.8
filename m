Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D222072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CcHefzq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgE2P5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:57:49 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:28586 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbgE2P5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:57:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TFgPUA032457;
        Fri, 29 May 2020 10:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Hc0douW9uBezthanKf9+weMeVoMuwkjFT6cH2Wn6LMA=;
 b=CcHefzq7F+fe3DEdDazt41Zv6LFgCIFhuZd0LeJY4Dwwjeorm6aOsjx48B6qpK+OqUZU
 Qugp/++ICY2h0HkJWFoX4/53xJdO3ZzgakLgsdheKhwpxHdZRNv6GUgKXUul7aPDap/t
 7l5x267mUpDnfdiVJ1tvCNRMfl6gOZ9ndy99vnNh6d7MU9Nth0tBSkUugpjzXkMgqblO
 lRAGAJiJ43wo47dyH6pJp+uqaQmlX8Xj8z5e/ATBJEnIGyl6gsxc4UEoOeo8uSy6z72p
 1Pu4YOOvVaoBY1E6iCWfYAc3gwv6IGAm7NiTD+5JTvjGZBL0uR0kUDeVDg8gR8G0z08d OQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31708q12u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:57:44 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 29 May
 2020 16:57:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 29 May 2020 16:57:43 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EFB972C8;
        Fri, 29 May 2020 15:57:42 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <s.nawrocki@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/3] mfd: arizona: Remove BUG_ON usage
Date:   Fri, 29 May 2020 16:57:40 +0100
Message-ID: <20200529155742.18399-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 spamscore=0 mlxlogscore=737 cotscore=-2147483648
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON macros are generally frowned upon when the issue isn't super
critical, the kernel can certainly carry on with the 32k clock on the
CODEC in a bad state so change the BUG_ON to a WARN_ON.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/arizona-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index f73cf76d1373d..19e0bc3c0683e 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -80,7 +80,7 @@ int arizona_clk32k_disable(struct arizona *arizona)
 {
 	mutex_lock(&arizona->clk_lock);
 
-	BUG_ON(arizona->clk32k_ref <= 0);
+	WARN_ON(arizona->clk32k_ref <= 0);
 
 	arizona->clk32k_ref--;
 
-- 
2.11.0

