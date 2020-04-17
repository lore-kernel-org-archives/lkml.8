Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8CC38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97C220936
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="l91RhOJy";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="i+0G2f+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgDQQWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:22:16 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:17434 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730408AbgDQQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:22:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HGAD3D019642;
        Fri, 17 Apr 2020 09:22:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DDx5kvpghf7H6u3a4NRVTSRP0lg12WihRsZeZQxST1M=;
 b=l91RhOJyxE3P+jQ1UKDvoPYgvgX/B7mx0y3G3w14dPbmt8Jmeqh5gdESbb5y3YoGKaMy
 V6MzKOZFP/mPt9Mj98RxnRlAfvV38LTJ8s0VgJFSNymcVx+y57SOfC8cH2xuhqHrRmns
 ZuI7IM8gajek1Pl8H35PS7ZU4B8p5c+I8Z9I/A386qhYYeCpXVWrk5U1vwld8cmlvzVl
 qpXJwlCVCju75GvuNe2kvDMlGZRy5AFBXswZDZq+ASSK5ktYeTPXdg9ge1Icksuyazv0
 t7BuHee4/2L6VA7Sw5ir/VyDf5VO9DnzawVkHNsnTAA5ZV2kqSc3KLIQi3inSR6bBr1+ TQ== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2054.outbound.protection.outlook.com [104.47.44.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30dn79550d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8L6BG2Mg46ytO5IpgqbmMPSGYcRCVDl1QtbOHnKgbTsAnVOOOxbdxk3rVeGj4I02h87CE0WA7NGeuTQdSSwqbTdZs6iYnTR/Jt7dTAaODio+YO5h/EXFbuLqbK9tq24aw3Dfltu1B0nLApMofhu05TQ/q2YAXEBZWrh3P4N/L1hxg/UlJ6avMSs8W24roaCAScV34+MuYteGAdEal6+QuIuZh4luqc0XUm0Q4bG70Bjjy4u1VHWih2OlYsnWOailKXOwEiqrgQnCkQuyFG6WsXZ9Lrl39cBpHjFl5YBPokWkzAMbwwcJGSE9d7i87cGZFO9ROYxoq62OEIp80stQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDx5kvpghf7H6u3a4NRVTSRP0lg12WihRsZeZQxST1M=;
 b=JplMAw4ZIMDgrf2BNAjEJgr11NibpWe54+A39Ynw0gf8ZFnwu40VvoTUws7XgnS2S9HHXGf7TRzkZxLKG2hMsWtikf4S3IA+4WP1DPVVWTUOWNMNWvNOACsB9DqSaJuufqu86zqlM8uqevznjRwgo96ebgYb8Vvp9WgSGqhtpFqidCXDgQcIQOG8KSZIg2gkPmxnmT0a/IJOlyLkXAjqvbs6/PQnBk7a4YYbJ4fHmTy8qEL/YvJyrinNRJcxJ057IaAN3zNkK9CIznrSgAkM8itAure43K1HDO83MrCgbnO3cEhJyv/1ClfRDYoB/qiQhBupUK9eKoRBhZ9uEJ+iIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDx5kvpghf7H6u3a4NRVTSRP0lg12WihRsZeZQxST1M=;
 b=i+0G2f+b7J/05txEufBGe7gGVUaDqChIAblb2kqf/fFMfl1bhfXDP3b11aPXvi/weWYzlBm/QgL4AuF3dolRTTOcH98Jpq4DawUSbrCyGM7X9QlznKP1gp/7pPX23oeVyEnfF2K7s7qQm8KJMf/aImd+4pn925RnPBOQ5AEecwY=
Received: from DM5PR22CA0003.namprd22.prod.outlook.com (2603:10b6:3:101::13)
 by CY4PR07MB2886.namprd07.prod.outlook.com (2603:10b6:903:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 16:22:03 +0000
Received: from DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::bc) by DM5PR22CA0003.outlook.office365.com
 (2603:10b6:3:101::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 16:22:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT019.mail.protection.outlook.com (10.13.178.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:22:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03HGM0MZ140329
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 09:22:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:22:00 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:22:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGM0ZY030839;
        Fri, 17 Apr 2020 18:22:00 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGM0mT030836;
        Fri, 17 Apr 2020 18:22:00 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 4/8] i3c: master: defslvs processing
Date:   Fri, 17 Apr 2020 18:21:57 +0200
Message-ID: <1587140518-30782-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36092001)(46966005)(316002)(42186006)(70586007)(478600001)(70206006)(86362001)(36906005)(110136005)(4326008)(107886003)(26826003)(54906003)(36756003)(356005)(81166007)(6666004)(2616005)(82740400003)(81156014)(336012)(2906002)(186003)(8676002)(47076004)(8936002)(5660300002)(426003)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b81e04a-062e-46fb-f3b5-08d7e2eb76a4
X-MS-TrafficTypeDiagnostic: CY4PR07MB2886:
X-Microsoft-Antispam-PRVS: <CY4PR07MB28860D56479A7EA924E5A264C1D90@CY4PR07MB2886.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrLBOhFXk1Etm8eF9xPePPeqOTTpZwZgmJmM9dv4IXCeTprnB87fn0JM+RJ+YUFPqrdBtFL8oj26G90v76KLkEQAfYXj4hOJii3/u0oPowTghXrB7NLesSf8GvVn/maHgeo6zJ9Eq7IdWU/qdKVQ4C1I+5WCn1huB5coy8T47j8qIRrWY4FG89IddvhjcsoiK4uBSd7/mqdxq9FVKTS+/pNwSqC8jLovkX1LhIPPWWTY/EMrSxF+gaufWnqy6lxTjCgiu+mfmIHmEWjrS5E8DhAR75LqGtLmetsGusyZ2jESIQGJmwAgFyuITj5Gdw+DieOyi2iekrciRDvMqZ6mYaytKWTJ5PVcy1Y/AT5Hu8g6Z09WtLgWtzjDg1qQ/GxdD8P2ecsItbzLABMKfpSnRbctIKbbmSTT1tSEZak9tD7LdVP73dCWAYnq+XM2JanF0DjMWpsixnD9lMyl9RmTatbZDbKtHM+KExawUghH1o9KLuGTEgv0Y7ua7ye0JtSx/Ff8zYPyAplFbRx2u6uzXhBlkFsu9L4lbfvSIgjbvbw=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:03.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b81e04a-062e-46fb-f3b5-08d7e2eb76a4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2886
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=905
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add DEFSLVS processing code
to I3C master subsystem.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 200 +++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |   6 ++
 2 files changed, 206 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3598856a0b25..2690910d724c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1830,6 +1830,206 @@ int i3c_master_acquire_bus(struct i3c_master_controller *master)
 }
 EXPORT_SYMBOL_GPL(i3c_master_acquire_bus);
 
+static struct i2c_dev_boardinfo *
+i3c_master_alloc_i2c_boardinfo(struct i3c_master_controller *master,
+			       u16 addr, u8 lvr)
+{
+	struct i2c_dev_boardinfo *i2cboardinfo;
+
+	i2cboardinfo = kzalloc(sizeof(*i2cboardinfo), GFP_KERNEL);
+	if (!i2cboardinfo)
+		return ERR_PTR(-ENOMEM);
+
+	i2cboardinfo->base.addr = addr;
+	i2cboardinfo->lvr = lvr;
+
+	return i2cboardinfo;
+}
+
+static void
+i3c_master_copy_olddev(struct i3c_master_controller *master,
+		       struct i3c_dev_desc *newdev,
+		       struct i3c_dev_desc *olddev)
+{
+	struct i3c_ibi_setup ibireq = { };
+	bool enable_ibi = false;
+	int ret;
+
+	newdev->dev = olddev->dev;
+	if (newdev->dev)
+		newdev->dev->desc = newdev;
+
+	mutex_lock(&olddev->ibi_lock);
+	if (olddev->ibi) {
+		ibireq.handler = olddev->ibi->handler;
+		ibireq.max_payload_len = olddev->ibi->max_payload_len;
+		ibireq.num_slots = olddev->ibi->num_slots;
+
+		if (olddev->ibi->enabled) {
+			enable_ibi = true;
+			i3c_dev_disable_ibi_locked(olddev);
+		}
+
+		i3c_dev_free_ibi_locked(olddev);
+	}
+	mutex_unlock(&olddev->ibi_lock);
+
+	i3c_master_detach_i3c_dev(olddev);
+	i3c_master_free_i3c_dev(olddev);
+
+	if (ibireq.handler) {
+		mutex_lock(&newdev->ibi_lock);
+		ret = i3c_dev_request_ibi_locked(newdev, &ibireq);
+		if (ret) {
+			dev_err(&master->dev,
+				"Failed to request IBI on device %d-%llx",
+				master->bus.id, newdev->info.pid);
+		} else if (enable_ibi) {
+			ret = i3c_dev_enable_ibi_locked(newdev);
+			if (ret)
+				dev_err(&master->dev,
+					"Failed to re-enable IBI on device %d-%llx",
+					master->bus.id, newdev->info.pid);
+		}
+		mutex_unlock(&newdev->ibi_lock);
+	}
+}
+
+static int i3c_master_populate_bus(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_dev_desc *desc;
+	struct i2c_dev_desc *i2cdev;
+	struct i2c_dev_boardinfo *info;
+	struct i3c_dev_desc *i3cdev, *olddev, *i3ctmp;
+	struct i3c_bus *i3cbus;
+	struct list_head i3c_old;
+	int slot, ret;
+
+	INIT_LIST_HEAD(&i3c_old);
+	i3cbus = i3c_master_get_bus(master);
+	list_add(&i3c_old, &i3cbus->devs.i3c);
+	list_del(&i3cbus->devs.i3c);
+	INIT_LIST_HEAD(&i3cbus->devs.i3c);
+	desc = master->defslvs_data.devs;
+	for (slot = 1; slot <= master->defslvs_data.ndevs; slot++, desc++) {
+		if (desc->static_addr && list_empty(&master->bus.devs.i2c)) {
+			i3c_bus_set_addr_slot_status(&master->bus,
+						     desc->static_addr,
+						     I3C_ADDR_SLOT_I2C_DEV);
+			info = i3c_master_alloc_i2c_boardinfo(master,
+							      desc->static_addr,
+							      desc->lvr);
+			if (IS_ERR(info)) {
+				ret = PTR_ERR(info);
+				goto err_detach_devs;
+			}
+
+			i2cdev = i3c_master_alloc_i2c_dev(master, info);
+			if (IS_ERR(i2cdev)) {
+				ret = PTR_ERR(i2cdev);
+				goto err_detach_devs;
+			}
+
+			ret = i3c_master_attach_i2c_dev(master, i2cdev);
+			if (ret) {
+				i3c_master_free_i2c_dev(i2cdev);
+				goto err_detach_devs;
+			}
+		} else {
+			struct i3c_device_info info = {
+				.dyn_addr = desc->dyn_addr
+			};
+
+			i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+			if (IS_ERR(i3cdev)) {
+				ret = PTR_ERR(i3cdev);
+				goto err_detach_devs;
+			}
+
+			ret = i3c_master_attach_i3c_dev(master, i3cdev);
+			if (ret)
+				goto err_detach_devs;
+
+			ret = i3c_master_retrieve_dev_info(i3cdev);
+			if (ret)
+				goto err_detach_devs;
+
+			list_for_each_entry(olddev, &i3c_old, common.node) {
+				if (i3cdev != olddev &&
+				    i3cdev->info.pid == olddev->info.pid)
+					i3c_master_copy_olddev(master, i3cdev,
+							       olddev);
+			}
+		}
+	}
+
+	list_for_each_entry_safe(i3cdev, i3ctmp, &i3c_old,
+				 common.node) {
+		i3c_master_detach_i3c_dev(i3cdev);
+		i3c_master_free_i3c_dev(i3cdev);
+	}
+
+	return 0;
+
+err_detach_devs:
+	if (!master->init_done) {
+		i3c_master_detach_free_devs(master);
+	} else {
+		INIT_LIST_HEAD(&i3cbus->devs.i3c);
+		list_add(&i3cbus->devs.i3c, &i3c_old);
+		list_del(&i3c_old);
+	}
+
+	return ret;
+}
+
+/* This function may sleep, so should not be called from atomic context */
+int i3c_master_process_defslvs(struct i3c_master_controller *master)
+{
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	i3cbus = i3c_master_get_bus(master);
+
+	i3c_bus_normaluse_lock(&master->bus);
+	ret = i3c_master_acquire_bus(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+	if (ret)
+		return ret;
+
+	/* Again bus_init to bus_mode, based on data received in DEFSLVS */
+	ret = i3c_bus_set_mode(i3cbus, master->defslvs_data.bus_mode);
+	if (ret)
+		return ret;
+
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_cleanup_bus;
+
+	if (!ret) {
+		master->ops->master_set_info(master);
+		i3c_bus_maintenance_lock(&master->bus);
+		ret = i3c_master_populate_bus(master);
+		if (ret) {
+			i3c_bus_maintenance_unlock(&master->bus);
+			goto err_cleanup_bus;
+		}
+		i3c_master_register_new_i3c_devs(master);
+		i3c_bus_maintenance_unlock(&master->bus);
+	}
+
+	if (master->init_done)
+		i3c_master_enable_mr_events(master);
+	return 0;
+
+err_cleanup_bus:
+	i3c_master_enable_mr_events(master);
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_process_defslvs);
+
 /**
  * i3c_master_bus_init() - initialize an I3C bus
  * @master: main master initializing the bus
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index c465c7792ccb..cc482934803b 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -520,6 +520,11 @@ struct i3c_master_controller {
 	struct completion mr_comp;
 	enum i3c_mr_state mr_state;
 	u8 mr_addr;
+	struct {
+		u32 ndevs;
+		enum i3c_bus_mode bus_mode;
+		struct i3c_ccc_dev_desc *devs;
+	} defslvs_data;
 };
 
 /**
@@ -544,6 +549,7 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
 
+int i3c_master_process_defslvs(struct i3c_master_controller *master);
 void i3c_master_yield_bus(struct i3c_master_controller *master,
 			  u8 slv_dyn_addr);
 void i3c_sec_mst_mr_dis_event(struct i3c_master_controller *m);
-- 
2.17.1

