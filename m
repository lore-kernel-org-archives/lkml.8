Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D6C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8C42076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h9Xf3BBb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="f5O+AxRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHTNta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:49:30 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49024 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730360AbgHTNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:38:51 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KDZKp9004650;
        Thu, 20 Aug 2020 06:38:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=zBBLu7HUgXmF/EFUE6V3RsAR6ZyTq/hhPB0GN6/des0=;
 b=h9Xf3BBbaJZHmTqhUsSJqzV/qLSESO5oXNUu7Dc/z5Bn/RXTeLc2ya35YSb8bgv3sY3+
 wiXsKC0eTfB9cSQ9JRHAIY/773T+SAIQTR64HLNgUw4E9bJD6qo7Lm0YXlEIY86EBpgj
 7b/rTvxPI2XKUhkK1SzCOMQ29SyJ/RKMX3kEWeW3fRMGQFB+6Xf7jvPsNqkNfCCO6vH7
 Fv2O7uwXyMvyvi6lqTvwAJq5RVXEnvSCb7/hRMIclW39xL6aaWIEHm/7r6Mg2G41VWtC
 Iv9p1kda6pfumDyo9I4PGl5Lt1shzdCjs315UbIh3O6J2r2RnUOxliOqAiLNt/YR+Yy3 1g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3306jnt9t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 06:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5JRe3+JoorSoKuB3MmmbX3uHu1ywOH6HMs9QEO6Ob11udqKq8aFSbW0Ly1RMSLaG7pg8oBmzfweA7EE5AlsXNxEaVnbnudcp65DbJ4jXUvsq2VFQ5rcuU9OmFFvO2Q9JoWiXZfLvfUkCWEp/EA11Vr2L58qWTeSnUCTNvjtw8dJLtLXAysaH/Cwv3NF7/gtxG60z5lrVadICt4VV+C+qatKAvQpZ4Tu/T0/o+jREQdehIWIueIGyUyWs5uEoLoTTnhhsrAGom+/xPL7FqUB+2QonY7Hy0Gce+HqDhtOv8o+mYotKCTpeNaDA/zWQSsgEufKsCBEQcHgBZN3AZNYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBBLu7HUgXmF/EFUE6V3RsAR6ZyTq/hhPB0GN6/des0=;
 b=gr8EwBzE+sKkM8hINjf6PPGYo77MnN5HaWFKnRec/uZZ27FdxLvY0C1iNq6YVlhN3HR1C9kt4toR9glOuChtVrJeBez7sL+lh+tTtheO3QeSUw7mP8D/9IqiBLEos2bmr5NBs6Vg1m3yVm6vHzn2EG5pSKKUPXH1nPYxs1hmF+r7Bv283NNnaY1VVFUOa7fjJgTgLzrLgy5f401pJ42WuhtIBhx8w9m0idxXW6tmWumKcaqbgVCzY8yChwU8QbEeDj04BK+Kw7MSc8VFNVDISU2f49+9KCV9CQRWHcTUj1xhQkKLUsbAcQkvmeq5JUo4Rj8e++OJgDWL9Vy8hx1EBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBBLu7HUgXmF/EFUE6V3RsAR6ZyTq/hhPB0GN6/des0=;
 b=f5O+AxRVqmtHSRtB48F4YMhFCpIDG5/n+IYMHV5otMbj6F90vaNlVm/RoDr1bk48V1sbjCkF5sPxpliVtFcd8cda514I7PiI6Rp6e9rW5x4XewA44c3nRLfI7+1w0OzlwgbcRnToPcmKzZQwQIr5gM4URGZP5nYa7atoWdmoR3Q=
Received: from BN6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:404:10::11)
 by SN6PR07MB4352.namprd07.prod.outlook.com (2603:10b6:805:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 13:38:36 +0000
Received: from BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10:cafe::e2) by BN6PR03CA0097.outlook.office365.com
 (2603:10b6:404:10::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 13:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT059.mail.protection.outlook.com (10.13.183.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Thu, 20 Aug 2020 13:38:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07KDcVpV016996
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Aug 2020 09:38:33 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 20 Aug 2020 15:38:30 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 20 Aug 2020 15:38:30 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07KDcUV8015786;
        Thu, 20 Aug 2020 15:38:30 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07KDcSiQ015784;
        Thu, 20 Aug 2020 15:38:28 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v3] i3c: master: fix for SETDASA and DAA process
Date:   Thu, 20 Aug 2020 15:38:26 +0200
Message-ID: <1597930706-15744-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c661d762-21f2-4e63-4149-08d8450e568c
X-MS-TrafficTypeDiagnostic: SN6PR07MB4352:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4352DC10FE71B9F22C6A8858C15A0@SN6PR07MB4352.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HJ/uyArF0dP9/f8LF148UfPGeAHnXVdoljNYJ4peGCwrK9SkZn/fIBuhfBQyqB3EplX+b6NPZuTWUZTVqktwpDzhQ7y37oCl2WaP6U+fb9qHZA4SCtGN0cW0Bgr4r5+hmXmoJif0MrM910wdw5P1M/KxEYykFRkrrUP3aiXbqxnqmGmx8MHVvCNDZlVuujszYH8EyIt0HMB4Kjgzu5BuOKznbtsgsMwMzDHxqHyWa/AtoTyDfeGVxGYWW4j6jqhJ8rzbQphzr+KX83jwrzKY0qWY26U1VBHrdRUpTb2VVR0YsbSHqaBsst7cuyJlv1AM9QvO/OiZ+SdIvyUR8I4QEmqT+kVCHHv7aj0gcakfMEGknrEoesDoLV3FodppjcTjXJOQWj83+fQ8CSSY2iC9ffqAUJbznKSHrOvL11WeUA=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(46966005)(110136005)(36756003)(26005)(478600001)(186003)(5660300002)(316002)(426003)(336012)(47076004)(83380400001)(2906002)(2616005)(107886003)(8676002)(82310400002)(8936002)(42186006)(54906003)(86362001)(4326008)(356005)(70206006)(70586007)(81166007)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 13:38:35.6566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c661d762-21f2-4e63-4149-08d8450e568c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4352
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=2
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008200113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix following issue.
Controller slots blocked for devices with static_addr
but no init_dyn_addr may limit the number of I3C devices
on the bus which gets dynamic address in DAA. So
instead of attaching all the devices with static_addr,
now we only attach the devices which successfully
complete SETDASA. For remaining devices with init_dyn_addr,
i3c_master_add_i3c_dev_locked() will try to set requested
dynamic address after DAA.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
Changes between v2 and v3 are:
1. Keeping init_dyn_addr reserved.
2. Code refactoring and changes in comments.

Changes between v1 and v2 are:
1. Added boardinfo attach fix.
2. Removed reattach issue related fix.
3. Reserve init_dyn_addr initially, so that it will not
   be used in DAA and  attempt can be made to set those
   firmware requested dynamic address after DAA.
---
 drivers/i3c/master.c |  115 ++++++++++++++++++++++++++++----------------------
 1 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3d995f2..24543d8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1367,7 +1367,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr) {
+	if (dev->info.dyn_addr != old_dyn_addr &&
+	    (!dev->boardinfo ||
+	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
 		status = i3c_bus_get_addr_slot_status(&master->bus,
 						      dev->info.dyn_addr);
 		if (status != I3C_ADDR_SLOT_FREE)
@@ -1426,33 +1428,49 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
 		master->ops->detach_i2c_dev(dev);
 }
 
-static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
+static int i3c_master_pre_assign_dyn_addr(struct i3c_master_controller *master,
+					  struct i3c_dev_boardinfo *boardinfo)
 {
-	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_device_info info = {
+		.static_addr = boardinfo->static_addr,
+	};
+	struct i3c_dev_desc *i3cdev;
 	int ret;
 
-	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
-	    !dev->boardinfo->static_addr)
-		return;
+	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+	if (IS_ERR(i3cdev))
+		return -ENOMEM;
+
+	i3cdev->boardinfo = boardinfo;
 
-	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
-					dev->boardinfo->init_dyn_addr);
+	ret = i3c_master_attach_i3c_dev(master, i3cdev);
 	if (ret)
-		return;
+		goto err_attach;
+
+	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
+					i3cdev->boardinfo->init_dyn_addr);
+	if (ret)
+		goto err_setdasa;
 
-	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
-	ret = i3c_master_reattach_i3c_dev(dev, 0);
+	i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
+	ret = i3c_master_reattach_i3c_dev(i3cdev, 0);
 	if (ret)
 		goto err_rstdaa;
 
-	ret = i3c_master_retrieve_dev_info(dev);
+	ret = i3c_master_retrieve_dev_info(i3cdev);
 	if (ret)
 		goto err_rstdaa;
 
-	return;
+	return 0;
 
 err_rstdaa:
-	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
+	i3c_master_rstdaa_locked(master, i3cdev->boardinfo->init_dyn_addr);
+err_setdasa:
+	i3c_master_detach_i3c_dev(i3cdev);
+err_attach:
+	i3c_master_free_i3c_dev(i3cdev);
+
+	return ret;
 }
 
 static void
@@ -1619,8 +1637,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
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
@@ -1633,10 +1651,14 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
  * 4. Disable all slave events.
  *
  * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for I3C
- *    devices that have a static address
+ *    devices that have a static address and attach corresponding statically
+ *    defined I3C devices to the master. If only init_dyn_addr is available
+ *    or if SETDASA fails, reserve those init_dyn_addr to be used later to set
+ *    address using SETNEWDA after DAA.
  *
  * 6. Do a DAA (Dynamic Address Assignment) to assign dynamic addresses to all
- *    remaining I3C devices
+ *    remaining I3C devices and attach them to the master if the dynamic address
+ *    assignment succeeds
  *
  * Once this is done, all I3C and I2C devices should be usable.
  *
@@ -1647,7 +1669,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1679,34 +1700,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
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
@@ -1744,10 +1737,32 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 
 	/*
 	 * Pre-assign dynamic address and retrieve device information if
-	 * needed.
+	 * needed. And reserve the init_dyn_addr in case of failure, to retry
+	 * setting the requested address after DAA is done in
+	 * i3c_master_add_i3c_dev_locked().
 	 */
-	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
-		i3c_master_pre_assign_dyn_addr(i3cdev);
+	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
+		/*
+		 * We don't attach devices which are not addressable
+		 * (no static_addr and dyn_addr) and devices with static_addr
+		 * but no init_dyn_addr will participate in DAA.
+		 */
+		if (!i3cboardinfo->init_dyn_addr ||
+		    (i3cboardinfo->static_addr &&
+		     !i3c_master_pre_assign_dyn_addr(master, i3cboardinfo)))
+			continue;
+
+		ret = i3c_bus_get_addr_slot_status(&master->bus,
+						   i3cboardinfo->init_dyn_addr);
+		if (ret != I3C_ADDR_SLOT_FREE) {
+			ret = -EBUSY;
+			goto err_rstdaa;
+		}
+
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     i3cboardinfo->init_dyn_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+	}
 
 	ret = i3c_master_do_daa(master);
 	if (ret)
-- 
1.7.1

