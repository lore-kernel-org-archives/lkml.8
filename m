Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACFFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAF020735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XVg+Upd2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QimQe5iv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgEKNNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:13:23 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:4520 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:13:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDALTK008908;
        Mon, 11 May 2020 06:13:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=4FRcNFjZwGmvKQB8przLp4g01TtaSXbGNg+J/Gf1cKU=;
 b=XVg+Upd2u1Mvqo1VddLDp5V0SXnueFYVLtG1+yvqBsOm9K1ConzRSspFH6UXC31Dp7AR
 17GLnOzcZY82jJEN+8bsip2eTanl+hxKp4UOmWkq/dKIUCqz5Npq1V+yLy6sbZyDjqNg
 M3aJq2evNIuAogbX18Dpg7l7SP6rUsPgeq2T2Df+qZs071/dTKZeG/xfX/ELzqNs64ob
 MmvQLOsj2B+IRu/ObUno42g35iyz+dHgyhNLsB/OUrMO0gzMIB+FXfSn+qLKOO1RFfDo
 LSyPc8/L8iGSB5EoqCLVtJ6a3Lpgyh1bw5YLbgTVvUkBUSStAU++QaSYHtpIQ4Uhr24w tA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xeag9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yar66oRySfYf2ipguupX8rrtnIOPMWtSoui2xUJHrNui6XBWwqiFXHw5CqSjA61zmvGHx9434pU3dGxhU+RJyZa6EjuNu3OeqsbmvtLmSfjRpGawcdZcrrrSYrExEvJ3iejlwumyWfmAMhMmby768PzJCcmQ6w5L/HKFAyTvTiOMplDqlnw/gAYJBn/DW/uhNdUcJ4NYOldzQQRvHzlOTftjJH81datIhhNRCRgIAynkdu6qeWQfQ9Bk0t5UFp/01s/VsWkq+G4oTfcv31h7ZzAEiD0gW+jm+C0ZAhT95bMEwDGfxE1Uga679WQGIupofTPrGfFloYWZDuVBTIBVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FRcNFjZwGmvKQB8przLp4g01TtaSXbGNg+J/Gf1cKU=;
 b=Whzl/cNFJ5nFrt9mbdvfuOW0URVy3n+23glObjvp4jjcANWG+st89KTofNnK+xzDQ4dX94EkdU6nQTvALqsepu/SDmldgjG6H0bGGNE7ZZPGtLUI5VBeHtoykf/jwVxUlZi7XWHkDOW0qvzu1PYEdpQAr9hSrn5Bvpm7yNgdSmN3g0i5HZTavsBhN9XvX1uSdA0CIpQl6UTFqxxLi1N9nSZD1epkHeIeUyS4Lylz4bJbrl0GMTLt8RWoMfAhspBe5OtSpPRWfKEKK4OMuSOA+1lpH+rU/qv3/rs5Z8aKAPQcvIKiMDm0JAIAVp7G79o2NreJSaW6Sj0MKNhYhqWVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FRcNFjZwGmvKQB8przLp4g01TtaSXbGNg+J/Gf1cKU=;
 b=QimQe5ivVFak4Bt5/tPPBq+vCxeM6qK/8Jmq/HuK5w8meztX1C9ZZ3Wd4Q6oFrAGdU+3JmxOycn5XZlsl27jowSYlU6IDMqkdnGLi/DGu30WD1+q0HQ4wm3KqjxGDUqslDRnbACgq0X3snQ40TA7AHZQeMhlo2t89xMCVB11/VM=
Received: from BN6PR08CA0078.namprd08.prod.outlook.com (2603:10b6:404:b6::16)
 by BN8PR07MB6065.namprd07.prod.outlook.com (2603:10b6:408:6c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Mon, 11 May
 2020 13:13:11 +0000
Received: from BN8NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::5a) by BN6PR08CA0078.outlook.office365.com
 (2603:10b6:404:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Mon, 11 May 2020 13:13:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT032.mail.protection.outlook.com (10.13.183.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:13:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDD8ud031288
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2020 06:13:09 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:13:07 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:13:07 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDD7uQ006260;
        Mon, 11 May 2020 15:13:07 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDD7T1006258;
        Mon, 11 May 2020 15:13:07 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 2/7] i3c: master: use i3c_master_register only for main master
Date:   Mon, 11 May 2020 15:13:05 +0200
Message-ID: <1589202785-6174-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36092001)(46966005)(33430700001)(54906003)(2616005)(426003)(110136005)(356005)(316002)(42186006)(2906002)(26005)(47076004)(107886003)(86362001)(8936002)(7636003)(82740400003)(8676002)(82310400002)(33440700001)(4326008)(336012)(478600001)(5660300002)(36756003)(70206006)(36906005)(186003)(70586007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a380fd1-04d5-4cdb-ae02-08d7f5ad0ddc
X-MS-TrafficTypeDiagnostic: BN8PR07MB6065:
X-Microsoft-Antispam-PRVS: <BN8PR07MB606544BB3AFB75DBB6380F57C1A10@BN8PR07MB6065.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ut/MY4dlrjZ8M3I80qUWfMlf9p9gYsaO/rzLC1wtulKkLrO9JAXNRmh7rgTkAoVfX2nvFTCoDz5FCsFoFHUjMP9Yr5wpCg9pC174UOE9Ly7pZYUrKO/h8ZYNL//yxUgNrthadVTT9rymXmdsCpnHZ48qonuNp+QQWbj4rEqIXeCaP1BjIcCAov19lNj+8HZCXoqqeBhUzzGsmkdInA4CY8/ZLDvw9a+49KFS/wSFl42uw/LNaV7Ojo0Sj2cuRYEZ80L4bxx9hkaDsZIpcaGpkwfKAuHdcQU0woTUcjn5fQtwdkE7sXwp92dsgkGL4H84GznkhUeBf2jTGtu3nnQE3g4CBohNlYBE0Sp29x6ju0ZRGguBleBDtaKFSCihsXMw2LkP+DS6g3KxhEmsVQcbiLlxQjt8stbS/yZhVLVX3nesrZsIMXj6yL1sQSPBqaQn+DTcGrgp0basnDqCp1LzMFBkrsqEm+zsInykVlzjNKcbKOMy30orDBGFqdWEyeWf2TU40Thy7X+A1EnpDssgmEsVhe+m23ugt2F9FwRlY3v+HngfPWQMDr4p83LQ5E1bAEU0+79ugJzvdn9AyIHCuXfos+lVTyia6p8IIEgxVbk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:13:10.5568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a380fd1-04d5-4cdb-ae02-08d7f5ad0ddc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6065
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=2 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed last argument 'secondary' and refactored
i3c_master_register to move code that can be common
to i3c_secondary_master_register to separate function
i3c_master_init.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c                 | 69 +++++++++++++++++-----------
 drivers/i3c/master/dw-i3c-master.c   |  2 +-
 drivers/i3c/master/i3c-master-cdns.c |  2 +-
 include/linux/i3c/master.h           |  3 +-
 4 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52121fe..ba07a7d49633 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2391,31 +2391,10 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	return 0;
 }
 
-/**
- * i3c_master_register() - register an I3C master
- * @master: master used to send frames on the bus
- * @parent: the parent device (the one that provides this I3C master
- *	    controller)
- * @ops: the master controller operations
- * @secondary: true if you are registering a secondary master. Will return
- *	       -ENOTSUPP if set to true since secondary masters are not yet
- *	       supported
- *
- * This function takes care of everything for you:
- *
- * - creates and initializes the I3C bus
- * - populates the bus with static I2C devs if @parent->of_node is not
- *   NULL
- * - registers all I3C devices added by the controller during bus
- *   initialization
- * - registers the I2C adapter and all I2C devices
- *
- * Return: 0 in case of success, a negative error code otherwise.
- */
-int i3c_master_register(struct i3c_master_controller *master,
-			struct device *parent,
-			const struct i3c_master_controller_ops *ops,
-			bool secondary)
+static int i3c_master_init(struct i3c_master_controller *master,
+			   struct device *parent,
+			   const struct i3c_master_controller_ops *ops,
+			   bool secondary)
 {
 	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
 	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
@@ -2482,6 +2461,45 @@ int i3c_master_register(struct i3c_master_controller *master,
 	if (ret)
 		goto err_put_dev;
 
+	return 0;
+
+err_put_dev:
+	put_device(&master->dev);
+
+	return ret;
+}
+
+/**
+ * i3c_master_register() - register an I3C master
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ * @secondary: true if you are registering a secondary master. Will return
+ *	       -ENOTSUPP if set to true since secondary masters are not yet
+ *	       supported
+ *
+ * This function takes care of everything for you:
+ *
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ * - registers all I3C devices added by the controller during bus
+ *   initialization
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_register(struct i3c_master_controller *master,
+			struct device *parent,
+			const struct i3c_master_controller_ops *ops)
+{
+	int ret;
+
+	ret = i3c_master_init(master, parent, ops, false);
+	if (ret)
+		return ret;
+
 	ret = device_add(&master->dev);
 	if (ret)
 		goto err_cleanup_bus;
@@ -2511,7 +2529,6 @@ int i3c_master_register(struct i3c_master_controller *master,
 err_cleanup_bus:
 	i3c_master_bus_cleanup(master);
 
-err_put_dev:
 	put_device(&master->dev);
 
 	return ret;
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1d83c97431c7..5d5a8a90ec06 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1158,7 +1158,7 @@ static int dw_i3c_probe(struct platform_device *pdev)
 	master->free_pos = GENMASK(master->maxdevs - 1, 0);
 
 	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &dw_mipi_i3c_ops, false);
+				  &dw_mipi_i3c_ops);
 	if (ret)
 		goto err_assert_rst;
 
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 8889a4fdb454..ed4f43807f9e 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1615,7 +1615,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
 	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &cdns_i3c_master_ops, false);
+				  &cdns_i3c_master_ops);
 	if (ret)
 		goto err_disable_sysclk;
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index f13fd8b1dd79..f5ba82c390bc 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -533,8 +533,7 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 
 int i3c_master_register(struct i3c_master_controller *master,
 			struct device *parent,
-			const struct i3c_master_controller_ops *ops,
-			bool secondary);
+			const struct i3c_master_controller_ops *ops);
 int i3c_master_unregister(struct i3c_master_controller *master);
 
 /**
-- 
2.17.1

