Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DAC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FEF2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GSx+Nnc3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="j+SwRIDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgDQQYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:24:45 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33326 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgDQQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:24:44 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HG8ZJR005950;
        Fri, 17 Apr 2020 09:24:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ZvhRH3xAfgPso8HZox/pqBYWze5a42LxvvGPZD7MjSI=;
 b=GSx+Nnc3sOYypzi3bWLvD2u0r1G96mfoeLYXjv+j4BIoaiPMa6z7WrCWgaBxA+ZblyJW
 QiQprk6shwyTdSfZijlzBFKkGLfkDbTudsCaWmaundtTyMzU6eqw9MF1VT5XvnXqxEk+
 k3eSQoNR8+fKLhtTZapHJEJBUsrqGDWQbfrVMgjm35WGJe7OXrkg49vzY90xiIXZwBI7
 1ADHYJ7i/F36TB8Duz7VnWeJE9pBbjva07k/sHfxiaeWftqhWxBz37IzBytWjIRhjTpP
 Nji1tT+iZFk9XCV9ehYwJp56iCrn7tUF+zzS/5BbazT+qCYE2jW2AI7zSN4GNWYbjMMD 9A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30dn9650uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz8AjzrhxXS3juVUpC4oZlkortMn3aF85ZgcTZVqDN1404wluhw3PyINIULIvi3Sdfsyt7FevuBu6BumSQDcyakl7WQBkyio1bVmn4VuynaIojma1sRFWLPe8ZhEVQcCCvv5ryOdM/U9V4s5xKShVzS2h74zWjt55grMIETBJnovT2y0B4jaOcCmMOpWzc+chvhHY1sqRqDVGIw87A7e8OT+nzzrc4FJyrf9a4lLe0TSef75usAPV9uM7cLGiNFcJ4NePO69sYHcjCBP6hsGpYRa+Mj61DFikPV9gim70LHQUJ40GXRXzsc57YqnKKv7Fq0bzj324Ng+y0jD4L1V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvhRH3xAfgPso8HZox/pqBYWze5a42LxvvGPZD7MjSI=;
 b=Ndo0c7yDp40b/uCRT5kiSkHOs9UYJwDajFeWwfZzNsKd+Lccy8vh9LZAiNoi/xwWcWACPI8QwbwRSRwJkI7pVlPovnvkCve3RWH0fs3aLuNjUrEjaYmZkXcXn0hWNUcv622+HHRqAdddHzqGWStbvTH+4C5eh/da94v/Lt1thownOcwA9cS7Uo1/UBjWH0HudL5CCVUFpxkfS1KDFdMAdXSwUuvrJYfmyToKeUuuM7bPjlUfudSgR/Bnbi7fUjuMntaFyY5A/BIt62Sa9n79HINXf5Z524A5XvKlcSUa9KobXBTJ07KZrSJqaRfwDBf9jo87zQ4VR6FE5Gm8kOenUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvhRH3xAfgPso8HZox/pqBYWze5a42LxvvGPZD7MjSI=;
 b=j+SwRIDY3Tb+mdX1dngNh37WNiJlaNCRR/IwL68H9UttVUmgbL4lyZi70WMaLqEVg3LMRET9IE4uKMCjNGlzH8tGy0sB8S4KYON2/nPcKHKbrz5DyiQEyK9P5dZwjDv9lWxuZXrs1nc1NsyFKfpSpkftFrA6Hj5V/Jk3Fwackk4=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by BN7PR07MB4737.namprd07.prod.outlook.com (2603:10b6:408::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Fri, 17 Apr 2020 16:24:28 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::fa) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 16:24:27 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:24:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03HGOOJK140461
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 09:24:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:24:24 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:24:24 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGOOuS032481;
        Fri, 17 Apr 2020 18:24:24 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGON7l032480;
        Fri, 17 Apr 2020 18:24:23 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 8/8] i3c: master: add mastership handover support to cdns i3c master driver
Date:   Fri, 17 Apr 2020 18:24:22 +0200
Message-ID: <1587140662-32408-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(36092001)(46966005)(81156014)(36756003)(107886003)(26005)(2906002)(47076004)(8676002)(5660300002)(30864003)(2616005)(26826003)(478600001)(316002)(42186006)(86362001)(82740400003)(426003)(8936002)(110136005)(81166007)(4326008)(54906003)(70206006)(186003)(356005)(36906005)(70586007)(336012)(42413003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3152a3c7-a20f-4276-dfad-08d7e2ebcc7d
X-MS-TrafficTypeDiagnostic: BN7PR07MB4737:
X-Microsoft-Antispam-PRVS: <BN7PR07MB47371C42B25A67075D8A3B37C1D90@BN7PR07MB4737.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0pEMR5HjP872/DwGjHgol/kGpymd5gpDnv+mfX+QbsDHU78/t1t1zNDPVAYffir6OErUJjTZDEAiTUiAJsnzAdN1pxxmDPoaCJ37ApRjlPYosxB1VjWA4rVZKSZizsiLmbw/QaQahOelteBeooeZPhuvfLRX1qkWc3xYIG3zLoYS/PPgSHdm7J/OAzVwmIEO7g6mrwHFM83TRBtbjU6ZViGMCt/1Wg0cvY3sVndf1LZhRpekIk6JAEGPwPdR6JkDS7F+7L45ynCrKb+DYZaoidNn692/d4D03OQ+ANrs+i1UWDYp6QQyT/6S2qv9FIyW6h0RC6PvPVIaqJm3wR3p1MsycRaTegDkI5jbGpbHsjyd3zJNPNe2c8huaYHZHnFgtPUdLUZQrijSfuT//j6piWLb8eLQACUobQS7FFtBFmUA1+z69/n3YBL1wtW/MgaIEJ0jrXC2uuHXJyrsyPTsNu+cnKm4rYCGBqnVteobOUt57ije6LZdn7liCNiUjOhLg+VrIFEkvIc70Ck2CiTD57IFNsPX1iKZ1/cO2C0bY6vTegTGC6BLAvU40iGnowl
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:24:27.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3152a3c7-a20f-4276-dfad-08d7e2ebcc7d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4737
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=946 suspectscore=2 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add secondary master support to
Cadence's I3C master controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c                 |  32 ++-
 drivers/i3c/master/i3c-master-cdns.c | 365 +++++++++++++++++++++++++--
 2 files changed, 362 insertions(+), 35 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c0b6a0c658f0..c716c3461f7e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -481,7 +481,7 @@ static int i3c_master_enable_mr_events(struct i3c_master_controller *master)
 }
 
 /* This function is expected to be called with normaluse_lock */
-int i3c_master_acquire_bus(struct i3c_master_controller *master)
+static int i3c_master_acquire_bus(struct i3c_master_controller *master)
 {
 	int ret = 0;
 
@@ -512,7 +512,6 @@ int i3c_master_acquire_bus(struct i3c_master_controller *master)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_master_acquire_bus);
 
 static ssize_t mode_show(struct device *dev,
 			 struct device_attribute *da,
@@ -2526,12 +2525,19 @@ static int i3c_master_i2c_adapter_xfer(struct i2c_adapter *adap,
 	}
 
 	i3c_bus_normaluse_lock(&master->bus);
-	dev = i3c_master_find_i2c_dev_by_addr(master, addr);
-	if (!dev)
-		ret = -ENOENT;
-	else
-		ret = master->ops->i2c_xfers(dev, xfers, nxfers);
-	i3c_bus_normaluse_unlock(&master->bus);
+	if (master->ops->check_event_set(master, I3C_SLV_DEFSLVS_CCC) &&
+	    !i3c_master_acquire_bus(master)) {
+		dev = i3c_master_find_i2c_dev_by_addr(master, addr);
+		if (!dev)
+			ret = -ENOENT;
+		else
+			ret = master->ops->i2c_xfers(dev, xfers, nxfers);
+		i3c_bus_normaluse_unlock(&master->bus);
+		i3c_master_enable_mr_events(master);
+	} else {
+		i3c_bus_normaluse_unlock(&master->bus);
+		ret = -EAGAIN;
+	}
 
 	return ret ? ret : nxfers;
 }
@@ -3065,6 +3071,7 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 				 int nxfers)
 {
 	struct i3c_master_controller *master;
+	int ret;
 
 	if (!dev)
 		return -ENOENT;
@@ -3076,7 +3083,14 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master->ops->priv_xfers)
 		return -ENOTSUPP;
 
-	return master->ops->priv_xfers(dev, xfers, nxfers);
+	if (master->ops->check_event_set(master, I3C_SLV_DEFSLVS_CCC) &&
+	    !i3c_master_acquire_bus(master)) {
+		ret = master->ops->priv_xfers(dev, xfers, nxfers);
+		i3c_master_enable_mr_events(master);
+		return ret;
+	} else {
+		return -EAGAIN;
+	}
 }
 
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev)
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index c2d1631a9e38..1bc27f0de8ba 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -157,6 +157,7 @@
 #define SLV_IMR				0x48
 #define SLV_ICR				0x4c
 #define SLV_ISR				0x50
+#define SLV_INT_DEFSLVS			BIT(21)
 #define SLV_INT_TM			BIT(20)
 #define SLV_INT_ERROR			BIT(19)
 #define SLV_INT_EVENT_UP		BIT(18)
@@ -390,7 +391,14 @@ struct cdns_i3c_xfer {
 
 struct cdns_i3c_master {
 	struct work_struct hj_work;
+	struct work_struct defslvs_work;
+	bool defslvs_processed;
+	bool mr_done;
 	struct i3c_master_controller base;
+	struct {
+		struct work_struct work;
+		u32 ibir;
+	} events;
 	u32 free_rr_slots;
 	unsigned int maxdevs;
 	struct {
@@ -936,6 +944,27 @@ static int cdns_i3c_master_get_rr_slot(struct cdns_i3c_master *master,
 	return -EINVAL;
 }
 
+static int cdns_i3c_master_find_rr_slot(struct cdns_i3c_master *master,
+					u8 addr)
+{
+	u32 activedevs, rr;
+	int i;
+
+	activedevs = readl(master->regs + DEVS_CTRL) &
+		     DEVS_CTRL_DEVS_ACTIVE_MASK;
+
+	for (i = 1; i <= master->maxdevs; i++) {
+		if (!(BIT(i) & activedevs))
+			continue;
+
+		rr = readl(master->regs + DEV_ID_RR0(i));
+		if (DEV_ID_RR0_GET_DEV_ADDR(rr) == addr)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int cdns_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 					    u8 old_dyn_addr)
 {
@@ -955,7 +984,11 @@ static int cdns_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
 	if (!data)
 		return -ENOMEM;
 
-	slot = cdns_i3c_master_get_rr_slot(master, dev->info.dyn_addr);
+	if (m->secondary)
+		slot = cdns_i3c_master_find_rr_slot(master, dev->info.dyn_addr);
+	else
+		slot = cdns_i3c_master_get_rr_slot(master, dev->info.dyn_addr);
+
 	if (slot < 0) {
 		kfree(data);
 		return slot;
@@ -998,7 +1031,12 @@ static int cdns_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
 	struct cdns_i3c_i2c_dev_data *data;
 	int slot;
 
-	slot = cdns_i3c_master_get_rr_slot(master, 0);
+	if (m->secondary)
+		slot = cdns_i3c_master_find_rr_slot(master,
+						    dev->boardinfo->base.addr);
+	else
+		slot = cdns_i3c_master_get_rr_slot(master, 0);
+
 	if (slot < 0)
 		return slot;
 
@@ -1010,14 +1048,17 @@ static int cdns_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
 	master->free_rr_slots &= ~BIT(slot);
 	i2c_dev_set_master_data(dev, data);
 
-	writel(prepare_rr0_dev_address(dev->boardinfo->base.addr) |
-	       (dev->boardinfo->base.flags & I2C_CLIENT_TEN ?
-		DEV_ID_RR0_LVR_EXT_ADDR : 0),
-	       master->regs + DEV_ID_RR0(data->id));
-	writel(dev->boardinfo->lvr, master->regs + DEV_ID_RR2(data->id));
-	writel(readl(master->regs + DEVS_CTRL) |
-	       DEVS_CTRL_DEV_ACTIVE(data->id),
-	       master->regs + DEVS_CTRL);
+	if (!m->secondary) {
+		writel(prepare_rr0_dev_address(dev->boardinfo->base.addr) |
+		       (dev->boardinfo->base.flags & I2C_CLIENT_TEN ?
+			DEV_ID_RR0_LVR_EXT_ADDR : 0),
+			master->regs + DEV_ID_RR0(data->id));
+		writel(dev->boardinfo->lvr,
+		       master->regs + DEV_ID_RR2(data->id));
+		writel(readl(master->regs + DEVS_CTRL) |
+		       DEVS_CTRL_DEV_ACTIVE(data->id),
+		       master->regs + DEVS_CTRL);
+	}
 
 	return 0;
 }
@@ -1187,10 +1228,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 
 	cdns_i3c_master_upd_i3c_scl_lim(master);
 
-	/* Unmask Hot-Join and Mastership request interrupts. */
-	i3c_master_enec_locked(m, I3C_BROADCAST_ADDR,
-			       I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR);
-
 	return 0;
 }
 
@@ -1287,8 +1324,8 @@ static int cdns_i3c_master_set_info(struct i3c_master_controller *m)
 		writel(prepare_rr0_dev_address(ret) | DEV_ID_RR0_IS_I3C,
 		       master->regs + DEV_ID_RR0(0));
 	}
-
 	cdns_i3c_master_dev_rr_to_info(master, 0, &info);
+
 	if (info.bcr & I3C_BCR_HDR_CAP)
 		info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
 
@@ -1296,7 +1333,6 @@ static int cdns_i3c_master_set_info(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-
 	return 0;
 }
 
@@ -1356,6 +1392,7 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
 
 static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 {
+	struct i3c_dev_desc *dev;
 	u32 status0;
 
 	writel(MST_INT_IBIR_THR, master->regs + MST_ICR);
@@ -1377,27 +1414,120 @@ static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 
 		case IBIR_TYPE_MR:
 			WARN_ON(IBIR_XFER_BYTES(ibir) || (ibir & IBIR_ERROR));
+			if (ibir & IBIR_ACKED) {
+				dev = master->ibi.slots[IBIR_SLVID(ibir)];
+				i3c_master_yield_bus(&master->base,
+						     dev->info.dyn_addr);
+			}
+			break;
+
 		default:
 			break;
 		}
 	}
 }
 
+static void cdns_i3c_process_defslvs(struct cdns_i3c_master *master)
+{
+	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
+	struct i3c_ccc_dev_desc *desc;
+	u32 devs, val, rr, slot;
+
+	desc = master->base.defslvs_data.devs;
+	master->base.defslvs_data.ndevs = 0;
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+	for (slot = 1; slot < I3C_BUS_MAX_DEVS; slot++) {
+		if (!(devs & BIT(slot)))
+			continue;
+
+		master->base.defslvs_data.ndevs++;
+		memset(desc, 0, sizeof(struct i3c_ccc_dev_desc));
+		val = readl(master->regs + DEV_ID_RR0(slot));
+		if (val & DEV_ID_RR0_IS_I3C) {
+			rr = readl(master->regs + DEV_ID_RR0(slot));
+			desc->dyn_addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			rr = readl(master->regs + DEV_ID_RR2(slot));
+			desc->dcr = rr;
+			desc->bcr = rr >> 8;
+		} else {
+			rr = readl(master->regs + DEV_ID_RR0(slot));
+			desc->static_addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			rr = readl(master->regs + DEV_ID_RR2(slot));
+			desc->lvr = rr;
+			switch (desc->lvr & I3C_LVR_I2C_INDEX_MASK) {
+			case I3C_LVR_I2C_INDEX(0):
+				if (mode < I3C_BUS_MODE_MIXED_FAST)
+					mode = I3C_BUS_MODE_MIXED_FAST;
+				break;
+			case I3C_LVR_I2C_INDEX(1):
+			case I3C_LVR_I2C_INDEX(2):
+				if (mode < I3C_BUS_MODE_MIXED_SLOW)
+					mode = I3C_BUS_MODE_MIXED_SLOW;
+				break;
+			default:
+				break;
+			}
+		}
+		desc++;
+	}
+	master->base.defslvs_data.bus_mode = mode;
+}
+
+void cdns_i3c_handle_slv_events(struct cdns_i3c_master *master, u32 events)
+{
+	u32 status1;
+
+	status1 = readl(master->regs + SLV_STATUS1);
+
+	if (events & SLV_INT_EVENT_UP && status1 & SLV_STATUS1_MR_DIS)
+		i3c_sec_mst_mr_dis_event(&master->base);
+
+	if (events & SLV_INT_MR_DONE) {
+		writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO | FLUSH_CMD_FIFO |
+		       FLUSH_CMD_RESP,
+		       master->regs + FLUSH_CTRL);
+		master->mr_done = true;
+	}
+
+	if (events & SLV_INT_DEFSLVS) {
+		master->defslvs_processed = false;
+		queue_work(master->base.wq, &master->defslvs_work);
+	}
+}
+
 static irqreturn_t cdns_i3c_master_interrupt(int irq, void *data)
 {
 	struct cdns_i3c_master *master = data;
 	u32 status;
 
-	status = readl(master->regs + MST_ISR);
-	if (!(status & readl(master->regs + MST_IMR)))
-		return IRQ_NONE;
+	if (!master->base.this ||
+	    master->base.this != master->base.bus.cur_master) {
+		status = (readl(master->regs + SLV_ISR) &
+			  readl(master->regs + SLV_IMR));
+		if (!status)
+			return IRQ_NONE;
+		writel(status, master->regs + SLV_ICR);
+
+		cdns_i3c_handle_slv_events(master, status);
+
+	} else {
+		status = readl(master->regs + MST_ISR);
+		if (!(status & readl(master->regs + MST_IMR)))
+			return IRQ_NONE;
+
+		spin_lock(&master->xferqueue.lock);
+		cdns_i3c_master_end_xfer_locked(master, status);
+		spin_unlock(&master->xferqueue.lock);
 
-	spin_lock(&master->xferqueue.lock);
-	cdns_i3c_master_end_xfer_locked(master, status);
-	spin_unlock(&master->xferqueue.lock);
+		if (status & MST_INT_IBIR_THR)
+			cnds_i3c_master_demux_ibis(master);
 
-	if (status & MST_INT_IBIR_THR)
-		cnds_i3c_master_demux_ibis(master);
+		if (status & MST_INT_MR_DONE) {
+			writel(MST_INT_MR_DONE, master->regs + MST_ICR);
+			writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO | FLUSH_CMD_FIFO |
+			       FLUSH_CMD_RESP, master->regs + FLUSH_CTRL);
+		}
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1521,6 +1651,161 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 	i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 }
 
+static int cdns_i3c_master_find_ibi_slot(struct cdns_i3c_master *master,
+					 struct i3c_dev_desc *dev,
+					 s16 *slot)
+{
+	unsigned long flags;
+	unsigned int i;
+	int ret = -ENOENT;
+
+	spin_lock_irqsave(&master->ibi.lock, flags);
+		for (i = 0; i < master->ibi.num_slots; i++) {
+			if (master->ibi.slots[i] == dev) {
+				*slot = i;
+				ret = 0;
+				break;
+			}
+		}
+
+	if (ret) {
+		for (i = 0; i < master->ibi.num_slots; i++) {
+			if (!master->ibi.slots[i]) {
+				master->ibi.slots[i] = dev;
+				*slot = i;
+				ret = 0;
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&master->ibi.lock, flags);
+
+	return ret;
+}
+
+static int cdns_i3c_request_mastership(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	int status;
+
+	status = readl(master->regs + SLV_STATUS1);
+
+	if (status & SLV_STATUS1_MR_DIS)
+		return -EACCES;
+
+	master->mr_done = false;
+	writel(readl(master->regs + CTRL) | CTRL_MST_INIT | CTRL_MST_ACK,
+	       master->regs + CTRL);
+
+	return 0;
+}
+
+static void
+cdns_i3c_master_disable_mastership_events(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i3c_dev_desc *i3cdev;
+	unsigned long flags;
+	u32 sirmap;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+		    I3C_BCR_I3C_MASTER ||
+		    m->this == i3cdev)
+			continue;
+
+		data = i3c_dev_get_master_data(i3cdev);
+
+		if (i3cdev->ibi && i3cdev->ibi->handler)
+			continue;
+
+		spin_lock_irqsave(&master->ibi.lock, flags);
+		sirmap = readl(master->regs + SIR_MAP_DEV_REG(data->ibi));
+		sirmap &= ~SIR_MAP_DEV_CONF_MASK(data->ibi);
+		sirmap |= SIR_MAP_DEV_CONF(data->ibi,
+					SIR_MAP_DEV_DA(I3C_BROADCAST_ADDR));
+		writel(sirmap, master->regs + SIR_MAP_DEV_REG(data->ibi));
+		spin_unlock_irqrestore(&master->ibi.lock, flags);
+
+		cdns_i3c_master_free_ibi(i3cdev);
+	}
+}
+
+static void
+cdns_i3c_master_enable_mastership_events(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i3c_dev_desc *i3cdev;
+	unsigned long flags;
+	u32 sircfg, sirmap;
+	int ret;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+		    I3C_BCR_I3C_MASTER ||
+		    m->this == i3cdev)
+			continue;
+
+		data = i3c_dev_get_master_data(i3cdev);
+		if (!data)
+			continue;
+
+		ret = cdns_i3c_master_find_ibi_slot(master, i3cdev, &data->ibi);
+		if (ret)
+			continue;
+
+		spin_lock_irqsave(&master->ibi.lock, flags);
+		sirmap = readl(master->regs + SIR_MAP_DEV_REG(data->ibi));
+		sirmap &= ~SIR_MAP_DEV_CONF_MASK(data->ibi);
+		sircfg = SIR_MAP_DEV_ROLE(i3cdev->info.bcr >> 6) |
+			SIR_MAP_DEV_DA(i3cdev->info.dyn_addr) |
+			SIR_MAP_DEV_PL(i3cdev->info.max_ibi_len) |
+			SIR_MAP_DEV_ACK;
+
+		if (i3cdev->info.bcr & I3C_BCR_MAX_DATA_SPEED_LIM)
+			sircfg |= SIR_MAP_DEV_SLOW;
+
+		sirmap |= SIR_MAP_DEV_CONF(data->ibi, sircfg);
+		writel(sirmap, master->regs + SIR_MAP_DEV_REG(data->ibi));
+		spin_unlock_irqrestore(&master->ibi.lock, flags);
+	}
+}
+
+static bool
+cdns_i3c_master_check_event_set(struct i3c_master_controller *m,
+				enum i3c_event event)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	bool ret = false;
+
+	switch (event) {
+	case I3C_SLV_DA_UPDATE:
+		if (readl(master->regs + SLV_STATUS1) & SLV_STATUS1_HAS_DA)
+			ret = true;
+		break;
+
+	case I3C_SLV_DEFSLVS_CCC:
+			ret = master->defslvs_processed;
+		break;
+
+	case I3C_SLV_MR_DIS:
+		if (readl(master->regs + SLV_STATUS1) & SLV_STATUS1_MR_DIS)
+			ret = true;
+		break;
+
+	case I3C_SLV_MR_DONE:
+		ret = master->mr_done;
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
 	.master_set_info = cdns_i3c_master_set_info,
@@ -1541,6 +1826,10 @@ static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.request_ibi = cdns_i3c_master_request_ibi,
 	.free_ibi = cdns_i3c_master_free_ibi,
 	.recycle_ibi_slot = cdns_i3c_master_recycle_ibi_slot,
+	.request_mastership = cdns_i3c_request_mastership,
+	.enable_mr_events = cdns_i3c_master_enable_mastership_events,
+	.disable_mr_events = cdns_i3c_master_disable_mastership_events,
+	.check_event_set = cdns_i3c_master_check_event_set,
 };
 
 static void cdns_i3c_master_hj(struct work_struct *work)
@@ -1552,10 +1841,24 @@ static void cdns_i3c_master_hj(struct work_struct *work)
 	i3c_master_do_daa(&master->base);
 }
 
+static void cdns_i3c_sec_master_defslvs(struct work_struct *work)
+{
+	struct cdns_i3c_master *master = container_of(work,
+						      struct cdns_i3c_master,
+						      defslvs_work);
+
+	cdns_i3c_process_defslvs(master);
+	if (i3c_master_process_defslvs(&master->base))
+		queue_work(master->base.wq, work);
+	else
+		master->defslvs_processed = true;
+}
+
 static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master;
 	struct resource *res;
+	bool secondary;
 	int ret, irq;
 	u32 val;
 
@@ -1607,6 +1910,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	val = readl(master->regs + CONF_STATUS0);
+	secondary = (val & CONF_STATUS0_SEC_MASTER) ? true : false;
 
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
@@ -1627,12 +1931,21 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (!master->ibi.slots)
 		goto err_disable_sysclk;
 
+	if (secondary) {
+		INIT_WORK(&master->defslvs_work, cdns_i3c_sec_master_defslvs);
+		master->defslvs_processed = false;
+	} else {
+		master->defslvs_processed = true;
+	}
+
+	writel(SLV_INT_EVENT_UP | SLV_INT_DEFSLVS | SLV_INT_MR_DONE,
+	       master->regs + SLV_IER);
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
-	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
+	writel(MST_INT_IBIR_THR | MST_INT_MR_DONE, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
 	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &cdns_i3c_master_ops, false);
+				  &cdns_i3c_master_ops, secondary);
 	if (ret)
 		goto err_disable_sysclk;
 
-- 
2.17.1

