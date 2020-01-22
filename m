Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1ACC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A962467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ekgdRp2w";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wmACBUH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgAVKq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:46:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:13008 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729522AbgAVKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:40 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAgdfT009205;
        Wed, 22 Jan 2020 02:45:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rLMYUSV2r/0A9wA/W3pdkoSCGJ9W/Lk4BQY09DCkULI=;
 b=ekgdRp2wjl/T3wbAVz0EjTMduGvZWjCPaICGFs1OZ8eO+xpvmr3GKi2tyaZDypnjb2Ir
 yh0Bc1pWGi7W5ZSesRe/2u7PqwcHs7wUO1BmeIO9wG/KGC5ubDTg+NuBcaeOmSXFSxFx
 fSGIOwsM3YC4FPWT21kBMxZSwohjrwDw2/HI3h/skVF4badHxMoINBSbLcMj4KNzjO6g
 vlxZ/4dFWrJ8XW4s8IJO7gDNuSsqsaGifZ8LDB5FutzmBglitL88Re89byx4JRQqVJiX
 yxVWk6u+hFh6BEzLcZG8O9A7rJFbX0wkA/xbGsMLyR0JE6M82jWp2gybsTC5qyvGzuhr 5A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mgyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izbs9SeZFLtkXgHuGUzyyr3OJFlpGuIt3qeEbg7mo3gA6wO9GczxHnvP7mrksiELax2/foy3pungybFarYGTEwb7lgQXQTCR8G+AROR7vG/y5E7yONmQuljCUzC33Kcya4AdOXozgWlTvEpX0yp0pP1wT0SdxKK5E6T19iUpBPAFrwa6wnlr2sVzsrk/5U1+Bc9SB9Ral4rOv5C3v8mK0oj4yapslkt9g2gPvrB6xQnKqchYPnnAGezZJEjUdCFlb5ZTZHA/i7EcPHnBbLubmiYUDezvurokHKQ+NbmDIM/rbVVv4sc+kbnFIu/JxYZ0H4GYnSaUI3wJ05M49yrQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLMYUSV2r/0A9wA/W3pdkoSCGJ9W/Lk4BQY09DCkULI=;
 b=kTC7dSyED3mGVJ1mBGDUXozoAu3rAXsuh0PY+NQdkc1GcHVHF4XMTY2wqEl060HeSA+0As4vJhfltr0MqGHVAiTc/EKGVdKDH2PHR7KIRnpz0cHYBE9TbaliOuXcNNX3RrlZfUTVEAP1gSwWnAP/Mb8NvFCW/9GJ2GtRjhzEiOalpljduP47JLpRjMWXqjj4iaZrVsxJzML+gW6E02EKXwm9o75rSs+P3Veyv6V6SIyXqbY+YB6O/QCynnsi99zAUsQB2OflJau1KVCmMhMXrlviSEamlFD70j8CfvduaguvzGR0MHqyKFWzIQSuvmT3C99aE58/KEry12kdAJFzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLMYUSV2r/0A9wA/W3pdkoSCGJ9W/Lk4BQY09DCkULI=;
 b=wmACBUH9dE++RkEtcChCeysUUGiz62feL2tZObkL/+uRKxZS3YWAjSedRWUZjrcJ56GjkuTcQldCrWg7HM1kq8O+El6rZgO29ovEAwRCAs5D+jd+VMndQSeqZYEbCW7TGuDj0JJlnro02zTjPbePE0hoR3TwFonSfSiPEwcu+bY=
Received: from CH2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:20::25)
 by CY1PR07MB2732.namprd07.prod.outlook.com (2a01:111:e400:c61c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.21; Wed, 22 Jan
 2020 10:45:26 +0000
Received: from BN8NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::205) by CH2PR07CA0012.outlook.office365.com
 (2603:10b6:610:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT061.mail.protection.outlook.com (10.13.182.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBC001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:24 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:20 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:20 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjK9Y007246;
        Wed, 22 Jan 2020 11:45:20 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjKCJ007245;
        Wed, 22 Jan 2020 11:45:20 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 03/14] phy: cadence-torrent: Adopt Torrent nomenclature
Date:   Wed, 22 Jan 2020 11:45:07 +0100
Message-ID: <1579689918-7181-4-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(189003)(36092001)(199004)(2906002)(7636002)(86362001)(70586007)(54906003)(4326008)(70206006)(478600001)(26826003)(5660300002)(42186006)(110136005)(316002)(107886003)(186003)(26005)(36756003)(336012)(426003)(8676002)(356004)(6666004)(2616005)(8936002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2732;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e430c9-0f97-478e-a89f-08d79f2830ae
X-MS-TrafficTypeDiagnostic: CY1PR07MB2732:
X-Microsoft-Antispam-PRVS: <CY1PR07MB2732570679DE2F7253407A31D20C0@CY1PR07MB2732.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0kWHiGrKEmzx7pxlBWkxfheD7C8SW0b8ez+uCUHT6f8o+as/V5mbfje/r09/uK0BJS0+K9an2P02FuKFkfPp8zOAmndV+MZbeQmEGilbXidAgCpKR+mfRC1aGpb/M+iTyx0N4/qhrV13ZwcchRqPVVEAjrVIgRnn/mQjmrOVbkqxHi8seZKcPlJJHMywWGME+s7d4R73wV2tv1diAZFMsJLi5h/t1oEud5H3ts3rS7cJOyrUavtTnIQMFr7LPK8WTz7O2TKeOpWtWNFBS7VyQcx8XI9ADsV/scdkeVkThoWzKBd2wEQKe5GjOsqZv26QYXdr+d38E/3hPhTXHK03KqTU6ibrKY10jIUVrHylmJ8y6RM4rqYiPmMm2H2bpTD6MOGM+xtMfNvQJgSH9jdx9ulLsEfKXr45TJ3chZLZOvqFv4YT6SIrb0wZOvBuytxLAvyD78pMkUwNyY4MaBPYMsEp1QVplTATDbbPPRmPZQk76v01cIKKKo+Pv24anZ4
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:25.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e430c9-0f97-478e-a89f-08d79f2830ae
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2732
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
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
---
 drivers/phy/cadence/phy-cadence-torrent.c | 111 ++++++++++++++++--------------
 1 file changed, 58 insertions(+), 53 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index beb80f7..eb61005 100644
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
2.4.5

