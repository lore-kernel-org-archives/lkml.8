Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896A3207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CUbHoGhW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="edPGZRvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgEaHQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:16:31 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39728 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728411AbgEaHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:16:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V7Cpxi011959;
        Sun, 31 May 2020 00:16:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ISLroFu3HNY44NFLODvcFyRCyKdfruWAuy5Qc4FHoMY=;
 b=CUbHoGhWVGWGWHlLb3v0dbNRGyXHlC131gePeLgLlO5XKevI9IMqjVAdepIH66ge2WvC
 MYya6XJ77ev1XjsEP60SRik8Hh434ElAAuF6/UoshKCDnOagEcIPU8M22euP9BaKXz12
 +dBIWzIXOVMEfqWovoA2PsAX1TRtp/ivbXNEDUeYlgc/19cnlbQg67lrubrQmkLCwcnm
 FGh62bEpAo57fjzgPcK5yDhRC4pHmj0mPxlUW1IHPb9z6puWNZZlvjt3fq+HHkUBJMwf
 TM+rM+ZXbeD6q4QQlncu5wrwxp3YLqobtZV+yQehI/p22ToxtEeoJnJJumY3geAW763b hw== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31bm1wjg1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp/PgkTUPNDioDS1fezzAm349h6gQJVvEG6c/udM3pef9kARGEoytIayrVwaNDIQd/Fl8UV68dBUGg6/d/m3aQ9qzcmbqksXncBepRQp7D6D1Z2N1DT7yejraLPpmGTlQejfgzpSFhBJrBqpnQxbheoNQKKgzydq+E96+YZLVJ+yCOz9fVEoziEwm7PnOqS+AhEKe2Hr70WM88A//5VynycA2fNXUAszsA9fIgNYXp0U3eWCMVfmJT/3wryGSwKZLZt1pRIAjVW8gAYU2JgUHz8A54H19OZd4nvNmyCzY1jLYmrAWWPKaiiEAAXr/wJyY4SYVnIbApiZYw9abkW5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISLroFu3HNY44NFLODvcFyRCyKdfruWAuy5Qc4FHoMY=;
 b=mdqBtIb9aKNcF0D0UFGnKFGuxA8cEZvuFHlSsdnSnvNC3AnZkqXeecaCSr9bhb6S1NJU10FkVXAR0tLt2R7+ksPO4wFNZmzORBJpP5GQ+J56DqXZtnIKtuAfZbVYkQYHE1rAYeFWtPITL3jC4p+SdNoLFuFpXfVBZFzR+D1hpl6lWqbjmGyOHLjGE7BKVBcKgb+uxRwhaYyl8vnvjiFNmDuQviEHAduenczQqFZ80FQEDlh3vKJAO44ySFDmVZtmrQaKpZmtY8qbQdGi+BI72AdzNPx66IDdtQoFol4LBz1wSLM+GQEN41Ao+puCfw4DdYE0zkRZpw4jK2LjZRC+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISLroFu3HNY44NFLODvcFyRCyKdfruWAuy5Qc4FHoMY=;
 b=edPGZRvQ94ohqCIzI6voTdOvaFLVpf0cmYrSQ6TPLGf5mxep2+KwnBNMvRPHfBkz7AGU5NduL1iPnbxIb6xsd4WfwZA6TXjqYk53204YeMfF/gLL0fhkavlWq6JAnLR9YqhgyiiVi9VlQi50b1IsplUuKpNwqdHSInZYCtKfrFw=
Received: from MWHPR04CA0060.namprd04.prod.outlook.com (2603:10b6:300:6c::22)
 by MWHPR0701MB3785.namprd07.prod.outlook.com (2603:10b6:301:78::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Sun, 31 May
 2020 07:16:19 +0000
Received: from MW2NAM12FT023.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::34) by MWHPR04CA0060.outlook.office365.com
 (2603:10b6:300:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Sun, 31 May 2020 07:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT023.mail.protection.outlook.com (10.13.180.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Sun, 31 May 2020 07:16:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7GEVp003619
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 31 May 2020 03:16:15 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 31 May 2020 09:16:13 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 31 May 2020 09:16:13 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7GDrZ007576;
        Sun, 31 May 2020 09:16:13 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04V7GCIN007571;
        Sun, 31 May 2020 09:16:12 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v8 7/7] i3c: master: mastership handover, defslvs processing in cdns controller driver
Date:   Sun, 31 May 2020 09:16:11 +0200
Message-ID: <1590909371-7534-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
References: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(39850400004)(346002)(36092001)(46966005)(426003)(70206006)(70586007)(336012)(110136005)(8936002)(82310400002)(81166007)(356005)(54906003)(36756003)(47076004)(2906002)(36906005)(316002)(82740400003)(8676002)(42186006)(186003)(26005)(107886003)(86362001)(478600001)(30864003)(4326008)(5660300002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 950f73eb-9fe1-4f88-9160-08d80532838a
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3785:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB37852D957C6BF6456D9661C1C18D0@MWHPR0701MB3785.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6S+gLU4VLcUbZ+IrivC8mOUBJWKzI+DraWs3baLiTIe/NitxeDI0W18w5cHArhx41eQ9d6mbcBLkdaO3on6XKM3RZuTYAKyJWEyEcIEnr0AuIegkZtD0N5AHagw3XY61u9ap9zLgnPJY+Plba6frbgPGabC1Sw/l7cl0C9VO2hXPlJuelOGQcX6Fug/acA54lh8LZRh5aAAaiWyQJr70JyTRvDQ9NhfCnD5JTT6W6Kqra37lWRpQObwIzR8RyIaGh37KLcSDR1uJ9PvFwJCgPDUJds+YKWxUji0VOzV56qff+jY0dcJElLtwpylTjat+BLjpku+mnDFVfUw7Bgf0HJp9OUbuDrKxxUdE/nD7cKmlBmu9u9B6UmQxbyI0S0FEV/6JaqUyXR207TAOiPrghz1Y+raZbBUHQpPsrBFux0=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 07:16:18.4036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 950f73eb-9fe1-4f88-9160-08d80532838a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3785
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 suspectscore=2 phishscore=0 adultscore=0
 cotscore=-2147483648 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added I3C bus mastership handover and DEFSLVS message handling
code to Cadence's I3C master controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 329 +++++++++++++++++++++++++--
 1 file changed, 306 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index c7db02543e33..fa54725be47c 100644
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
@@ -189,7 +190,7 @@
 #define SLV_STATUS1_HJ_DIS		BIT(18)
 #define SLV_STATUS1_MR_DIS		BIT(17)
 #define SLV_STATUS1_PROT_ERR		BIT(16)
-#define SLV_STATUS1_DA(x)		(((s) & GENMASK(15, 9)) >> 9)
+#define SLV_STATUS1_DA(s)		(((s) & GENMASK(15, 9)) >> 9)
 #define SLV_STATUS1_HAS_DA		BIT(8)
 #define SLV_STATUS1_DDR_RX_FULL		BIT(7)
 #define SLV_STATUS1_DDR_TX_FULL		BIT(6)
@@ -390,6 +391,9 @@ struct cdns_i3c_xfer {
 
 struct cdns_i3c_master {
 	struct work_struct hj_work;
+	struct work_struct mr_yield_work;
+	struct work_struct defslvs_work;
+	struct completion mr_done;
 	struct i3c_master_controller base;
 	u32 free_rr_slots;
 	unsigned int maxdevs;
@@ -408,6 +412,7 @@ struct cdns_i3c_master {
 	struct clk *pclk;
 	struct cdns_i3c_master_caps caps;
 	unsigned long i3c_scl_lim;
+	u8 mr_addr;
 };
 
 static inline struct cdns_i3c_master *
@@ -1187,10 +1192,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 
 	cdns_i3c_master_upd_i3c_scl_lim(master);
 
-	/* Unmask Hot-Join and Mastership request interrupts. */
-	i3c_master_enec_locked(m, I3C_BROADCAST_ADDR,
-			       I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR);
-
 	return 0;
 }
 
@@ -1199,21 +1200,21 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
 	unsigned long pres_step, sysclk_rate, max_i2cfreq;
 	struct i3c_bus *bus = i3c_master_get_bus(m);
-	u32 ctrl, prescl0, prescl1, pres, low;
+	u32 ctrl, prescl0, prescl1, pres, low, bus_mode;
 	struct i3c_device_info info = { };
 	int ret, ncycles;
 
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
@@ -1244,7 +1245,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
 
 	prescl0 |= PRESCL_CTRL0_I2C(pres);
-	writel(prescl0, master->regs + PRESCL_CTRL0);
 
 	/* Calculate OD and PP low. */
 	pres_step = 1000000000 / (bus->scl_rate.i3c * 4);
@@ -1252,7 +1252,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ncycles < 0)
 		ncycles = 0;
 	prescl1 = PRESCL_CTRL1_OD_LOW(ncycles);
-	writel(prescl1, master->regs + PRESCL_CTRL1);
 
 	/* Get an address for the master. */
 	ret = i3c_master_get_free_addr(m, 0);
@@ -1270,13 +1269,21 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
+	ctrl = readl(master->regs + CTRL);
+	if (ctrl & CTRL_DEV_EN)
+		cdns_i3c_master_disable(master);
+	writel(prescl0, master->regs + PRESCL_CTRL0);
+	writel(prescl1, master->regs + PRESCL_CTRL1);
+	ctrl &= ~CTRL_BUS_MODE_MASK;
+	ctrl |= bus_mode | CTRL_HALT_EN | CTRL_MCS_EN;
 	/*
 	 * Enable Hot-Join, and, when a Hot-Join request happens, disable all
 	 * events coming from this device.
 	 *
 	 * We will issue ENTDAA afterwards from the threaded IRQ handler.
 	 */
-	ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC | CTRL_HALT_EN | CTRL_MCS_EN;
+	if (!m->secondary)
+		ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC;
 	writel(ctrl, master->regs + CTRL);
 
 	cdns_i3c_master_enable(master);
@@ -1340,6 +1347,7 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
 
 static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 {
+	struct i3c_dev_desc *dev;
 	u32 status0;
 
 	writel(MST_INT_IBIR_THR, master->regs + MST_ICR);
@@ -1361,6 +1369,14 @@ static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 
 		case IBIR_TYPE_MR:
 			WARN_ON(IBIR_XFER_BYTES(ibir) || (ibir & IBIR_ERROR));
+			if (ibir & IBIR_ACKED) {
+				dev = master->ibi.slots[IBIR_SLVID(ibir)];
+				master->mr_addr = dev->info.dyn_addr;
+				queue_work(master->base.wq,
+					   &master->mr_yield_work);
+			}
+			break;
+
 		default:
 			break;
 		}
@@ -1372,16 +1388,42 @@ static irqreturn_t cdns_i3c_master_interrupt(int irq, void *data)
 	struct cdns_i3c_master *master = data;
 	u32 status;
 
-	status = readl(master->regs + MST_ISR);
-	if (!(status & readl(master->regs + MST_IMR)))
-		return IRQ_NONE;
+	if (master->base.this &&
+	    master->base.this == master->base.bus.cur_master) {
+		status = readl(master->regs + MST_ISR);
+		if (!(status & readl(master->regs + MST_IMR)))
+			return IRQ_NONE;
+
+		spin_lock(&master->xferqueue.lock);
+		cdns_i3c_master_end_xfer_locked(master, status);
+		spin_unlock(&master->xferqueue.lock);
+
+		if (status & MST_INT_IBIR_THR)
+			cnds_i3c_master_demux_ibis(master);
+
+		if (status & MST_INT_MR_DONE) {
+			writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO,
+			       master->regs + FLUSH_CTRL);
+			writel(MST_INT_MR_DONE, master->regs + MST_ICR);
+		}
+	} else {
+		status = (readl(master->regs + SLV_ISR) &
+			  readl(master->regs + SLV_IMR));
+
+		if (!status)
+			return IRQ_NONE;
+
+		if (status & SLV_INT_MR_DONE) {
+			writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO,
+			       master->regs + FLUSH_CTRL);
+			complete(&master->mr_done);
+		}
 
-	spin_lock(&master->xferqueue.lock);
-	cdns_i3c_master_end_xfer_locked(master, status);
-	spin_unlock(&master->xferqueue.lock);
+		if (status & SLV_INT_DEFSLVS)
+			queue_work(master->base.wq, &master->defslvs_work);
 
-	if (status & MST_INT_IBIR_THR)
-		cnds_i3c_master_demux_ibis(master);
+		writel(status, master->regs + SLV_ICR);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1505,6 +1547,106 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
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
+	for (i = 0; i < master->ibi.num_slots; i++) {
+		if (master->ibi.slots[i] == dev) {
+			*slot = i;
+			ret = 0;
+			break;
+		}
+	}
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
+	status = readl(master->regs + MST_STATUS0);
+	if (status & MST_STATUS0_MASTER_MODE)
+		return 0;
+
+	status = readl(master->regs + SLV_STATUS1);
+	if (!(status & SLV_STATUS1_HAS_DA))
+		return -EACCES;
+
+	if (status & SLV_STATUS1_MR_DIS)
+		return -EACCES;
+
+	writel(readl(master->regs + CTRL) | CTRL_MST_INIT | CTRL_MST_ACK,
+	       master->regs + CTRL);
+
+	init_completion(&master->mr_done);
+	if (!wait_for_completion_timeout(&master->mr_done,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
+
+	return 0;
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
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
 	.bus_cleanup = cdns_i3c_master_bus_cleanup,
@@ -1524,6 +1666,8 @@ static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.request_ibi = cdns_i3c_master_request_ibi,
 	.free_ibi = cdns_i3c_master_free_ibi,
 	.recycle_ibi_slot = cdns_i3c_master_recycle_ibi_slot,
+	.request_mastership = cdns_i3c_request_mastership,
+	.enable_mr_events = cdns_i3c_master_enable_mastership_events,
 };
 
 static void cdns_i3c_master_hj(struct work_struct *work)
@@ -1535,10 +1679,135 @@ static void cdns_i3c_master_hj(struct work_struct *work)
 	i3c_master_do_daa(&master->base);
 }
 
+static void cdns_i3c_master_yield(struct work_struct *work)
+{
+	struct cdns_i3c_master *master = container_of(work,
+						      struct cdns_i3c_master,
+						      mr_yield_work);
+
+	i3c_master_yield_bus(&master->base, master->mr_addr);
+}
+
+static void cdns_i3c_sec_master_defslvs(struct work_struct *work)
+{
+	struct cdns_i3c_master *master = container_of(work,
+						      struct cdns_i3c_master,
+						      defslvs_work);
+	struct i3c_master_controller *m = &master->base;
+	struct i3c_ccc_dev_desc *desc;
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i2c_dev_desc *i2cdev;
+	u32 devs, val, rr, slot;
+	u32 r0, r1, r2;
+	u8 saddr;
+
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+	master->free_rr_slots = GENMASK(master->maxdevs, 1) & ~devs;
+
+	/*
+	 * We chose to ignore I2C devices received from
+	 * main master and use I2C device info from boardinfo.
+	 * Since I2C device from boardinfo are already
+	 * registered during bus_init, we just use same slot
+	 * and if any I3C device is received in DEFSLVS in that
+	 * place, just move that I3C device to other free slot.
+	 * If there is no free slot, then such I3C devices
+	 * are ignored.
+	 * Master controller driver can chose how to handle I2C
+	 * devices in DEFSLVS and pass only I3C devices list to
+	 * I3C core DEFSVLS processing to handle hotplug and
+	 * I3C device address changes.
+	 */
+	for (slot = 0; slot < master->maxdevs; slot++) {
+		if (!(devs & BIT(slot)))
+			continue;
+
+		val = readl(master->regs + DEV_ID_RR0(slot));
+		if (!(val & DEV_ID_RR0_IS_I3C)) {
+			writel(readl(master->regs + DEVS_CTRL) |
+				DEVS_CTRL_DEV_CLR(slot),
+				master->regs + DEVS_CTRL);
+			master->free_rr_slots |= BIT(slot);
+		}
+	}
+
+	val = 0;
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+	i3c_bus_for_each_i2cdev(&m->bus, i2cdev) {
+		data = i2c_dev_get_master_data(i2cdev);
+		if (devs & BIT(data->id)) {
+			rr = readl(master->regs + DEV_ID_RR0(data->id));
+			saddr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			if (saddr != i2cdev->boardinfo->base.addr) {
+				r0 = readl(master->regs + DEV_ID_RR0(data->id));
+				r1 = readl(master->regs + DEV_ID_RR1(data->id));
+				r2 = readl(master->regs + DEV_ID_RR2(data->id));
+				slot = ffs(master->free_rr_slots) - 1;
+				if (slot > 0) {
+					writel(r0,
+					       master->regs + DEV_ID_RR0(slot));
+					writel(r1,
+					       master->regs + DEV_ID_RR1(slot));
+					writel(r2,
+					       master->regs + DEV_ID_RR2(slot));
+					writel(readl(master->regs + DEVS_CTRL) |
+					       DEVS_CTRL_DEV_ACTIVE(slot),
+					       master->regs + DEVS_CTRL);
+					master->free_rr_slots &= ~BIT(slot);
+				}
+			} else {
+				continue;
+			}
+		}
+		writel(readl(master->regs + DEVS_CTRL) |
+		       DEVS_CTRL_DEV_CLR(data->id),
+		       master->regs + DEVS_CTRL);
+		writel(readl(master->regs + DEVS_CTRL) |
+		       DEVS_CTRL_DEV_ACTIVE(data->id),
+		       master->regs + DEVS_CTRL);
+		writel(prepare_rr0_dev_address(i2cdev->boardinfo->base.addr) |
+		       (i2cdev->boardinfo->base.flags & I2C_CLIENT_TEN ?
+			DEV_ID_RR0_LVR_EXT_ADDR : 0),
+			master->regs + DEV_ID_RR0(data->id));
+		writel(i2cdev->boardinfo->lvr,
+		       master->regs + DEV_ID_RR2(data->id));
+		master->free_rr_slots &= ~BIT(data->id);
+	}
+
+	master->base.defslvs_data.ndevs = 0;
+	desc = master->base.defslvs_data.devs;
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+
+	for (slot = 0; slot < master->maxdevs; slot++) {
+		if (!(devs & BIT(slot)))
+			continue;
+
+		val = readl(master->regs + DEV_ID_RR0(slot));
+		if (val & DEV_ID_RR0_IS_I3C) {
+			memset(desc, 0, sizeof(struct i3c_ccc_dev_desc));
+			rr = readl(master->regs + DEV_ID_RR0(slot));
+			desc->dyn_addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			rr = readl(master->regs + DEV_ID_RR2(slot));
+			desc->dcr = rr;
+			desc->bcr = rr >> 8;
+			master->base.defslvs_data.ndevs++;
+			desc++;
+		}
+	}
+
+	val = readl(master->regs + SLV_STATUS1);
+	if (!(val & SLV_STATUS1_HAS_DA) ||
+	    i3c_master_process_defslvs(m, SLV_STATUS1_DA(val))) {
+		queue_work(master->base.wq, work);
+		return;
+	}
+}
+
 static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master;
 	struct resource *res;
+	bool secondary;
 	int ret, irq;
 	u32 val;
 
@@ -1579,6 +1848,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
 
+	INIT_WORK(&master->mr_yield_work, cdns_i3c_master_yield);
 	INIT_WORK(&master->hj_work, cdns_i3c_master_hj);
 	writel(0xffffffff, master->regs + MST_IDR);
 	writel(0xffffffff, master->regs + SLV_IDR);
@@ -1590,6 +1860,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	val = readl(master->regs + CONF_STATUS0);
+	secondary = (val & CONF_STATUS0_SEC_MASTER) ? true : false;
 
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
@@ -1610,12 +1881,24 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (!master->ibi.slots)
 		goto err_disable_sysclk;
 
+	if (secondary)
+		INIT_WORK(&master->defslvs_work, cdns_i3c_sec_master_defslvs);
+
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
-	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
+	writel(MST_INT_IBIR_THR | MST_INT_MR_DONE, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
-	ret = i3c_primary_master_register(&master->base, &pdev->dev,
-					  &cdns_i3c_master_ops);
+	if (secondary) {
+		ret = i3c_secondary_master_register(&master->base, &pdev->dev,
+						    &cdns_i3c_master_ops);
+		if (!ret)
+			writel(SLV_INT_DEFSLVS | SLV_INT_MR_DONE,
+			       master->regs + SLV_IER);
+	} else {
+		ret = i3c_primary_master_register(&master->base, &pdev->dev,
+						  &cdns_i3c_master_ops);
+	}
+
 	if (ret)
 		goto err_disable_sysclk;
 
-- 
2.17.1

