Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F878C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57013206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZY6dJUG2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iJuecZgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBFGL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:29 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:12810 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgBFGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:27 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669Ba3015932;
        Wed, 5 Feb 2020 22:11:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Ja4cseYHalvt30XgiUC/qFKdrSN1paRzR1Q7G8Se+lM=;
 b=ZY6dJUG2CXim0F7Xi4538dD3PT0aCAEX+vj88xG9dlA3HTvzaHVdZJ7QNhiXEyExy6RE
 82voXadTeZ21F7esKl3/+G6XA2mBC+POe3ZAHiD5QljRvlYVmaouGx9tBmjfhSgNEZZ9
 3FM2gs2sGtdwhlC67Ct3byXZrmaoKbl1DaaVnxQI3jj7AcbyUVNkXc+j0nD43s+SDBTp
 ZH1RwRZZzDYeumB0ESlMV478CClF2Z+jKmNKnjafxVmQm3+x8u5qtodMV7jPzcEimB78
 gZZlojhTSp9+hRKG88O47m6tEm/Nk9bixhL6NO0zGzqDXkJkbUZzowPmu2r/KXa6kDbV Qg== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2052.outbound.protection.outlook.com [104.47.46.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunrb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIgaPPikx8IfGIXz7n0OC4VkmuKSp7GZarEsCuK7+nkj4pA2cgAwRK2UXtfTTivzR1HjLVUpmuuOQxofOMEs+H5vOCj6OWM0Mf8YYFsG7aS05m4qz5ADbluPKmFEDj57tFGyol8a+VesC4vyMLOsewg7wk8HJwaL/jbKNKc3QRe0X5AnLmbut6vbmYydGgLPqlLz+MS3L9hsbTX9BAJsu0w7RyRtyON5jK+QxZE4Qfp585+okVbVqk5cLqFN5Rqrhmbzs2+j0POw1KBfV+7vRt05vT7Vgav2eHg9G16rQkOTGkO0spI9Sj9GJ6rQIWeoT+fYbKloSwP5lK4pqkMsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja4cseYHalvt30XgiUC/qFKdrSN1paRzR1Q7G8Se+lM=;
 b=QEYSyT3WwreDBhPDSrzCrpBbUcWrdzJQ1JionzPcHc+qWPsWxQf2XTzi++aPHywWBplor+YvngTdrV7UCK50LiKIX8+Jr9lPxdP/Fz3hx7+rehbtqZyFWyWWfVlr0Bfp2vZnGwInEPzoKJyXbilT7q/n0ekOYAo0PDMhulu3gsaxXcyAenZF3naQkFGeBI37EcjXfIVlc7BGl08cVADZhji/U48PvHS/0Bpa8JRQyaH744n/v/3X5YV1EBYH+zAF9nM0Udqr1kXH1wExULn9W6saD5Y6a8e35dkVN4h0W7ujnIPiTkiOuyoXVHLZpddiw3WBtIZgTYuc7i1FN2j9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja4cseYHalvt30XgiUC/qFKdrSN1paRzR1Q7G8Se+lM=;
 b=iJuecZgfOja6kE5DSq5GTpD4imQIWT5+6MJMbcsqrMWueJP0Q9dvWqjvZYK+9KpgBNMgldNJeodBgckCizSMYvqvcJ4XPonio1Ip9wwsNpXfrLV8gAHt9yh36kPZJ3yWpssIrh6kBKQCL6aCI0YWK07/e15d7l53AApd7OjdICw=
Received: from BN8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:ac::21)
 by MN2PR07MB5854.namprd07.prod.outlook.com (2603:10b6:208:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27; Thu, 6 Feb
 2020 06:11:17 +0000
Received: from MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::209) by BN8PR07CA0008.outlook.office365.com
 (2603:10b6:408:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT048.mail.protection.outlook.com (10.13.180.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5FB174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:15 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B4bV017059;
        Thu, 6 Feb 2020 07:11:04 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B4DW017058;
        Thu, 6 Feb 2020 07:11:04 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 09/13] phy: cadence-torrent: Implement PHY configure APIs
Date:   Thu, 6 Feb 2020 07:10:57 +0100
Message-ID: <1580969461-16981-10-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(199004)(36092001)(189003)(70206006)(70586007)(107886003)(110136005)(2906002)(54906003)(42186006)(36906005)(316002)(4326008)(478600001)(26005)(186003)(8936002)(81156014)(81166006)(86362001)(2616005)(426003)(5660300002)(30864003)(36756003)(356004)(6666004)(336012)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB5854;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0aaaff0-8fc1-46c0-8534-08d7aacb605b
X-MS-TrafficTypeDiagnostic: MN2PR07MB5854:
X-Microsoft-Antispam-PRVS: <MN2PR07MB5854AE77E7000FC48B9A7093D21D0@MN2PR07MB5854.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK/k7h0vxoNQ2OAHd5XnlMvb5S0Xn0YAq9pWtiMtvPB8RRhhtyBRcybbUiL8kUicuCwxYJUlwez8Wp8Wo4B6Gv+v3bc05ZgqRqARUX85/T5COJg+4fEb9LrEubFvnkwB17ynY2KTGtTdqCi1Ckri2Hw5FFA8TgV4i0DumTCgxrn6X8mO70nHfCe07asiHqTVtSG1v2xd+Cmcxiw4fVGvLJpVLfY5tMjRuB38U3BDDNXYRgswxWoJSShi9w3mL2V0aFCwzARHQy1tcl2Yr1Wj0sDu4YzSg4TW0oebKN4B+hQOA5tWDj5b4vPBusgGYAgJe/0v00UOK8d5lBvwD9NkWwtpemfd3KkMygrLSUY+r8IbBLditphgsneJjW358h6i1kYVbiUOQnKccEA9IfaixqM0yNk8hR0JcJzJvyK4TakPxSnI7FlJ02pGqSCLQaTvCIyT3cLsWm91/cJ1xXfwJtA0+vLbKvfSR2EPEy4zZ9X5grTaWYwb8jrpOQb+RM/m
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:16.7338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0aaaff0-8fc1-46c0-8534-08d7aacb605b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5854
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add support for PHY configuration APIs. These will mainly reconfigure
link rate, number of lanes, voltage swing and pre-emphasis values.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 436 +++++++++++++++++++++-
 1 file changed, 431 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 1596d2c8cfc2..e3b33569285f 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -36,6 +36,9 @@
 #define PHY_AUX_CONFIG			0x00
 #define PHY_AUX_CTRL			0x04
 #define PHY_RESET			0x20
+#define PMA_TX_ELEC_IDLE_MASK		0xF0U
+#define PMA_TX_ELEC_IDLE_SHIFT		4
+#define PHY_L00_RESET_N_MASK		0x01U
 #define PHY_PMA_XCVR_PLLCLK_EN		0x24
 #define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
 #define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
@@ -119,6 +122,10 @@
 #define CMN_PDIAG_PLL1_CP_IADJ_M0	0x00714
 #define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x00718
 
+#define TX_TXCC_CTRL			0x10100
+#define TX_TXCC_CPOST_MULT_00		0x10130
+#define TX_TXCC_MGNFS_MULT_000		0x10140
+#define DRV_DIAG_TX_DRV			0x10318
 #define XCVR_DIAG_PLLDRC_CTRL		0x10394
 #define XCVR_DIAG_HSCLK_SEL		0x10398
 #define XCVR_DIAG_HSCLK_DIV		0x1039c
@@ -128,6 +135,8 @@
 #define TX_PSC_A2			0x10408
 #define TX_PSC_A3			0x1040c
 #define TX_RCVDET_ST_TMR		0x1048c
+#define TX_DIAG_ACYA			0x1079c
+#define TX_DIAG_ACYA_HBDC_MASK		0x0001U
 #define RX_PSC_A0			0x20000
 #define RX_PSC_A1			0x20004
 #define RX_PSC_A2			0x20008
@@ -139,6 +148,9 @@
 
 #define PHY_PLL_CFG			0x30038
 
+#define PHY_PMA_CMN_CTRL2		0x38004
+#define PHY_PMA_PLL_RAW_CTRL		0x3800c
+
 struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
@@ -158,7 +170,8 @@ enum phy_powerstate {
 
 static int cdns_torrent_dp_init(struct phy *phy);
 static int cdns_torrent_dp_exit(struct phy *phy);
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
+			       u32 num_lanes);
 static
 int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
@@ -182,9 +195,16 @@ static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 				    unsigned char num_bits,
 				    unsigned int val);
 
+static int cdns_torrent_dp_configure(struct phy *phy,
+				     union phy_configure_opts *opts);
+static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   u32 num_lanes,
+					   enum phy_powerstate powerstate);
+
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_dp_init,
 	.exit		= cdns_torrent_dp_exit,
+	.configure	= cdns_torrent_dp_configure,
 	.owner		= THIS_MODULE,
 };
 
@@ -196,6 +216,16 @@ static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
 	writel(val, cdns_phy->sd_base + offset);
 }
 
+static u32 cdns_torrent_phy_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
+{
+	return readl(cdns_phy->sd_base + offset);
+}
+
+#define cdns_torrent_phy_read_poll_timeout(cdns_phy, offset, val, cond, \
+					   delay_us, timeout_us) \
+	readl_poll_timeout((cdns_phy)->sd_base + (offset), \
+			   val, cond, delay_us, timeout_us)
+
 /* DPTX mmr access functions */
 
 static void cdns_torrent_dp_write(struct cdns_torrent_phy *cdns_phy,
@@ -214,6 +244,237 @@ static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
 	readl_poll_timeout((cdns_phy)->base + (offset), \
 			   val, cond, delay_us, timeout_us)
 
+/*
+ * Structure used to store values of PHY registers for voltage-related
+ * coefficients, for particular voltage swing and pre-emphasis level. Values
+ * are shared across all physical lanes.
+ */
+struct coefficients {
+	/* Value of DRV_DIAG_TX_DRV register to use */
+	u16 diag_tx_drv;
+	/* Value of TX_TXCC_MGNFS_MULT_000 register to use */
+	u16 mgnfs_mult;
+	/* Value of TX_TXCC_CPOST_MULT_00 register to use */
+	u16 cpost_mult;
+};
+
+/*
+ * Array consists of values of voltage-related registers for sd0801 PHY. A value
+ * of 0xFFFF is a placeholder for invalid combination, and will never be used.
+ */
+static const struct coefficients vltg_coeff[4][4] = {
+	/* voltage swing 0, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x002A,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x001F,
+		 .cpost_mult = 0x0014},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0012,
+		 .cpost_mult = 0x0020},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x002A}
+	},
+
+	/* voltage swing 1, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x001F,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0013,
+		 .cpost_mult = 0x0012},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x001F},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF}
+	},
+
+	/* voltage swing 2, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0013,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x0013},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF}
+	},
+
+	/* voltage swing 3, pre-emphasis 0->3 */
+	{	{.diag_tx_drv = 0x0003, .mgnfs_mult = 0x0000,
+		 .cpost_mult = 0x0000},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF},
+		{.diag_tx_drv = 0xFFFF, .mgnfs_mult = 0xFFFF,
+		 .cpost_mult = 0xFFFF}
+	}
+};
+
+/*
+ * Enable or disable PLL for selected lanes.
+ */
+static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
+				      struct phy_configure_opts_dp *dp,
+				      bool enable)
+{
+	u32 rd_val;
+	u32 ret;
+	/*
+	 * Used to determine, which bits to check for or enable in
+	 * PHY_PMA_XCVR_PLLCLK_EN register.
+	 */
+	u32 pll_bits;
+	/* Used to enable or disable lanes. */
+	u32 pll_val;
+
+	/* Select values of registers and mask, depending on enabled lane
+	 * count.
+	 */
+	switch (dp->lanes) {
+	/* lane 0 */
+	case (1):
+		pll_bits = 0x00000001;
+		break;
+	/* lanes 0-1 */
+	case (2):
+		pll_bits = 0x00000003;
+		break;
+	/* lanes 0-3, all */
+	default:
+		pll_bits = 0x0000000F;
+		break;
+	}
+
+	if (enable)
+		pll_val = pll_bits;
+	else
+		pll_val = 0x00000000;
+
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
+
+	/* Wait for acknowledgment from PHY. */
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN_ACK,
+						rd_val,
+						(rd_val & pll_bits) == pll_val,
+						0, POLL_TIMEOUT_US);
+	ndelay(100);
+	return ret;
+}
+
+/*
+ * Perform register operations related to setting link rate, once powerstate is
+ * set and PLL disable request was processed.
+ */
+static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
+					  struct phy_configure_opts_dp *dp)
+{
+	u32 ret;
+	u32 read_val;
+
+	/* Disable the cmn_pll0_en before re-programming the new data rate. */
+	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0);
+
+	/*
+	 * Wait for PLL ready de-assertion.
+	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
+	 */
+	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
+						 read_val,
+						 ((read_val >> 2) & 0x01) != 0,
+						 0, POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	/* DP Rate Change - VCO Output settings. */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz) {
+		/* PMA common configuration 19.2MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
+							dp->ssc);
+		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
+	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz) {
+		/* PMA common configuration 25MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
+						      dp->ssc);
+		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
+	}
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
+
+	/* Enable the cmn_pll0_en. */
+	cdns_torrent_phy_write(cdns_phy, PHY_PMA_PLL_RAW_CTRL, 0x3);
+
+	/*
+	 * Wait for PLL ready assertion.
+	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
+	 */
+	ret = cdns_torrent_phy_read_poll_timeout(cdns_phy, PHY_PMA_CMN_CTRL2,
+						 read_val,
+						 (read_val & 0x01) != 0,
+						 0, POLL_TIMEOUT_US);
+	return ret;
+}
+
+/*
+ * Verify, that parameters to configure PHY with are correct.
+ */
+static int cdns_torrent_dp_verify_config(struct cdns_torrent_phy *cdns_phy,
+					 struct phy_configure_opts_dp *dp)
+{
+	u8 i;
+
+	/* If changing link rate was required, verify it's supported. */
+	if (dp->set_rate) {
+		switch (dp->link_rate) {
+		case 1620:
+		case 2160:
+		case 2430:
+		case 2700:
+		case 3240:
+		case 4320:
+		case 5400:
+		case 8100:
+			/* valid bit rate */
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* Verify lane count. */
+	switch (dp->lanes) {
+	case 1:
+	case 2:
+	case 4:
+		/* valid lane count. */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check against actual number of PHY's lanes. */
+	if (dp->lanes > cdns_phy->num_lanes)
+		return -EINVAL;
+
+	/*
+	 * If changing voltages is required, check swing and pre-emphasis
+	 * levels, per-lane.
+	 */
+	if (dp->set_voltages) {
+		/* Lane count verified previously. */
+		for (i = 0; i < dp->lanes; i++) {
+			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
+				return -EINVAL;
+
+			/* Sum of voltage swing and pre-emphasis levels cannot
+			 * exceed 3.
+			 */
+			if (dp->voltage[i] + dp->pre[i] > 3)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
 static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 				       u32 num_lanes)
@@ -250,6 +511,171 @@ static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
 }
 
+/* Configure lane count as required. */
+static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
+				     struct phy_configure_opts_dp *dp)
+{
+	u32 value;
+	u32 ret;
+	u8 lane_mask = (1 << dp->lanes) - 1;
+
+	value = cdns_torrent_dp_read(cdns_phy, PHY_RESET);
+	/* clear pma_tx_elec_idle_ln_* bits. */
+	value &= ~PMA_TX_ELEC_IDLE_MASK;
+	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
+	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
+		 PMA_TX_ELEC_IDLE_MASK;
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+
+	/* reset the link by asserting phy_l00_reset_n low */
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET,
+			      value & (~PHY_L00_RESET_N_MASK));
+
+	/*
+	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
+	 * and powered down when re-enabling the link
+	 */
+	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+
+	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
+
+	/* release phy_l0*_reset_n based on used laneCount */
+	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
+	cdns_torrent_dp_write(cdns_phy, PHY_RESET, value);
+
+	/* Wait, until PHY gets ready after releasing PHY reset signal. */
+	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	if (ret)
+		return ret;
+
+	ndelay(100);
+
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+
+	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
+
+	return ret;
+}
+
+/* Configure link rate as required. */
+static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
+				    struct phy_configure_opts_dp *dp)
+{
+	u32 ret;
+
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A3);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A2);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A0);
+	if (ret)
+		return ret;
+	ndelay(900);
+
+	return ret;
+}
+
+/* Configure voltage swing and pre-emphasis for all enabled lanes. */
+static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
+					 struct phy_configure_opts_dp *dp)
+{
+	u8 lane;
+	u16 val;
+	unsigned int lane_bits;
+
+	for (lane = 0; lane < dp->lanes; lane++) {
+		lane_bits = (lane & LANE_MASK) << 11;
+
+		val = cdns_torrent_phy_read(cdns_phy,
+					    (TX_DIAG_ACYA | lane_bits));
+		/*
+		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
+		 * current state of the analog TX driver.
+		 */
+		val |= TX_DIAG_ACYA_HBDC_MASK;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_DIAG_ACYA | lane_bits), val);
+
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_TXCC_CTRL | lane_bits), 0x08A4);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
+		cdns_torrent_phy_write(cdns_phy,
+				       (DRV_DIAG_TX_DRV | lane_bits), val);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_TXCC_MGNFS_MULT_000 | lane_bits),
+				       val);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_TXCC_CPOST_MULT_00 | lane_bits),
+				       val);
+
+		val = cdns_torrent_phy_read(cdns_phy,
+					    (TX_DIAG_ACYA | lane_bits));
+		/*
+		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
+		 * analog TX driver to reflect the new programmed one.
+		 */
+		val &= ~TX_DIAG_ACYA_HBDC_MASK;
+		cdns_torrent_phy_write(cdns_phy,
+				       (TX_DIAG_ACYA | lane_bits), val);
+	}
+};
+
+static int cdns_torrent_dp_configure(struct phy *phy,
+				     union phy_configure_opts *opts)
+{
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = cdns_torrent_dp_verify_config(cdns_phy, &opts->dp);
+	if (ret) {
+		dev_err(&phy->dev, "invalid params for phy configure\n");
+		return ret;
+	}
+
+	if (opts->dp.set_lanes) {
+		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
+		if (ret) {
+			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
+			return ret;
+		}
+	}
+
+	if (opts->dp.set_rate) {
+		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
+		if (ret) {
+			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
+			return ret;
+		}
+	}
+
+	if (opts->dp.set_voltages)
+		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
+
+	return ret;
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
@@ -321,7 +747,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_run(cdns_phy);
+	ret = cdns_torrent_dp_run(cdns_phy, cdns_phy->num_lanes);
 
 	return ret;
 }
@@ -898,7 +1324,7 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	return ret;
 }
 
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 {
 	unsigned int read_val;
 	int ret;
@@ -919,12 +1345,12 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 
 	ndelay(100);
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, cdns_phy->num_lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
 					      POWERSTATE_A2);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, cdns_phy->num_lanes,
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
 					      POWERSTATE_A0);
 
 	return ret;
-- 
2.20.1

