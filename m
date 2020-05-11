Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B10C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE4920735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MJVmX0qF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZkzbEj2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgEKNON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:14:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54244 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:14:12 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDAKcs008826;
        Mon, 11 May 2020 06:14:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qum8SK3AEkkepzqllm/N7GlPGng4CYG3oDc+9SHt+3c=;
 b=MJVmX0qFSpFkUMQKANWE7fmghB8+oi1TP8nYNwrHzv7AhzjG0nRfbTtsdoZygFwqdEOq
 5nBoUdw6R7A3t8YTPCIM+kgULe6QsC4M2vdVqMkxldVNFP8FmIPDLGRhFGUaHSHIZ44J
 osVf72l6cgu/zW9vGS92cqI0EPFw19XQzJ+V61+HlgcCOUWEpyxKAzTPpFDyVG20smBC
 CwB78Fc3Qx6w+4E1oyrzDOtoMHjTKAvorlf9b7dw00UA0bDcA4K2OJ8ZWg8xDlGjHzdx
 MHszZBIPwkQPBDZEu087FRHuPnEAe4RjBBth6cYH/sRujw9CeBC68/podJuzSALW8PfB WA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xeajh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkurpUPWsJwaE5T2KgNRNNroaj0z6FCTZ5uth/dEDrny+Bs0f6oEGPN1EEluTZ7AgeUvVYy9KbVyHnXLgdNMjwxntA0JVqPuUBoZqqszF0+EmZY4Yh1Z5kJN33+Uf6ShrL/nZPVSx/04AeihG7nfUuuSvr+3uwYIFqw623uBZ0GIFrxXf87rGt/8mG+ike8cpNBiY8qEOSiet2XjAqH32f7BklJ/gGGtaTrCBhSxiNjH5Nu/YRBGL/Br8pEJ9xLrn4Vs5oZ+CedCKqKNtaWdZJlLfGWHvS1o/6mPT+QMBwwydob34t/TtI8IGByevYpRbUVCb29bEB8Ny3J55vJdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qum8SK3AEkkepzqllm/N7GlPGng4CYG3oDc+9SHt+3c=;
 b=SVIqY7hXWH11RMxj4El2fHtMcchBg5xrT2fpYaR1KVESehuVA+FAF/Zl1Fjal5HAVC0TKS90SQ4RBiNFguWI6JBKpjLceuRkcFLYxfK/onjQ+JBhXpX2XHZWY5yOlzlZQ9CAr3eNSMch33xP3bcFKtFJG48o6pvz1ZkXWU57n8HHRRTH+e+gd7MUbaWqkeysyS7IXJyN0KfFoII/ktIG8WgTioigxapOf6R5DXXD1iOzvfL7+zT62imhllcNuSQR3wqtJTy81ZuxXqp6X8x7CGUBhpcYGANj8bE1F+NJe1QeiUrZfHkvdboe/uCGHOHpMP+X8eGwIueFKVrfRMhQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qum8SK3AEkkepzqllm/N7GlPGng4CYG3oDc+9SHt+3c=;
 b=ZkzbEj2IRPIKPoT+WurCDOrFByR2QD7OiViDTLcYhd+DYqjJ/QiQEeQWQas0SSzC5GNHE3QM8sqoVaUOPYkQkOYaHdI6SYHacZYP18o5gSEl2NYANbzY45UfOCMsG33eNLodiZE0lyMocJD6t3nBvHXMtYlRRF07M0AMWbdgCew=
Received: from BN6PR11CA0025.namprd11.prod.outlook.com (2603:10b6:404:4b::11)
 by SN6PR07MB5311.namprd07.prod.outlook.com (2603:10b6:805:67::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 13:13:59 +0000
Received: from BN8NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::36) by BN6PR11CA0025.outlook.office365.com
 (2603:10b6:404:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Mon, 11 May 2020 13:13:59 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT062.mail.protection.outlook.com (10.13.183.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:13:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 04BDDuhF230231
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 06:13:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:13:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:13:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDDtTV006981;
        Mon, 11 May 2020 15:13:55 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDDtnL006979;
        Mon, 11 May 2020 15:13:55 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 3/7] i3c: master: add i3c_secondary_master_register
Date:   Mon, 11 May 2020 15:13:53 +0200
Message-ID: <1589202833-6908-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36092001)(46966005)(33430700001)(336012)(70206006)(26005)(2906002)(82310400002)(186003)(47076004)(2616005)(81166007)(82740400003)(4326008)(426003)(356005)(107886003)(110136005)(478600001)(54906003)(70586007)(316002)(36906005)(42186006)(5660300002)(8936002)(33440700001)(86362001)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6468498-7406-4c3c-3e0f-08d7f5ad2a97
X-MS-TrafficTypeDiagnostic: SN6PR07MB5311:
X-Microsoft-Antispam-PRVS: <SN6PR07MB53110A75379ED4FA95716D3EC1A10@SN6PR07MB5311.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsF2722Qatd4AlabKxflc3/j7FC925UQgMVBn3aJLcKJ60B16vJ9IAhQphfbnA6DtlxATsCcnj0OA2kTdF6xEEsVdQlt3uZ8oEsjdichjXLymzL3hROaNzo7/XNX0Lza9XpMuxhARazyTqwRWlW7AquGUh3KJrnfY49sxTd1jtqlwbJLZEnk1HzR4kx0nhNHWlC6xSmi3UmvbNcsPSBDWRwiv4XbOOgQy+dYcZsBOlf6Wi8QAkdvnnXv5kBCvkTFvGrugY47NnPVPGb6auJMOFdurOz06MqMcYRZaKEHSVsYW+/k5YsZo27b+EzWr8BTtrQ4tPuDoXQeU4xM/pRMKX6Bu4lVz5zwhjpz9DkK797wKQUt43REZXZtlJdddhcpN/kTWg9KxXT8VmSvg2o2PgOkGUah+Uds25A4d4V7fhjX1CKjNahw+jQ9Y+jjAuRFjtUACJs24eLV1icrOcnMswo8Eaxm01zqSsS4s3uwSIzDlWfUGNWzkdJfDlWXrTQBDaju22D6DlsX7FZZkZv4Wlc+Wc12yZU34B++smuOxHTTsvAgvHOCOlVNBzPArAGVkNiP5JVVtHgUFXCBtjMlfEDzd+wmj52uwdzpJzewSEc=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:13:58.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6468498-7406-4c3c-3e0f-08d7f5ad2a97
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5311
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

add i3c_secondary_master_register which is used
to register secondary masters.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 154 ++++++++++++++++++++++++++++++++++++-
 include/linux/i3c/master.h |   3 +
 2 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index ba07a7d49633..669bd7e45810 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1768,6 +1768,90 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	return ret;
 }
 
+/**
+ * i3c_secondary_master_bus_init() - initialize an I3C bus for secondary
+ * master
+ * @master: secondary master initializing the bus
+ *
+ * This function does
+ *
+ * 1. Attach I2C devs to the master
+ *
+ * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
+ *    the master controller. That's usually where the bus mode is selected
+ *    (pure bus or mixed fast/slow bus)
+ *
+ * Once this is done, I2C devices should be usable.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+static int i3c_secondary_master_bus_init(struct i3c_master_controller *master)
+{
+	enum i3c_addr_slot_status status;
+	struct i2c_dev_boardinfo *i2cboardinfo;
+	struct i2c_dev_desc *i2cdev;
+	int ret;
+
+	/*
+	 * First attach all devices with static definitions provided by the
+	 * FW.
+	 */
+	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node) {
+		status = i3c_bus_get_addr_slot_status(&master->bus,
+						      i2cboardinfo->base.addr);
+		if (status != I3C_ADDR_SLOT_FREE) {
+			ret = -EBUSY;
+			goto err_detach_devs;
+		}
+
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     i2cboardinfo->base.addr,
+					     I3C_ADDR_SLOT_I2C_DEV);
+
+		i2cdev = i3c_master_alloc_i2c_dev(master, i2cboardinfo);
+		if (IS_ERR(i2cdev)) {
+			ret = PTR_ERR(i2cdev);
+			goto err_detach_devs;
+		}
+
+		ret = i3c_master_attach_i2c_dev(master, i2cdev);
+		if (ret) {
+			i3c_master_free_i2c_dev(i2cdev);
+			goto err_detach_devs;
+		}
+	}
+
+	/*
+	 * Now execute the controller specific ->bus_init() routine, which
+	 * might configure its internal logic to match the bus limitations.
+	 */
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_detach_devs;
+
+	/*
+	 * The master device should have been instantiated in ->bus_init(),
+	 * complain if this was not the case.
+	 */
+	if (!master->this) {
+		dev_err(&master->dev,
+			"master_set_info() was not called in ->bus_init()\n");
+		ret = -EINVAL;
+		goto err_bus_cleanup;
+	}
+
+	return 0;
+
+err_bus_cleanup:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+err_detach_devs:
+	i3c_master_detach_free_devs(master);
+
+	return ret;
+}
+
 static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
 {
 	if (master->ops->bus_cleanup)
@@ -2457,7 +2541,10 @@ static int i3c_master_init(struct i3c_master_controller *master,
 		goto err_put_dev;
 	}
 
-	ret = i3c_master_bus_init(master);
+	if (secondary)
+		ret = i3c_secondary_master_bus_init(master);
+	else
+		ret = i3c_master_bus_init(master);
 	if (ret)
 		goto err_put_dev;
 
@@ -2535,6 +2622,71 @@ int i3c_master_register(struct i3c_master_controller *master,
 }
 EXPORT_SYMBOL_GPL(i3c_master_register);
 
+/**
+ * i3c_secondary_master_register() - register an I3C secondary master
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ *
+ * This function does minimal required initialization for secondary
+ * master, rest functionality like creating and registering I2C
+ * and I3C devices is done in defslvs processing.
+ *
+ *  i3c_secondary_master_register() does following things -
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ *   initialization
+ * - allocate memory for defslvs_data.devs, which is used to receive
+ *   defslvs list
+ * - create I3C device representing this master
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_secondary_master_register(struct i3c_master_controller *master,
+				  struct device *parent,
+				  const struct i3c_master_controller_ops *ops)
+{
+	int ret;
+
+	ret = i3c_master_init(master, parent, ops, true);
+	if (ret)
+		return ret;
+
+	ret = device_add(&master->dev);
+	if (ret)
+		goto err_cleanup_bus;
+
+	/*
+	 * Expose our I3C bus as an I2C adapter so that I2C devices are exposed
+	 * through the I2C subsystem.
+	 */
+	ret = i3c_master_i2c_adapter_init(master);
+	if (ret)
+		goto err_del_dev;
+
+	/*
+	 * We're done initializing the bus and the controller, we can now
+	 * register I3C devices from defslvs list.
+	 */
+	master->init_done = true;
+
+	return 0;
+
+err_del_dev:
+	device_del(&master->dev);
+
+err_cleanup_bus:
+	i3c_master_bus_cleanup(master);
+
+	put_device(&master->dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
+
 /**
  * i3c_master_unregister() - unregister an I3C master
  * @master: master used to send frames on the bus
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index f5ba82c390bc..5124ff4831eb 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -534,6 +534,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 int i3c_master_register(struct i3c_master_controller *master,
 			struct device *parent,
 			const struct i3c_master_controller_ops *ops);
+int i3c_secondary_master_register(struct i3c_master_controller *master,
+				  struct device *parent,
+				  const struct i3c_master_controller_ops *ops);
 int i3c_master_unregister(struct i3c_master_controller *master);
 
 /**
-- 
2.17.1

