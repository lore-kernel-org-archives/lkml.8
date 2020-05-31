Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C65C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B11207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YDnHq0+v";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6NvI74kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgEaHOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:14:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:26300 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728411AbgEaHOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:14:42 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V79ox6012583;
        Sun, 31 May 2020 00:14:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MPZk32MF5v2uDXKTY3E42r1qm4NRHuFRtHQAyhrkjC4=;
 b=YDnHq0+vpZprfwpsQo/cBImBtx8DzSZA3P6A0fDoa1rOHCftQUvSZ/x3i0hdhX14h2B+
 1dIBRUGEXZQMIPqEOOCBEW6uaixMcbB250yfF82D6/Ka0p+Xi0+v/yzZplBfTyj8AyKN
 Q/s/+VZR2IIhvuu0ddXKEvgXhALXaVG85gUVoXRolCxwD3+LzpBvDAlE5/8LoNL/8YZb
 NSGpatf3H1YLUbDBFuNHKYUGCmRUrGutKYoKG3lvujQ2NNzyjmllfVh8ou+LgsdkRIAe
 +U9uyQZjYokjtfIAjjkFks9Svty+A6J5sDZbPgQsqc0Fevcizt9XdyfhwVX3FcBWBXs4 DA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31bk2xann3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZE0Zdw7yAqJn2auwwZMtUcZucXZODLGFXTY7Uyr3300oW6xdkH3jZHPfpbug9hzgR5Dc2VzND53NVHiZcxbv8La4z/Lkk7KldeMfJXvMo1KGOvCl3fw+hiXaUZEwGQ31XUPwWnEhvINXyvZ16KNberIgE/3EtN1gEWgsQCqHUnqI343LdpWuqC1JiodkxHtmRnby8exMwHdTiLbzuZMKE3FKXlES3hUrRl1++FjWe6fHjaoMWyBiX7OZjnI94eFQ/QUzzM3EDIpwQ7kWJlE/M5GPF2U9/vt2WlWaihhF16dhN1rIZ8otDiTEO+XW/GhnkNAe4N1NlDkO0r+14NW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPZk32MF5v2uDXKTY3E42r1qm4NRHuFRtHQAyhrkjC4=;
 b=nZc+k+W5hmkS56bSyJOUnzj+71bFX7djCJg3LLpVvMHdhyWxZ0AT4rCGhXlNrztoU4oun1ayKEydtdyjoPjolAwukq/wq07a+qVkT13ZGxujCnviIBZ/ocvrG7HbAJXn7ktOgAkeYiE9YTJQoTkX8D6X2+8WJstSGilCZr7hqTqqdm9qzgW1uFSDPznIH71wC3TOSV3L2Mtb08dlyC9LH2QFTO+3cLSaB6WDQL0ry+dReIaBxubPk7u2vEhIaCR6dWkVRXncgdQ/7UblTPIGeacvlT2H98ydzo9IS/eB7gb+7cJpXohj8RoPLNwnF/vWRP5WiXJAoBcRiLUG+lwo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPZk32MF5v2uDXKTY3E42r1qm4NRHuFRtHQAyhrkjC4=;
 b=6NvI74kcfY5wYBG3sD8Dsz0IMRnd0/DXPUVSZ9ASknqV0BomxRZz7HVBvbR3NxzJk6ICEiE2Xtq5JaaRS8k+p3ZnOClpKgqB83/v64g3TpAki3g7SKsPxHeJ5cqApEqi6OFuRQdw+fGEfes678XBaGhAs8fs+ekKF1DjeFyoUvQ=
Received: from MWHPR2001CA0020.namprd20.prod.outlook.com
 (2603:10b6:301:15::30) by DM6PR07MB6202.namprd07.prod.outlook.com
 (2603:10b6:5:157::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Sun, 31 May
 2020 07:14:32 +0000
Received: from MW2NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::a4) by MWHPR2001CA0020.outlook.office365.com
 (2603:10b6:301:15::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Sun, 31 May 2020 07:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT013.mail.protection.outlook.com (10.13.180.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Sun, 31 May 2020 07:14:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7ET4V021358
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 31 May 2020 00:14:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 31 May 2020 09:14:28 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 31 May 2020 09:14:28 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7ESAt006990;
        Sun, 31 May 2020 09:14:28 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04V7ESCK006987;
        Sun, 31 May 2020 09:14:28 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v8 4/7] i3c: master: add mastership handover support
Date:   Sun, 31 May 2020 09:14:27 +0200
Message-ID: <1590909267-6949-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
References: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(36092001)(46966005)(8936002)(186003)(83380400001)(86362001)(36756003)(478600001)(82740400003)(426003)(8676002)(47076004)(2616005)(26005)(356005)(82310400002)(7636003)(70586007)(2906002)(54906003)(70206006)(4326008)(36906005)(316002)(110136005)(42186006)(107886003)(5660300002)(336012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ce7325-abe1-42ef-31c3-08d8053243cb
X-MS-TrafficTypeDiagnostic: DM6PR07MB6202:
X-Microsoft-Antispam-PRVS: <DM6PR07MB62029F9A0348DB6AB98C138DC18D0@DM6PR07MB6202.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXKAoKNNnbTFj111RZvnK2s8MgzOVJCFplcofCdtSnyNThvcleysk4TgtUJI6kYJy1HvqU8oEOi8kZboqDY07Q11/OVd3zBd/iEvI5kfHX4mpJlg8KRbkZLgTplAfe80Mn1vTxXPnJmNX5fJNSA9/o6AOyS9XzCmJEEK2XNwGxZMUkRwBgvxYceUYc9l1gNenpoCRhKkmvvKhdHi24uDQxD8IIP4FZvj+WDYs6SLvMt87D35VprdbdMZ31wa9aH/i6F0V3cX+DlBlYbHVLg3tsXEltTY5Ba7QXlZkk0+GpXHHCqUUdBU7d1wWRhzK/d/70qsqyJFzdKvQIBpSHHsVQ2y7OMR8JqyQYVCq7DTEyDC6IhjI1mFhiyzO/2YhtqtqCHl5IZ2+hSJIK0JlR+KJwidMyfeYZtEHKiTcEIGXoU=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 07:14:31.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ce7325-abe1-42ef-31c3-08d8053243cb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6202
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 cotscore=-2147483648 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=2 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added mastership acquire and yield functions.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 176 +++++++++++++++++++++++++++++++++++--
 include/linux/i3c/master.h |   6 ++
 2 files changed, 173 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 62f39997a6db..f9ab21e8f6ee 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -43,6 +43,16 @@ static void i3c_bus_maintenance_lock(struct i3c_bus *bus)
 	down_write(&bus->lock);
 }
 
+/**
+ * i3c_bus_maintenance_downgrade_lock - Downgrade maintenance lock to
+ * normaluse lock.
+ * @bus: I3C bus to take the lock on
+ */
+static void i3c_bus_maintenance_downgrade_lock(struct i3c_bus *bus)
+{
+	downgrade_write(&bus->lock);
+}
+
 /**
  * i3c_bus_maintenance_unlock - Release the bus lock after a maintenance
  *			      operation
@@ -467,6 +477,59 @@ static const char * const i3c_bus_mode_strings[] = {
 	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
 };
 
+static int i3c_master_enable_mr_events(struct i3c_master_controller *master)
+{
+	int ret;
+
+	master->ops->enable_mr_events(master);
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = i3c_master_enec_locked(master, I3C_BROADCAST_ADDR,
+				     I3C_CCC_EVENT_MR | I3C_CCC_EVENT_HJ);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return ret;
+}
+
+/**
+ * i3c_master_acquire_bus() - acquire I3C bus mastership
+ * @m: I3C master object
+ *
+ * This function may sleep.
+ * It is expected to be called with normaluse_lock.
+ */
+static int i3c_master_acquire_bus(struct i3c_master_controller *m)
+{
+	int ret = 0;
+
+	/*
+	 * Request mastership needs maintenance(write) lock. So, to avoid
+	 * deadlock, release normaluse(read) lock, which is expected to be
+	 * held before calling this function.
+	 * normaluse(read) lock is expected to be held before calling
+	 * this function to avoid race with maintenance activities
+	 * like DEFSLVS processing etc
+	 */
+	i3c_bus_normaluse_unlock(&m->bus);
+	i3c_bus_maintenance_lock(&m->bus);
+
+	if (m->this && m->this == m->bus.cur_master) {
+		i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
+					I3C_CCC_EVENT_MR |
+					I3C_CCC_EVENT_HJ);
+		goto mr_req_done;
+	}
+
+	ret = m->ops->request_mastership(m);
+	if (ret)
+		goto mr_req_done;
+
+	m->bus.cur_master = m->this;
+
+mr_req_done:
+	i3c_bus_maintenance_downgrade_lock(&m->bus);
+	return ret;
+}
+
 static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *da,
 			 char *buf)
@@ -685,6 +748,33 @@ static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
 	return 0;
 }
 
+static int i3c_master_get_accmst_locked(struct i3c_master_controller *master,
+					u8 addr)
+{
+	struct i3c_ccc_getaccmst *accmst;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	accmst = i3c_ccc_cmd_dest_init(&dest, addr, sizeof(*accmst));
+	if (!accmst)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETACCMST, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	if (dest.payload.len != sizeof(*accmst))
+		ret = -EIO;
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static struct i2c_dev_desc *
 i3c_master_find_i2c_dev_by_addr(const struct i3c_master_controller *master,
 				u16 addr)
@@ -1558,10 +1648,6 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
 		return -EINVAL;
 
-	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
-	    master->secondary)
-		return -EINVAL;
-
 	if (master->this)
 		return -EINVAL;
 
@@ -1570,7 +1656,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 		return PTR_ERR(i3cdev);
 
 	master->this = i3cdev;
-	master->bus.cur_master = master->this;
+
+	if (!master->secondary)
+		master->bus.cur_master = master->this;
 
 	ret = i3c_master_attach_i3c_dev(master, i3cdev);
 	if (ret)
@@ -1612,6 +1700,74 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 	}
 }
 
+/**
+ * i3c_master_yield_bus() - yield I3C bus mastership
+ * @m: I3C master object
+ * @sec_mst_dyn_addr: address of device requesting mastership
+ *
+ * This function may sleep.
+ * It is expected to be called with normaluse_lock.
+ */
+void
+i3c_master_yield_bus(struct i3c_master_controller *m, u8 sec_mst_dyn_addr)
+{
+	struct i3c_dev_desc *i3cdev;
+	bool dev_found =  false;
+	int ret = 0;
+
+	i3c_bus_maintenance_lock(&m->bus);
+	if (m->this != m->bus.cur_master)
+		goto mr_yield_done;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (sec_mst_dyn_addr == i3cdev->info.dyn_addr) {
+			dev_found = true;
+			break;
+		}
+	}
+
+	/* Requesting device not found on i3c list. This should never happen. */
+	if (!dev_found)
+		goto mr_yield_done;
+
+	/*
+	 * Maintenance lock and master check above is used to
+	 * avoid race amongst devices sending MR requests
+	 * at the same time, as soon as ENEC MST is sent by the current
+	 * master. It ensure that only one MR request is processed,
+	 * rest MR requests on losing devices will timeout in wait MR
+	 * DONE state. And next MR requests are blocked due to DISEC MST
+	 * sent by current master in yield operation.
+	 * New master should send ENEC MST once it's work is done.
+	 * maintainanace lock is also needed for i3c_master_get_accmst_locked.
+	 */
+
+	ret = i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
+				      I3C_CCC_EVENT_MR |
+				      I3C_CCC_EVENT_HJ);
+	/*
+	 * Once mastership is given to the new master, it is expected that
+	 * MR is disabled prior to that and new master is responsible to
+	 * enable it by broadcasting ENEC MR when it's work is done.
+	 * If DISEC MR fails and we still go ahead with handover, chances
+	 * are new master will get interrupted by unexpected MR requests.
+	 */
+	if (ret)
+		goto mr_yield_done;
+
+	ret = i3c_master_get_accmst_locked(m, sec_mst_dyn_addr);
+	if (ret)
+		goto mr_yield_done;
+
+	m->bus.cur_master = i3cdev;
+
+mr_yield_done:
+	i3c_bus_maintenance_unlock(&m->bus);
+	if (ret)
+		i3c_master_enable_mr_events(m);
+}
+EXPORT_SYMBOL_GPL(i3c_master_yield_bus);
+
 /**
  * i3c_primary_master_bus_init() - initialize an I3C bus
  * @master: main master initializing the bus
@@ -2472,6 +2628,9 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	     !ops->recycle_ibi_slot))
 		return -EINVAL;
 
+	if (ops->request_mastership && !ops->enable_mr_events)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2485,10 +2644,6 @@ static int i3c_master_init(struct i3c_master_controller *master,
 	struct i2c_dev_boardinfo *i2cbi;
 	int ret;
 
-	/* We do not support secondary masters yet. */
-	if (secondary)
-		return -ENOTSUPP;
-
 	ret = i3c_master_check_ops(ops);
 	if (ret)
 		return ret;
@@ -2605,6 +2760,9 @@ int i3c_primary_master_register(struct i3c_master_controller *master,
 	i3c_master_register_new_i3c_devs(master);
 	i3c_bus_normaluse_unlock(&master->bus);
 
+	if (ops->request_mastership)
+		ret = i3c_master_enable_mr_events(master);
+
 	return 0;
 
 err_del_dev:
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index c3d05f66fceb..693b920bfd54 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -418,6 +418,8 @@ struct i3c_bus {
  *		      for a future IBI
  *		      This method is mandatory only if ->request_ibi is not
  *		      NULL.
+ * @request_mastership: send mastership request to the current master
+ * @enable_mr_events: enable mastership request handling by the controller
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -445,6 +447,8 @@ struct i3c_master_controller_ops {
 	int (*disable_ibi)(struct i3c_dev_desc *dev);
 	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
 				 struct i3c_ibi_slot *slot);
+	int (*request_mastership)(struct i3c_master_controller *master);
+	void (*enable_mr_events)(struct i3c_master_controller *m);
 };
 
 /**
@@ -510,6 +514,8 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
 
+void i3c_master_yield_bus(struct i3c_master_controller *m,
+			  u8 sec_mst_dyn_addr);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
2.17.1

