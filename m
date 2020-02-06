Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21A0214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LIPX6ygu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="aj93Kpvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBFGLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:55 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34080 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgBFGL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:28 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01667JQ5008121;
        Wed, 5 Feb 2020 22:11:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=sWHRG9gt3DTBAVjoT3KBaYz+vpJ/i09QReKXqTkN9bw=;
 b=LIPX6yguc/fTmzYmATinKGwnpyYuz9ns94f3Zmu6o771oEb6PdBTkSbnX/tLFcnARrWQ
 H2m4ZEdyu3cxxBP5jZPYZZ0NcnIpYwcATuWlq5niIQye/5Fm9BR9qG2ZCQIoTjH3HwrX
 3pl0l/EQwbv/9jI8ddYK8EkvITN/t4SMBpmZJQeUc7V5b8vXxVhpU4yw36WsyjQA7M0s
 XPyODDL8lREJnuzyruJhmMzn/kt+4oMGSW5Nlb2qH8b73lviy3fpuoyXWCId8AwzQgWs
 FkO0Jbg0azsBWb3gSa9P8QTNN6QFbsJYkPxyKRCjdDvQe+FiBDvIK4jOC4/YuT3qIfCH 9w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xyhkv5pje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiNYn4663WP+Lw4w0bF/nUe7yBE0DyZQd4hgERmGtkDOK4XByKh2WM33JpvpYpZcuoLZB/bdbkqHJjtEU6CHOEV+eGBNmTTM8SRlOLl5FK/NXrWM07UXnDOJvRW/c3TD9+kgZ0Y/Kd3sry+2j3TAvmrA+di8KOG0135n6G3aM3H1YEqpjifL/931Y01Hugds9oWF/Z4rDBNKQKp9DuecSshulUNKDdzbUJ/Q6xOPmzJIzn3QdIeMbCNezaEo9Hz2JgGI3wxVse5AtuBKv8o2u4PbjVmBoFF6hXSIC9aaab37YNRHonkzCcZZxKNUu4/8vnyQ7rG4jS5IfqbRJc7qrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWHRG9gt3DTBAVjoT3KBaYz+vpJ/i09QReKXqTkN9bw=;
 b=XDidZr7DnjWkuRX66meQi88OMM1ZmcfT6xb7m4f5ygIdRICpRqzy2I2h+T6BbHXD4lZhE6rQsHXFvXl48/71ehbHe+1qTgmsO+XqBpFiEL5VzqxnnvtZIpF1Fx6q64MdNSHr1rf+VHfK3hOfRN06d5cmowP85Mmkdnj4HOVG32//Qm71u4ZXx+h+U+99MnYw+2WWGzwgtFsiHmEp/N71vFpDc5pflNQ1gVEYq5sjkR4mRSLi6nut3uBSeaYAsP4Mp6iiGNuqLA+alAcg6Q6JpIdQfvLqE/YriAs2zQd6tiJX0M857hWv1O9MXQ4OxL+arzOsSrLDgOnb9wPflzMTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWHRG9gt3DTBAVjoT3KBaYz+vpJ/i09QReKXqTkN9bw=;
 b=aj93KpvoCc4Ps6BTE9AU4mKH1Bw8aWFuZ48WCUWHKJNnJrOWYUHdGpx/NdtULB9j5gLsFBZljklltCnpwOI8gGk8qd6uXrHUeJ31NPxc3zp2QmWCJ2pVufHSUcx3nMnxuFZN3yxJvqM5v8GRcVE5QElrO5CkCsyU/hlfjBaGEis=
Received: from BYAPR07CA0081.namprd07.prod.outlook.com (2603:10b6:a03:12b::22)
 by BYAPR07MB5160.namprd07.prod.outlook.com (2603:10b6:a03:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Thu, 6 Feb
 2020 06:11:14 +0000
Received: from MW2NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::202) by BYAPR07CA0081.outlook.office365.com
 (2603:10b6:a03:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:14 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT065.mail.protection.outlook.com (10.13.180.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F7174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:13 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3EI017050;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B3Tg017049;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 07/13] phy: cadence-torrent: Refactor code for reusability
Date:   Thu, 6 Feb 2020 07:10:55 +0100
Message-ID: <1580969461-16981-8-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36092001)(189003)(199004)(110136005)(336012)(26005)(36756003)(36906005)(54906003)(42186006)(70586007)(86362001)(356004)(6666004)(316002)(5660300002)(426003)(2616005)(70206006)(478600001)(81156014)(81166006)(8936002)(2906002)(8676002)(4326008)(186003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5160;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 059250c5-9b2a-4981-5987-08d7aacb5eec
X-MS-TrafficTypeDiagnostic: BYAPR07MB5160:
X-Microsoft-Antispam-PRVS: <BYAPR07MB51605A93D56BBAE7CB72DFF8D21D0@BYAPR07MB5160.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3cRj6M9tWwrnUzw04FH9Z1mGJ1BJi9tR7k8OHtmXEbFzw3O1u2j1Bi6/inYpKRphRoQUfDsPp5ABFrkSjsz1ac73L0QQJClBbItR/dZaMElr4+SbDbZuL28zIvknm3/YOy8Drlguez+Af4V4VUmv7YmOI1qNkR6YRhaSDmzUwbWBnokzSSLgGcxev/a2CR907cs3THG8Pt4pN215vtQfWA2tkgcb8Q3nG/OzcUw9uz0lAL1QzfYCF7u9iatvcI7U6zcsC1kJbmMivwHPASkNDQXLIjavnv3lnE3jtmFsvSslUyryyN1mAtwE0MKVgBdfD5VzL8Dwsnud3YaJYYYNH5cMhKIHYlm6CoX1fgl1kQTFDd1gs2/O80m24Gu6DoIFEVBO4uPUqcGHbNetYWKFjU6AsU9EAx+UxSY2lmCLZRftOXkyMntAAops5fxPNoig6hugUjWkHZ5hbyKnMDEgOv/W8k9Aw9+AOC/1JdC8eutcOXEKB+YryPEUZ28TVhs
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:14.3285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059250c5-9b2a-4981-5987-08d7aacb5eec
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add a separate function to set different power state values.
Use uniform polling timeout value. Also check return values
of functions for proper error handling.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 230 +++++++++++++---------
 1 file changed, 137 insertions(+), 93 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 5c7c185ddbfe..b180fbaa3f12 100644
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
2.20.1

