Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7AFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B008207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WkISm747";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="msnnDt32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgEaHPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:15:18 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:49006 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728411AbgEaHPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:15:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V7Cd2H011255;
        Sun, 31 May 2020 00:15:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=HSAfxfjWq/W3gCl3huZzPEQwMR/yP/WhKtdEZ7yKb5E=;
 b=WkISm747nh7BmFiaT3u4m8YG6h5qa6MEgTm2HG5QDuGBaxUJrhaLRoi1/hlkPaCwqLed
 7dL+0sUoRwOWHKJDAVh6XKdLlDMr5phZInjBfpPI8vEX0pbKlKrA0/f1G86Huqt8m1Va
 Ni4vju3jvIdnjjosn1GCOboOsUc9QagizD9qn3gUZobvT7iKETE9bvdLOBZ8RhY7iW/V
 p64UsjetFp9rXLp1z8LFy/jJ04Xc9WuMSho3MM6+D5NJtUtYAkKSNf7vImCWDqWQbQRU
 9v2vpYeFf5RJZTzSuR25Vv/Sq+e4WOmajUMysEVkccrEHJU+z2DNea7DGc+OwL8272F7 yQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31bm1wjfye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leip38qkdQ37pSMdlQy3nuSguhBgg+n6mAicFJmG72YYDKVk/UefngEYYLOu130ysVqMDy/N6DVTuXfgggcgXGBOYPbmzR1Ragb9vSHCp0J99qIAE5oWkf4NiZzj/9D9arZHtLy/BNostljWfEIeSE2biI1fipxbnBnqbTtb9TQXVWyVJl7CL0/OotxB4FBwEBpxFOswosvFo1VFkoBh3cxGgUUgqwYOrWdH/B6uTM6BVO8gHe6MLPe9jrkBX51D1LxtNd14BFSD1z37ITUFxi9hSsGSKnw6/IccX+BIjIe0BfpgJhb7e8rvva5JbbYmgM/7fnYmZsvUkujIWHrGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSAfxfjWq/W3gCl3huZzPEQwMR/yP/WhKtdEZ7yKb5E=;
 b=ci+dmpl9p7Ewhmpt6qjq8DCwjV8eEZmEE0Kv3tpF/nBTJ2A2P6m43E5bWsbolMcHjWjPK2/sE4K7BPeM8kyh37/j4kGIY6DjxC6idgcWsvLl0wI7F7ns8oPSa+0SW1xKA8aLe5uVwu1Y57FO64oEt28+/9OMk8f6fCp8lEYS/zzfrwjYGK7umI+RoeZkj1eVfzDs9MiX1HoL/mHQTh7mBT5nBwnpRl/9C7ZkV5D81xcyKu+eTaXuJcrM6M9WtKi93gB0OtGi1eY/ppHUuTgu3aqe2lvlTv55v/spXpb5So/M5Bp6bl2TnFmdXwWXgjNGpJi0C8CRTt9U5v2A7A2fgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSAfxfjWq/W3gCl3huZzPEQwMR/yP/WhKtdEZ7yKb5E=;
 b=msnnDt32vRfz/ZrYjhK6PX2P8zLsS5/R/jF2JKci6Ll+XBjcYB2p9azER1oSqXT8/XEYvlsW2ajIV3g5Hhv/7cFOxoYBK91EI8sOCh/TTIn7j6/95TNaaWLeuVR+bQdC0bQrM78VQLo3PPIcKRTwQMw1yVP6SNhedEMdFpst0mI=
Received: from DM3PR12CA0115.namprd12.prod.outlook.com (2603:10b6:0:51::11) by
 CY4PR07MB3494.namprd07.prod.outlook.com (2603:10b6:910:80::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.21; Sun, 31 May 2020 07:15:08 +0000
Received: from DM6NAM12FT063.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::dd) by DM3PR12CA0115.outlook.office365.com
 (2603:10b6:0:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Sun, 31 May 2020 07:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT063.mail.protection.outlook.com (10.13.178.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Sun, 31 May 2020 07:15:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7F5hZ019917
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 31 May 2020 00:15:06 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 31 May 2020 09:15:04 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 31 May 2020 09:15:04 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7F4p2007272;
        Sun, 31 May 2020 09:15:04 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04V7F4FZ007271;
        Sun, 31 May 2020 09:15:04 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v8 5/7] i3c: master: add defslvs processing
Date:   Sun, 31 May 2020 09:15:03 +0200
Message-ID: <1590909303-7223-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
References: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(36092001)(46966005)(5660300002)(4326008)(8936002)(8676002)(2616005)(110136005)(336012)(42186006)(36906005)(26005)(54906003)(426003)(316002)(478600001)(7636003)(86362001)(83380400001)(2906002)(107886003)(70206006)(47076004)(36756003)(82740400003)(70586007)(356005)(186003)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4deb0f02-ebb1-4cc7-4c3d-08d80532597c
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494739AE94C769B7F7FCF8BC18D0@CY4PR07MB3494.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgV9FjjNmrjACKarS/6JqbsNkCRVxNPZV4V9cwZZlv4dYJRWGzeeRsWBl6fc1MPmW8qaC/+XUIfCa/LhpnIcuRlnZ8Bp53TtVWi56RPUEzQw7EfyU6L/yat1IC6cLNgM5MTT4HLzPlij3e6mwTbQd/zFhTIC+7gHfbL5WJrqPsOQ7NxI7IWbnIdhdbA3BnYIjLQZNkMc9Fd+hn5zDzxaEutyx0fgj6QENZPB2KIF2Rho2ZeJ1q+WvAhfEtFXbEx+IfBTG0nrHNfIZitQJeCW7zGkrRmZXrPEFm5WLmFvcvgJ9HsGmQl37Ux6bC3M0Dzj6bFRFFtwZ9fv78TMCn486FO3ZX2bw3FvWx4iCG8XQbQDKimeX8L7byBf2FhGtJz9fsp1B0ddXaRfYwlvdZ8O/As3y7jJ1euoxdqRWdbT8Bw=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 07:15:07.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb0f02-ebb1-4cc7-4c3d-08d80532597c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 cotscore=-2147483648 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added defslvs processing code to the I3C master subsystem.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 68 ++++++++++++++++++++++++++++++++++++--
 include/linux/i3c/master.h |  7 ++++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index f9ab21e8f6ee..de3cb39df9ff 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2127,7 +2127,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (!master->secondary && newdev->info.dyn_addr != expected_dyn_addr) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.
@@ -2804,12 +2804,20 @@ int i3c_secondary_master_register(struct i3c_master_controller *master,
 				  struct device *parent,
 				  const struct i3c_master_controller_ops *ops)
 {
-	int ret;
+	int ret, sz;
 
 	ret = i3c_master_init(master, parent, ops, true);
 	if (ret)
 		return ret;
 
+	sz = sizeof(struct i3c_ccc_dev_desc) * I3C_BUS_MAX_DEVS;
+	master->defslvs_data.devs = devm_kzalloc(&master->dev, sz,
+						 GFP_KERNEL);
+	if (!master->defslvs_data.devs) {
+		ret = -ENOMEM;
+		goto err_cleanup_bus;
+	}
+
 	ret = device_add(&master->dev);
 	if (ret)
 		goto err_cleanup_bus;
@@ -2842,6 +2850,62 @@ int i3c_secondary_master_register(struct i3c_master_controller *master,
 }
 EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
 
+static int
+i3c_master_populate_bus(struct i3c_master_controller *master, u8 dyn_addr)
+{
+	struct i3c_dev_desc *olddev;
+	struct i3c_ccc_dev_desc *desc;
+	int ret, slot;
+
+	i3c_bus_for_each_i3cdev(&master->bus, olddev)
+		i3c_master_put_i3c_addrs(olddev);
+
+	master->this->info.dyn_addr = dyn_addr;
+	i3c_master_get_i3c_addrs(master->this);
+
+	desc = master->defslvs_data.devs;
+	for (slot = 1; slot < master->defslvs_data.ndevs; slot++) {
+		ret = i3c_master_add_i3c_dev_locked(master,
+						    desc[slot].dyn_addr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * i3c_master_process_defslvs() - process I3C device list received in
+ * DEFSLVS for device plug/unplug and address change.
+ * @m: I3C master object
+ * @dyn_addr: Current dynamic address of this device
+ *
+ * This function may sleep, so should not be called in the atomic context.
+ */
+int i3c_master_process_defslvs(struct i3c_master_controller *m, u8 dyn_addr)
+{
+	int ret;
+
+	i3c_bus_normaluse_lock(&m->bus);
+	ret = i3c_master_acquire_bus(m);
+	i3c_bus_normaluse_unlock(&m->bus);
+	if (ret)
+		return ret;
+
+	i3c_bus_maintenance_lock(&m->bus);
+	ret = i3c_master_populate_bus(m, dyn_addr);
+	i3c_bus_maintenance_unlock(&m->bus);
+	if (!ret) {
+		i3c_bus_normaluse_lock(&m->bus);
+		i3c_master_register_new_i3c_devs(m);
+		i3c_bus_normaluse_unlock(&m->bus);
+	}
+	i3c_master_enable_mr_events(m);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_process_defslvs);
+
 /**
  * i3c_master_unregister() - unregister an I3C master
  * @master: master used to send frames on the bus
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 693b920bfd54..48803736ba17 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -471,6 +471,8 @@ struct i3c_master_controller_ops {
  *	in a thread context. Typical examples are Hot Join processing which
  *	requires taking the bus lock in maintenance, which in turn, can only
  *	be done from a sleep-able context
+ * @defslvs_data: list used to pass i3c device list received in DEFSLVS message,
+ *	from DEFSLVS controller driver to I3C core
  *
  * A &struct i3c_master_controller has to be registered to the I3C subsystem
  * through i3c_master_register(). None of &struct i3c_master_controller fields
@@ -490,6 +492,10 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct {
+		u32 ndevs;
+		struct i3c_ccc_dev_desc *devs;
+	} defslvs_data;
 };
 
 /**
@@ -516,6 +522,7 @@ struct i3c_master_controller {
 
 void i3c_master_yield_bus(struct i3c_master_controller *m,
 			  u8 sec_mst_dyn_addr);
+int i3c_master_process_defslvs(struct i3c_master_controller *m, u8 dyn_addr);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
2.17.1

