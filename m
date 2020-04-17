Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4E6C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842DD2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="eDmO9E0X";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RJWT4qup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgDQQXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:23:20 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48210 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgDQQXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:23:18 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HG8SGv005877;
        Fri, 17 Apr 2020 09:23:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MU02I0AFeh9Ec5HIMpPtlFMS2QMDWcuUvC8AGqRTQJg=;
 b=eDmO9E0XjBz64EXjHXGWeKLQSR13WAmZLsvz5RJXWNTbLNaMY0Vf+s+/s6MSHIm+KlbW
 ChnvVNbDBmxZkrC4AGFkpkYesrjUayZOQJoDUjYDH8yuoBZkn75wXHg0B/fFwG9HJU3B
 kTgZq0bRXfS6uOwJd1J4ZOxCyyQ75N+KGOYzHuC/iNuEczCpgJUDcYr1Oszmx8Ajz6gs
 4RTXO7ncvuhtgy/apyCdjoUECnRTSFi7WD7Wz7b2X6j+nOzW/s8uTchtpc+HsNoMBmQh
 Mg0JeoTcdaszf6juwcVjLwkjOAcij7mZEC3KaDsPVC56OzTWrUDSnM4ntO6QFHYpzAvJ Kg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30dn9650mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf1R80ecNbqbbtW8cxO0GUIvklWxuuVzIHixXV8+0ZyPD1BOVZRQasMGt3Ma8R4AkrmPo69BlPSwSDMGmFr15VwDNMozLTNORbsccJ6ReZWI0VLZYwQAZR5qbxJ2OlaI08uZc7Lkd5TyLSAwvi4eC9t9puAhPFmp/Khrlre5FnCktwalF1U4fkS9TlO7TeNW71NjwsxlG0rkMCvm61Uus3ZZy0zPs+llqYzOfDxryzfH2oLrBG3a6FYmOBz9H1m8y7k6SPguAqSohhaT7ZHbiKzVBwuwO0y/OFhFvNQ9IWOEHs0Dk7c53ny9LEyjG9EqesaF6gKi/Z1uGYbGXW0AIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU02I0AFeh9Ec5HIMpPtlFMS2QMDWcuUvC8AGqRTQJg=;
 b=BiOKmbqu9UuTXo08SKivv+c958mXd+dc7wkof/u/20CbwW/V30Xy7YH0WspDOG4BQIRjYJP2HYj0OW1ib6VwtIuqMS0oKaHU2oPojDWF4pmaHg5LXEFHFfVS2OcJlA3gWhU3xoX+fYg8BwyYLc+5atSsxvrYkWHpGUdOFS0FhN3iGRc0Ip0uh07MFnvPW55T5JP7kzRwbOH2sPiajJlprw/oOfoCv8DT7u9WxGo9bcCECbA/GK9UINm5D8TqfAztuLedY/T0lYFlYS9WZNrPKryc5b6U4vr0vXCwPoqaBKJVu5SpWRWwf5lkqk/0mlFhVcUBLg/uv5PSpFyz4xINgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU02I0AFeh9Ec5HIMpPtlFMS2QMDWcuUvC8AGqRTQJg=;
 b=RJWT4qupZOtmVL2XGKuhcHtAaTW4ahMpQdoGPX64hmt7ZgLp29lqe7alwI2KVP+x94UKpEQJdDVm36DMEUExfNNHHjSSpCaBo/oPRildA/MYvt7dS1VsbPJ1SYs5zn6EOfwM/EsAB8CV45rW2HjzJTqYkawBwX2I1v5dt0yuTww=
Received: from MWHPR14CA0056.namprd14.prod.outlook.com (2603:10b6:300:81::18)
 by BN7PR07MB5361.namprd07.prod.outlook.com (2603:10b6:408:23::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.28; Fri, 17 Apr
 2020 16:23:00 +0000
Received: from MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::94) by MWHPR14CA0056.outlook.office365.com
 (2603:10b6:300:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Fri, 17 Apr 2020 16:23:00 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT037.mail.protection.outlook.com (10.13.180.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:22:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGMvar028269
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Apr 2020 09:22:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:22:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:22:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGMuCK031470;
        Fri, 17 Apr 2020 18:22:56 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGMuA1031469;
        Fri, 17 Apr 2020 18:22:56 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 7/8] i3c: master: added sysfs key i3c_acquire_bus
Date:   Fri, 17 Apr 2020 18:22:54 +0200
Message-ID: <1587140574-31403-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(46966005)(36756003)(4326008)(5660300002)(478600001)(2906002)(107886003)(86362001)(70586007)(70206006)(336012)(316002)(42186006)(246002)(54906003)(110136005)(426003)(36906005)(82740400003)(47076004)(7636003)(26005)(356005)(8676002)(186003)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4e7f0b6-a0ee-4fcc-14b7-08d7e2eb9839
X-MS-TrafficTypeDiagnostic: BN7PR07MB5361:
X-Microsoft-Antispam-PRVS: <BN7PR07MB5361CC410BBDF3BF653FA896C1D90@BN7PR07MB5361.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6X4peHHfEVp6TP5q7INoAbNavp2USguV294DkRAVkEPvWZyHuOaRI12RfCc22ZbPvjubNHle8DA6BRChqr1NZzaWeaFvwPGpFe63Djz0hl+ka/nRzyPVljhaxp63AVdPB/Nt+pVAljVzm6gzOm+tSZWyKB5aMyL15094aW2U4AcEGEIG5eUBvsEuipAVcsW8te4+CWgmq8H4fq21dXrfxIk6xEBRuwcqOETM8O855URGxNj6smoxGHKFZdR3CscFkbcaxsjrV/OahwWkt3pf0YLMk56e0dsO+1RUHMyAOw0vF2iwayyy9WU/WlCwKsFCMNvA1lj184p5ZFtvh2nsQdmUw74uodGDjCtKNSkalA4MlNFmiIF5QEF18gpFXf+SlEYU+7SWKO6koXh6FNfK7+qUhCcVQIPr7Slm8ekPdiVkzlOvcxVdLTHi0i+4f1wCDyYnp6HGcX5q4t2Vusbxhe0AyM1WmK4JZunSIuLCltnR9rft5UPvr6UZb34kFjY29AS4v0V+naK1aEdOEdvhQpFc/chbWIKATOfMa450Cc=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:59.4704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e7f0b6-a0ee-4fcc-14b7-08d7e2eb9839
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5361
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add sysfs key 'i3c_acquire_bus'
to acquire I3C bus.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c | 112 +++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 47 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 39a412b32c59..c0b6a0c658f0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -467,6 +467,53 @@ static const char * const i3c_bus_mode_strings[] = {
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
 static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *da,
 			 char *buf)
@@ -533,6 +580,23 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(i2c_scl_frequency);
 
+static ssize_t i3c_acquire_bus_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
+	int ret;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	ret = i3c_master_acquire_bus(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+	if (!ret)
+		i3c_master_enable_mr_events(master);
+
+	return ret ?: count;
+}
+static DEVICE_ATTR_WO(i3c_acquire_bus);
+
 static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_mode.attr,
 	&dev_attr_current_master.attr,
@@ -543,6 +607,7 @@ static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_pid.attr,
 	&dev_attr_dynamic_address.attr,
 	&dev_attr_hdrcap.attr,
+	&dev_attr_i3c_acquire_bus.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
@@ -1244,19 +1309,6 @@ static int i3c_master_get_accmst_locked(struct i3c_master_controller *master,
 	return ret;
 }
 
-static int i3c_master_enable_mr_events(struct i3c_master_controller *master)
-{
-	int ret;
-
-	master->ops->enable_mr_events(master);
-	i3c_bus_maintenance_lock(&master->bus);
-	ret = i3c_master_enec_locked(master, I3C_BROADCAST_ADDR,
-				     I3C_CCC_EVENT_MR | I3C_CCC_EVENT_HJ);
-	i3c_bus_maintenance_unlock(&master->bus);
-
-	return ret;
-}
-
 static int i3c_master_getaccmst(struct i3c_master_controller *master)
 {
 	int ret;
@@ -1792,40 +1844,6 @@ void i3c_sec_mst_mr_dis_event(struct i3c_master_controller *m)
 }
 EXPORT_SYMBOL_GPL(i3c_sec_mst_mr_dis_event);
 
-/* This function is expected to be called with normaluse_lock */
-int i3c_master_acquire_bus(struct i3c_master_controller *master)
-{
-	int ret = 0;
-
-	if (!master->this || master->this != master->bus.cur_master) {
-		if (master->mr_state == I3C_MR_IDLE) {
-			master->mr_state = I3C_MR_WAIT_DA;
-			init_completion(&master->mr_comp);
-			queue_work(master->wq, &master->sec_mst_work);
-			/*
-			 * Bus acquire procedure may need write lock
-			 * so release read lock before yielding
-			 * to bus acquire state machine
-			 */
-			i3c_bus_normaluse_unlock(&master->bus);
-			wait_for_completion(&master->mr_comp);
-			i3c_bus_normaluse_lock(&master->bus);
-			if (master->mr_state != I3C_MR_DONE)
-				ret = -EAGAIN;
-			master->mr_state = I3C_MR_IDLE;
-		} else {
-			/*
-			 * MR request is already in process for
-			 * this master
-			 */
-			ret = -EAGAIN;
-		}
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(i3c_master_acquire_bus);
-
 static struct i2c_dev_boardinfo *
 i3c_master_alloc_i2c_boardinfo(struct i3c_master_controller *master,
 			       u16 addr, u8 lvr)
-- 
2.17.1

