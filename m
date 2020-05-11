Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD9D2192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YIrtVrdA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dM0Ih/io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgEKNUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:20:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23824 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbgEKNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:20:07 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BD8Bx4016654;
        Mon, 11 May 2020 06:15:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Ff47UsXqo08jJp96SlPnPp4QA6IrV9yuuGoM9oOVvsM=;
 b=YIrtVrdAMB26ycd9Oi260N5gijRjbLtKqvCYNkKFUYZQ6jthrCZoXcsYZ7ZCfD3j7LHA
 c6u1HiBSUdM6Ok4NC7qqk64qmUEaZVSsQ3Yn7dNLYKSsiffsN+iaMKDS3MQZmFsnxK7L
 SpF8sW5IAJbcqGLRT8IaQjPIwViU1CJYrn1uI6KueIpVnifGBzBrngHYQiJvZo+cTxxS
 XGGDWBbaFe7t8mK6rqLYcq7COnSrqKmALnnmMsbHrbat6uuDqcPngyU0SwQ+qS3319Gm
 rDWbmvjNRK1a5T2kV8AbWTkdd9Wss+9dincZTstdv/AtB/Gvcz8h+mnVE2Ri8ALqe6V+ EQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30ws2xx3y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq4de5OwFNxvGV8khY/Si8ktxGddI9zAwpau93d0wYeUFqGYilr61xlJuA2zVo5XgNIMfP+r5U+62KyQ0nmX1UgV4PvKjxRiPUVAljp79wUN/OV1aPdnbvFzrojR+ybtes3ExKOkv2mPQ2x0R465ucyhnQh4rAKWQ4VjXZKrvmNF4Ewjfs1CejavDwARBrA/wJP5i2HZREwJvR7exXHwWkYNU3eAyl3Y9yeprP5A43yycSSITOmY4NFWfnr15QlqfUb0F356giuw3GntGyk0rAyfNE1cL2oD9bGuBQA49mpqIa5fnieTH90JKLSSYF/bb8xf+XN3wqC+cXv67lJv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff47UsXqo08jJp96SlPnPp4QA6IrV9yuuGoM9oOVvsM=;
 b=N/iv5auuDa1lw+Q92s6g4Z/Tc/2IXM9VWOh7199ulGmvt5OYoVUs7Ddv0dFa2w3/gHyFSa8Ypsx2dbhTICSizLtvZT80MOJIK0u/N6lN17nJS9LMs4dYobAYfj0gHbDQTScuLsXGtadgr52czHQ1h9x/HXGTdIqDZm6uIoSmFqnviwV9heMrX7BsS8ZOFakbcWSZ710pZwIlc2iw07dvHdgeWouWr7LVB3mg58DAq22AlqQDuW9iCYSn+xjKzK7FVTH16XF5g3oIDcvdi7xieDeHTIVHAudRIG1EAEz2uS7JAP9srmFeHAYvAdGymoRkr0yg9M41kT//HVR8PAiUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff47UsXqo08jJp96SlPnPp4QA6IrV9yuuGoM9oOVvsM=;
 b=dM0Ih/ioA3DMTdtrgDgxclqaWZ50HrTfAr7vH4A7DZVzNa1PmRKh1pSaA0Sl5HUWO00Iu/1tJDFT3RN9ldvPScUaLdHoRGDAchzbAohLxl1RzObzvuD7WYo8EA7pvT6ML8RrSp0YMJkc+tEdkLC7ZxTWjOjmApGcc9pA6csbVgk=
Received: from BN6PR1101CA0017.namprd11.prod.outlook.com
 (2603:10b6:405:4a::27) by BL0PR07MB5443.namprd07.prod.outlook.com
 (2603:10b6:208:27::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Mon, 11 May
 2020 13:14:58 +0000
Received: from BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::12) by BN6PR1101CA0017.outlook.office365.com
 (2603:10b6:405:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Mon, 11 May 2020 13:14:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT015.mail.protection.outlook.com (10.13.183.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:14:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDEqt1019853
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2020 09:14:53 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:14:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:14:50 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDEpe2009276;
        Mon, 11 May 2020 15:14:51 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDEo8n009271;
        Mon, 11 May 2020 15:14:50 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 4/7] i3c: master: add mastership handover support
Date:   Mon, 11 May 2020 15:14:49 +0200
Message-ID: <1589202889-9186-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(36092001)(46966005)(33430700001)(82740400003)(316002)(36906005)(42186006)(8676002)(8936002)(478600001)(5660300002)(110136005)(70586007)(54906003)(86362001)(82310400002)(107886003)(81166007)(70206006)(47076004)(26005)(186003)(2616005)(336012)(36756003)(33440700001)(356005)(426003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d1e4f01-e537-4687-16d1-08d7f5ad4d5c
X-MS-TrafficTypeDiagnostic: BL0PR07MB5443:
X-Microsoft-Antispam-PRVS: <BL0PR07MB544345249058E50AE2898111C1A10@BL0PR07MB5443.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NAadNDPwI+++nPilG1p9lzRYXzuIFIDUMqBZI0EWCzqB4jhXuCtySZvTrgJbS+MRwDoGHNB3VPB4WtpsDbto7fU8kTQo/qqgXmicfEI+DaEG5vpJkj0ICqAn1SIOiUS+RerhyndxRKU4NHPpM9VsX/0RrrfQ/IR5hG6JXoxPwn8DB+J3s4QhIemIeIGdXfcglABIvuuE74YDRXTrY9FOq59JLFlf2n9fFq9iCSCeV6N7zD0DHTPfZeFhrutFljlS5efwstGcDlqaDS/Gsi8LKqqeojSlTw+kphe/+3LBbkvQaWAl/ihf+HduSp4cvHfYhHoUce9Om76UgxMv9Mxy3AcWIlXa12uhdBO+V7CwJhGbvJ8xNl0L2Z9UpcDS6YS0sh25Dx7OEuIOpU4oRJGRT2WKGMEUctauCc4Lg/c9SwHm9YIJpcjwFUUOlhMqv9r6I/yQ/BqmHnbD3gf888yVOm/X915i+4iAY/KOQvoxGggtKWWlmrL3jvbQBKAFo7ThlZChugI9nNQcRLUjAeRllJUPvgIohL05Jiwq83/1AioRwM2iQ5AxIxGYLxL1z06sDYqvGmxlllgRU6MjcKbxez5Ba1v7lcDQdca0F0myts=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:14:57.1912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1e4f01-e537-4687-16d1-08d7f5ad4d5c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5443
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=2 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=867
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added mastership acquire and yield functions.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 187 +++++++++++++++++++++++++++++++++++--
 include/linux/i3c/master.h |  23 +++++
 2 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 669bd7e45810..9c8250a6a2b0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/iopoll.h>
 
 #include "internals.h"
 
@@ -467,6 +468,79 @@ static const char * const i3c_bus_mode_strings[] = {
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
+static int check_event_da_update(struct i3c_master_controller *m)
+{
+	return m->ops->check_event_set(m, I3C_SLV_DA_UPDATE);
+}
+
+static int check_event_mr_done(struct i3c_master_controller *m)
+{
+	return m->ops->check_event_set(m, I3C_SLV_MR_DONE);
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
+	u32 val;
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
+	ret = readx_poll_timeout(check_event_da_update, m, val,
+				 val, 100, 1000000);
+	if (ret)
+		goto mr_req_done;
+
+	ret = m->ops->request_mastership(m);
+	if (ret)
+		goto mr_req_done;
+
+	ret = readx_poll_timeout(check_event_mr_done, m, val,
+				 val, 100, 1000000);
+	if (!ret)
+		m->bus.cur_master = m->this;
+
+mr_req_done:
+	i3c_bus_maintenance_unlock(&m->bus);
+	i3c_bus_normaluse_lock(&m->bus);
+	return ret;
+}
+
 static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *da,
 			 char *buf)
@@ -685,6 +759,33 @@ static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
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
@@ -1558,10 +1659,6 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
 		return -EINVAL;
 
-	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
-	    master->secondary)
-		return -EINVAL;
-
 	if (master->this)
 		return -EINVAL;
 
@@ -1570,7 +1667,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 		return PTR_ERR(i3cdev);
 
 	master->this = i3cdev;
-	master->bus.cur_master = master->this;
+
+	if (!master->secondary)
+		master->bus.cur_master = master->this;
 
 	ret = i3c_master_attach_i3c_dev(master, i3cdev);
 	if (ret)
@@ -1612,6 +1711,73 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
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
+	int ret = 0;
+
+	i3c_bus_maintenance_lock(&m->bus);
+	if (m->this != m->bus.cur_master)
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
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (sec_mst_dyn_addr == i3cdev->info.dyn_addr) {
+			m->bus.cur_master = i3cdev;
+			break;
+		}
+	}
+
+	/* Requesting device not found on i3c list. This should never happen. */
+	if (m->this == m->bus.cur_master) {
+		ret = -EAGAIN;
+		WARN_ON(1);
+	}
+
+mr_yield_done:
+	i3c_bus_maintenance_unlock(&m->bus);
+	if (ret)
+		i3c_master_enable_mr_events(m);
+}
+EXPORT_SYMBOL_GPL(i3c_master_yield_bus);
+
 /**
  * i3c_master_bus_init() - initialize an I3C bus
  * @master: main master initializing the bus
@@ -2472,6 +2638,10 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	     !ops->recycle_ibi_slot))
 		return -EINVAL;
 
+	if (ops->request_mastership &&
+	    (!ops->enable_mr_events || !ops->check_event_set))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2485,10 +2655,6 @@ static int i3c_master_init(struct i3c_master_controller *master,
 	struct i2c_dev_boardinfo *i2cbi;
 	int ret;
 
-	/* We do not support secondary masters yet. */
-	if (secondary)
-		return -ENOTSUPP;
-
 	ret = i3c_master_check_ops(ops);
 	if (ret)
 		return ret;
@@ -2608,6 +2774,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 	i3c_master_register_new_i3c_devs(master);
 	i3c_bus_normaluse_unlock(&master->bus);
 
+	if (ops->request_mastership)
+		ret = i3c_master_enable_mr_events(master);
+
 	return 0;
 
 err_del_dev:
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 5124ff4831eb..dd67497ad8b1 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -259,6 +259,16 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+/**
+ * enum i3c_event - I3C master (currently acting as a slave) controller events
+ * @I3C_SLV_DA_UPDATE: I3C master has dynamic address
+ * @I3C_SLV_MR_DONE: I3C mastership request completed successfully
+ */
+enum i3c_event {
+	I3C_SLV_DA_UPDATE,
+	I3C_SLV_MR_DONE,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -418,6 +428,12 @@ struct i3c_bus {
  *		      for a future IBI
  *		      This method is mandatory only if ->request_ibi is not
  *		      NULL.
+ * @request_mastership: send mastership request to the current master
+ * @enable_mr_events: enable mastership request handling by the controller
+ * @check_event_set: check events (enum i3c_event) such as device has dynamic
+ *		     address, mastership request is completed successfully.
+ * @sec_mst_dyn_addr: read current dynamic address of the I3C device from
+ *		      hardware.
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
@@ -445,6 +461,11 @@ struct i3c_master_controller_ops {
 	int (*disable_ibi)(struct i3c_dev_desc *dev);
 	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
 				 struct i3c_ibi_slot *slot);
+	int (*request_mastership)(struct i3c_master_controller *master);
+	void (*enable_mr_events)(struct i3c_master_controller *m);
+	bool (*check_event_set)(struct i3c_master_controller *m,
+				enum i3c_event);
+	int (*sec_mst_dyn_addr)(struct i3c_master_controller *m);
 };
 
 /**
@@ -510,6 +531,8 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
 
+void i3c_master_yield_bus(struct i3c_master_controller *m,
+			  u8 sec_mst_dyn_addr);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
2.17.1

