Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2443BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFDC2468E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dLJA13JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAVLIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:08:51 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:4700 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgAVLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:08:47 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MB1Rpm005799;
        Wed, 22 Jan 2020 05:08:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=x1yMu7o79Jw/xPDHt66WPliG8dBpE+NmweeSPNWuINM=;
 b=dLJA13JKuUutxwMq3nAVV73TC1THZRwtRXzt7bRxcZhPZXi8icAj6FNPtn+oXDeyAOBY
 bt0fDqH3QOgq7TuQidoHWsazn0pccEctLCbfw708VDwjtXJKFZ2Ut7Hee71zkf9YAwFN
 WyGuRcfoIliNP7RcS833ytRuoxq2HYyAn/9nhn0WoqixiDtnCLDrEYN8bFq/XlFSU8e3
 7zXoctj47BU0i21tQ3CxAqQpDQ7gWgYnhkDzPx6g3POQARnIu6E+2JvigGMqIBQOHPQ+
 mg3pej0S17kPLis2ofRa5sN12g+O43cHlATvhSWdyos/OE3LgJSSgPI5P83q6PQStqyC Wg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xm00ed9h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jan 2020 05:08:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 22 Jan
 2020 11:08:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 22 Jan 2020 11:08:42 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 178F82C8;
        Wed, 22 Jan 2020 11:08:42 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <lee.jones@linaro.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of regulator unbinding
Date:   Wed, 22 Jan 2020 11:08:41 +0000
Message-ID: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=561
 phishscore=0 spamscore=0 bulkscore=2 adultscore=0 lowpriorityscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001220101
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
released after all the MFD children, except for the regulator child
itself, have been removed. This is achieved by having the regulator
driver itself do the disable/put, as it is the last driver removed from
the MFD.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/arizona-ldo1.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 1a3d7b720f5e0..83dd37dbfe07b 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -375,6 +375,18 @@ static int madera_ldo1_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int madera_ldo1_remove(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+
+	if (madera->internal_dcvdd) {
+		regulator_disable(madera->dcvdd);
+		regulator_put(madera->dcvdd);
+	}
+
+	return arizona_ldo1_remove(pdev);
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
 	.remove = arizona_ldo1_remove,
@@ -385,7 +397,7 @@ static struct platform_driver arizona_ldo1_driver = {
 
 static struct platform_driver madera_ldo1_driver = {
 	.probe = madera_ldo1_probe,
-	.remove = arizona_ldo1_remove,
+	.remove = madera_ldo1_remove,
 	.driver		= {
 		.name	= "madera-ldo1",
 	},
-- 
2.11.0

