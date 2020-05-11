Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B82AC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165ED206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FSjdPMmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgEKPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:53:40 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:14896 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729485AbgEKPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:53:38 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BFpaMB011362;
        Mon, 11 May 2020 10:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=LVT6ZUNmQ8zghcnjSZN8pwbJCuxBB/vMw/LG3F5YpHU=;
 b=FSjdPMmEYLt7+kTRzbS3zYA206JASuBIZ9B4IyMQX+YuxHvY2TgyukeC0XPJkhNQXH5Q
 oR/E3pjsPVtmZCPGWPywqwBpGIkG8aoPpDUerFt4VzuN8uN2L64WSNuvJkH70/ebTVVR
 XSLiulmsvugjUpF4I3RVISTdcw71XU18HJEqruYKq2PZTgcvCEts8RXu0nK9fX+l6w7E
 xpTb0fgJS4DWaIIzDxcs2k9V52LbQ2wXSlXRiUWga7lJyQIttn4DPw1YajKreI+zqk8D
 ZiTJLuBAtF3AwPxgOzKjCvKP9PYyc9ieRqUHxy5keEAxHgYmSjHrmo55sURRLUToo6mk UQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 30wrxq2ynd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 May 2020 10:53:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 16:53:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 11 May 2020 16:53:33 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 87F532C6;
        Mon, 11 May 2020 15:53:33 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] mfd: madera: Improve handling of regulator unbinding
Date:   Mon, 11 May 2020 16:53:33 +0100
Message-ID: <20200511155333.2183-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200511155333.2183-1-ckeepax@opensource.cirrus.com>
References: <20200511155333.2183-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=1 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=753 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110125
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

Use the new MFD mfd_remove_devices_by_tag functionality to split
the child drivers into two groups. An "optional" group of drivers
and a core group that provide functionality to the others. Remove
the optional group first, clean up the regulators etc. then finally
remove the remaining children.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
  - Added MFD by tag thing and removed the regulator parts

Thanks,
Charles

 drivers/mfd/madera-core.c | 73 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 7e0835cb062b1..f89b8825ebc1f 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -38,6 +38,8 @@
 #define MADERA_RESET_MIN_US	2000
 #define MADERA_RESET_MAX_US	3000
 
+#define MADERA_OPTIONAL_DRIVER	1
+
 static const char * const madera_core_supplies[] = {
 	"AVDD",
 	"DBVDD1",
@@ -56,14 +58,19 @@ static const char * const cs47l15_supplies[] = {
 static const struct mfd_cell cs47l15_devs[] = {
 	{ .name = "madera-pinctrl", },
 	{ .name = "madera-irq" },
-	{ .name = "madera-gpio" },
+	{
+		.name = "madera-gpio",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
 	{
 		.name = "madera-extcon",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l15_supplies,
 		.num_parent_supplies = 1, /* We only need MICVDD */
 	},
 	{
 		.name = "cs47l15-codec",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l15_supplies,
 		.num_parent_supplies = ARRAY_SIZE(cs47l15_supplies),
 	},
@@ -80,15 +87,23 @@ static const char * const cs47l35_supplies[] = {
 static const struct mfd_cell cs47l35_devs[] = {
 	{ .name = "madera-pinctrl", },
 	{ .name = "madera-irq", },
-	{ .name = "madera-micsupp", },
-	{ .name = "madera-gpio", },
+	{
+		.name = "madera-micsupp",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
+	{
+		.name = "madera-gpio",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
 	{
 		.name = "madera-extcon",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l35_supplies,
 		.num_parent_supplies = 1, /* We only need MICVDD */
 	},
 	{
 		.name = "cs47l35-codec",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l35_supplies,
 		.num_parent_supplies = ARRAY_SIZE(cs47l35_supplies),
 	},
@@ -108,15 +123,23 @@ static const char * const cs47l85_supplies[] = {
 static const struct mfd_cell cs47l85_devs[] = {
 	{ .name = "madera-pinctrl", },
 	{ .name = "madera-irq", },
-	{ .name = "madera-micsupp" },
-	{ .name = "madera-gpio", },
+	{
+		.name = "madera-micsupp",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
+	{
+		.name = "madera-gpio",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
 	{
 		.name = "madera-extcon",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l85_supplies,
 		.num_parent_supplies = 1, /* We only need MICVDD */
 	},
 	{
 		.name = "cs47l85-codec",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l85_supplies,
 		.num_parent_supplies = ARRAY_SIZE(cs47l85_supplies),
 	},
@@ -134,15 +157,23 @@ static const char * const cs47l90_supplies[] = {
 static const struct mfd_cell cs47l90_devs[] = {
 	{ .name = "madera-pinctrl", },
 	{ .name = "madera-irq", },
-	{ .name = "madera-micsupp", },
-	{ .name = "madera-gpio", },
+	{
+		.name = "madera-micsupp",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
+	{
+		.name = "madera-gpio",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
 	{
 		.name = "madera-extcon",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l90_supplies,
 		.num_parent_supplies = 1, /* We only need MICVDD */
 	},
 	{
 		.name = "cs47l90-codec",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l90_supplies,
 		.num_parent_supplies = ARRAY_SIZE(cs47l90_supplies),
 	},
@@ -157,15 +188,23 @@ static const char * const cs47l92_supplies[] = {
 static const struct mfd_cell cs47l92_devs[] = {
 	{ .name = "madera-pinctrl" },
 	{ .name = "madera-irq", },
-	{ .name = "madera-micsupp", },
-	{ .name = "madera-gpio" },
+	{
+		.name = "madera-micsupp",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
+	{
+		.name = "madera-gpio",
+		.tag = MADERA_OPTIONAL_DRIVER,
+	},
 	{
 		.name = "madera-extcon",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l92_supplies,
 		.num_parent_supplies = 1, /* We only need MICVDD */
 	},
 	{
 		.name = "cs47l92-codec",
+		.tag = MADERA_OPTIONAL_DRIVER,
 		.parent_supplies = cs47l92_supplies,
 		.num_parent_supplies = ARRAY_SIZE(cs47l92_supplies),
 	},
@@ -743,18 +782,22 @@ int madera_dev_exit(struct madera *madera)
 	/* Prevent any IRQs being serviced while we clean up */
 	disable_irq(madera->irq);
 
-	/*
-	 * DCVDD could be supplied by a child node, we must disable it before
-	 * removing the children, and prevent PM runtime from turning it back on
-	 */
-	pm_runtime_disable(madera->dev);
+	pm_runtime_get_sync(madera->dev);
 
-	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+	mfd_remove_devices_by_tag(madera->dev, MADERA_OPTIONAL_DRIVER);
+
+	pm_runtime_disable(madera->dev);
 
 	regulator_disable(madera->dcvdd);
 	regulator_put(madera->dcvdd);
 
 	mfd_remove_devices(madera->dev);
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

