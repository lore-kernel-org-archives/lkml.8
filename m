Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539BAC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298AC2468B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hsiPPPbO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tETPDNQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgAVKpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:45:42 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56532 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729066AbgAVKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:39 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAipjr016477;
        Wed, 22 Jan 2020 02:45:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=2jrrthqidaIPvK7iaIgnUE69C0Z7MDg7V6EglWzhoo8=;
 b=hsiPPPbOM94yvw4UPMB8KcV4QjCrv3iP1NlbvT6dJpWFr0xX/dzkZ+1SEJ93Z2thSjJz
 vDEOPvB7MRLtCa8iRYkEAY0kJCJK/a4gItKu6wgn/Da+ag1uo6AcBCGh/ryBTNC0k7Vt
 DxrYgGbr+ftplScIBmgcAIDHZg+09/N5WRsXc1/FKXTqaitnUfw4kJGL5L4I8z6Ox9J7
 N1zCuhLOqBiE+eBnqWRKoMQNCtP+DOkWtrrfOPn2YrqOhWy+9uSBiBBJOqUzkpRrnB29
 EGsf3zy10CP1VDcgvmbdav34wtnUlwYmXtMnsZ1FGLySsI479jwffOAzgfJhLaBVfXZ6 rQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3vsss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmRoGSU5sHvKX/+u8x5O3qsYV2onhm3Bd16nPJqxqYX2vyBUKojQR7cNDbl1hm52otAy1gY2VoYfieIFBzCxhUj6B3YoVI8l4mBRX4X/GKp4ocvZA6CZ0K4FnBhWY2blhq49k+M0LQWVvwK0vojezcUY6NTq215v4h7RuDOSp/dYZIC2KLKl8eCgDhoskvhkED35NCOClmsBL8tGWcPOXRweMoYgQsbM7c+ERzFRSqSIYklU7Kf3ly4mLJPx3z/s/GqyR+7MWQ5U3Wq9/mFL+soB9Od4hJOCM+c+gvf0cx1OVacFUiFL+/s2AjUBw7A3g/kcHisdGE0kLA/xDu33SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jrrthqidaIPvK7iaIgnUE69C0Z7MDg7V6EglWzhoo8=;
 b=VTzRXrNLFp73q7GzgIsUOKRgB8X/d+NWD/iUy3a3DL75+Vj9EOfKe5y+Q/1zdF9WoUHSLSt33Jn3oqrKc2Djy8yFl15opIP8Kc0PXIjQGlDCqjnV7u3mGAOPbo0W1DC9Njw3ik1h0FOSMV904bOTTy+LmGl8Bqvr7Ag9cxsC2AmPLSFlYxdwfY+yWaW2e26DftwYCYDlF4WH7RXTSB8Z0ZtFDOKDPSpeGtmZIzT/M11MTXLd3jys/egQ6D7+917y2D9DY0vTpjJAAgvlXlZti4HCqpkDlOVYanoCAZQ6jbzC+ejcO+ugja2Q2P9tgXlJ6AtFEocltyzb9IyJ+f+a1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jrrthqidaIPvK7iaIgnUE69C0Z7MDg7V6EglWzhoo8=;
 b=tETPDNQooaAY9VEIgK+inVS49e0Yz+lmWJuGDPDG19Sthw5if7lkmZ4JyY+kpqycw+rrNqeltLLqc0Q2Ug963irR6w5u9h9yBg2qcYVwbC2Y95PYme8swhN+pUJpsTUAqbPHMVGyYS7GUQLIWj+Wy0cdG3JmIZjfGiYFyIkRA7E=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by BN3PR07MB2499.namprd07.prod.outlook.com (2a01:111:e400:c5f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.24; Wed, 22 Jan
 2020 10:45:26 +0000
Received: from DM6NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::200) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT059.mail.protection.outlook.com (10.13.179.1) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBF001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjLbi007260;
        Wed, 22 Jan 2020 11:45:21 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjLG9007259;
        Wed, 22 Jan 2020 11:45:21 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 06/14] phy: cadence-torrent: Refactor code for reusability
Date:   Wed, 22 Jan 2020 11:45:10 +0100
Message-ID: <1579689918-7181-7-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(36092001)(2906002)(246002)(86362001)(7636002)(6666004)(5660300002)(356004)(426003)(336012)(70206006)(107886003)(186003)(2616005)(8936002)(478600001)(8676002)(70586007)(316002)(110136005)(26826003)(54906003)(26005)(4326008)(42186006)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2499;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69fd411c-2daf-4a7e-84f5-08d79f28311d
X-MS-TrafficTypeDiagnostic: BN3PR07MB2499:
X-Microsoft-Antispam-PRVS: <BN3PR07MB2499C0417F2E74FB25960119D20C0@BN3PR07MB2499.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgx5lKhZyyp6P+D5xeXIsiuQ1pwpgLwHMXK0z+pMiqTgAczpWCOiFufjPYm4S9CPPQbIHz6A4D+XT3LKWNZuFA2YCHJD6fVNDARMqZoAGbIqKlUMpRrIoV2CtnXH07ZvjP6nPeZ3Hdgqc1Tb4L+FkYfptI+UtqNcRrRyksKUMxaAUemv5JElxRb+QXW3XUS4OPB2cgfveZNO7virx3aFJJX0JnzXbQVBjnx+Is3VPLtcDsE5pt7Qs/ZXi0wx0L1NnabMGqUpyCYEPBbHsZ/RLVfoNmK/OX9FVD79dh8T8EyWoT+roEYHzFZ9b1AI/+waOgXTysIcw4+8WwuZnJOAEi4E5E9yCKQQzdXDqnDncy6+QgGrkBqqDbYgmyCI7k1dWThiKJOlSBNBDGlKTUCDPxH8noVl5mFQ9P/EeLnfP+wk/b3f57c3iNBkUYvPqr25soqb0nuPRYFS9wd4lThWPKDioOS4Mr0KE318FGBEWW/ozMeAzdEylGXY7OWDvPAz
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:26.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fd411c-2daf-4a7e-84f5-08d79f28311d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2499
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add a separate function to set different power state values.
Use uniform polling timeout value. Also check return values
of functions for proper error handling.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 230 ++++++++++++++++++------------
 1 file changed, 137 insertions(+), 93 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 5c7c185..b180fba 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -22,7 +22,7 @@
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
-#define POLL_TIMEOUT_US		2000
+#define POLL_TIMEOUT_US		5000
 #define LANE_MASK		0x7
 
 /*
@@ -39,6 +39,7 @@
 #define PHY_POWER_STATE_LN_1	0x0008
 #define PHY_POWER_STATE_LN_2	0x0010
 #define PHY_POWER_STATE_LN_3	0x0018
+#define PMA_XCVR_POWER_STATE_REQ_LN_MASK	0x3FU
 #define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
 #define PHY_PMA_CMN_READY		0x34
 #define PHY_PMA_XCVR_TX_VMARGIN		0x38
@@ -109,10 +110,17 @@ struct cdns_torrent_phy {
 	struct device *dev;
 };
 
+enum phy_powerstate {
+	POWERSTATE_A0 = 0,
+	/* Powerstate A1 is unused */
+	POWERSTATE_A2 = 2,
+	POWERSTATE_A3 = 3,
+};
+
 static int cdns_torrent_dp_init(struct phy *phy);
-static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
 static
-void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
+int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
 static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
@@ -158,9 +166,46 @@ static u32 cdns_torrent_dp_read(struct cdns_torrent_phy *cdns_phy, u32 offset)
 	readl_poll_timeout((cdns_phy)->base + (offset), \
 			   val, cond, delay_us, timeout_us)
 
+/* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
+static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
+				       u32 num_lanes)
+{
+	u32 pwr_state = cdns_torrent_dp_read(cdns_phy,
+					     PHY_PMA_XCVR_POWER_STATE_REQ);
+	u32 pll_clk_en = cdns_torrent_dp_read(cdns_phy,
+					      PHY_PMA_XCVR_PLLCLK_EN);
+
+	/* Lane 0 is always enabled. */
+	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+		       PHY_POWER_STATE_LN_0);
+	pll_clk_en &= ~0x01U;
+
+	if (num_lanes > 1) {
+		/* lane 1 */
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_1);
+		pll_clk_en &= ~(0x01U << 1);
+	}
+
+	if (num_lanes > 2) {
+		/* lanes 2 and 3 */
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_2);
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_3);
+		pll_clk_en &= ~(0x01U << 2);
+		pll_clk_en &= ~(0x01U << 3);
+	}
+
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
+	int ret;
 
 	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
@@ -173,40 +218,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
 	 */
-
-	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ,
-				PHY_POWER_STATE_LN_0, 6, 0x0000);
-
-	if (cdns_phy->num_lanes >= 2) {
-		cdns_dp_phy_write_field(cdns_phy,
-					PHY_PMA_XCVR_POWER_STATE_REQ,
-					PHY_POWER_STATE_LN_1, 6, 0x0000);
-
-		if (cdns_phy->num_lanes == 4) {
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_REQ,
-						PHY_POWER_STATE_LN_2, 6, 0);
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_REQ,
-						PHY_POWER_STATE_LN_3, 6, 0);
-		}
-	}
-
-	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
-				0, 1, 0x0000);
-
-	if (cdns_phy->num_lanes >= 2) {
-		cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
-					1, 1, 0x0000);
-		if (cdns_phy->num_lanes == 4) {
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN,
-						2, 1, 0x0000);
-			cdns_dp_phy_write_field(cdns_phy,
-						PHY_PMA_XCVR_PLLCLK_EN,
-						3, 1, 0x0000);
-		}
-	}
+	cdns_torrent_dp_set_a0_pll(cdns_phy, cdns_phy->num_lanes);
 
 	/*
 	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
@@ -225,23 +237,31 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* take out of reset */
 	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
-	cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
-	cdns_torrent_dp_run(cdns_phy);
+	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = cdns_torrent_dp_run(cdns_phy);
+
+	return ret;
 }
 
 static
-void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
+int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
 
 	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy, PHY_PMA_CMN_READY,
-						reg, reg & 1, 0, 500);
-	if (ret == -ETIMEDOUT)
+						reg, reg & 1, 0,
+						POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for PMA common ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
@@ -397,12 +417,73 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
 }
 
-static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   u32 num_lanes,
+					   enum phy_powerstate powerstate)
+{
+	/* Register value for power state for a single byte. */
+	u32 value_part;
+	u32 value;
+	u32 mask;
+	u32 read_val;
+	u32 ret;
+
+	switch (powerstate) {
+	case (POWERSTATE_A0):
+		value_part = 0x01U;
+		break;
+	case (POWERSTATE_A2):
+		value_part = 0x04U;
+		break;
+	default:
+		/* Powerstate A3 */
+		value_part = 0x08U;
+		break;
+	}
+
+	/* Select values of registers and mask, depending on enabled
+	 * lane count.
+	 */
+	switch (num_lanes) {
+	/* lane 0 */
+	case (1):
+		value = value_part;
+		mask = 0x0000003FU;
+		break;
+	/* lanes 0-1 */
+	case (2):
+		value = (value_part
+			 | (value_part << 8));
+		mask = 0x00003F3FU;
+		break;
+	/* lanes 0-3, all */
+	default:
+		value = (value_part
+			 | (value_part << 8)
+			 | (value_part << 16)
+			 | (value_part << 24));
+		mask = 0x3F3F3F3FU;
+		break;
+	}
+
+	/* Set power state A<n>. */
+	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, value);
+	/* Wait, until PHY acknowledges power state completion. */
+	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_ACK,
+						read_val,
+						(read_val & mask) == value, 0,
+						POLL_TIMEOUT_US);
+	cdns_torrent_dp_write(cdns_phy,
+			      PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
+	ndelay(100);
+
+	return ret;
+}
+
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int read_val;
-	u32 write_val1 = 0;
-	u32 write_val2 = 0;
-	u32 mask = 0;
 	int ret;
 
 	/*
@@ -413,60 +494,23 @@ static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 						PHY_PMA_XCVR_PLLCLK_EN_ACK,
 						read_val, read_val & 1, 0,
 						POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT)
+	if (ret == -ETIMEDOUT) {
 		dev_err(cdns_phy->dev,
 			"timeout waiting for link PLL clock enable ack\n");
-
-	ndelay(100);
-
-	switch (cdns_phy->num_lanes) {
-	case 1:	/* lane 0 */
-		write_val1 = 0x00000004;
-		write_val2 = 0x00000001;
-		mask = 0x0000003f;
-		break;
-	case 2: /* lane 0-1 */
-		write_val1 = 0x00000404;
-		write_val2 = 0x00000101;
-		mask = 0x00003f3f;
-		break;
-	case 4: /* lane 0-3 */
-		write_val1 = 0x04040404;
-		write_val2 = 0x01010101;
-		mask = 0x3f3f3f3f;
-		break;
+		return ret;
 	}
 
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val1);
-
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_ACK,
-						read_val,
-						(read_val & mask) == write_val1,
-						0, POLL_TIMEOUT_US);
-
-	if (ret == -ETIMEDOUT)
-		dev_err(cdns_phy->dev,
-			"timeout waiting for link power state ack\n");
-
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
 	ndelay(100);
 
-	cdns_torrent_dp_write(cdns_phy,
-			      PHY_PMA_XCVR_POWER_STATE_REQ, write_val2);
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, cdns_phy->num_lanes,
+					      POWERSTATE_A2);
+	if (ret)
+		return ret;
 
-	ret = cdns_torrent_dp_read_poll_timeout(cdns_phy,
-						PHY_PMA_XCVR_POWER_STATE_ACK,
-						read_val,
-						(read_val & mask) == write_val2,
-						0, POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT)
-		dev_err(cdns_phy->dev,
-			"timeout waiting for link power state ack\n");
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, cdns_phy->num_lanes,
+					      POWERSTATE_A0);
 
-	cdns_torrent_dp_write(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ, 0);
-	ndelay(100);
+	return ret;
 }
 
 static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
-- 
2.4.5

