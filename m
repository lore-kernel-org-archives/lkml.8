Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718FC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B9642072D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="U461OgXk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lUogR5iK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgDQQXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:23:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14430 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgDQQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:23:15 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HG8ZJ6005950;
        Fri, 17 Apr 2020 09:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=j0YzqH0LOASWyCskXMTYJBzp3O+rA9RvIKb8xRTOvfI=;
 b=U461OgXk+uEoH1fC9k4M9EaFzwhtPjFWvl1HvdX0HvSxbHrpYbYZE3bd19tH/remU56l
 73rLDOs14guWNoHuO8SXu/5YW9dqHse09lhKIzDqa6w6HjSQWGxvTVp7wXooogmzHUBp
 ygoFbGt+pGSpYcrflL9ptHSalDutpp6qwxueyOMvI1A0vMMHurWARwYXJP8RWYzBlHQR
 zOYLVeEHB5jiQIx9fjSlgLIU4m56w9SZjFILwRURiw8PYefY6MVrfkEukwiS5Am/5adp
 ecw+aBbS0mnAX6GUA5oy26v0HeLxjq7oANtAOEwrRyHa/IKZgR+7sWWlM/5mph++4PZ3 cg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30dn9650ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaOlp3B/E/bvuwjlThNm+idpXugAjw2kroCJW/q2IDDNWh4ty9PgX2KhqGlYZ8TzpDGX8kBmDiqFzyM8kNPGyhfJ1cqejYSdE5uu5BHx7Sy3HTjWM7ta1calcsE6cfLMbI2tuqX9xKjD1fuVtbadfBfdIdqeRO6+c4fNwxzvVoTPlP90jcomDk4QDwSEYxQt/k3LnbkOy7IiRoDNuLloHxFbeLiklKxteCNvNsj5QHoHKr2CjooxNZ1ndvrOMOC5rdByKG+grsvaExXpDnmPohuiBpjlnj9lI552rFU6U1xvvtNTribivzsEUqqQ2tGOwwvdWMj4G3HwqcwJ7yxM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0YzqH0LOASWyCskXMTYJBzp3O+rA9RvIKb8xRTOvfI=;
 b=BtM/Od27bBCKN9ABzMAiF88eM4poNheuVTXnQT9Y8r7Zhue19xDeUseZN7xaEGrbqMzhWNctK51549cfM/7ox5az4MfEvg2/+ncVqpZCcWIkrfRM8kTz8x3g5Ia9i6nejwuk/M3DwHpu3rjlGbbLq+KtcJAF44UEsaxrZlb61OKcVbqeWkoDwiMO/7Vvx0I6s9BC990i4hxHB/MDRBUORrAAn0TpIMI4qn/VkVNdH/0ZGW3nQO9a0lAiGKVetBRg7BGHxZR0IER8NwAKuCyYHg2X/y6uDm+ezPbSGqHAR9CCg9qpDkOe/+2aFyWKSzkHURnHqLMWeXDbzA1fdc9oyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0YzqH0LOASWyCskXMTYJBzp3O+rA9RvIKb8xRTOvfI=;
 b=lUogR5iKQyrseNOH8L9wyBmCOdS1AVRYtvosITVTBngWkj4z3nMsVfqbOOd/H5CXE4EXfryA9XxbQGx9T469dzyw5ntHleVq8CWoW9iDjxhGdDbAyZQPO3iVlMZZwCO4qhWYGUbL+X9Zb44vx8Si6jZ3qVzmwT3vzwiO+3lkBWI=
Received: from MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16)
 by DM6PR07MB4762.namprd07.prod.outlook.com (2603:10b6:5:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 16:22:50 +0000
Received: from BN8NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:208:1b4:cafe::ff) by MN2PR15CA0003.outlook.office365.com
 (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 16:22:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT020.mail.protection.outlook.com (10.13.182.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:22:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGMiEv024565
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Apr 2020 09:22:46 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:22:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:22:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGMiHF031311;
        Fri, 17 Apr 2020 18:22:44 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGMilg031310;
        Fri, 17 Apr 2020 18:22:44 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 6/8] i3c: master: secondary master initialization
Date:   Fri, 17 Apr 2020 18:22:35 +0200
Message-ID: <1587140555-31191-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(36092001)(46966005)(2906002)(426003)(8676002)(336012)(5660300002)(26005)(478600001)(2616005)(316002)(110136005)(54906003)(186003)(107886003)(36906005)(42186006)(4326008)(36756003)(26826003)(8936002)(246002)(356005)(7636003)(70586007)(82740400003)(86362001)(70206006)(47076004)(6666004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d92c5d50-91a8-4478-a841-08d7e2eb9239
X-MS-TrafficTypeDiagnostic: DM6PR07MB4762:
X-Microsoft-Antispam-PRVS: <DM6PR07MB47622E5780710B36D55D67EEC1D90@DM6PR07MB4762.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq6/Gz47TKk9NFfquwfjD8+cYUlbTu2fjnkfDRD0HoPhuTfRM0QnWCvqu8ecX1ijPpkW/ZHGiTPHsrDA79vsZ24wxnm8iooP3nU4AqtR8/LmeqBMwv6vwzcI6fgPNpgh8ZGxq8AYlP9nGMahCAr+NSbd/KySUupwHVgmjDfOpSRYzqvPaSLiq/9lF/67soCrHGIOdBNdHCqQXu4ZE6VnZakIHWnsittOslishuNMQHpo72oOiYmcxgaDIxbZGGXMQ5QZRChW8FEbSbicKkeyriX9d74HKpjHNi72ZY+J1yZRpPvmamfIAZHcRg5UOSQ8RQAdFszy10pyx5o0CtY9XrFcLdUKSSruhjJyvWb4fpZTlnhS8/9R1UUWjy+DT3SUP/4V8xigBB/TQoBXd3SNAd8XiLukIqCmD1NCKUg5Nc5fLXfUgjpySL7AQ8RcYB2fpPJr3YXjos8lGSVNjeoWZcGLuz4W/7jFEao90RFC5FBS5BqKyBQwSggIr+Iy3wlLQk6cSAPJ6X07H++Tnpxk59WdcKOP/dwVorZdvBvrZJ4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:49.3289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d92c5d50-91a8-4478-a841-08d7e2eb9239
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4762
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 suspectscore=2 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add secondary master support to
I3C master subsystem.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 153 ++++++++++++++++++++++++++++---------
 include/linux/i3c/master.h |   1 +
 2 files changed, 116 insertions(+), 38 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 19d4800ed573..39a412b32c59 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1621,10 +1621,6 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
 		return -EINVAL;
 
-	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
-	    master->secondary)
-		return -EINVAL;
-
 	if (master->this)
 		return -EINVAL;
 
@@ -2040,9 +2036,10 @@ EXPORT_SYMBOL_GPL(i3c_master_process_defslvs);
  * 1. Attach I2C and statically defined I3C devs to the master so that the
  *    master can fill its internal device table appropriately
  *
- * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
- *    the master controller. That's usually where the bus mode is selected
- *    (pure bus or mixed fast/slow bus)
+ * 2. Should have called &i3c_master_controller_ops->bus_init()
+ *    method with pure bus mode to initialize the master controller.
+ *    That's usually where the bus mode is selected (pure bus or
+ *    mixed fast/slow bus)
  *
  * 3. Instruct all devices on the bus to drop their dynamic address. This is
  *    particularly important when the bus was previously configured by someone
@@ -2126,14 +2123,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		}
 	}
 
-	/*
-	 * Now execute the controller specific ->bus_init() routine, which
-	 * might configure its internal logic to match the bus limitations.
-	 */
-	ret = master->ops->bus_init(master);
-	if (ret)
-		goto err_detach_devs;
-
 	ret = master->ops->master_set_info(master);
 	if (ret)
 		goto err_detach_devs;
@@ -2146,7 +2135,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		dev_err(&master->dev,
 			"master_set_info() was not called in ->bus_init()\n");
 		ret = -EINVAL;
-		goto err_bus_cleanup;
+		goto err_detach_devs;
 	}
 
 	/*
@@ -2155,14 +2144,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	 */
 	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
 	if (ret && ret != I3C_ERROR_M2)
-		goto err_bus_cleanup;
+		goto err_detach_devs;
 
 	/* Disable all slave events before starting DAA. */
 	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
 				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
 				      I3C_CCC_EVENT_HJ);
 	if (ret && ret != I3C_ERROR_M2)
-		goto err_bus_cleanup;
+		goto err_detach_devs;
 
 	/*
 	 * Pre-assign dynamic address and retrieve device information if
@@ -2180,10 +2169,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 err_rstdaa:
 	i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
 
-err_bus_cleanup:
-	if (master->ops->bus_cleanup)
-		master->ops->bus_cleanup(master);
-
 err_detach_devs:
 	i3c_master_detach_free_devs(master);
 
@@ -2813,9 +2798,68 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	     !ops->recycle_ibi_slot))
 		return -EINVAL;
 
+	if (ops->request_mastership &&
+	    (!ops->enable_mr_events || !ops->disable_mr_events ||
+	     !ops->check_event_set))
+		return -EINVAL;
+
 	return 0;
 }
 
+static void i3c_secondary_master_register(struct work_struct *work)
+{
+	struct i3c_master_controller *master;
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	master = container_of(work, struct i3c_master_controller,
+			      sec_mst_register_work);
+	i3cbus = i3c_master_get_bus(master);
+
+	i3c_bus_normaluse_lock(&master->bus);
+	if (!master->ops->check_event_set(master, I3C_SLV_DEFSLVS_CCC) ||
+	    i3c_master_acquire_bus(master)) {
+		i3c_bus_normaluse_unlock(&master->bus);
+		queue_work(master->wq, work);
+		return;
+	}
+	i3c_bus_normaluse_unlock(&master->bus);
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
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	i3c_master_enable_mr_events(master);
+
+	return;
+
+err_del_dev:
+	device_del(&master->dev);
+
+err_cleanup_bus:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+	put_device(&master->dev);
+}
+
 /**
  * i3c_master_register() - register an I3C master
  * @master: master used to send frames on the bus
@@ -2845,10 +2889,10 @@ int i3c_master_register(struct i3c_master_controller *master,
 	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
 	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
 	struct i2c_dev_boardinfo *i2cbi;
-	int ret;
+	int ret, sz;
 
-	/* We do not support secondary masters yet. */
-	if (secondary)
+	/*Check if controller driver supports secondary masters. */
+	if (secondary && !ops->request_mastership)
 		return -ENOTSUPP;
 
 	ret = i3c_master_check_ops(ops);
@@ -2872,13 +2916,45 @@ int i3c_master_register(struct i3c_master_controller *master,
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
+	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
+	if (!master->wq) {
+		ret = -ENOMEM;
+		goto err_put_dev;
+	}
+
+	master->mr_state = I3C_MR_IDLE;
 	INIT_WORK(&master->sec_mst_work, i3c_sec_mst_acquire_bus);
 	INIT_WORK(&master->mst_work, i3c_mst_yield_bus);
 
-	ret = of_populate_i3c_bus(master);
+	ret = i3c_bus_set_mode(i3cbus, mode);
+	if (ret)
+		goto err_put_dev;
+
+	/*
+	 * Now execute the controller specific ->bus_init() routine, which
+	 * might configure its internal logic to match the bus limitations.
+	 */
+	ret = master->ops->bus_init(master);
 	if (ret)
 		goto err_put_dev;
 
+	if (secondary) {
+		sz = sizeof(struct i3c_ccc_dev_desc) * I3C_BUS_MAX_DEVS;
+		master->defslvs_data.devs = devm_kzalloc(&master->dev, sz,
+							 GFP_KERNEL);
+		if (!master->defslvs_data.devs)
+			goto err_put_dev;
+
+		INIT_WORK(&master->sec_mst_register_work,
+			  i3c_secondary_master_register);
+		queue_work(master->wq, &master->sec_mst_register_work);
+		return 0;
+	}
+
+	ret = of_populate_i3c_bus(master);
+	if (ret)
+		goto err_cleanup_bus;
+
 	list_for_each_entry(i2cbi, &master->boardinfo.i2c, node) {
 		switch (i2cbi->lvr & I3C_LVR_I2C_INDEX_MASK) {
 		case I3C_LVR_I2C_INDEX(0):
@@ -2892,23 +2968,13 @@ int i3c_master_register(struct i3c_master_controller *master,
 			break;
 		default:
 			ret = -EINVAL;
-			goto err_put_dev;
+			goto err_cleanup_bus;
 		}
 	}
 
-	ret = i3c_bus_set_mode(i3cbus, mode);
-	if (ret)
-		goto err_put_dev;
-
-	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
-	if (!master->wq) {
-		ret = -ENOMEM;
-		goto err_put_dev;
-	}
-
 	ret = i3c_master_bus_init(master);
 	if (ret)
-		goto err_put_dev;
+		goto err_cleanup_bus;
 
 	ret = device_add(&master->dev);
 	if (ret)
@@ -2931,6 +2997,17 @@ int i3c_master_register(struct i3c_master_controller *master,
 	i3c_master_register_new_i3c_devs(master);
 	i3c_bus_normaluse_unlock(&master->bus);
 
+	ret = i3c_bus_set_mode(i3cbus, mode);
+	if (ret)
+		goto err_del_dev;
+
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_del_dev;
+
+	if (ops->request_mastership)
+		i3c_master_enable_mr_events(master);
+
 	return 0;
 
 err_del_dev:
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index cc482934803b..08b63e285b7b 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -515,6 +515,7 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct work_struct sec_mst_register_work;
 	struct work_struct mst_work;
 	struct work_struct sec_mst_work;
 	struct completion mr_comp;
-- 
2.17.1

