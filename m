Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A44C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D672072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="idMNsRml";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="3q0MSZXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEUJiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:38:17 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:31770 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbgEUJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:38:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L9VZm9028962;
        Thu, 21 May 2020 02:33:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GAXJ+owLulIELMeVNHd+LmdUORNK5FyST/rE/QAXRMc=;
 b=idMNsRmllJ9XTiGEuQ8wbLsLfjf9tGUlFkAMLe4Pnuv0BkFwtgg2uPmSNmElTDaHRmGG
 G5KnEWdsHhJgKKYdzWavK/mMeLUTmIMaAWb+C5hjxn55cTqgtiNlaO9sFz3ntYHy9sT5
 p3cxCycwj+PfC6K/Ah8y2JsxfFDoVBLA1Lxh7RdAsyidsKgOCdezn2H2xESZfyv3+Q5N
 Tkp11WzfncASARiIFR1rPaCVo4EO/nLfI0IkkAY6u4f5TffyBLu27w1ClGUK8DXHjP4X
 tr2wLBu1b056KfKrGWLZ2jbNBl96xOP2y9ZGmoZnjkrbKVfJ3XFx6UXyrhON7hrlmFpr bw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 312cqymnm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 02:33:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGje8EbAtCdIcgtHh6PBPap1h6YWGAV0U/LvDA0NQDIq3qbwsW3fubR6M9wD4c7leB8p5PMBuOkEY0FiwxMGX+H0pSrEmtvnpuuLp4lOnlweezGJOpKYMZ10j62JS026S/i3SSUQi5cyLpi2F8WoSNY9NK3FDfb+Z5iH+wYbGe69/9JufOmgF8jE3u4ePOxZHC1obt1nAXq6Zd8IoMWXMsKJlw7fYTpnIAx8gCqWDpppo/t7kXKxes3bUIMO7ry24C/xaTUqlbFdUaY7Kzl9IdoKxMu0s096NxwjFttlahzJQ+23mVTackrrgKZ1LewfujJYzNDR8x+VcZdZn82ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAXJ+owLulIELMeVNHd+LmdUORNK5FyST/rE/QAXRMc=;
 b=RaohzpJsdkFAKSlL/9EIEhr2Azm1ai46uA3dbF8aEdClu7qAOGhPz281hmbtjhDU1hHthFUgX57JSpa9FbYCImUVL1NH8VpeUrF26uej8asEMu3XKlL7+vdgEXdkH3Pg4Iin5fdC0Pk6b170cYOR3AQvn0Mixpe9aCHJPK5SGpt8ge/ziXWxANYavc9h1ZK3c/XS4jOrifnPoltFIt1oLPrxF0WDAxc6kHtBAgzmWhNLs2SJtJytBIQISKflZ9+27EcJuFNvtybDyOxYLaSwg3ZydwHwGnpmAWdMAsYERnRAIUqm2ZO9L0NHamSH0Vtk8L8cY5wEx7CYt6Oh5U8xGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAXJ+owLulIELMeVNHd+LmdUORNK5FyST/rE/QAXRMc=;
 b=3q0MSZXNgbmjQuFZ6sqB+6c5XjWFVkzCXSiUkFu1MLNQRSqFSSb4AhoQs+1IlPgTkgrIqSUEQfWK6iFs4LwGI3JZTkf9wIvYs9NNwbz2xNc7S8Fyi0hnS1GTChyXDKls0Tt2SQPW3LoLwxnXEBvX1S7K/4oI0F9amHZk+EEDw4o=
Received: from MWHPR12CA0028.namprd12.prod.outlook.com (2603:10b6:301:2::14)
 by MN2PR07MB7182.namprd07.prod.outlook.com (2603:10b6:208:1a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 09:33:06 +0000
Received: from MW2NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::7b) by MWHPR12CA0028.outlook.office365.com
 (2603:10b6:301:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 09:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT027.mail.protection.outlook.com (10.13.180.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Thu, 21 May 2020 09:33:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04L9X3IW024402
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 May 2020 02:33:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 21 May 2020 11:33:02 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 May 2020 11:33:02 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04L9X222000868;
        Thu, 21 May 2020 11:33:02 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04L9X2sa000865;
        Thu, 21 May 2020 11:33:02 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v2 2/2] i3c: master: fix for SETDASA and DAA process
Date:   Thu, 21 May 2020 11:33:01 +0200
Message-ID: <1590053581-803-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1590053467-32079-1-git-send-email-pthombar@cadence.com>
References: <1590053467-32079-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(46966005)(2616005)(36756003)(5660300002)(8936002)(316002)(4326008)(186003)(7636003)(2906002)(36906005)(26005)(478600001)(356005)(47076004)(82740400003)(82310400002)(426003)(70206006)(107886003)(86362001)(70586007)(110136005)(54906003)(8676002)(336012)(42186006);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92fce2c6-3326-47b5-68aa-08d7fd69f72e
X-MS-TrafficTypeDiagnostic: MN2PR07MB7182:
X-Microsoft-Antispam-PRVS: <MN2PR07MB7182D62BB87F86A7D599E778C1B70@MN2PR07MB7182.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b73f4GL1e48B0ZUxuEEPn0wL6fDBCA9VzZmFFqn12is/uEh9+dPRQ3qwFQksIcdJpRpRs8gQOp2z9wtdk/57HnvKuQ7ehVrUOEK9Rsd3kjmPnK25tU0v1JZVWpCftVrWkI6VORxW5gNlxQUiexxFre4nvybAByZW7nqwyHzj/BR0/Z07jzaIyP7AyYlF/I9/KU3bEyIvYa7FUcruXPzb8TQdpmLqt1CMuwGfJKitA3cDfYCDg9+N0uTLbs/HEdOtbRL795vcAG5sRxV/SH2+QgYDjKVQtZcfE4FYT9ZXwG6uv54Wf0Qs8tEwPf7e/qcipYAcBzpqSiqVYogeqoNMk9Juo2PoXnUgiVUT6LrkDM3CgUOCLI2SU6atXkN8vcPtbGjaqIoSgekDYoxk6WzkebaIaqOVdz+opYTlC+w5dCA=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 09:33:05.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fce2c6-3326-47b5-68aa-08d7fd69f72e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_05:2020-05-20,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 cotscore=-2147483648 impostorscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=2 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210069
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
 drivers/i3c/master.c | 119 ++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 48 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3d995f247cb7..5e0438ecf95c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1426,33 +1426,57 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
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
+	/*
+	 * We anyway don't attach devices which are not addressable
+	 * (no static_addr and dyn_addr) and devices with static_addr
+	 * but no init_dyn_addr will participate in DAA.
+	 */
+	if (!boardinfo->static_addr || !boardinfo->init_dyn_addr)
+		return -EINVAL;
 
-	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
-					dev->boardinfo->init_dyn_addr);
+	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+	if (IS_ERR(i3cdev))
+		return -ENOMEM;
+
+	i3cdev->boardinfo = boardinfo;
+
+	ret = i3c_master_attach_i3c_dev(master, i3cdev);
 	if (ret)
-		return;
+		goto err_attach;
 
-	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
-	ret = i3c_master_reattach_i3c_dev(dev, 0);
+	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
+					i3cdev->boardinfo->init_dyn_addr);
+	if (ret)
+		goto err_setdasa;
+
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
@@ -1633,7 +1657,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
  * 4. Disable all slave events.
  *
  * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for I3C
- *    devices that have a static address
+ *    devices that have a static address and attach corresponding statically
+ *    defined I3C devices to the master.
  *
  * 6. Do a DAA (Dynamic Address Assignment) to assign dynamic addresses to all
  *    remaining I3C devices
@@ -1647,7 +1672,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1679,34 +1703,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
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
@@ -1744,10 +1740,26 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 
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
+		ret = i3c_master_pre_assign_dyn_addr(master, i3cboardinfo);
+		if (!ret ||  !i3cboardinfo->init_dyn_addr)
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
@@ -1780,6 +1792,7 @@ static void i3c_master_attach_boardinfo(struct i3c_dev_desc *i3cdev)
 {
 	struct i3c_master_controller *master = i3cdev->common.master;
 	struct i3c_dev_boardinfo *i3cboardinfo;
+	u8 init_dyn_addr;
 
 	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
 		if (i3cdev->info.pid != i3cboardinfo->pid)
@@ -1787,6 +1800,16 @@ static void i3c_master_attach_boardinfo(struct i3c_dev_desc *i3cdev)
 
 		i3cdev->boardinfo = i3cboardinfo;
 		i3cdev->info.static_addr = i3cboardinfo->static_addr;
+		init_dyn_addr = i3cboardinfo->init_dyn_addr;
+		/*
+		 * Free reserved init_dyn_addr so that attach can
+		 * get it before trying setnewda.
+		 */
+		if (i3cboardinfo->init_dyn_addr)
+			i3c_bus_set_addr_slot_status(&master->bus,
+						     init_dyn_addr,
+						     I3C_ADDR_SLOT_FREE);
+
 		return;
 	}
 }
-- 
2.17.1

