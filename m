Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF36BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982632071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SbyJbVm3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="un6VRm2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgHYGcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:32:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50506 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728440AbgHYGcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:32:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6TeuS025593;
        Mon, 24 Aug 2020 23:31:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=4oFWS9VUwRmfZSx2NN80aEtyUui9d7l710A8hhgRX+g=;
 b=SbyJbVm39AnKQOhybrMOPpyyeRzrsdw3ijkVndTmA6k2iuBaZIXgt8XN+o48G1mIR5ad
 dzzcMPI+USsJXzXGFNWriqztUUiQK/Jyx7aDlO+Y1xvwyBYi1vBHVG9+ECE5NmYuA+TB
 24CRKmXHzWlVl5PEeGVKG/rqrUMHLnUs5v+uBMCgXVIKfLi0pBl2FTo7VxgDQLS7wEMo
 IFGUB8zqrBqXxdLaHw1VWS0lZE8tBV8jG+KQz4ci/YGLKb0QPcwIWp/jFKiOGFwyVF52
 /rkkh7hO3w3nqqPY9EUyJHf8a1Wbvb5sQ4e2RbhC5fi2Is+dRYUp+j8OJ7rksWqQv8vE JQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxx1t68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 23:31:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtPJDASE8vpSdZmb4gjLkZ838ei/bP+DxiopxNgOYZiw93vNj+3RYHEoFhFpjQ/4D5K5XLseDUM2E400O1P8CKI9c04Xmb2IZuUFDOn3RR1DxdXiQUkmyLjUuTotpuCySu6G7R3uGh5OkWAcOaO3HjTd9knlTWkWISuenKkvmNNU6fRXYHNkE5CdfybYZSRnkqWFhVIFp21UMCfZcy7K8Sr8Q/7VFEZiGJuqO/odNW3CajKRUHKqDExXltAsuFMuishfACTMXqOIkJ9ZXhVnq8JjMpQS9E29mo8+5WoJQBls7jO/XG74N6B7nQoZHj6Co3DuHMP4qV3mLlKLZoMEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oFWS9VUwRmfZSx2NN80aEtyUui9d7l710A8hhgRX+g=;
 b=aPYpjgayq3wht0cfOQbCiPUmOrZah6K3NRx2pp2AAHLo/nC9EgQWiaNRuzNekxSE2bAuJxLmm8bTc/fJUN9uj9COB191z8Yoxo55d7/VqaIQa44Q6xDtT9AN2XKR7O2zJKshCZnUVqzrpihLl16tc5/TYFqwQYMCEDhjb+2Mxkvuhljw5ytk3ZDNJzZT9AwHbAdxTuZaFCltwLtzK8zK7z8+V/y9+VbgOlaDQ1sFyeSVpPh/PzqaX9GOFbxU2gmlgiQDpzWFf84v7DkVWlj25dFOEEHlGPbho3F2ee8+FeXK4kejjJU2LV0HfGhPBEwlN6aWkygIOHrmYj0psMrlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oFWS9VUwRmfZSx2NN80aEtyUui9d7l710A8hhgRX+g=;
 b=un6VRm2cMupG1eoRY4r4AZBHmozdXH1Hwjf0I96UhYlxc4xKwoAdLo4jPjrYIj5qElak6cLCsIb3X3LLYkZ/TZT5cNoyhH6iRXje+b7gnhe1z5+ijZIyNgk2LuWRrl/m4WuQyd7ZvjPlmBGiaE2rJyiVi2DJfiq0u+j4jS31WZ4=
Received: from DM6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:5:15b::23)
 by BN7PR07MB4594.namprd07.prod.outlook.com (2603:10b6:406:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 06:31:55 +0000
Received: from DM6NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::b2) by DM6PR18CA0010.outlook.office365.com
 (2603:10b6:5:15b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Tue, 25 Aug 2020 06:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT038.mail.protection.outlook.com (10.13.178.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Tue, 25 Aug 2020 06:31:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07P6VpYI010677
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Aug 2020 02:31:53 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 25 Aug 2020 08:31:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 25 Aug 2020 08:31:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07P6Vpkl014819;
        Tue, 25 Aug 2020 08:31:51 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07P6VoXo014813;
        Tue, 25 Aug 2020 08:31:50 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v5] i3c: master: fix for SETDASA and DAA process
Date:   Tue, 25 Aug 2020 08:31:49 +0200
Message-ID: <1598337109-14770-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5277c1ca-16ec-464a-05ab-08d848c08f9a
X-MS-TrafficTypeDiagnostic: BN7PR07MB4594:
X-Microsoft-Antispam-PRVS: <BN7PR07MB45945A7CB66AD1A97E681FD6C1570@BN7PR07MB4594.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIfOcRw0sn3BTESIjP2zwij/aeJRkblxXmP65OSQxDK2KlUEGuLU7ohoIDgYT1+/mU7wp6Oz1Ax9413nG7SG+eA+eiUDHXVXa7A5xvkaGLRjqMCJN9ae53gRX/l8vsu5xdA+/YD7BcSNdJW6pd5lFihvoMWW0kEuAN9WNHvVMrUF7TjkLu9UWfwgD05sCNxy3NbmqduJ6qdBDmhZo5QNjlObVaA1Zz/z+W8jKhX2nHYJ76Yls1vFWJsylAwwfmVoeiR6wcZResoEBRhzMP1KjOO3572r0Pb811CAYr0O5GggHEcv3xjK7zj1HAu20LcdjaVQERXCe8Gs1qMdQwtU1VYAJWp7C7lGww25elReCy050keNfps5TP/38nMSQQDg48Oy/ljDqfDJ1ziK9EikJCJe/m0AQG4xU1NNRR05maw=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36092001)(46966005)(47076004)(83380400001)(36756003)(70586007)(426003)(336012)(356005)(2616005)(86362001)(81166007)(478600001)(82740400003)(2906002)(8676002)(70206006)(186003)(26005)(4326008)(8936002)(110136005)(82310400002)(107886003)(42186006)(54906003)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 06:31:55.2432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5277c1ca-16ec-464a-05ab-08d848c08f9a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4594
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=2
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250049
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
 drivers/i3c/master.c |  125 +++++++++++++++++++++++++++++--------------------
 1 files changed, 74 insertions(+), 51 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3d995f2..dd73bbf 100644
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
@@ -1632,8 +1650,10 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
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
  *    remaining I3C devices
@@ -1647,7 +1667,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1679,34 +1698,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
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
@@ -1743,11 +1734,43 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
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

