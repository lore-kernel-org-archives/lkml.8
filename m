Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A74C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFB3206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HlPF7c03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgFPOGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:06:36 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:1384 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728928AbgFPOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:06:32 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GE413U031762;
        Tue, 16 Jun 2020 09:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=tDwZrzOaf+kwqgr496ZZbxdWP63PFoZujF0vFUMPp2o=;
 b=HlPF7c03fhruewxm8WfdpOrUwvTHvq1Qe/mYdlJGVbM9oiJgid7+QW4b1fh9cQJnIrS4
 eKl+w9BnvZm++QnNUb2jMWNiGbk3CcBXMJVJ6VBHEyi+0FkAXANJGfXsqnBMRWTdzErl
 DNwL3BIFoWEJauGsx12fD0Ga8aQ5/VLR6MfENrFePIHwT/O04NXvbGsrwtVW8vr86s5O
 HrPXDQ3hfr/RjPqppZNMFblquv3SQj/7nr8R7r71fhw5SXF3a3klB5d48A3BRFwi3hSy
 aCpAEGIFI8biNjGP1X7q0QHcKSRgvOa6LKagc+b6vhhdRgRZDFQNKw4LFIvDpsLRxcqX Kg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31mv73mgrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 09:06:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 16 Jun
 2020 15:06:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 16 Jun 2020 15:06:27 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CDED9448;
        Tue, 16 Jun 2020 14:06:27 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v3 2/2] mfd: madera: Improve handling of regulator unbinding
Date:   Tue, 16 Jun 2020 15:06:27 +0100
Message-ID: <20200616140627.17170-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200616140627.17170-1-ckeepax@opensource.cirrus.com>
References: <20200616140627.17170-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=906
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=1
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160103
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

Changes since v2:
 - Moved to new mfd_remove_devices_late

Thanks,
Charles

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

