Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB249C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE04207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wi5z6An7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgFONxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:53:39 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:56206 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729930AbgFONxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:53:33 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FDi3s3007530;
        Mon, 15 Jun 2020 08:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=eCEGLDFCnMYuvh0oioO6nr6glagRLpUoXe3eWPdSEEA=;
 b=Wi5z6An7VHyFoqp71rSi5cI359K/oJBD5p5naeeFaQMjpzY1pZTozOAK8OdGe1H2bc6g
 9OdB9YMyCljrx7//ap/YpmrQbnNZky69u+lyDXxPlcSSN6OvnSp/ablnafOdZ1oLt2sc
 ClpWYs9gVkCuBF7PaV5oYTzCiWNf00k+8eCyLDOZwcfcNqXmefJTONeA31js2yBtfgTn
 r1e9w/ZH75sTGQz2bCEshslFSe1RIeIWaqsd1srZPjwI2PYLE4pcMXBv2b096wCkoHdz
 n0Q9g3cdj6ynpBN1uIHYq3cyyUK0YoYzAm5oDlFnXM3pX5fq0P5W9+9U3eo8YW4pt+mY yQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31mv73jqtn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Jun 2020 08:53:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 15 Jun
 2020 14:53:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 15 Jun 2020 14:53:24 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 163582D4;
        Mon, 15 Jun 2020 13:53:24 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <s.nawrocki@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/4] mfd: arizona: Ensure 32k clock is put on driver unbind and error
Date:   Mon, 15 Jun 2020 14:53:21 +0100
Message-ID: <20200615135323.15215-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
References: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=3
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst it doesn't matter if the internal 32k clock register settings
are cleaned up on exit, as the part will be turned off losing any
settings, hence the driver hasn't historially bothered. The external
clock should however be cleaned up, as it could cause clocks to be
left on, and will at best generate a warning on unbind.

Add clean up on both the probe error path and unbind for the 32k
clock.

Fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

Thanks,
Charles

 drivers/mfd/arizona-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 19e0bc3c0683e..000cb82023e35 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -1426,6 +1426,15 @@ int arizona_dev_init(struct arizona *arizona)
 	arizona_irq_exit(arizona);
 err_pm:
 	pm_runtime_disable(arizona->dev);
+
+	switch (arizona->pdata.clk32k_src) {
+	case ARIZONA_32KZ_MCLK1:
+	case ARIZONA_32KZ_MCLK2:
+		arizona_clk32k_disable(arizona);
+		break;
+	default:
+		break;
+	}
 err_reset:
 	arizona_enable_reset(arizona);
 	regulator_disable(arizona->dcvdd);
@@ -1448,6 +1457,15 @@ int arizona_dev_exit(struct arizona *arizona)
 	regulator_disable(arizona->dcvdd);
 	regulator_put(arizona->dcvdd);
 
+	switch (arizona->pdata.clk32k_src) {
+	case ARIZONA_32KZ_MCLK1:
+	case ARIZONA_32KZ_MCLK2:
+		arizona_clk32k_disable(arizona);
+		break;
+	default:
+		break;
+	}
+
 	mfd_remove_devices(arizona->dev);
 	arizona_free_irq(arizona, ARIZONA_IRQ_UNDERCLOCKED, arizona);
 	arizona_free_irq(arizona, ARIZONA_IRQ_OVERCLOCKED, arizona);
-- 
2.11.0

