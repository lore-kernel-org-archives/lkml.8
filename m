Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9318AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BEA2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WNMywFer";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="N4i1Oo1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgENQae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:30:34 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48062 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725973AbgENQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:30:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EGSebj005736;
        Thu, 14 May 2020 09:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=KrEPjDQfBJ55WUXvAN2iF+b6bRRwMQzFFzZ9Wu3S/fo=;
 b=WNMywFerwawT7d7aXKXSc1NoO/FbNhcIrtoC73++xb8W2fpmxE04DWaMV4XK3TobFfKi
 MB/e1BfI0CrPDwUmEJnon09CjbKdOpiW7Vp4WlUWwq38T8CQYgY/HdElIOhGG+Uk/y5d
 s5HE3qtv9Z5V7dq7aYe3DbRN2LExoweGtbheR5GPYHnL7je3f6Ou2sXn893wfoXt8R/k
 1WVcnuxhbKXYLiqqU4M+SIGN1yUydbbUNwW4t9qSVfMNs1OOKbNsfTZwpAN3Up9XXXiV
 ica5TKZoowKp60ddXhNVeRVuMg0N+HdHOO1nzDI9Iyl/bItQN8QG5oxHb7t+I6AFR8c8 3w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3100wtj0wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXg2rdh/4R68uALkoy94Kf7a3LW79pnuao1LnVL4OYKOOc6KGTxp2Y5sUAilRf+BY24pfVAyQTSkp8v+TUEHtphAQSENyF41wTiSvicQ+96V2LLHZrXT5Sb6PxW/PFx8rokWsRtx/Zd0ZN4e3PEihJB4hQHc83kG5AJ5qjdLSc+CnmNJeSC9BsmHU6XIPZHXBl5srgfbRg/a7Zkpvq6aY4FH9s2OMYA+gB6b9cz7nfzJP9PyN2vqsc4dlR5BuXQvadHh4wPnDWbS1P9C8bYALiaPtqPY6P5YKcRT23BIFZKil8Du/eMtKiWlDqfHCDZ3Zy8+kfVWXCJJFtnRIlsrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrEPjDQfBJ55WUXvAN2iF+b6bRRwMQzFFzZ9Wu3S/fo=;
 b=ZX7jWHfEF8VjgIyDxw5n5fokp18pCXPxOrordPYh8asSTIzqT/8RjVMVrNRBx96MN0nO21MTaUpv5+IYLIZr5E1kDjqy1Aff+8PpzKY4+A6uTAe7vh1pYX5Y9o1fpFWukpEgJJCglmztP97NNMfaktPt3FljjyVUemfiY7JQjzZNGRL2DBKzBaHwI8xUX08qsUcpd/oz1TlNbhyRiihPdIgZt8ncjcK7Wd5xkyDggzyMo2bhPftW0zW+j5BUV16WGlykuRH8WdMsNYfuntSlFwK+q7ls1mbbqQ59nqDzZu6BYZ0NEJmO6xES/m4wmq6hz9qFrbPs71UBb94pHV93Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrEPjDQfBJ55WUXvAN2iF+b6bRRwMQzFFzZ9Wu3S/fo=;
 b=N4i1Oo1tXIgA2v4o3JJbJWhHqJdlr0J8CK4fSPw6C9nmG8j4B9LL7EwkwahajkbZ6VxBxR1rK8rQoQ3JrgtffYg4kpW48o/v3ULVLI+XzaIP/4B3RupjxQU/VXrrNGRY01Epba3NxaIW6R1zngfKEAa381JbNdZxo8hWzC/aJHg=
Received: from DM5PR07CA0029.namprd07.prod.outlook.com (2603:10b6:3:16::15) by
 DM6PR07MB6698.namprd07.prod.outlook.com (2603:10b6:5:1cc::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24; Thu, 14 May 2020 16:30:16 +0000
Received: from DM6NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::3a) by DM5PR07CA0029.outlook.office365.com
 (2603:10b6:3:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 16:30:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT065.mail.protection.outlook.com (10.13.179.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Thu, 14 May 2020 16:30:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 04EGUDYk018154
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 May 2020 09:30:14 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 May 2020 18:30:12 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 May 2020 18:30:12 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04EGUC0L016783;
        Thu, 14 May 2020 18:30:12 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04EGUBRR016771;
        Thu, 14 May 2020 18:30:11 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH] i3c: master: fix for SETDASA and DAA process
Date:   Thu, 14 May 2020 18:30:09 +0200
Message-ID: <1589473809-16708-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36092001)(46966005)(86362001)(36906005)(110136005)(70206006)(70586007)(47076004)(2906002)(82740400003)(54906003)(8676002)(42186006)(316002)(5660300002)(186003)(426003)(8936002)(2616005)(7636003)(478600001)(82310400002)(4326008)(26005)(356005)(36756003)(107886003)(336012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f3c9c0-daf8-4656-6dfa-08d7f824158e
X-MS-TrafficTypeDiagnostic: DM6PR07MB6698:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6698189DC91FDD692C0A78C7C1BC0@DM6PR07MB6698.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24nSN2J10mmxKqVV81BEQbG6TCkcbTLabix2OCqhxS+5kxqSvhQFcJWvAoNRI2LWqZO9F6xE/52hIDExVv+RObIuiyZgNJPMUt3wXJu921bQfbGGoRDFS5FsCP0HnUAuMfmrnDJJJET/Ix+H/8p1xh5TnqANc9sjOiEFpzuPb07VGZbjI+aKG87+MsUZrGdfKDfhR50iz6jwNQBjjhQ+Dmy0TRuRnbLBU7HRkxu/1oqfCd0GgPKMbqaxqdwe6+PplrfrDjp1rFDH+kfhE7FBDirD3yIRXpHjggJxa/T+qFE9/oVdlveQ4VZljrpXVmmsZXG6CDyKhGh9wiN3GLfSrwbOY3WaShXm/wpLU4xyxGfdggYXGhbvIYHLEMHjhqyQJ+6XlJOuVI3wcqcSA2E1x0KiIOWUrPJguzf3hN/hUrILL87sHLmJkr5xn+XA5eJoIWbrxLkwvZlhH2u4XHM9qej4BpqWhfHzwcW3L+XRxzaRkyW/cW7sXEi6Mr/EXVUpKT153AU6GKsxykTIK7SS4JvxxjTfYIb1jO3j0NeaPxI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:30:15.9292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f3c9c0-daf8-4656-6dfa-08d7f824158e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6698
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 clxscore=1015 suspectscore=2 cotscore=-2147483648 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix following issues.
1. Controller slots blocked for devices with static_addr
   but no init_dyn_addr may limit the number of I3C devices
   on the bus which gets dynamic address in DAA. So
   instead of attaching all the devices with static_addr,
   now we only attach the devices which successfully
   complete SETDASA. Remaining devices are handled in DAA.
2. Since we alreay handled devices with init_dyn_addr, removed
   it's handling from i3c_master_add_i3c_dev_locked().
   Now only case handled is devices already with dyn_addr
   participated in DAA, and again got new dyn_addr with an
   extra slot in the master controller.
3. Removed unnecessary i3c_master_reattach_i3c_dev() from
   i3c_master_add_i3c_dev_locked(), right away after finding
   if duplicate device exists in the I3C list.
   In case of different new and old dyn_addr
   i3c_master_reattach_i3c_dev() will fail which is wrong,
   and in case of same dyn_addr it doesn't add anything new.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c | 111 ++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52121fe..f1d929b58549 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1375,6 +1375,11 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
+
+		if (old_dyn_addr)
+			i3c_bus_set_addr_slot_status(&master->bus,
+						     old_dyn_addr,
+						     I3C_ADDR_SLOT_FREE);
 	}
 
 	if (master->ops->reattach_i3c_dev) {
@@ -1426,33 +1431,52 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
 		master->ops->detach_i2c_dev(dev);
 }
 
-static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
+static void i3c_master_pre_assign_dyn_addr(struct i3c_master_controller *master,
+					   struct i3c_dev_boardinfo *boardinfo)
 {
-	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_device_info info = {
+		.static_addr = boardinfo->static_addr,
+	};
+	struct i3c_dev_desc *i3cdev;
 	int ret;
 
-	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
-	    !dev->boardinfo->static_addr)
+	/*
+	 * We anyway don't attach devices which are not addressable
+	 * (no static_addr and dyn_addr) and devices with static_addr
+	 * but no init_dyn_addr will participate in DAA.
+	 */
+	if (!boardinfo->static_addr || !boardinfo->init_dyn_addr)
+		return;
+
+	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+	if (IS_ERR(i3cdev))
 		return;
 
-	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
-					dev->boardinfo->init_dyn_addr);
+	i3cdev->boardinfo = boardinfo;
+
+	ret = i3c_master_attach_i3c_dev(master, i3cdev);
 	if (ret)
 		return;
 
-	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
-	ret = i3c_master_reattach_i3c_dev(dev, 0);
+	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
+					i3cdev->boardinfo->init_dyn_addr);
 	if (ret)
-		goto err_rstdaa;
+		goto err_setdasa;
 
-	ret = i3c_master_retrieve_dev_info(dev);
+	i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
+	ret = i3c_master_reattach_i3c_dev(i3cdev, 0);
 	if (ret)
 		goto err_rstdaa;
 
-	return;
+	ret = i3c_master_retrieve_dev_info(i3cdev);
+	if (ret)
+		goto err_rstdaa;
 
 err_rstdaa:
-	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
+	i3c_master_rstdaa_locked(master, i3cdev->boardinfo->init_dyn_addr);
+err_setdasa:
+	i3c_master_detach_i3c_dev(i3cdev);
+	i3c_master_free_i3c_dev(i3cdev);
 }
 
 static void
@@ -1619,8 +1643,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
  * This function is following all initialisation steps described in the I3C
  * specification:
  *
- * 1. Attach I2C and statically defined I3C devs to the master so that the
- *    master can fill its internal device table appropriately
+ * 1. Attach I2C devs to the master so that the master can fill its internal
+ *    device table appropriately
  *
  * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
  *    the master controller. That's usually where the bus mode is selected
@@ -1647,7 +1671,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1679,34 +1702,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_detach_devs;
 		}
 	}
-	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
-		struct i3c_device_info info = {
-			.static_addr = i3cboardinfo->static_addr,
-		};
-
-		if (i3cboardinfo->init_dyn_addr) {
-			status = i3c_bus_get_addr_slot_status(&master->bus,
-						i3cboardinfo->init_dyn_addr);
-			if (status != I3C_ADDR_SLOT_FREE) {
-				ret = -EBUSY;
-				goto err_detach_devs;
-			}
-		}
-
-		i3cdev = i3c_master_alloc_i3c_dev(master, &info);
-		if (IS_ERR(i3cdev)) {
-			ret = PTR_ERR(i3cdev);
-			goto err_detach_devs;
-		}
-
-		i3cdev->boardinfo = i3cboardinfo;
-
-		ret = i3c_master_attach_i3c_dev(master, i3cdev);
-		if (ret) {
-			i3c_master_free_i3c_dev(i3cdev);
-			goto err_detach_devs;
-		}
-	}
 
 	/*
 	 * Now execute the controller specific ->bus_init() routine, which
@@ -1746,8 +1741,8 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	 * Pre-assign dynamic address and retrieve device information if
 	 * needed.
 	 */
-	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
-		i3c_master_pre_assign_dyn_addr(i3cdev);
+	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node)
+		i3c_master_pre_assign_dyn_addr(master, i3cboardinfo);
 
 	ret = i3c_master_do_daa(master);
 	if (ret)
@@ -1811,7 +1806,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 {
 	struct i3c_device_info info = { .dyn_addr = addr };
 	struct i3c_dev_desc *newdev, *olddev;
-	u8 old_dyn_addr = addr, expected_dyn_addr;
+	u8 old_dyn_addr = addr;
 	struct i3c_ibi_setup ibireq = { };
 	bool enable_ibi = false;
 	int ret;
@@ -1866,39 +1861,25 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 		i3c_master_free_i3c_dev(olddev);
 	}
 
-	ret = i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
-	if (ret)
-		goto err_detach_dev;
-
 	/*
 	 * Depending on our previous state, the expected dynamic address might
 	 * differ:
 	 * - if the device already had a dynamic address assigned, let's try to
-	 *   re-apply this one
-	 * - if the device did not have a dynamic address and the firmware
-	 *   requested a specific address, pick this one
+	 *   re-apply this one. Device with dyn_addr participated in DAA ?
 	 * - in any other case, keep the address automatically assigned by the
 	 *   master
 	 */
-	if (old_dyn_addr && old_dyn_addr != newdev->info.dyn_addr)
-		expected_dyn_addr = old_dyn_addr;
-	else if (newdev->boardinfo && newdev->boardinfo->init_dyn_addr)
-		expected_dyn_addr = newdev->boardinfo->init_dyn_addr;
-	else
-		expected_dyn_addr = newdev->info.dyn_addr;
-
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (old_dyn_addr && old_dyn_addr != newdev->info.dyn_addr) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.
 		 */
 		ret = i3c_master_setnewda_locked(master,
 						 newdev->info.dyn_addr,
-						 expected_dyn_addr);
+						 old_dyn_addr);
 		if (!ret) {
-			old_dyn_addr = newdev->info.dyn_addr;
-			newdev->info.dyn_addr = expected_dyn_addr;
-			i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
+			newdev->info.dyn_addr = old_dyn_addr;
+			i3c_master_reattach_i3c_dev(newdev, addr);
 		} else {
 			dev_err(&master->dev,
 				"Failed to assign reserved/old address to device %d%llx",
-- 
2.17.1

