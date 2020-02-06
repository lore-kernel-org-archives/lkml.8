Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30981C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0FC21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ea5cefxS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="l0bI3y7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBFGMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:12:16 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60346 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbgBFGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:25 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669Nas016381;
        Wed, 5 Feb 2020 22:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=vwyooUQ9UUoBBsFvdfCcySILbYzHP50VoWTwqK3TKCU=;
 b=Ea5cefxSH7Ide27gYk1CAp2qYr9Ahqss2pdjDmjmtqpnn0Ix58MW68uXY4IHU4Sb7M0b
 +M50mw7L3fC17MUGeMV4vM7t4beHGSUpAv6DjBM7UggqX8R8adloEiinqghf9/bMK/Z5
 dlJhfTegQjSG3R7oW3iNUPQ0jPYyU4J7dc/Cydy47B6y6pWgcjWcOYzl9hV4WSDc53Jw
 8oxzrmVm5Zd7wHILabp2bderquhFFZWPxTNTwi15SoP6NBUzHYq4o5rxlr8qcX97xlK0
 9H9st4n1sVeA3YH/ChE4wscQwRLPJbzOt1fQdMF1TijlkOpprXqz9zDgCn6kmyxuhH0O QA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunrar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtkuLCWqqP4LlCRdhXaiptPJNcIdY5e3h15PRmcenPjorg6JIrLZZRX6fg80mZ1VHBOFd2J8p+WvSs/m986o+vYIJ/6pD2fZKxXD7Ftu3tetbYx+w5NsMGerr6W44XUt75eIvRux/UjKxPpPIlIfaDWyCdqqcQAD3zGEljDYHwYtoiV1Bt9wdw1QXBvZMeyKtyCWghQayXvTsKamXmyx86DfbD8loZC3lfv0c1lzUqyl3SJ0koVWNAK1u9IFEpDgB8TY2GG1rOxDZcA1+mrhaaSD48F0xPP7RpdcKIsAf5ETpYikqC+koe9uq69QElAD7r4Nbj2aVGIGYTjNc/MiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwyooUQ9UUoBBsFvdfCcySILbYzHP50VoWTwqK3TKCU=;
 b=bHKUn17lzVLGz8OgbjAiZeEhO0CrToAqWit7X8X/Bfxu1fpkkgtFoX8CrYxOfkXe+OEkyrMh7/z+Rsq71M7vuh+HCttPYVXtg74zc8E7Lro9kcugJjrWJl4A6FAgI7K38kqhvVhpPwnKCSX0Fx3nIGQfHnHuZQmlT4Pmd9O/MMdlibqJKfq5IO53Yn7mJxqsiWtJMQZBQkELuNGqq6xcJF1XqONgQqzc3tPXxFd21yBtL/GFWDyYJW57fe0PoQyxzp+6OXuG48aFcZEDTdgkxjZmnegLWb9l+t2B2+GnFMRWNG0+6Eoz8oGT3F0qLiOTnMWbmf9kGncFCxrG5Sw22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwyooUQ9UUoBBsFvdfCcySILbYzHP50VoWTwqK3TKCU=;
 b=l0bI3y7W9W6fZ/br9OxDx3iZnWUIUMKoVDctSnz73LISbCLgw0rkJ1HiZcpzhyWKYkAG6NH2R0QrBAL8+nH6V0Anzw5oh8me7PBEBI11dWqGL5ClCtgQCf6sWXUbCFobghskk/xm5vrCW1dgQvmggjNvy/XtBkra5EVUQjgrdxA=
Received: from DM5PR07CA0096.namprd07.prod.outlook.com (2603:10b6:4:ae::25) by
 BYAPR07MB5912.namprd07.prod.outlook.com (2603:10b6:a03:138::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.33; Thu, 6 Feb
 2020 06:11:13 +0000
Received: from BN8NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::201) by DM5PR07CA0096.outlook.office365.com
 (2603:10b6:4:ae::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 BN8NAM12FT053.mail.protection.outlook.com (10.13.182.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5Ex174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:06 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3kq017037;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B3HD017036;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 04/13] phy: cadence-torrent: Adopt Torrent nomenclature
Date:   Thu, 6 Feb 2020 07:10:52 +0100
Message-ID: <1580969461-16981-5-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(36092001)(336012)(26005)(6666004)(86362001)(356004)(186003)(478600001)(2616005)(2906002)(54906003)(42186006)(426003)(36756003)(5660300002)(81166006)(8676002)(4326008)(81156014)(36906005)(316002)(110136005)(70586007)(70206006)(8936002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5912;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 935a0fb3-3219-4a5c-dfb7-08d7aacb5ced
X-MS-TrafficTypeDiagnostic: BYAPR07MB5912:
X-Microsoft-Antispam-PRVS: <BYAPR07MB59126903C85F55DFD4BBA965D21D0@BYAPR07MB5912.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lhN2svxQaTRvqZYXQ2gtISJMKgKYQkx9EVqzHk3OlHOhABLIEGfPxZKwpVSXzc5PqO3nDQvkv2XxMGYz7qwNAwg7vhIudl2zDKOnLhol1CfWDrqO29aEBUXCktkSUHyF2eoHKDy/vJGQqHYCLjK+bO9eykv2UmYhoonyGjw1bkqI1td8qrRkf1Fg8rupL/eymK/jwEnK+rMa5YkwIrnUyN3wvetN/1Y5ArC+H0nbz9ex4cNl/3UBB9yHWm6XqRG6vkxbHvh0/exLckCUWQz5ZpFkjH8fZaKsil1mPPdSYpOfEFveyTaTGeoFtf8buKqMK1G6hCJbR8xW0RZye5u9HxAbnwCT/UrUps0PKVjUtT3a4dojt1sAV3ab0nXOI+DiHnwNcmA6na4dmBW+o9XXWkzo0dMQYc6B60ZNfXyIaC58is/E7sTZLN0yoNvJXofe7iRVNFgDxbGXsCSN+vOYzctAVYaokabhBL3GqQ26M0NG+CFJld84i+sMa/Fo5WK
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:10.8871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935a0fb3-3219-4a5c-dfb7-08d7aacb5ced
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5912
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

- Change private data struct cdns_dp_phy to cdns_torrent_phy
- Change module description and registration accordingly
- Generic torrent functions have prefix cdns_torrent_phy_*
- Functions specific to Torrent phy for DisplayPort are prefixed as
  cdns_torrent_dp_*

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 111 +++++++++++-----------
 1 file changed, 58 insertions(+), 53 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index beb80f71a34a..eb61005077ab 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Cadence MHDP DisplayPort SD0801 PHY driver.
+ * Cadence Torrent SD0801 PHY driver.
  *
  * Copyright 2018 Cadence Design Systems, Inc.
  *
@@ -101,7 +101,7 @@
 #define RX_PSC_A3			0x2000c
 #define PHY_PLL_CFG			0x30038
 
-struct cdns_dp_phy {
+struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 num_lanes; /* Number of lanes to use */
@@ -109,36 +109,39 @@ struct cdns_dp_phy {
 	struct device *dev;
 };
 
-static int cdns_dp_phy_init(struct phy *phy);
-static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+static int cdns_torrent_dp_init(struct phy *phy);
+static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy);
+static
+void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
+static
+void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane);
-static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy);
-static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
-					unsigned int offset,
-					unsigned char start_bit,
-					unsigned char num_bits,
-					unsigned int val);
-
-static const struct phy_ops cdns_dp_phy_ops = {
-	.init		= cdns_dp_phy_init,
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy);
+static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
+				    unsigned int offset,
+				    unsigned char start_bit,
+				    unsigned char num_bits,
+				    unsigned int val);
+
+static const struct phy_ops cdns_torrent_phy_ops = {
+	.init		= cdns_torrent_dp_init,
 	.owner		= THIS_MODULE,
 };
 
-static int cdns_dp_phy_init(struct phy *phy)
+static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
 
-	struct cdns_dp_phy *cdns_phy = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
 
 	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
-	cdns_dp_phy_pma_cfg(cdns_phy);
+	cdns_torrent_dp_pma_cfg(cdns_phy);
 
 	/*
 	 * Set lines power state to A0
@@ -185,24 +188,25 @@ static int cdns_dp_phy_init(struct phy *phy)
 	 */
 	lane_bits = (1 << cdns_phy->num_lanes) - 1;
 	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
-		   cdns_phy->base + PHY_RESET);
+	       cdns_phy->base + PHY_RESET);
 
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
 	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
 
 	/* PHY PMA registers configuration functions */
-	cdns_dp_phy_pma_cmn_vco_cfg_25mhz(cdns_phy);
-	cdns_dp_phy_pma_cmn_rate(cdns_phy);
+	cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy);
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy);
 
 	/* take out of reset */
 	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
-	cdns_dp_phy_wait_pma_cmn_ready(cdns_phy);
-	cdns_dp_phy_run(cdns_phy);
+	cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	cdns_torrent_dp_run(cdns_phy);
 
 	return 0;
 }
 
-static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
+static
+void cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
@@ -214,19 +218,20 @@ static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
 			"timeout waiting for PMA common ready\n");
 }
 
-static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy)
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int i;
 
 	/* PMA common configuration */
-	cdns_dp_phy_pma_cmn_cfg_25mhz(cdns_phy);
+	cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++)
-		cdns_dp_phy_pma_lane_cfg(cdns_phy, i);
+		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
 }
 
-static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+static
+void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* refclock registers - assumes 25 MHz refclock */
 	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
@@ -259,7 +264,8 @@ static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
 	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
 }
 
-static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* Assumes 25 MHz refclock */
 	switch (cdns_phy->max_bit_rate) {
@@ -300,7 +306,7 @@ static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
 	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
 }
 
-static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int clk_sel_val = 0;
 	unsigned int hsclk_div_val = 0;
@@ -340,12 +346,12 @@ static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
 	/* PMA lane configuration to deal with multi-link operation */
 	for (i = 0; i < cdns_phy->num_lanes; i++) {
 		writel(hsclk_div_val,
-		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i<<11)));
+		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i << 11)));
 	}
 }
 
-static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
-				     unsigned int lane)
+static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
+					 unsigned int lane)
 {
 	unsigned int lane_bits = (lane & LANE_MASK) << 11;
 
@@ -361,7 +367,7 @@ static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
 	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
 }
 
-static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
+static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int read_val;
 	u32 write_val1 = 0;
@@ -382,7 +388,6 @@ static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
 	ndelay(100);
 
 	switch (cdns_phy->num_lanes) {
-
 	case 1:	/* lane 0 */
 		write_val1 = 0x00000004;
 		write_val2 = 0x00000001;
@@ -425,7 +430,7 @@ static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
 	ndelay(100);
 }
 
-static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+static void cdns_dp_phy_write_field(struct cdns_torrent_phy *cdns_phy,
 				    unsigned int offset,
 				    unsigned char start_bit,
 				    unsigned char num_bits,
@@ -438,10 +443,10 @@ static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
 		start_bit))), cdns_phy->base + offset);
 }
 
-static int cdns_dp_phy_probe(struct platform_device *pdev)
+static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
-	struct cdns_dp_phy *cdns_phy;
+	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct phy *phy;
@@ -453,9 +458,9 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 
 	cdns_phy->dev = &pdev->dev;
 
-	phy = devm_phy_create(dev, NULL, &cdns_dp_phy_ops);
+	phy = devm_phy_create(dev, NULL, &cdns_torrent_phy_ops);
 	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create DisplayPort PHY\n");
+		dev_err(dev, "failed to create Torrent PHY\n");
 		return PTR_ERR(phy);
 	}
 
@@ -470,7 +475,7 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->sd_base);
 
 	err = device_property_read_u32(dev, "num_lanes",
-				       &(cdns_phy->num_lanes));
+				       &cdns_phy->num_lanes);
 	if (err)
 		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
 
@@ -487,7 +492,7 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 	}
 
 	err = device_property_read_u32(dev, "max_bit_rate",
-		   &(cdns_phy->max_bit_rate));
+				       &cdns_phy->max_bit_rate);
 	if (err)
 		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
 
@@ -519,23 +524,23 @@ static int cdns_dp_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static const struct of_device_id cdns_dp_phy_of_match[] = {
+static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy"
 	},
 	{}
 };
-MODULE_DEVICE_TABLE(of, cdns_dp_phy_of_match);
+MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
 
-static struct platform_driver cdns_dp_phy_driver = {
-	.probe	= cdns_dp_phy_probe,
+static struct platform_driver cdns_torrent_phy_driver = {
+	.probe	= cdns_torrent_phy_probe,
 	.driver = {
-		.name	= "cdns-dp-phy",
-		.of_match_table	= cdns_dp_phy_of_match,
+		.name	= "cdns-torrent-phy",
+		.of_match_table	= cdns_torrent_phy_of_match,
 	}
 };
-module_platform_driver(cdns_dp_phy_driver);
+module_platform_driver(cdns_torrent_phy_driver);
 
 MODULE_AUTHOR("Cadence Design Systems, Inc.");
-MODULE_DESCRIPTION("Cadence MHDP PHY driver");
+MODULE_DESCRIPTION("Cadence Torrent PHY driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

