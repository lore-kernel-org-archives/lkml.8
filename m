Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7C9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A78822BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bNYYrZ5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgGWKzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:55:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59394 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728426AbgGWKzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:55:04 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NAiI98003765;
        Thu, 23 Jul 2020 05:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=U17bNxoNWi8qqSnjSrUhsMn9nJE+sQOjHBXNeVMYZKc=;
 b=bNYYrZ5TJ/mMZnuhoHUq6AYvWVGMFrL/u1EO9PFW+cVqlCkE3X4OrqVm/BYjokyEwxDK
 f825RVmuWkdzirrBa69KCPJj+vGKmt2mOP7KRt1sEZm3ALJScQvZvzT1tmf2RlARJQBb
 DgpJGmFw6Y8EQBNaSxVobQDRt3wWKfahYztqWllaWXtCrZPsumTz02WOKr1x11C0Ol+L
 vv9AVCEcztKR4FT/BmdKybNfTLb6//J/8h4d5pORviXza5talV0+w9DrdcupqubtxSfY
 hQpjPxsHv+bTzk6ZhKEcRo7ga66JoJNT+r14ix4KIjQHHBMKBGMTyjxtQYYRUx6CUdg2 kA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 32bxg1fd81-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 05:55:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 23 Jul
 2020 11:55:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 23 Jul 2020 11:55:00 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2425B2C3;
        Thu, 23 Jul 2020 10:55:00 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [RESEND PATCH v3 2/2] mfd: madera: Improve handling of regulator unbinding
Date:   Thu, 23 Jul 2020 11:54:59 +0100
Message-ID: <20200723105459.5530-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200723105459.5530-1-ckeepax@opensource.cirrus.com>
References: <20200723105459.5530-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 clxscore=1015
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=844 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007230082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current unbinding process for Madera has some issues. The trouble
is runtime PM is disabled as the first step of the process, but
some of the drivers release IRQs causing regmap IRQ to issue a
runtime get which fails. To allow runtime PM to remain enabled during
mfd_remove_devices, the DCVDD regulator must remain available. In
the case of external DCVDD's this is simple, the regulator can simply
be disabled/put after the call to mfd_remove_devices. However, in
the case of an internally supplied DCVDD the regulator needs to be
released after the other MFD children depending on it.

Use the new MFD mfd_remove_devices_late functionality to split
the DCVDD regulator off from the other drivers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 4724c1a01a39f..8a8d733fdce5b 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -44,7 +44,10 @@ static const char * const madera_core_supplies[] = {
 };
 
 static const struct mfd_cell madera_ldo1_devs[] = {
-	{ .name = "madera-ldo1", },
+	{
+		.name = "madera-ldo1",
+		.level = MFD_DEP_LEVEL_HIGH,
+	},
 };
 
 static const char * const cs47l15_supplies[] = {
@@ -743,18 +746,22 @@ int madera_dev_exit(struct madera *madera)
 	/* Prevent any IRQs being serviced while we clean up */
 	disable_irq(madera->irq);
 
-	/*
-	 * DCVDD could be supplied by a child node, we must disable it before
-	 * removing the children, and prevent PM runtime from turning it back on
-	 */
-	pm_runtime_disable(madera->dev);
+	pm_runtime_get_sync(madera->dev);
 
-	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+	mfd_remove_devices(madera->dev);
+
+	pm_runtime_disable(madera->dev);
 
 	regulator_disable(madera->dcvdd);
 	regulator_put(madera->dcvdd);
 
-	mfd_remove_devices(madera->dev);
+	mfd_remove_devices_late(madera->dev);
+
+	pm_runtime_set_suspended(madera->dev);
+	pm_runtime_put_noidle(madera->dev);
+
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+
 	madera_enable_hard_reset(madera);
 
 	regulator_bulk_disable(madera->num_core_supplies,
-- 
2.11.0

