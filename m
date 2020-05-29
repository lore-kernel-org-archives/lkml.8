Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33024C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA492077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Qy9OQEAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgE2P5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:57:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:22312 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgE2P5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:57:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TFgPUB032457;
        Fri, 29 May 2020 10:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=CCughQNF+AA3SdzhHCIQAzcbidYWB0JFMun0a0Q//Z8=;
 b=Qy9OQEARotEK5EdEr12GLL0ASxqgSsfraLvfzWIyuiQA6mnIn2wtCC1dViT0a2GYccLY
 5n7uxASHoeq64SgRUWDM/XZQLKGgbVSX3y2TYhuuLe+Apk1U21T4R1IzwtXWtM0KzftI
 n2x0Mc5nIthJkCiij1y7ZUYfXhr1/AR/oXuE35n8jyHntXhInamp4dJa98IWbT6pRS6S
 oCxtyAdIo2CIm0zNETwAJJ4V0Z5jmCF68kTKlJo5zunFi+FDm4PpfHIr6Sw6T3jfnvbw
 vxSGssNZFtDhWaLPTbr33wRIC4KfMM/d3zrTgpF+oahGLUeXLlujZQM0v2fpQoPIDZRz ag== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31708q12u4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 10:57:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 29 May
 2020 16:57:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 29 May 2020 16:57:43 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C4B62C5;
        Fri, 29 May 2020 15:57:43 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <s.nawrocki@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/3] mfd: madera: Fix minor formatting issues
Date:   Fri, 29 May 2020 16:57:41 +0100
Message-ID: <20200529155742.18399-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200529155742.18399-1-ckeepax@opensource.cirrus.com>
References: <20200529155742.18399-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 spamscore=0 mlxlogscore=960 cotscore=-2147483648
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005290123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c        | 12 ++++++------
 drivers/mfd/madera-i2c.c         |  1 -
 include/linux/mfd/madera/pdata.h |  1 -
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 7e0835cb062b1..4724c1a01a39f 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -44,7 +44,7 @@ static const char * const madera_core_supplies[] = {
 };
 
 static const struct mfd_cell madera_ldo1_devs[] = {
-	{ .name = "madera-ldo1" },
+	{ .name = "madera-ldo1", },
 };
 
 static const char * const cs47l15_supplies[] = {
@@ -55,8 +55,8 @@ static const char * const cs47l15_supplies[] = {
 
 static const struct mfd_cell cs47l15_devs[] = {
 	{ .name = "madera-pinctrl", },
-	{ .name = "madera-irq" },
-	{ .name = "madera-gpio" },
+	{ .name = "madera-irq", },
+	{ .name = "madera-gpio", },
 	{
 		.name = "madera-extcon",
 		.parent_supplies = cs47l15_supplies,
@@ -108,7 +108,7 @@ static const char * const cs47l85_supplies[] = {
 static const struct mfd_cell cs47l85_devs[] = {
 	{ .name = "madera-pinctrl", },
 	{ .name = "madera-irq", },
-	{ .name = "madera-micsupp" },
+	{ .name = "madera-micsupp", },
 	{ .name = "madera-gpio", },
 	{
 		.name = "madera-extcon",
@@ -155,10 +155,10 @@ static const char * const cs47l92_supplies[] = {
 };
 
 static const struct mfd_cell cs47l92_devs[] = {
-	{ .name = "madera-pinctrl" },
+	{ .name = "madera-pinctrl", },
 	{ .name = "madera-irq", },
 	{ .name = "madera-micsupp", },
-	{ .name = "madera-gpio" },
+	{ .name = "madera-gpio", },
 	{
 		.name = "madera-extcon",
 		.parent_supplies = cs47l92_supplies,
diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
index 6b965eb034b6c..7df5b9ba58554 100644
--- a/drivers/mfd/madera-i2c.c
+++ b/drivers/mfd/madera-i2c.c
@@ -88,7 +88,6 @@ static int madera_i2c_probe(struct i2c_client *i2c,
 	if (!madera)
 		return -ENOMEM;
 
-
 	madera->regmap = devm_regmap_init_i2c(i2c, regmap_16bit_config);
 	if (IS_ERR(madera->regmap)) {
 		ret = PTR_ERR(madera->regmap);
diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index fa9595dd42ba5..601cbbc10370c 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -21,7 +21,6 @@
 
 struct gpio_desc;
 struct pinctrl_map;
-struct madera_codec_pdata;
 
 /**
  * struct madera_pdata - Configuration data for Madera devices
-- 
2.11.0

