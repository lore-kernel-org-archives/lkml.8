Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F931C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB3E2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bhAXYF0k";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ri/GX2l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgH0QR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:17:26 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44048 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgH0QRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC8sW005495;
        Thu, 27 Aug 2020 09:17:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=BgOa/mwLZ9rbqjsR0854NlKCMepDbYICLTwrXNZgaZE=;
 b=bhAXYF0kzBHqdE5+zu6RLGP5Mzkoze+9ZpGu6opOJK8p5ceQ1rbD9WMJuleIxKTn9Ha1
 Vyz/h8GuXgQfzzS3DVVxOsKhMXLcEfPF3VCnJsI7rLwgX6RRPxiPWxNzRIZPon/O4S/L
 lJs5R9UbjPH/t5cDkNb2wRbmc+h3MHNWratKAHqlG5GUsh/sTgRils+hy/odxOasciNX
 09vvmKPT/6FqW/Bq6uhMcx+Cd3A8z5jX0FSzpBB7hbtY0OD8b55JK6SJs24h4ceb1U6b
 6fKRV9QJH0js88qezKEN0mYyhSYHXQmRZLzwo2aknrma7hWQP62OPo3dBTUhv9uhp4zp vw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i69my7r//UOTpnN6iQVqQv5z2ecFI8uhNQxjE+vQqfF+GRSjotvdnNN8mSAFWKbpmXK3ffjdJEsj6RzeH8ukfXka4Em91Dsp+751643By76kcTH6Qh5ajWQOi8uDSk57aNKvsBLZyKze9gJgzit86W5u9b1wGjgj+yhY6KORXPWVp3lqfYpIsa93DfXQhsnnkaRq20mo1aRgLqex5iCcISlxp0TWrixtqwEJBJlw9HkPg15YwcmcFtSZ1Oiv6tW3eo7TS66gmXPwwt/JZs2aCf+WHwt9KSdjViPk0FZm1T+00NJYCQEEagX10NbIxCghD+fUXanavb9q1xOfrHUKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgOa/mwLZ9rbqjsR0854NlKCMepDbYICLTwrXNZgaZE=;
 b=KdNhiBkbJ8dljTRpPF/wZcAUvmRJFb3eQQU0VV6WoPb2P+NVXz8/8twtfAFQ9lRmYQ+JjJijnrpmv7GeNeqNqEZ44eKHxqo8E5O78GZ1+Zy4VS8tsLbnOWVjB60IulsWF7Lin/H5WsAw+aJzpNYYaDAzcsLVXIgx4s925ofawPJ2oVWRrnHi6kRjs8ZHzhUNgehJ9Oc9gYuWNCP5dCFiRxZABvBEiBD4DwF7pMibXf7RNFleiPFySzjuD7knSsnWBqDfrXBvb7NlI56Rw/yODvNAS8998RU5cyZT42Xbabt1Ckmqo149lz/l2D2nDu4C6Jpzk/WqiTrb+dEzHFOkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgOa/mwLZ9rbqjsR0854NlKCMepDbYICLTwrXNZgaZE=;
 b=Ri/GX2l8r9D0zedxCJEg54QVuC33VcxwmQ1wSXYzQ707dTL5YMX60gYjt/C6mUOOxzmOvY6e7WAhhrl1PV49zYmnOn2AeycTZe0VmKB5YIB4W/pq04/vxgMzztbZ+cassQBuVb+gGaJDZwoJTmSnXfPeHicIkD0iRzDK1aiP9qo=
Received: from DM5PR22CA0011.namprd22.prod.outlook.com (2603:10b6:3:101::21)
 by BY5PR07MB6593.namprd07.prod.outlook.com (2603:10b6:a03:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 16:16:59 +0000
Received: from DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::11) by DM5PR22CA0011.outlook.office365.com
 (2603:10b6:3:101::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT040.mail.protection.outlook.com (10.13.179.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:16:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquG016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:16:55 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGqC6031819;
        Thu, 27 Aug 2020 18:16:52 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGq54031818;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 01/13] phy: cadence-torrent: Add single link PCIe support
Date:   Thu, 27 Aug 2020 18:16:39 +0200
Message-ID: <1598545011-31772-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d88505-0355-465e-227f-08d84aa49f01
X-MS-TrafficTypeDiagnostic: BY5PR07MB6593:
X-Microsoft-Antispam-PRVS: <BY5PR07MB65937C8A2B91CB364CA7EBD6C5550@BY5PR07MB6593.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwB9unUW9HDeeUa8Hq9KR8i9XJW2DJn9oi3xBIP7fnpT0VBKBOc/fziLQCDd3aW3phHpVwj7oMAboDFlhMbbqP2tpnXe9mIPTpMycZa7yfxKkTY1QDKCEpcXIIwvvmtVIhed+3vFGUMFfERDw4kcP8DkLc0GdgYWXbhPSst2mAWT/h7qXGdxpJmpCh27Iupga0t4m5pObPyIC9v49rgODWf/rPcWoWUGXJ6XQ+T/244AYToxbSDEWrhnIo+BomPl0asD9sSk0YMjzacG+WwYTtCqPQnRH/Z6V/Xy03J1B2ufZffvBo2YMLcKfA0FR3t682GyDbFexbayPOH0nAA1QKja7QmjePVg6UMc0E0jdDq+I4qE6jamAXhyfJkGyli49QfcJofHKWf28Jxb8nGxPjWZ/VB81/fFlexE1nmfrDA=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36092001)(46966005)(42186006)(36756003)(478600001)(83380400001)(110136005)(63350400001)(6666004)(26005)(54906003)(70586007)(47076004)(426003)(2906002)(186003)(86362001)(8676002)(81166007)(63370400001)(316002)(82740400003)(70206006)(2616005)(4326008)(30864003)(356005)(336012)(82310400002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:16:57.4629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d88505-0355-465e-227f-08d84aa49f01
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6593
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=990 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single link PCIe register sequences in Torrent PHY driver.
Also, add support for getting SSC type from DT.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 296 +++++++++++++++++++---
 1 file changed, 266 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ed2140691077..fcd1a2617f0a 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -28,6 +28,9 @@
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
+#define NUM_SSC_MODE		3
+#define NUM_PHY_TYPE		2
+
 #define POLL_TIMEOUT_US		5000
 
 #define TORRENT_COMMON_CDB_OFFSET	0x0
@@ -98,6 +101,14 @@
 #define CMN_PLL0_LOCK_REFCNT_START      0x009CU
 #define CMN_PLL0_LOCK_PLLCNT_START	0x009EU
 #define CMN_PLL0_LOCK_PLLCNT_THR        0x009FU
+#define CMN_PLL0_INTDIV_M1		0x00A0U
+#define CMN_PLL0_FRACDIVH_M1		0x00A2U
+#define CMN_PLL0_HIGH_THR_M1		0x00A3U
+#define CMN_PLL0_DSM_DIAG_M1		0x00A4U
+#define CMN_PLL0_SS_CTRL1_M1		0x00A8U
+#define CMN_PLL0_SS_CTRL2_M1		0x00A9U
+#define CMN_PLL0_SS_CTRL3_M1		0x00AAU
+#define CMN_PLL0_SS_CTRL4_M1		0x00ABU
 #define CMN_PLL1_VCOCAL_TCTRL		0x00C2U
 #define CMN_PLL1_VCOCAL_INIT_TMR	0x00C4U
 #define CMN_PLL1_VCOCAL_ITER_TMR	0x00C5U
@@ -130,8 +141,10 @@
 #define CMN_PDIAG_PLL0_CP_PADJ_M0	0x01A4U
 #define CMN_PDIAG_PLL0_CP_IADJ_M0	0x01A5U
 #define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x01A6U
+#define CMN_PDIAG_PLL0_CTRL_M1		0x01B0U
 #define CMN_PDIAG_PLL0_CP_PADJ_M1	0x01B4U
 #define CMN_PDIAG_PLL0_CP_IADJ_M1	0x01B5U
+#define CMN_PDIAG_PLL0_FILT_PADJ_M1	0x01B6U
 #define CMN_PDIAG_PLL1_CTRL_M0		0x01C0U
 #define CMN_PDIAG_PLL1_CLK_SEL_M0	0x01C1U
 #define CMN_PDIAG_PLL1_CP_PADJ_M0	0x01C4U
@@ -162,6 +175,9 @@
 #define RX_REE_GCSM1_CTRL		0x0108U
 #define RX_REE_GCSM2_CTRL		0x0110U
 #define RX_REE_PERGCSM_CTRL		0x0118U
+#define RX_REE_TAP1_CLIP		0x0171U
+#define RX_REE_TAP2TON_CLIP		0x0172U
+#define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
 #define PHY_PLL_CFG			0x000EU
@@ -182,12 +198,24 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+enum cdns_torrent_phy_type {
+	TYPE_DP,
+	TYPE_PCIE
+};
+
+enum cdns_torrent_ssc_mode {
+	NO_SSC,
+	EXTERNAL_SSC,
+	INTERNAL_SSC
+};
+
 struct cdns_torrent_inst {
 	struct phy *phy;
 	u32 mlane;
-	u32 phy_type;
+	enum cdns_torrent_phy_type phy_type;
 	u32 num_lanes;
 	struct reset_control *lnk_rst;
+	enum cdns_torrent_ssc_mode ssc_mode;
 };
 
 struct cdns_torrent_phy {
@@ -221,8 +249,9 @@ enum phy_powerstate {
 	POWERSTATE_A3 = 3,
 };
 
+static int cdns_torrent_phy_init(struct phy *phy);
+static int cdns_torrent_phy_exit(struct phy *phy);
 static int cdns_torrent_dp_init(struct phy *phy);
-static int cdns_torrent_dp_exit(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
 			       u32 num_lanes);
 static
@@ -252,17 +281,30 @@ static int cdns_torrent_phy_on(struct phy *phy);
 static int cdns_torrent_phy_off(struct phy *phy);
 
 static const struct phy_ops cdns_torrent_phy_ops = {
-	.init		= cdns_torrent_dp_init,
-	.exit		= cdns_torrent_dp_exit,
+	.init		= cdns_torrent_phy_init,
+	.exit		= cdns_torrent_phy_exit,
 	.configure	= cdns_torrent_dp_configure,
 	.power_on	= cdns_torrent_phy_on,
 	.power_off	= cdns_torrent_phy_off,
 	.owner		= THIS_MODULE,
 };
 
+struct cdns_reg_pairs {
+	u32 val;
+	u32 off;
+};
+
+struct cdns_torrent_vals {
+	struct cdns_reg_pairs *reg_pairs;
+	u32 num_regs;
+};
+
 struct cdns_torrent_data {
-		u8 block_offset_shift;
-		u8 reg_offset_shift;
+	u8 block_offset_shift;
+	u8 reg_offset_shift;
+	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -846,19 +888,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	ret = clk_prepare_enable(cdns_phy->clk);
-	if (ret) {
-		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
-		return ret;
-	}
-
-	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
-	if (!(cdns_phy->ref_clk_rate)) {
-		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
-		clk_disable_unprepare(cdns_phy->clk);
-		return -EINVAL;
-	}
-
 	switch (cdns_phy->ref_clk_rate) {
 	case REF_CLK_19_2MHz:
 	case REF_CLK_25MHz:
@@ -918,7 +947,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-static int cdns_torrent_dp_exit(struct phy *phy)
+static int cdns_torrent_phy_exit(struct phy *phy)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 
@@ -1725,6 +1754,74 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
+static int cdns_torrent_phy_init(struct phy *phy)
+{
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	enum cdns_torrent_phy_type phy_type = inst->phy_type;
+	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
+	struct cdns_reg_pairs *reg_pairs;
+	struct regmap *regmap;
+	u32 num_regs;
+	int ret, i, j;
+
+	ret = clk_prepare_enable(cdns_phy->clk);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
+		return ret;
+	}
+
+	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
+	if (!(cdns_phy->ref_clk_rate)) {
+		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
+		clk_disable_unprepare(cdns_phy->clk);
+		return -EINVAL;
+	}
+
+	if (phy_type == TYPE_DP)
+		return cdns_torrent_dp_init(phy);
+
+	/* PMA common registers configurations */
+	cmn_vals = cdns_phy->init_data->cmn_vals[phy_type][ssc];
+	if (cmn_vals) {
+		reg_pairs = cmn_vals->reg_pairs;
+		num_regs = cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
+	/* PMA TX lane registers configurations */
+	tx_ln_vals = cdns_phy->init_data->tx_ln_vals[phy_type][ssc];
+	if (tx_ln_vals) {
+		reg_pairs = tx_ln_vals->reg_pairs;
+		num_regs = tx_ln_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_tx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
+	/* PMA RX lane registers configurations */
+	rx_ln_vals = cdns_phy->init_data->rx_ln_vals[phy_type][ssc];
+	if (rx_ln_vals) {
+		reg_pairs = rx_ln_vals->reg_pairs;
+		num_regs = rx_ln_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_rx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_torrent_phy *cdns_phy;
@@ -1736,6 +1833,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	int ret, subnodes, node = 0, i;
 	u32 total_num_lanes = 0;
 	u8 init_dp_regmap = 0;
+	u32 phy_type;
 
 	/* Get init data for this PHY */
 	data = of_device_get_match_data(dev);
@@ -1801,14 +1899,26 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		if (of_property_read_u32(child, "cdns,phy-type",
-					 &cdns_phy->phys[node].phy_type)) {
+		if (of_property_read_u32(child, "cdns,phy-type", &phy_type)) {
 			dev_err(dev, "%s: No \"cdns,phy-type\"-property.\n",
 				child->full_name);
 			ret = -EINVAL;
 			goto put_child;
 		}
 
+		switch (phy_type) {
+		case PHY_TYPE_PCIE:
+			cdns_phy->phys[node].phy_type = TYPE_PCIE;
+			break;
+		case PHY_TYPE_DP:
+			cdns_phy->phys[node].phy_type = TYPE_DP;
+			break;
+		default:
+			dev_err(dev, "Unsupported protocol\n");
+			ret = -EINVAL;
+			goto put_child;
+		}
+
 		if (of_property_read_u32(child, "cdns,num-lanes",
 					 &cdns_phy->phys[node].num_lanes)) {
 			dev_err(dev, "%s: No \"cdns,num-lanes\"-property.\n",
@@ -1819,7 +1929,18 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 
 		total_num_lanes += cdns_phy->phys[node].num_lanes;
 
-		if (cdns_phy->phys[node].phy_type == PHY_TYPE_DP) {
+		/* Get SSC mode */
+		cdns_phy->phys[node].ssc_mode = NO_SSC;
+		of_property_read_u32(child, "cdns,ssc-mode",
+				     &cdns_phy->phys[node].ssc_mode);
+
+		gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
+		if (IS_ERR(gphy)) {
+			ret = PTR_ERR(gphy);
+			goto put_child;
+		}
+
+		if (cdns_phy->phys[node].phy_type == TYPE_DP) {
 			switch (cdns_phy->phys[node].num_lanes) {
 			case 1:
 			case 2:
@@ -1862,13 +1983,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				goto put_child;
 			}
 
-			gphy = devm_phy_create(dev, child,
-					       &cdns_torrent_phy_ops);
-			if (IS_ERR(gphy)) {
-				ret = PTR_ERR(gphy);
-				goto put_child;
-			}
-
 			if (!init_dp_regmap) {
 				ret = cdns_torrent_dp_regmap_init(cdns_phy);
 				if (ret)
@@ -1892,6 +2006,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 
 			phy_set_attrs(gphy, &torrent_attr);
 		}
+
 		cdns_phy->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
 
@@ -1935,14 +2050,135 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Single link PCIe, 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs sl_pcie_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M1},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M1},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M1},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M1},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0050, CMN_PLL0_INTDIV_M1},
+	{0x0050, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M1},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0036, CMN_PLL0_HIGH_THR_M1},
+	{0x0036, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M1},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M1},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M1},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x0058, CMN_PLL0_SS_CTRL3_M1},
+	{0x0058, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x0012, CMN_PLL0_SS_CTRL4_M1},
+	{0x0012, CMN_PLL1_SS_CTRL4_M0},
+	{0x0C5E, CMN_PLL0_VCOCAL_REFTIM_START},
+	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
+	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
+	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
+	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
+	{0x00C7, CMN_PLL1_LOCK_PLLCNT_START},
+	{0x0005, CMN_PLL0_LOCK_PLLCNT_THR},
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
+};
+
+static struct cdns_torrent_vals sl_pcie_100_int_ssc_cmn_vals = {
+	.reg_pairs = sl_pcie_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_pcie_100_int_ssc_cmn_regs),
+};
+
+/* PCIe, 100 MHz Ref clk, no SSC & external SSC */
+static struct cdns_reg_pairs pcie_100_ext_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs pcie_100_ext_no_ssc_rx_ln_regs[] = {
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x0001, RX_DIAG_ACYA}
+};
+
+static struct cdns_torrent_vals pcie_100_no_ssc_cmn_vals = {
+	.reg_pairs = pcie_100_ext_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = pcie_100_ext_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_rx_ln_regs),
+};
+
 static const struct cdns_torrent_data cdns_map_torrent = {
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.cmn_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		},
+	},
+	.tx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = NULL,
+			[EXTERNAL_SSC] = NULL,
+			[INTERNAL_SSC] = NULL,
+		},
+	},
+	.rx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		},
+	},
 };
 
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.cmn_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		},
+	},
+	.tx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = NULL,
+			[EXTERNAL_SSC] = NULL,
+			[INTERNAL_SSC] = NULL,
+		},
+	},
+	.rx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		},
+	},
 };
 
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
-- 
2.26.1

