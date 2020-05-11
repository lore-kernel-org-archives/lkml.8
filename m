Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B97C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017FD20735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Uteur4VJ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="f+aN0uQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgEKNRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:17:48 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:36302 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgEKNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:17:47 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDEONN013452;
        Mon, 11 May 2020 06:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=UtXxKqgtdoRLAx0Ug+UCUsVbZq2xBNWsTKonncytI3g=;
 b=Uteur4VJxorKIny4l3sTcvuI0iAR5wGp1hQloslFapHOCQgKqmglL98cWoANa85rzA3n
 T+ZPjBjkW/5u8mgr+it9f5SloW6m3LGGr+sAUwSs4RB1/Hn3OIZJ/SztwkgsQGRiCBTx
 HTWj2/YiRqTXzAaXOpDWHjSRhm1JEbFh7QVsgEUvJomCq/reuXmSnVgxofornxpzuVM/
 RkH/X0yrFXyu2x1Jr5T7R8pWRDDgqjAUqDbGuuuw28qK/BoxOTnwD6zedzPPpVkoxaGH
 h/EjLtSYTi0lY/90F0JFmOfTxpzsVJRRsWng14cJrWAcaLVslngaRFNLwZLShsTM7IT8 3w== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xeay8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0D7CrIIOn7su+kdiXlBPYYx1BYRSXXY2ouSax6wG4Wv47Un9saefUV8k0DKJ340Q6tqfzOzfBAke71cHjy8E2Q6AwGUq0qcemmUVV/jUpyxiUsSrlh3Mq8BemjWP71bl0TckTJCDVRs17AEMYNhD1btI6nZxJKgO92IX+nUwdJj9/elwyAFW7Hkl5Zxswd7Nx7wtbGe3x6awbV/FEoPE7hV3kYDPo9fq24uavoi9Wxwlzb8eVs5EpHmzRswSknYIM2DOy36uxVEDAbvNM0F5gIMs2himHxiw5znx85Lf2ylrE8bXSgq7Q9eCiRikTopLzMnJLhsRoYU6JkkeOvHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtXxKqgtdoRLAx0Ug+UCUsVbZq2xBNWsTKonncytI3g=;
 b=Gi6S5VVVtlJulj9hszhJqJQ0Qe3TaEn4CnfXcNr/tIAxLE33GFxVqdWMql/XeOC9qzmoI7cVoXanLuYjMs/THLHBL0QDYvNO48CcKdOetFwZo9X+2JDoJSHXz5AlblgDtT1iBEmfK3u/b7r4Otn6WPh55sH3pCnlX05GyOvD+7IJtbOdvnrg+Z2lCigkstROGSQNt4yajoHKPDmLaz4X7ECogqvo35048OOgxi+j6Jqp7GyfhxXqMql1C3jFgqHhMchJWBhB6XHiK53Zh2lVBODCTn6+C0tAIgvl9dmpDiErisX6qLesCb6yBzA08bc4nGnlGXI18/OoQhAoalmggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtXxKqgtdoRLAx0Ug+UCUsVbZq2xBNWsTKonncytI3g=;
 b=f+aN0uQCChH2Gej0LEpHX1WcJZxetW6yAOPjgSuL7K+gAZOXiLEg4oGy/d6+trMaGfzIy2EtJs/OSrcaCcw35h5ehDZikD3DxY68B82bjcz+5dLDKFrLNYvE/XqOO4EPDds106h9kfPWIhdFItGZ9n1Td9PBUD5SK4uvJuNBWns=
Received: from DM5PR19CA0023.namprd19.prod.outlook.com (2603:10b6:3:151::33)
 by BYAPR07MB6247.namprd07.prod.outlook.com (2603:10b6:a03:11c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 13:17:30 +0000
Received: from DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::d6) by DM5PR19CA0023.outlook.office365.com
 (2603:10b6:3:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 13:17:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT055.mail.protection.outlook.com (10.13.179.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:17:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDHQxk029055
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2020 06:17:27 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:17:25 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:17:25 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDHPKc011381;
        Mon, 11 May 2020 15:17:25 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDHPJY011380;
        Mon, 11 May 2020 15:17:25 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 7/7] i3c: master: mastership handover, defslvs processing in cdns controller driver
Date:   Mon, 11 May 2020 15:17:24 +0200
Message-ID: <1589203044-11324-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36092001)(46966005)(33430700001)(5660300002)(54906003)(30864003)(8936002)(2616005)(336012)(426003)(186003)(26005)(8676002)(107886003)(2906002)(4326008)(316002)(82740400003)(42186006)(36756003)(110136005)(36906005)(70586007)(70206006)(33440700001)(82310400002)(356005)(47076004)(7636003)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28eedcf4-aa3b-402e-cb35-08d7f5ada855
X-MS-TrafficTypeDiagnostic: BYAPR07MB6247:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6247A8A8FE1E7E75AE48B3E0C1A10@BYAPR07MB6247.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALx1p0IjCEW3RqEkIIiRe6j7UEVmzH2nV0Xt9mC/cq2x3EcfNkqKYh0FZ261kTuxsVcAT+faymq8vBSLjMLDHz4R2J4a5Q9UcSmHETe7GGG/JpUHSriCXJpyQNPHABLKynWknZ6ZQdl392gwH0R/3+jzyzYiDr8xl0NyFJbjoKeXb3XtSUZwVMCXIzWAwDo3WPbtvgKa3Drl5WPNHlwueSqFepI/z/rHDFkbDU+IGumgiq/BghZYt/2ml50UqDiuVj/RgJvQW3AAjONq7JAc7hKerfHTGQYaIA8aw7aBx4u2FG/e6ZZBZULuCaaAo3GmWvwsNrr42L00Ego942KzeIN2UExgU/3AmUD4rEYMrkJtsxJxgL+tMIXdopnEfirSGVN8svI/EctmgN5XRiIbFbp1bXupVQZcBN/dbpPCjQmLhVVYI0hEKX0k7MKSbxWqRRcT9wBHGQZd76As0XzqFhwOKyi2AuWhj3c20hpUmRsUxGJBrxOPbEoBl0itBcTq8gXWpLpX4036s7uughZdDCkeQnCuFLQYEJ6QShzD2bMNjPOZQvjSS1Ei9+LanReFiwOC7rj3BYKWmUFaotXduc0oPbs8apAzzWoxBfA6Od8=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:17:29.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eedcf4-aa3b-402e-cb35-08d7f5ada855
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6247
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=2 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added I3C bus mastership handover and DEFSLVS message handling
code to Cadence's I3C master controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 377 +++++++++++++++++++++++++--
 1 file changed, 354 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index ed4f43807f9e..1155aa327404 100644
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
@@ -390,6 +391,8 @@ struct cdns_i3c_xfer {
 
 struct cdns_i3c_master {
 	struct work_struct hj_work;
+	struct work_struct mr_yield_work;
+	struct work_struct defslvs_work;
 	struct i3c_master_controller base;
 	u32 free_rr_slots;
 	unsigned int maxdevs;
@@ -408,6 +411,7 @@ struct cdns_i3c_master {
 	struct clk *pclk;
 	struct cdns_i3c_master_caps caps;
 	unsigned long i3c_scl_lim;
+	u8 mr_addr;
 };
 
 static inline struct cdns_i3c_master *
@@ -1187,10 +1191,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 
 	cdns_i3c_master_upd_i3c_scl_lim(master);
 
-	/* Unmask Hot-Join and Mastership request interrupts. */
-	i3c_master_enec_locked(m, I3C_BROADCAST_ADDR,
-			       I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR);
-
 	return 0;
 }
 
@@ -1199,21 +1199,21 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
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
@@ -1244,7 +1244,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
 
 	prescl0 |= PRESCL_CTRL0_I2C(pres);
-	writel(prescl0, master->regs + PRESCL_CTRL0);
 
 	/* Calculate OD and PP low. */
 	pres_step = 1000000000 / (bus->scl_rate.i3c * 4);
@@ -1252,7 +1251,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ncycles < 0)
 		ncycles = 0;
 	prescl1 = PRESCL_CTRL1_OD_LOW(ncycles);
-	writel(prescl1, master->regs + PRESCL_CTRL1);
 
 	/* Get an address for the master. */
 	ret = i3c_master_get_free_addr(m, 0);
@@ -1270,13 +1268,21 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
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
@@ -1340,6 +1346,7 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
 
 static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 {
+	struct i3c_dev_desc *dev;
 	u32 status0;
 
 	writel(MST_INT_IBIR_THR, master->regs + MST_ICR);
@@ -1361,6 +1368,14 @@ static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 
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
@@ -1372,16 +1387,40 @@ static irqreturn_t cdns_i3c_master_interrupt(int irq, void *data)
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
+		if (status & SLV_INT_MR_DONE)
+			writel(FLUSH_RX_FIFO | FLUSH_TX_FIFO,
+			       master->regs + FLUSH_CTRL);
 
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
@@ -1505,6 +1544,138 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
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
+
+	if (status & MST_STATUS0_MASTER_MODE)
+		return 0;
+
+	status = readl(master->regs + SLV_STATUS1);
+
+	if (status & SLV_STATUS1_MR_DIS)
+		return -EACCES;
+
+	writel(readl(master->regs + CTRL) | CTRL_MST_INIT | CTRL_MST_ACK,
+	       master->regs + CTRL);
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
+	case I3C_SLV_MR_DONE:
+		if (readl(master->regs + MST_STATUS0) & MST_STATUS0_MASTER_MODE)
+			ret = true;
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+int cdns_i3c_sec_master_dyn_addr(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	int dyn_addr = -1;
+	u32 status;
+
+	status = readl(master->regs + SLV_STATUS1);
+	if (status & SLV_STATUS1_HAS_DA)
+		dyn_addr = SLV_STATUS1_DA(status);
+
+	return dyn_addr;
+}
+
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
 	.bus_cleanup = cdns_i3c_master_bus_cleanup,
@@ -1524,6 +1695,10 @@ static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.request_ibi = cdns_i3c_master_request_ibi,
 	.free_ibi = cdns_i3c_master_free_ibi,
 	.recycle_ibi_slot = cdns_i3c_master_recycle_ibi_slot,
+	.request_mastership = cdns_i3c_request_mastership,
+	.enable_mr_events = cdns_i3c_master_enable_mastership_events,
+	.check_event_set = cdns_i3c_master_check_event_set,
+	.sec_mst_dyn_addr = cdns_i3c_sec_master_dyn_addr,
 };
 
 static void cdns_i3c_master_hj(struct work_struct *work)
@@ -1535,10 +1710,152 @@ static void cdns_i3c_master_hj(struct work_struct *work)
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
+	struct i3c_dev_desc *i3cdev;
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
+	if (i3c_master_process_defslvs(m)) {
+		queue_work(master->base.wq, work);
+		return;
+	}
+
+	/*
+	 * Fix data->id for any changes due to mismatch in number
+	 * of I2C devices on main and secondary master, causing
+	 * I3C devices received in DEFSLVS in a slot which was used
+	 * for I2C device on sec master to be moved to other free
+	 * slot. And then if any I3C device get unplugged
+	 * next DEFSLVS processing would I3C devices in original
+	 * I2C slot to be moved to different slot than it
+	 * was moved at the first DEFSLVS processing.
+	 */
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		data = i3c_dev_get_master_data(i3cdev);
+		if (!data)
+			continue;
+		data->id = cdns_i3c_master_get_rr_slot(master,
+						       i3cdev->info.dyn_addr);
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
 
@@ -1579,6 +1896,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
 
+	INIT_WORK(&master->mr_yield_work, cdns_i3c_master_yield);
 	INIT_WORK(&master->hj_work, cdns_i3c_master_hj);
 	writel(0xffffffff, master->regs + MST_IDR);
 	writel(0xffffffff, master->regs + SLV_IDR);
@@ -1590,6 +1908,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	val = readl(master->regs + CONF_STATUS0);
+	secondary = (val & CONF_STATUS0_SEC_MASTER) ? true : false;
 
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
@@ -1610,12 +1929,24 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (!master->ibi.slots)
 		goto err_disable_sysclk;
 
+	if (secondary)
+		INIT_WORK(&master->defslvs_work, cdns_i3c_sec_master_defslvs);
+
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
-	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
+	writel(MST_INT_IBIR_THR | MST_INT_MR_DONE, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
-	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &cdns_i3c_master_ops);
+	if (secondary) {
+		ret = i3c_secondary_master_register(&master->base, &pdev->dev,
+						    &cdns_i3c_master_ops);
+		if (!ret)
+			writel(SLV_INT_DEFSLVS | SLV_INT_MR_DONE,
+			       master->regs + SLV_IER);
+	} else {
+		ret = i3c_master_register(&master->base, &pdev->dev,
+					  &cdns_i3c_master_ops);
+	}
+
 	if (ret)
 		goto err_disable_sysclk;
 
-- 
2.17.1

