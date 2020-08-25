Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D116C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590322076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kIy4Mvaq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="itpoxEJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgHYGVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:21:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37214 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgHYGVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:21:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6Ff5u005142;
        Mon, 24 Aug 2020 23:21:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=b51Fa7VwPvrCivb/l0b/RDniP27UiksgCioJXHRmh/g=;
 b=kIy4MvaqsvugSxU6ye8vXsjZ899EVLC2p+z9i3o/r56iHBdIgubXG/FCBRoqcL9PkYZk
 4G5cCvojdykdQPzaGXTiuaa5gvhMfmTArprq+DTDoX+T/SCiSlk19OSRp6ShGUjlKcqT
 kZNq5tYOqr022Poe5dn/Z7SaStMh1RvMVFaOOdzkKzaxZ6QqjXObwcGxA0OywmrceeFr
 d2e52YTCYmU2Cuz4/fTAp7cov5fd9xMP269znx2Jch2j5Izaovv+dk/mtRKIG5CKMS6v
 XfjUAlBqLac+MdrlXatLYRjLSeryzDsWoB9cjgxKuqeaePMHTaBEbQmiRX5FRcc5mpRv tA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxx1rdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 23:21:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDYla8JvkIlPef8g654AXsqv2Iyryin4glB6xItoTLUq3JX+f9y+EugRiAKPS/UCx+Y/V+CHFC2JtLEqAg1OuUv5Z9uodmmXjxRX1s0Yqe9kDrMI2Dw+dVi5fIZhe6hKx2YhH9bglRyNbI62RRxrUpiTv6kR0C8U8W1+UOlTn/UR45I3F+UlW2qx9bZMLfGJ4nEAOhp+ANsqkBiZQxZ/2DV2svtMKKgLiJdPiuRqTTmF80RKHXX+WnBk6vVfrIy4VJVMfAgSsyr2nw4p2F0wjqORj1t6Jj7g0FCT92RvLMTofIJLuelMyN/lPKSEP8JEPcLHS+X7gN9ARvCy+mTtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b51Fa7VwPvrCivb/l0b/RDniP27UiksgCioJXHRmh/g=;
 b=DbxA3VZQjEZOAodeN1Uhs7NicQNAJYTuqoz2nXqbZz4Mg3awfQi7LuO7HsMs+Ebjowo8j88MmvUR2qfz2ENIgac1zhBiNOHL440fykWkAbO8izJdyGnVMs8xl3jEjQXJ8vaeqS+iWPucKGQ6oZzqhvKFi0bhz3qeniiI4OmFxZFWGIZT/iLR/Q5MnoinCLpsJf/WCiDFhD1Xn55LEiO4jywRhdjUKAUxMOem4cuguJSU/SiQt/fRljyh0uCxq3ovjQvSUuCIx/Sw13GzZN2l5lmEmVXIwuI71mO/E75cZ6T6YyTBSWH+8sgVhc9/i9tAClSDUASMRxWVKHS7JEoTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b51Fa7VwPvrCivb/l0b/RDniP27UiksgCioJXHRmh/g=;
 b=itpoxEJ2D9sHV7TD25d0pFrnCX1AJ5w3BpBjQ+oro7Xvu8ALCr4ZRAMwqngMhcdZ84TenR6R+H8Ovw3ASYrcEo+b+ue6KhVXiWHDxqmal0jbRMsWr39g2yWxZ7syIq7gSTPSLNyr075IWSCTRre7vMXMy12kaqPPtutGL6l6v3w=
Received: from DM6PR06CA0005.namprd06.prod.outlook.com (2603:10b6:5:120::18)
 by MW2PR07MB3931.namprd07.prod.outlook.com (2603:10b6:907:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 06:21:16 +0000
Received: from DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::aa) by DM6PR06CA0005.outlook.office365.com
 (2603:10b6:5:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Tue, 25 Aug 2020 06:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT030.mail.protection.outlook.com (10.13.178.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Tue, 25 Aug 2020 06:21:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07P6LCLZ013612
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Aug 2020 23:21:13 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Aug 2020 08:21:11 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Aug 2020 08:21:11 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07P6LBqm009623;
        Tue, 25 Aug 2020 08:21:11 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07P6LAb7009612;
        Tue, 25 Aug 2020 08:21:10 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v5] i3c: master: fix for SETDASA and DAA process
Date:   Tue, 25 Aug 2020 08:21:08 +0200
Message-ID: <1598336468-9564-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b88927a9-83aa-4a3c-fba9-08d848bf1259
X-MS-TrafficTypeDiagnostic: MW2PR07MB3931:
X-Microsoft-Antispam-PRVS: <MW2PR07MB393187B24900C45FFB2382F7C1570@MW2PR07MB3931.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzc9l2G1VV29pqtHbL36pUqxnm1On9o2Fd9lcgp7Wr1o5yUrt1GpskwsbsDfao5GTG4f09yQzgVKdcB5inws+8cujKp/VXG/rXN9kHqgLGBv50Gv2O1Kw2t4TDhO/ylnd+ipqe1A3M0mPasYtqJQ90sHlC++dvzeiCndlorkuWxy5+iNuDCyLL8JN+Ki597BG0iMtrV9Fqjwx9hIcE+Jdx9SG7KelHqpk4zH4uh6FjKc75cJvzSiFkNsPz2XUbrNcCNbJ2PbupzQCz69axZASuf4tcXyni9GOEAbWDT2RWYsmwUlJS0R/r1GRyT3gPpMAse9kQC5utv2x3PdquXb9YuzB4GYS8HIM7FXENEVi3YS3Q4Tg5zuv7tEV4OQb+guiQpHioH0Qf3xQ7THdzKaJtKEMvxb58TddRf1VCXZVrg=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36092001)(46966005)(4326008)(2906002)(82310400002)(478600001)(426003)(5660300002)(356005)(36756003)(7636003)(36906005)(2616005)(186003)(8676002)(336012)(110136005)(42186006)(316002)(86362001)(107886003)(26005)(82740400003)(70586007)(83380400001)(47076004)(54906003)(8936002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 06:21:15.5766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b88927a9-83aa-4a3c-fba9-08d848bf1259
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3931
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following issue.
Controller slots blocked for the devices with only static_addr
or init_dyn_addr may limit the number of I3C devices
on the bus which gets dynamic address in DAA. So
instead of attaching all the devices with static_addr,
now we only attach the devices which successfully
complete SETDASA. Similarly, for the devices with only
init_dyn_addr, init_dyn_addr are reserved, and after DAA
i3c_master_add_i3c_dev_locked() will try to set the requested
dynamic address.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
Changes between v4 and v5 are:
1. Modifications in comments and labels.

Changes between v3 and v4 are:
1. Code rectoring and removed Fixes tag.

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
 drivers/i3c/master.c |  128 +++++++++++++++++++++++++++++--------------------
 1 files changed, 76 insertions(+), 52 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3d995f2..ccf9b4e 100644
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
+static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
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
+		goto err_free_dev;
+
+	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
+					i3cdev->boardinfo->init_dyn_addr);
+	if (ret)
+		goto err_detach_dev;
 
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
+err_detach_dev:
+	i3c_master_detach_i3c_dev(i3cdev);
+err_free_dev:
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
@@ -1632,11 +1650,14 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
  *
  * 4. Disable all slave events.
  *
- * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for I3C
- *    devices that have a static address
+ * 5. Reserve address slots for I3C devices with init_dyn_addr. And if devices
+ *    also have static_addr, try to pre-assign dynamic addresses requested by
+ *    the FW with SETDASA and attach corresponding statically defined I3C
+ *    devices to the master.
  *
  * 6. Do a DAA (Dynamic Address Assignment) to assign dynamic addresses to all
- *    remaining I3C devices
+ *    remaining I3C devices and attach them to the master if the dynamic address
+ *    assignment succeeds
  *
  * Once this is done, all I3C and I2C devices should be usable.
  *
@@ -1647,7 +1668,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1679,34 +1699,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
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
@@ -1743,11 +1735,43 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 
 	/*
-	 * Pre-assign dynamic address and retrieve device information if
-	 * needed.
+	 * Reserve init_dyn_addr first, and then try to pre-assign dynamic
+	 * address and retrieve device information if needed.
+	 * In case pre-assign dynamic address fails, setting dynamic address to
+	 * the requested init_dyn_addr is retried after DAA is done in
+	 * i3c_master_add_i3c_dev_locked().
 	 */
-	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
-		i3c_master_pre_assign_dyn_addr(i3cdev);
+	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
+
+		/*
+		 * We don't reserve a dynamic address for devices that
+		 * don't explicitly request one.
+		 */
+		if (!i3cboardinfo->init_dyn_addr)
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
+
+		/*
+		 * Only try to create/attach devices that have a static
+		 * address. Other devices will be created/attached when
+		 * DAA happens, and the requested dynamic address will
+		 * be set using SETNEWDA once those devices become
+		 * addressable.
+		 */
+
+		if (i3cboardinfo->static_addr)
+			i3c_master_early_i3c_dev_add(master, i3cboardinfo);
+	}
 
 	ret = i3c_master_do_daa(master);
 	if (ret)
-- 
1.7.1

