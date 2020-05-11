Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DE0C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D222075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YtBmnW2b";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mEP62Of2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgEKNUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:20:43 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36958 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgEKNUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:20:42 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BD8BxC016654;
        Mon, 11 May 2020 06:15:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MC4fFwRxiOhMm5cfHt7BVPrcLVdhdXxS9WNj0pAT2LY=;
 b=YtBmnW2b6AwaCo1rbm3GNUBw1xfV1/8kTB8l+fmnhi0zXNSknNBHm1M4EpCsxmJXV8Rc
 B7q/+OckHOySIQc3q+QaiaPLLNVnLRRb+7D35P5RQ4xUAt8yLHId5umMN8xP1fnPXw8X
 Q2To7XFkOscp32cYhbrNfuVWgpFh25e8Tw63KoTbbpC9uIti7D77SFaZKPtNZUeAzrnD
 mcTYeVN+0fpkOpIKf1jo31eWRRUva23Sia8UIyrwbIt7eMyB+nhvUYUZ3BiZ0kv6gHyK
 YCHsbltscSzn1xiYJDT8L70I8jQge+shLXe/sh29IRakIsv3dD6LcSs0SJmstWo6Armx FQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30ws2xx413-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:15:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHYM8I2CBb83D13rTu3uOrldmPkvOrGsf+g611TD9qZzC3G9ly6y0cuC5lQ4XofKXAAi2L7a6q1VWld/1ZXOi2/tsHwDkoXMwazUXAbuNOtoDNgF2QDL84qWziqReJJb8bdfy5HwfqIDlvB6a6TLRqtbx1w0IwePsq771fYvkaU7fbTmcLFzRhp4yZXGs8OgUfenrdrGJjvrLm42MnJXLEOEK4cO5wBRWU68OdR1jxLUTS00VpZODsfhIBCv5+0BXbDPJ9irRdzJ1/6uZY2MxZHXYXe0KSbaTMijzPCEEpIUTNBQQW7pBZfIu02BRKpbLfX2DCQGpsp3hGVcy9YRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC4fFwRxiOhMm5cfHt7BVPrcLVdhdXxS9WNj0pAT2LY=;
 b=VnNIuzwvrWzmInSaPcmIEL4qCW1srdk7kvJ8/rilBo7PYsmfNbUPXhNTtYf0JzaiAYmBqbBAeH4bA0FkJYx7bFZpxb/UR5QZO5NySFUmLIKPEa6HtpM81DuR1gdGfzdF37aZ151qACpZRbh4bZFoSTLrzhmztu2wAjbFNeBFTRlUdtilYw7jmUPgLOREPN1xdFRJF9pRWWCZL5TkNZJrjH9njyHoosCuiQJ5J1inEkNq7WkLC1mLcBJGu6WbObzXTYtQ97ZQ214mU/3ybKEkG8HIADATdIb0D9cgI1uOMBcvjT/x5LRbQ9fVlunyrmYxlduhEtvCzFh5SYn5S70UIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC4fFwRxiOhMm5cfHt7BVPrcLVdhdXxS9WNj0pAT2LY=;
 b=mEP62Of29MUkQNMX/KoNNfG99EohPajiojs6qx+B7OVSYIC9aL/sE79cMAABOO7kSfF3QugNa7kA0633spgSmaj0ZwnBX4eTEF6kshEKlZzDMerdMH2PEp4JVUB7DPl2g6VNMxgv8Z76lVP/sBi1lXjE88wBeZd4QUFjmg4Jl7Q=
Received: from BN4PR13CA0016.namprd13.prod.outlook.com (2603:10b6:403:3::26)
 by MN2PR07MB7200.namprd07.prod.outlook.com (2603:10b6:208:1d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Mon, 11 May
 2020 13:15:34 +0000
Received: from BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:403:3:cafe::c8) by BN4PR13CA0016.outlook.office365.com
 (2603:10b6:403:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Mon, 11 May 2020 13:15:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT022.mail.protection.outlook.com (10.13.183.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:15:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDFU2Q028905
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2020 06:15:31 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:15:29 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:15:29 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDFTIT009970;
        Mon, 11 May 2020 15:15:29 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDFTFh009969;
        Mon, 11 May 2020 15:15:29 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 5/7] i3c: master: add defslvs processing
Date:   Mon, 11 May 2020 15:15:28 +0200
Message-ID: <1589202928-9912-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36092001)(46966005)(33430700001)(82740400003)(478600001)(47076004)(4326008)(316002)(186003)(110136005)(42186006)(26005)(107886003)(54906003)(36906005)(86362001)(70586007)(70206006)(2906002)(36756003)(336012)(7636003)(8936002)(356005)(8676002)(82310400002)(33440700001)(5660300002)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e743f9b-1ff5-4478-c31c-08d7f5ad62fc
X-MS-TrafficTypeDiagnostic: MN2PR07MB7200:
X-Microsoft-Antispam-PRVS: <MN2PR07MB7200887704F7252016D4D28DC1A10@MN2PR07MB7200.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pKDVdmlLvCWGxTP7xQD/WKiKzuRLyr8oebnXE+/uUNLSTjz3SX6XIFVVv4d3K3iBjXUTop0SbUzaV5mtiI9TmTelW0YgT19m0lLNcSu+ykVhfYY+n1Ta+os+Bw99WA3oS2qG+X3si0rZohOQtnnMpxt+OxMkWCdFSc8OSRFnu5WMczWmW1v/I8gzSeAQQNs+0yhovYt9Ja48yit81NxH4Ql9qZe9nHEwL7Q+NbsvcBUFiedhFWe+nrZOBPOs0z0CXTn5NqFGAXbXSEDnj673Lr0cVrrRXmvoV/mpJGkH26++lyFbh8XSJ2VDh9EjlivTL8t2vkYw2H619KaubtA9w/LTxsyB8BZwB4sdZs0c4PMzlX2KWH6CJ8K5jrIkPz1IwzWYXI3MaJOUeswWbQtJqdyt5sDFIXXdrLYCuyxCqF1GKQDBS7kYrBwvaotMTzV8MEv+PlpYSa+3l4B0dFTgsY/o1CYV0vt0PCLBZIWIejw391jS/cKUQj2oFfFFPnI+PF5dvLPFQFtLb7FhqxH4L8Qa/QJKGCIyDL+FYKAcFSpTJ0ogIWQIbfLgLGsVrEyin0tUsbq+Hds5tEkrDYk3KOs3vJVOrV2JZD3BYVMQwM=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:15:33.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e743f9b-1ff5-4478-c31c-08d7f5ad62fc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7200
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=2 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added defslvs processing code to the I3C master subsystem.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 142 ++++++++++++++++++++++++++++++++++++-
 include/linux/i3c/master.h |   7 ++
 2 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 9c8250a6a2b0..ea53fadeed99 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2639,7 +2639,8 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 		return -EINVAL;
 
 	if (ops->request_mastership &&
-	    (!ops->enable_mr_events || !ops->check_event_set))
+	    (!ops->enable_mr_events || !ops->check_event_set ||
+	     !ops->sec_mst_dyn_addr))
 		return -EINVAL;
 
 	return 0;
@@ -2818,12 +2819,20 @@ int i3c_secondary_master_register(struct i3c_master_controller *master,
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
@@ -2856,6 +2865,135 @@ int i3c_secondary_master_register(struct i3c_master_controller *master,
 }
 EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
 
+static int i3c_master_populate_bus(struct i3c_master_controller *master)
+{
+	struct i3c_dev_desc *i3cdev, *olddev, *tmp;
+	struct i3c_ccc_dev_desc *desc;
+	struct list_head i3c_old;
+	struct i3c_bus *i3cbus;
+	int slot, dyn_addr, ret;
+
+	i3cbus = i3c_master_get_bus(master);
+
+	INIT_LIST_HEAD(&i3c_old);
+	list_for_each_entry_safe(olddev, tmp, &i3cbus->devs.i3c, common.node) {
+		i3c_master_put_i3c_addrs(olddev);
+		list_del(&olddev->common.node);
+		list_add(&olddev->common.node, &i3c_old);
+	}
+
+	dyn_addr = master->ops->sec_mst_dyn_addr(master);
+	master->this->info.dyn_addr = dyn_addr;
+	i3c_master_get_i3c_addrs(master->this);
+	list_del(&master->this->common.node);
+	list_add(&master->this->common.node, &i3cbus->devs.i3c);
+
+	desc = master->defslvs_data.devs;
+	for (slot = 0; slot < master->defslvs_data.ndevs; slot++, desc++) {
+		struct i3c_device_info info = {
+			.dyn_addr = desc->dyn_addr
+		};
+
+		if (dyn_addr == info.dyn_addr)
+			continue;
+
+		i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+		if (IS_ERR(i3cdev)) {
+			ret = PTR_ERR(i3cdev);
+			goto populate_bus_fail;
+		}
+
+		i3c_master_get_i3c_addrs(i3cdev);
+		ret = i3c_master_retrieve_dev_info(i3cdev);
+		i3c_master_put_i3c_addrs(i3cdev);
+		if (ret) {
+			i3c_master_free_i3c_dev(i3cdev);
+			goto populate_bus_fail;
+		}
+
+		list_for_each_entry_safe(olddev, tmp, &i3c_old, common.node) {
+			if (olddev->info.pid == i3cdev->info.pid) {
+				olddev->info.dyn_addr = info.dyn_addr;
+				i3c_master_get_i3c_addrs(olddev);
+				list_del(&olddev->common.node);
+				list_add(&olddev->common.node,
+					 &i3cbus->devs.i3c);
+				i3c_master_free_i3c_dev(i3cdev);
+				i3cdev = NULL;
+				break;
+			}
+		}
+
+		if (i3cdev) {
+			ret = i3c_master_attach_i3c_dev(master, i3cdev);
+			if (ret) {
+				i3c_master_free_i3c_dev(i3cdev);
+				goto populate_bus_fail;
+			}
+		}
+	}
+
+	list_for_each_entry_safe(olddev, tmp, &i3c_old, common.node) {
+		if (olddev->dev) {
+			olddev->dev->desc = NULL;
+			if (device_is_registered(&olddev->dev->dev))
+				device_unregister(&olddev->dev->dev);
+			else
+				put_device(&olddev->dev->dev);
+			kfree(olddev->dev);
+		}
+		list_del(&olddev->common.node);
+		i3c_master_free_i3c_dev(olddev);
+	}
+
+	return 0;
+
+populate_bus_fail:
+	/*
+	 * Try to restore i3cbus->devs.i3c list, so far no i3c
+	 * device is deleted, only moved or added to the original
+	 * i3c list. Move rest of the i3c devices from old list,
+	 * to correctly process defslvs in rety.
+	 */
+	list_for_each_entry_safe(olddev, tmp, &i3c_old, common.node) {
+		list_del(&olddev->common.node);
+		list_add(&olddev->common.node, &i3cbus->devs.i3c);
+	}
+
+	return ret;
+}
+
+/**
+ * i3c_master_process_defslvs() - process I3C device list received in
+ * DEFSLVS for device plug/unplug and address change.
+ * @m: I3C master object
+ *
+ * This function may sleep, so should not be called in the atomic context.
+ */
+int i3c_master_process_defslvs(struct i3c_master_controller *m)
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
+	ret = i3c_master_populate_bus(m);
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
index dd67497ad8b1..688487c4a62a 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -488,6 +488,8 @@ struct i3c_master_controller_ops {
  *	in a thread context. Typical examples are Hot Join processing which
  *	requires taking the bus lock in maintenance, which in turn, can only
  *	be done from a sleep-able context
+ * @defslvs_data: list used to pass i3c device list received in DEFSLVS message,
+ *	from DEFSLVS controller driver to I3C core
  *
  * A &struct i3c_master_controller has to be registered to the I3C subsystem
  * through i3c_master_register(). None of &struct i3c_master_controller fields
@@ -507,6 +509,10 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct {
+		u32 ndevs;
+		struct i3c_ccc_dev_desc *devs;
+	} defslvs_data;
 };
 
 /**
@@ -533,6 +539,7 @@ struct i3c_master_controller {
 
 void i3c_master_yield_bus(struct i3c_master_controller *m,
 			  u8 sec_mst_dyn_addr);
+int i3c_master_process_defslvs(struct i3c_master_controller *m);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
2.17.1

