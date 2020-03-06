Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4487BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2886D2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCFQP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:15:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44420 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgCFQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:15:57 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026GF32T021743;
        Fri, 6 Mar 2020 11:15:56 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yfnray0m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 11:15:55 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 026GFscX039533
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Mar 2020 11:15:54 -0500
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Mar 2020 08:15:53 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Mar 2020 08:15:19 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 6 Mar 2020 08:15:52 -0800
Received: from saturn.ad.analog.com ([10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 026GFmB9003555;
        Fri, 6 Mar 2020 11:15:50 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] uio: uio_pdrv_genirq: use new devm_uio_register_device() function
Date:   Fri, 6 Mar 2020 18:18:53 +0200
Message-ID: <20200306161853.25368-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306161853.25368-1-alexandru.ardelean@analog.com>
References: <20200306161853.25368-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_05:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=545 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes use of the new devm_uio_register_device() initializer.
This cleans up the exit path quite nicely, and removes the remove function
of the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_pdrv_genirq.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index fc25ce90da3b..ae319ef3a832 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -99,6 +99,13 @@ static int uio_pdrv_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	return 0;
 }
 
+static void uio_pdrv_genirq_cleanup(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_disable(dev);
+}
+
 static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 {
 	struct uio_info *uioinfo = dev_get_platdata(&pdev->dev);
@@ -213,28 +220,16 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_enable(&pdev->dev);
 
-	ret = uio_register_device(&pdev->dev, priv->uioinfo);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register uio device\n");
-		pm_runtime_disable(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev, uio_pdrv_genirq_cleanup,
+				       &pdev->dev);
+	if (ret)
 		return ret;
-	}
-
-	platform_set_drvdata(pdev, priv);
-	return 0;
-}
-
-static int uio_pdrv_genirq_remove(struct platform_device *pdev)
-{
-	struct uio_pdrv_genirq_platdata *priv = platform_get_drvdata(pdev);
 
-	uio_unregister_device(priv->uioinfo);
-	pm_runtime_disable(&pdev->dev);
-
-	priv->uioinfo->handler = NULL;
-	priv->uioinfo->irqcontrol = NULL;
+	ret = devm_uio_register_device(&pdev->dev, priv->uioinfo);
+	if (ret)
+		dev_err(&pdev->dev, "unable to register uio device\n");
 
-	return 0;
+	return ret;
 }
 
 static int uio_pdrv_genirq_runtime_nop(struct device *dev)
@@ -271,7 +266,6 @@ MODULE_PARM_DESC(of_id, "Openfirmware id of the device to be handled by uio");
 
 static struct platform_driver uio_pdrv_genirq = {
 	.probe = uio_pdrv_genirq_probe,
-	.remove = uio_pdrv_genirq_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.pm = &uio_pdrv_genirq_dev_pm_ops,
-- 
2.20.1

