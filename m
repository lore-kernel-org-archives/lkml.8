Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E97BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF5A20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LsfJVkF+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jLl1UIXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHUJNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:13:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11426 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725855AbgHUJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:13:40 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07L999x0000548;
        Fri, 21 Aug 2020 02:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=l5FOAz/NpKhBkb0URCEcNILRDQGGA1HogBh29rdx6Vk=;
 b=LsfJVkF+s9J/33W+llpSW0KCJVAma3/bB8Ag9iuoY00gdKc+Yi9WZ3LQtKrIOxCyi+SV
 XaIS8r3ul9oLOjsaVFN9Gubag+s18K4GaFxR2pWiudZzxu57tZBqiEt+WqZzK0f1pH/9
 WuM5fBlwtGNLbzsmOL3RVoHtSUjfLahWCDXAElmk/z9+gH57eFKTibLsda1XkxMbHT87
 97ccvJX86KYRdx1viN0kzizKZIAPFbtPsg8ni7P+xlikyDOsVQPgXjaFJmIoTooKfTb/
 y+pcIOSB3iEz6S10WZ9WvSXAuG/20H/V7UkiF7comD/Ccji1EYmrN2xQRVPaFklDx1+j aQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332399hc07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 02:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca40qawdKN7w5VDidwnJ6jtu4iQHhiUC1HOilCzcBS+0TFpSRKbxHFR7gcvfzcOVqyOOVElhaQW+LCgfOew5ZpUDcP0zYTlmZVx+Ncyr89ckpkW1jYLawUwei6rnS9qCS/H2s37oo3vWsVl4yRnZUdHC+58jDWuV1zXDmur48fNzyxtUYBPQWMeS2LKH6IKvgSC1rQiGN2away1B+ZUbZG0GFxK+WoIfnqKN6TM3yb9VjxGuAZeV3HuI0g8CbqL3rd7MbhUB6OySoVK18iddhjEYNw6uB7bOC4GVAiN9Ab6pR/C19E2hycXaE/JlZADEke7infvwVErBDLVfOvPPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5FOAz/NpKhBkb0URCEcNILRDQGGA1HogBh29rdx6Vk=;
 b=P9JZKu11I50xytlxH4oDxGgbeSluo1TLjd3UZus/z3rgNuCKuiC7JxVZoLzqqw0pqU4V5c5WZO9O1t4u60z1bpW/27AYyT81u0Gg34tO1sRdH4miDJ8SU2u5NLzZFZVdyFE1VUYzQEi+2Ym0tAlEjpr77QL8WRkqsyr0B5JiP82/uNr6F0yv+bJkvJdkLQTv88V+Grj5+1HkIg0DJMszwFGtV779SOjDr/yaRGCTjwbE3OFyGCqFVV64Xse4YZa/7FkYhJVvViM2CihhL3rXJf3DgJRMzVdPs8SA0b5PKyD41QhH6bk7oxLn30dO6cAUd6Kedl3r2P6dWr3+2opdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5FOAz/NpKhBkb0URCEcNILRDQGGA1HogBh29rdx6Vk=;
 b=jLl1UIXbb5b0ZwVr0QfKKuqUnCfZ6WuQbUC3Ym2HI43rpBfsZj+vZ9M2ep8IKC4MJIX/lGsfq5NAP36MhmN9oUXIp0MhhqbaGTcAT2Cl3cCXLBn/fF/j0HcDIsYhxxwgAnenNoVI9z1Z7hFYQF9ZTl/y1CxZc+z7H5daWVAOS3g=
Received: from DM6PR07CA0044.namprd07.prod.outlook.com (2603:10b6:5:74::21) by
 MWHPR07MB3168.namprd07.prod.outlook.com (2603:10b6:300:ec::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 09:13:23 +0000
Received: from DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::b7) by DM6PR07CA0044.outlook.office365.com
 (2603:10b6:5:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 09:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT039.mail.protection.outlook.com (10.13.179.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Fri, 21 Aug 2020 09:13:21 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 07L9DIQm197779
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 02:13:19 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 21 Aug 2020 11:13:18 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 21 Aug 2020 11:13:18 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07L9DID2018549;
        Fri, 21 Aug 2020 11:13:18 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07L9DHUQ018548;
        Fri, 21 Aug 2020 11:13:17 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v4] i3c: master: fix for SETDASA and DAA process
Date:   Fri, 21 Aug 2020 11:13:15 +0200
Message-ID: <1598001195-18511-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7cb8679-7011-429b-2b35-08d845b273b1
X-MS-TrafficTypeDiagnostic: MWHPR07MB3168:
X-Microsoft-Antispam-PRVS: <MWHPR07MB31684F9CDF6F0AE44D505ADDC15B0@MWHPR07MB3168.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3myhHc4zYJozkH0SX8YnPN9PX8+X9vENc6dMEJqM7Fic6ee4HKJXMJe8KthBW3GlsoLqb2OLYblUb05fWiaC3mTT5KQD1Mi9zveo2yobW5bSBzK2RS4DBErsz4TGd/bEyKYrb/l5nOxUQI++Sd9+gfrf69c7vy/mbyruY7Qhs/eSMGh2FyXX9LuLKMtEtJ7a5hMfoYzx8R80imxjjcRkdMGdqPSeTuHimp05imd0ajSkOOkwLKFNCbjSxb7duBNeQkzyB50W8gpydCbnOBkeyVSfocP3OXEMBGjKT6VCKhw5/BbniUVAQ4oiXsfX08Iujvmj+wEm+ohQloPCrtosKTo2mtX50o5qJu0h3BldfcDTXuo+3WZ+W4cgYc7FoixHDEF3WJDMCAGJNWENxx9UZ8Q9jqOF+Z7kkYxSHddcCA=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36092001)(46966005)(70206006)(8936002)(26005)(2906002)(70586007)(5660300002)(54906003)(36756003)(8676002)(110136005)(478600001)(82740400003)(2616005)(36906005)(82310400002)(336012)(4326008)(186003)(426003)(316002)(42186006)(86362001)(81166007)(107886003)(83380400001)(47076004)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 09:13:21.9361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cb8679-7011-429b-2b35-08d845b273b1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_06:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=2
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210086
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
Changes between v3 and v4 are:
1. Code rectoring and removed Fixes tag

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
 drivers/i3c/master.c |  116 ++++++++++++++++++++++++++++---------------------
 1 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3d995f2..3ff95e4 100644
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
 
-	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
-					dev->boardinfo->init_dyn_addr);
+	i3cdev->boardinfo = boardinfo;
+
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
@@ -1744,10 +1737,33 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 
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
+		if (i3cboardinfo->static_addr)
+			i3c_master_early_i3c_dev_add(master, i3cboardinfo);
+	}
 
 	ret = i3c_master_do_daa(master);
 	if (ret)
-- 
1.7.1

