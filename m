Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA63AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CD20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TcODtX/I";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LpltpaR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgDQQVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:21:24 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:24796 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgDQQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:21:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HGADk9019643;
        Fri, 17 Apr 2020 09:21:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ePzRzJ4mehyx3KTFRN1b5Wxxyz2j/pVpdXMTskKAvuw=;
 b=TcODtX/IZiEEi9DB3BWGkwXTbZWHPVjO0hqAzUF+uE3BfzCJaGG+lav0oizPenvl9rlG
 R129b42gADOzOhhb7GQ3f41Sk9lO1jLcBVS7L0ikc12Yr4EULvM7l3y//E5WE8bJmJIU
 OZWg6szaxo+LNLZQBq7Ya4CUsUWn3qRClpt/Zzyh7CCJMxTDPshcvdR4wVK4lC5BmoON
 3zqbwlMr6VW6kDWJzuQVKT+Pua/BRYO9avSmY/YNVUQMpbWun7ERarhWhwfu00/3FfeY
 RXpUHs6Evn0FLGgopjz//WBdJ9vheB8Gxdt2K3eCux7Jnfq8Mw5ZE4GY9zNvaL+mO3Pw 2g== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30dn7954wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci2aGfcPYUj1/JFRkSxIDSUaCoRbOCP+FxJqM+PbZ/2Xrr7orbyqyY9Nv+A7CGkaOz6A27Alsg75S8X/a+11TPeao9xNpX0/Hu+i35O+3c61qQKHtyTevmOH5DIbM9QcDlTxGMfQr0Iw17HAudfG1jWGKwNjH6ZlxQGiPMtJTT0KgJKh67aL2/cuMvjgX6XCDDubHHNVeVrrBM0NOSJP086ZAcJ45olfRPSc26MUYMiUhvpVHBYKV6/wVzmKOznFtz0WD9/0qb5tfp557m1FyfNkPTvWFKw1IyBkiHbXXXfp4l/Jt6z0bf2Zt+Etj4ZBdfkkGi1KwTORWjLum903fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePzRzJ4mehyx3KTFRN1b5Wxxyz2j/pVpdXMTskKAvuw=;
 b=Z7OkVKKeGvCum17sO4KEcleqzd9D7sg1K4M19jm6WxX1IFoV0TAP2YXR1fRXZY4cBMsbIMZzkYsGz+WskoflWsJ28QAcD+WNATbx31bK4kQZE+LdItRutdxH0ZvKhuMj3QelyIPMOf3TbDHq3DfFbqT7zjDO6M67V+Oi6BdiqoV8zBCzK7MV+kFXKfOrfFmx5vd2UTNUzBLQ2vLmRisC9Y0cUh+4F8JyzQX6ZYo2lmOej3vXDVqVa+C/WWDyHcwKq3KqhosFwY96h/oNJimzZeS+tKSfJsPA+1izSdwmZ8685/BLa+4d3LCYdvkZjUcAAkCaxzRV0X+7O3MvApnQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePzRzJ4mehyx3KTFRN1b5Wxxyz2j/pVpdXMTskKAvuw=;
 b=LpltpaR509BOeQYHA1XptLMVY6LDdYaQkndeV+d0zI/LqWlQWCzZut7XcOCyBcg9pvwIaB7YLdRNDVTA6jSxX0TKVLRhutB8mcCePvqV7LmCg32ROCyfGd3SaVaWvyZLIMesnqfANB/nzO1WZUjSYuYEl3jB/5KekmaYmKYCFww=
Received: from BN4PR13CA0023.namprd13.prod.outlook.com (2603:10b6:403:3::33)
 by DM5PR07MB3893.namprd07.prod.outlook.com (2603:10b6:4:af::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 16:21:11 +0000
Received: from BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:403:3:cafe::9b) by BN4PR13CA0023.outlook.office365.com
 (2603:10b6:403:3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend
 Transport; Fri, 17 Apr 2020 16:21:10 +0000
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT017.mail.protection.outlook.com (10.13.182.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:21:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGL5DO028092
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Apr 2020 09:21:07 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:21:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:21:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGL5Xi030275;
        Fri, 17 Apr 2020 18:21:05 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGL5h2030274;
        Fri, 17 Apr 2020 18:21:05 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 3/8] i3c: master: i3c mastership request and handover
Date:   Fri, 17 Apr 2020 18:21:02 +0200
Message-ID: <1587140462-30209-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36092001)(46966005)(70586007)(478600001)(8676002)(26005)(107886003)(246002)(5660300002)(4326008)(336012)(70206006)(36906005)(426003)(86362001)(63370400001)(63350400001)(6666004)(2906002)(54906003)(42186006)(316002)(8936002)(186003)(47076004)(7636003)(356005)(82740400003)(2616005)(36756003)(110136005)(42413003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d38169a-7b62-4a55-95c5-08d7e2eb5672
X-MS-TrafficTypeDiagnostic: DM5PR07MB3893:
X-Microsoft-Antispam-PRVS: <DM5PR07MB3893B51721BDE19457676459C1D90@DM5PR07MB3893.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5ZuNSZGG9A1hyAwe0yHufVuvRw5SbmbrCsHzItvGqXmc96zZtTvPPHejlUGfZaYf3V6Vclar032MZFt9QPOwzHSC/tqRCkRcxvry/Uz+lfBBOole8RuytAUTM71miWPzHWCokQTs7bxkTdKqcjnW0iqgU9HdhiYpPzSmRdWlD+wKSLlqC/P9Wqo2eaMTliTW1nysX5xkpuEMqLNu85x8JCj7Td9T6wQ/Ha4Jc+R3MVMPXlRmol3pFkE8Q1mnVOb1pBAU0Y30uU1ZADVeGWVWq5Vky03B5meBAgN+8nb/fJ0EEgdj0gC6+S7vmJ6wLfd3lbF13wSHiklL4/kUapHAwQ28HZoP3u3yqT5bBzUek04DTv11kRGYT0dT31x67kN6u642GRXzETvKuGQ/O/KkJ9orDv+yeCX77gKKPJWRLKpJQzmhNULv3tcikBfB2aJN+wkXtn3g/cj902tXCvTTcMjIIZxKCgR8aKPSzSUTme//OnjolgjFulMxiRDEov6eHx0QXsf0QjhMeeuDhbaD/2txGA8NgCiLseTjkXo2SmGmxqd/luJNMguZtxEzf7k
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:21:09.0417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d38169a-7b62-4a55-95c5-08d7e2eb5672
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3893
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add I3C mastership request and
handover infrasturcture to I3C master subsystem.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 221 +++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  34 ++++++
 2 files changed, 255 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0ec332e45737..3598856a0b25 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1217,6 +1217,69 @@ static int i3c_master_getdcr_locked(struct i3c_master_controller *master,
 	return ret;
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
+static int i3c_master_getaccmst(struct i3c_master_controller *master)
+{
+	int ret;
+
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = i3c_master_get_accmst_locked(master, master->mr_addr);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return ret;
+}
+
+static int i3c_master_request_mastership(struct i3c_master_controller *master)
+{
+	int ret;
+
+	/* request_mastership callback should handle EN/DIS EC MR.*/
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = master->ops->request_mastership(master);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return ret;
+}
+
 static int i3c_master_retrieve_dev_info(struct i3c_dev_desc *dev)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
@@ -1612,6 +1675,161 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 	}
 }
 
+static void i3c_mst_yield_bus(struct work_struct *work)
+{
+	struct i3c_master_controller *m;
+	struct i3c_dev_desc *i3cdev;
+	int ret;
+
+	m = container_of(work, struct i3c_master_controller, mst_work);
+
+	switch (m->mr_state) {
+	case I3C_MR_DISEC_MR:
+		/*
+		 * Disable MR on all but the secondary master first
+		 * reaching here.
+		 */
+		i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+			if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+			    I3C_BCR_I3C_MASTER ||
+			    i3cdev->info.dyn_addr == m->mr_addr ||
+			    m->this == i3cdev)
+				continue;
+			i3c_bus_maintenance_lock(&m->bus);
+			i3c_master_disec_locked(m, i3cdev->info.dyn_addr,
+						I3C_CCC_EVENT_MR |
+						I3C_CCC_EVENT_HJ);
+			i3c_bus_maintenance_unlock(&m->bus);
+		}
+		m->mr_state = I3C_MR_GETACCMST;
+		queue_work(m->wq, &m->mst_work);
+		break;
+
+	case I3C_MR_GETACCMST:
+		ret = i3c_master_getaccmst(m);
+		if (!ret)
+			m->mr_state = I3C_MR_DONE;
+		else
+			m->mr_state = I3C_MR_FAILED;
+		queue_work(m->wq, &m->mst_work);
+		break;
+
+	case I3C_MR_DONE:
+		i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+			if (m->mr_addr == i3cdev->info.dyn_addr) {
+				m->bus.cur_master = i3cdev;
+				break;
+			}
+		}
+		m->mr_state = I3C_MR_IDLE;
+		break;
+
+	default:
+	case I3C_MR_FAILED:
+		i3c_master_enable_mr_events(m);
+		m->mr_state = I3C_MR_IDLE;
+		break;
+	}
+}
+
+void
+i3c_master_yield_bus(struct i3c_master_controller *master, u8 sec_mst_dyn_addr)
+{
+	if (master->this && master->this == master->bus.cur_master) {
+		master->ops->disable_mr_events(master);
+		master->mr_addr = sec_mst_dyn_addr;
+		master->mr_state = I3C_MR_DISEC_MR;
+		queue_work(master->wq, &master->mst_work);
+	} else {
+		/* If not a current master, we should never come here */
+		WARN_ON(1);
+	}
+}
+EXPORT_SYMBOL_GPL(i3c_master_yield_bus);
+
+static void i3c_sec_mst_acquire_bus(struct work_struct *work)
+{
+	struct i3c_master_controller *m;
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	m = container_of(work, struct i3c_master_controller, sec_mst_work);
+	i3cbus = i3c_master_get_bus(m);
+
+	switch (m->mr_state) {
+	case I3C_MR_WAIT_DA:
+		/* Wait until this master have dynamic address */
+		if (m->ops->check_event_set(m, I3C_SLV_DA_UPDATE))
+			m->mr_state = I3C_MR_REQUEST;
+		queue_work(m->wq, &m->sec_mst_work);
+		break;
+
+	case I3C_MR_REQUEST:
+		/* Wait until we can send MR */
+		ret = i3c_master_request_mastership(m);
+		if (!ret)
+			m->mr_state = I3C_MR_WAIT_MR_DONE;
+		queue_work(m->wq, &m->sec_mst_work);
+		break;
+
+	case I3C_MR_WAIT_MR_DONE:
+		if (m->ops->check_event_set(m, I3C_SLV_MR_DONE)) {
+			m->mr_state = I3C_MR_DONE;
+			m->bus.cur_master = m->this;
+			complete(&m->mr_comp);
+		} else {
+			queue_work(m->wq, &m->sec_mst_work);
+		}
+		break;
+
+	default:
+		m->mr_state = I3C_MR_FAILED;
+		complete(&m->mr_comp);
+		break;
+	}
+}
+
+void i3c_sec_mst_mr_dis_event(struct i3c_master_controller *m)
+{
+	if (m->mr_state != I3C_MR_IDLE)
+		m->mr_state = I3C_MR_WAIT_DA;
+}
+EXPORT_SYMBOL_GPL(i3c_sec_mst_mr_dis_event);
+
+/* This function is expected to be called with normaluse_lock */
+int i3c_master_acquire_bus(struct i3c_master_controller *master)
+{
+	int ret = 0;
+
+	if (!master->this || master->this != master->bus.cur_master) {
+		if (master->mr_state == I3C_MR_IDLE) {
+			master->mr_state = I3C_MR_WAIT_DA;
+			init_completion(&master->mr_comp);
+			queue_work(master->wq, &master->sec_mst_work);
+			/*
+			 * Bus acquire procedure may need write lock
+			 * so release read lock before yielding
+			 * to bus acquire state machine
+			 */
+			i3c_bus_normaluse_unlock(&master->bus);
+			wait_for_completion(&master->mr_comp);
+			i3c_bus_normaluse_lock(&master->bus);
+			if (master->mr_state != I3C_MR_DONE)
+				ret = -EAGAIN;
+			master->mr_state = I3C_MR_IDLE;
+		} else {
+			/*
+			 * MR request is already in process for
+			 * this master
+			 */
+			ret = -EAGAIN;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_acquire_bus);
+
 /**
  * i3c_master_bus_init() - initialize an I3C bus
  * @master: main master initializing the bus
@@ -2451,6 +2669,9 @@ int i3c_master_register(struct i3c_master_controller *master,
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
+	INIT_WORK(&master->sec_mst_work, i3c_sec_mst_acquire_bus);
+	INIT_WORK(&master->mst_work, i3c_mst_yield_bus);
+
 	ret = of_populate_i3c_bus(master);
 	if (ret)
 		goto err_put_dev;
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 3dc7eafe811a..c465c7792ccb 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -259,6 +259,27 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+enum i3c_mr_state {
+	I3C_MR_IDLE,
+	I3C_MR_DISEC_MR,
+	I3C_MR_SEND_DEFSLVS,
+	I3C_MR_GETACCMST,
+	I3C_MR_WAIT_DA,
+	I3C_MR_CHECK_STATE,
+	I3C_MR_REQUEST,
+	I3C_MR_WAIT_DEFSLVS,
+	I3C_MR_WAIT_MR_DONE,
+	I3C_MR_DONE,
+	I3C_MR_FAILED,
+};
+
+enum i3c_event {
+	I3C_SLV_DA_UPDATE,
+	I3C_SLV_DEFSLVS_CCC,
+	I3C_SLV_MR_DIS,
+	I3C_SLV_MR_DONE,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -448,6 +469,11 @@ struct i3c_master_controller_ops {
 	int (*disable_ibi)(struct i3c_dev_desc *dev);
 	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
 				 struct i3c_ibi_slot *slot);
+	int (*request_mastership)(struct i3c_master_controller *master);
+	void (*enable_mr_events)(struct i3c_master_controller *m);
+	void (*disable_mr_events)(struct i3c_master_controller *m);
+	bool (*check_event_set)(struct i3c_master_controller *m,
+				enum i3c_event);
 };
 
 /**
@@ -489,6 +515,11 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct work_struct mst_work;
+	struct work_struct sec_mst_work;
+	struct completion mr_comp;
+	enum i3c_mr_state mr_state;
+	u8 mr_addr;
 };
 
 /**
@@ -513,6 +544,9 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
 
+void i3c_master_yield_bus(struct i3c_master_controller *master,
+			  u8 slv_dyn_addr);
+void i3c_sec_mst_mr_dis_event(struct i3c_master_controller *m);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
2.17.1

