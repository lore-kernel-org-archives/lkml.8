Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A3C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE26222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jn8W6Old"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgANPKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:10:54 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42754 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgANPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:10:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFAojg004601;
        Tue, 14 Jan 2020 09:10:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=oZ3UOLHNg5cmYLllMOV3BK0IOa3Edehb6BWYGoMVahM=;
 b=jn8W6Old1pR8vjUksNHf4P/+u3ioTg6jC+/vTSzsjpbPY4GAgK+9CeluSk+zLEdeNlsz
 eZVBxsdakEC9RLd6r7BrBLz87hQXTmZ8LUxJyJv91yiNS48w3GASwRGLXZJcJxXnE5vN
 fUyw41ghzEMFQjvM7RJZkU024MccFwHv0tWzCg+9W3Glp9JJMBGZamPSYvnf0IEFUDSf
 Miiz/AUNr0il5lpkkYrVVLt+onks5mlfO0KVGg7PlDEPEjVyVmgxxp0ZcAQ6R/A7crUZ
 Y0reSGHWVC8rvK3AdXZD3p3NYnRWs3zVGzvBLFnLj51A6vixOCzB7h6UVV8uENBTfZrC gw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xfbntvpsa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jan 2020 09:10:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 14 Jan
 2020 15:10:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 14 Jan 2020 15:10:48 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CDAFD2D4;
        Tue, 14 Jan 2020 15:10:48 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/3] mfd: madera: Allow more time for hardware reset
Date:   Tue, 14 Jan 2020 15:10:48 +0000
Message-ID: <20200114151048.20282-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
References: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=1 priorityscore=1501 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both manual and power on resets have a brief period where the chip will
not be accessible immediately afterwards. Extend the time allowed for
this from a minimum of 1mS to 2mS based on newer evaluation of the
hardware and ensure this reset happens in all reset conditions. Whilst
making the change also remove the redundant NULL checks in the reset
functions as the GPIO functions already check for this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Switch from a helper function to defines for the delay

This patch can be applied separately from the other patches in the series,
if needed.

Thanks,
Charles

 drivers/mfd/madera-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a7d50a7fa625d..7e0835cb062b1 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -35,6 +35,9 @@
 
 #define MADERA_32KZ_MCLK2	1
 
+#define MADERA_RESET_MIN_US	2000
+#define MADERA_RESET_MAX_US	3000
+
 static const char * const madera_core_supplies[] = {
 	"AVDD",
 	"DBVDD1",
@@ -256,16 +259,13 @@ static int madera_soft_reset(struct madera *madera)
 	}
 
 	/* Allow time for internal clocks to startup after reset */
-	usleep_range(1000, 2000);
+	usleep_range(MADERA_RESET_MIN_US, MADERA_RESET_MAX_US);
 
 	return 0;
 }
 
 static void madera_enable_hard_reset(struct madera *madera)
 {
-	if (!madera->pdata.reset)
-		return;
-
 	/*
 	 * There are many existing out-of-tree users of these codecs that we
 	 * can't break so preserve the expected behaviour of setting the line
@@ -276,11 +276,9 @@ static void madera_enable_hard_reset(struct madera *madera)
 
 static void madera_disable_hard_reset(struct madera *madera)
 {
-	if (!madera->pdata.reset)
-		return;
-
 	gpiod_set_raw_value_cansleep(madera->pdata.reset, 1);
-	usleep_range(1000, 2000);
+
+	usleep_range(MADERA_RESET_MIN_US, MADERA_RESET_MAX_US);
 }
 
 static int __maybe_unused madera_runtime_resume(struct device *dev)
@@ -299,6 +297,8 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
+	usleep_range(MADERA_RESET_MIN_US, MADERA_RESET_MAX_US);
+
 	ret = madera_wait_for_boot(madera);
 	if (ret)
 		goto err;
-- 
2.11.0

