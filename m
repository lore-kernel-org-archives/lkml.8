Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F0CC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CDF2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="clBeF4Ei";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="M/1ubVVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgDQQVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:21:15 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44816 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgDQQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:21:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HGAFUQ019664;
        Fri, 17 Apr 2020 09:21:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=v/Jq0f/Q3Cf7y0O11BM3lByHfl3SGsLzushnQMtfEB4=;
 b=clBeF4EiaXAfjKqycV0WP3sibbm84WgMYgrfsHa+PNpo7xqWqXnDN+bC1+XFPdFXQFCt
 PmV3FWMuIJe54bHXK91MkkdQp3yCIMhysGJCEYotsN0VohtceUK8Xtx/UjW+92Beu+2i
 g2QQOwCr+BrdFYYVrCpc22c1HwDmylmEFGiyuxggL1zcVJyu+YQvbJ82X8tZtMiZpjQ4
 3VV2PcHJW4r+kTU6q26gyUMkhU/D8zoifc7h57GlhpQfQ+OO5Dj3dTtZLtHWDwH0egS4
 AJEIPpZ0rFk1yh573vM2/SpbnkDj6xTwXMyBYv+w+j8jCgsT22+yXPM7ham5V3/4o38J kg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30dn7954w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmyqTf5JX2iPYYrhTw2HyWDbhPzxB/Rz2/CLbzNIy12h9bQsdvBkTVS3r+nZvrW82HwwyRzSSB7/RIbIqNgSS5nkDTUX239+Z81MxInbhB89qkujM85KG6PE7fCOXtTCmK+Fk27X3oNnpA98TsKFB9t/VhrAvXMRScZu+aOa3bN9/P30y+cP8VS8QwjdZXoLQK5Uh98cUi8qmtxRrvarRj2dTepXbwpIWhjJnPg43fIgg7z/OHtBj1FVY/Tmf7bMAu+zybiWxOBm78G66NHRlHIAw2oer7hIqV6cA10fIv5j1+KB5IpkNwgrNbaXUf8kXeoEIVeQnuXSwPg6gx9ahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Jq0f/Q3Cf7y0O11BM3lByHfl3SGsLzushnQMtfEB4=;
 b=fbVO6N3zy5f0n0ivaVv+UjcTZ04BK9C4rcQBBXnwJzIz6z3bybN0XzXVgLJ3fN8lyI1C1srl0qzah3G85aMSuY3LuyiuYnuGgnPnepEy7P4W9Dw5S7VGbJ3FeJ6AwoUt7FSYvL280EjaxtlQZok0Qb85YqSkh3HDrjAQ9JD+Jz+nYkAEYoEQRUdfu6s/q8vYORWl+qRSIGM6DN68DqpnSg+YG/RWZ6kqZxrzraURYeXsLO4KVtaIQAHUN/A40wHsBd/V9xWdZ2nxKpA+XfaV8Tui36M7sqqq3mAJZoT4ih4LPRPsOo3zZhY+6ndfvtqe+TLZXGFAgk9LYrKrsejihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Jq0f/Q3Cf7y0O11BM3lByHfl3SGsLzushnQMtfEB4=;
 b=M/1ubVVyGbYn8Uy/ZHOWF9hpx3wwTKzBkqnlHFqLK5lFIsV9g+3Pl7nBcSCTKDkPhO0HEFzPAAy71hcaO7tD+N598vp3zU5w0s3+LCyYjq6RdcWUKWLn6mJRaDbS0avxIy2ubSb4tblG180EYN3IfQElNa8GliTfkELprvla7/g=
Received: from CO1PR15CA0082.namprd15.prod.outlook.com (2603:10b6:101:20::26)
 by DM5PR07MB2825.namprd07.prod.outlook.com (2603:10b6:3:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 16:20:58 +0000
Received: from MW2NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::15) by CO1PR15CA0082.outlook.office365.com
 (2603:10b6:101:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 16:20:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT022.mail.protection.outlook.com (10.13.180.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:20:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGKtUh024409
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Apr 2020 09:20:56 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:20:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:20:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGKsBp030139;
        Fri, 17 Apr 2020 18:20:54 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGKsAD030138;
        Fri, 17 Apr 2020 18:20:54 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 2/8] i3c: master: split bus_init callback into bus_init and master_set_info
Date:   Fri, 17 Apr 2020 18:20:52 +0200
Message-ID: <1587140452-30071-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
References: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(46966005)(5660300002)(47076004)(186003)(36756003)(246002)(7636003)(336012)(4326008)(42186006)(478600001)(2906002)(107886003)(86362001)(316002)(70206006)(36906005)(26005)(70586007)(8936002)(356005)(110136005)(54906003)(426003)(2616005)(82740400003)(8676002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e81e24-a3b4-46a2-f6d6-08d7e2eb4fc6
X-MS-TrafficTypeDiagnostic: DM5PR07MB2825:
X-Microsoft-Antispam-PRVS: <DM5PR07MB2825E238862D8C9341FD51C4C1D90@DM5PR07MB2825.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/JbW6vLG7gwrDghoobcJx8rEeWNnhwf9EtaUqrX3n4yf9SW+8OgYPpOqiCOAdQLHVptY04cHD+CaD52rOdXq+gie70qQByDKl35BLx4fjZzYXuwVlyFY1oDV/klL7mUr3nLfiboTTfJsXRRKdkvge9y3KXWsrNbLuAUGOybZTkkAS9gwOBL04o4+uMz6FXKGl9IOaowhpWsIFDbIgba43LKyBOWpyr/N7lADd1tBq+zMRajSW5j52yx/To2uO3QDnFTv0bxvQit7z8zi6Vgf2MGSuvdfksvD82KbydVBct8Q9oSkWLhfzoCgWmuATh9tBWIiLblhRdaFRJROJjK4dsXPPdHuf0LJ0Y2e7/HVFlyKPT9NVGb0lZwPbrxKieMIYFhr+FZ4CLnUyMKHO+SzVm7BHCto22OYAp1A9vIxHVyV/0L9vIECMOzvZUBxpZwm1rwk+dMA1Toddb3PNnPLlRuPq3FsPe/Gq9ALgahoY/h+T7qreuTW0KS3W5cuG/KILrymzwRDDIv9ibKixRhUY9qxgI7fgtEUvsqeXtyFCI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:20:57.6877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e81e24-a3b4-46a2-f6d6-08d7e2eb4fc6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2825
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

To support mastership handover procedure, this patch splits the
bus_init callback into bus_init and master_set_info callbacks

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c                 | 10 +++--
 drivers/i3c/master/dw-i3c-master.c   | 29 ++++++++-----
 drivers/i3c/master/i3c-master-cdns.c | 63 ++++++++++++++++++----------
 include/linux/i3c/master.h           |  7 +++-
 4 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52121fe..0ec332e45737 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1716,6 +1716,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	if (ret)
 		goto err_detach_devs;
 
+	ret = master->ops->master_set_info(master);
+	if (ret)
+		goto err_detach_devs;
+
 	/*
 	 * The master device should have been instantiated in ->bus_init(),
 	 * complain if this was not the case.
@@ -2378,9 +2382,9 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
-	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers ||
-	    !ops->i2c_funcs)
+	if (!ops || !ops->bus_init || !ops->master_set_info ||
+	    !ops->priv_xfers || !ops->send_ccc_cmd || !ops->do_daa ||
+	    !ops->i2c_xfers || !ops->i2c_funcs)
 		return -EINVAL;
 
 	if (ops->request_ibi &&
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1d83c97431c7..5c9a72d68fb8 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -593,7 +593,6 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 {
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	struct i3c_bus *bus = i3c_master_get_bus(m);
-	struct i3c_device_info info = { };
 	u32 thld_ctrl;
 	int ret;
 
@@ -624,6 +623,24 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	writel(INTR_MASTER_MASK, master->regs + INTR_STATUS_EN);
 	writel(INTR_MASTER_MASK, master->regs + INTR_SIGNAL_EN);
 
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
+
+	/* For now don't support Hot-Join */
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
+	       master->regs + DEVICE_CTRL);
+
+	dw_i3c_master_enable(master);
+
+	return 0;
+}
+
+static int dw_i3c_master_set_info(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct i3c_device_info info = { };
+	int ret;
+
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
 		return ret;
@@ -638,15 +655,6 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
-	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
-
-	/* For now don't support Hot-Join */
-	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
-	       master->regs + DEVICE_CTRL);
-
-	dw_i3c_master_enable(master);
-
 	return 0;
 }
 
@@ -1088,6 +1096,7 @@ static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
 
 static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 	.bus_init = dw_i3c_master_bus_init,
+	.master_set_info = dw_i3c_master_set_info,
 	.bus_cleanup = dw_i3c_master_bus_cleanup,
 	.attach_i3c_dev = dw_i3c_master_attach_i3c_dev,
 	.reattach_i3c_dev = dw_i3c_master_reattach_i3c_dev,
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 8889a4fdb454..c2d1631a9e38 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1199,21 +1199,20 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
 	unsigned long pres_step, sysclk_rate, max_i2cfreq;
 	struct i3c_bus *bus = i3c_master_get_bus(m);
-	u32 ctrl, prescl0, prescl1, pres, low;
-	struct i3c_device_info info = { };
-	int ret, ncycles;
+	u32 ctrl, prescl0, prescl1, pres, low, bus_mode;
+	int ncycles;
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
-		ctrl = CTRL_PURE_BUS_MODE;
+		bus_mode = CTRL_PURE_BUS_MODE;
 		break;
 
 	case I3C_BUS_MODE_MIXED_FAST:
-		ctrl = CTRL_MIXED_FAST_BUS_MODE;
+		bus_mode = CTRL_MIXED_FAST_BUS_MODE;
 		break;
 
 	case I3C_BUS_MODE_MIXED_SLOW:
-		ctrl = CTRL_MIXED_SLOW_BUS_MODE;
+		bus_mode = CTRL_MIXED_SLOW_BUS_MODE;
 		break;
 
 	default:
@@ -1244,7 +1243,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
 
 	prescl0 |= PRESCL_CTRL0_I2C(pres);
-	writel(prescl0, master->regs + PRESCL_CTRL0);
 
 	/* Calculate OD and PP low. */
 	pres_step = 1000000000 / (bus->scl_rate.i3c * 4);
@@ -1252,15 +1250,43 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ncycles < 0)
 		ncycles = 0;
 	prescl1 = PRESCL_CTRL1_OD_LOW(ncycles);
+
+	ctrl = readl(master->regs + CTRL);
+	if (ctrl & CTRL_DEV_EN)
+		cdns_i3c_master_disable(master);
+	writel(prescl0, master->regs + PRESCL_CTRL0);
 	writel(prescl1, master->regs + PRESCL_CTRL1);
+	ctrl &= ~CTRL_BUS_MODE_MASK;
+	ctrl |= bus_mode | CTRL_HALT_EN | CTRL_MCS_EN;
+	/*
+	 * Enable Hot-Join, and, when a Hot-Join request happens,
+	 * disable all events coming from this device.
+	 * We will issue ENTDAA afterwards from the threaded IRQ
+	 * handler.
+	 */
+	if (!m->secondary)
+		ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC;
+	writel(ctrl, master->regs + CTRL);
+	cdns_i3c_master_enable(master);
 
-	/* Get an address for the master. */
-	ret = i3c_master_get_free_addr(m, 0);
-	if (ret < 0)
-		return ret;
+	return 0;
+}
 
-	writel(prepare_rr0_dev_address(ret) | DEV_ID_RR0_IS_I3C,
-	       master->regs + DEV_ID_RR0(0));
+static int cdns_i3c_master_set_info(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct i3c_device_info info = { };
+	int ret;
+
+	if (!m->secondary) {
+		/* Get an address for the master. */
+		ret = i3c_master_get_free_addr(m, 0);
+		if (ret < 0)
+			return ret;
+
+		writel(prepare_rr0_dev_address(ret) | DEV_ID_RR0_IS_I3C,
+		       master->regs + DEV_ID_RR0(0));
+	}
 
 	cdns_i3c_master_dev_rr_to_info(master, 0, &info);
 	if (info.bcr & I3C_BCR_HDR_CAP)
@@ -1270,16 +1296,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	/*
-	 * Enable Hot-Join, and, when a Hot-Join request happens, disable all
-	 * events coming from this device.
-	 *
-	 * We will issue ENTDAA afterwards from the threaded IRQ handler.
-	 */
-	ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC | CTRL_HALT_EN | CTRL_MCS_EN;
-	writel(ctrl, master->regs + CTRL);
-
-	cdns_i3c_master_enable(master);
 
 	return 0;
 }
@@ -1507,6 +1523,7 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
+	.master_set_info = cdns_i3c_master_set_info,
 	.bus_cleanup = cdns_i3c_master_bus_cleanup,
 	.do_daa = cdns_i3c_master_do_daa,
 	.attach_i3c_dev = cdns_i3c_master_attach_i3c_dev,
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index f13fd8b1dd79..3dc7eafe811a 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -337,10 +337,12 @@ struct i3c_bus {
 
 /**
  * struct i3c_master_controller_ops - I3C master methods
- * @bus_init: hook responsible for the I3C bus initialization. You should at
- *	      least call master_set_info() from there and set the bus mode.
+ * @bus_init: hook responsible for the I3C bus initialization.
  *	      You can also put controller specific initialization in there.
  *	      This method is mandatory.
+ * @master_set_info: hook responsible for assigning address to main master.
+ *			You should call i3c_master_set_info from here.
+ *			This method is mandatory.
  * @bus_cleanup: cleanup everything done in
  *		 &i3c_master_controller_ops->bus_init().
  *		 This method is optional.
@@ -421,6 +423,7 @@ struct i3c_bus {
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
+	int (*master_set_info)(struct i3c_master_controller *m);
 	void (*bus_cleanup)(struct i3c_master_controller *master);
 	int (*attach_i3c_dev)(struct i3c_dev_desc *dev);
 	int (*reattach_i3c_dev)(struct i3c_dev_desc *dev, u8 old_dyn_addr);
-- 
2.17.1

