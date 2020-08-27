Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C72177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="RN+GetiL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YNoiEaWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgH0QRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:17:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39286 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbgH0QR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:26 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC68H005481;
        Thu, 27 Aug 2020 09:17:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VXcWj0GyWl4GI8QsCq3w+8yw//YdGoo7yEp8jmnoRc0=;
 b=RN+GetiLz3bK/FsLyDGWokYWsEN7NeNKlz1P5Vzib3dOvCaFTYpmRSG0FhSud4ZN3qo2
 AHYkXC0CXFuCbvgsimWveIimiNQprnCY6SWd6OXQ3QORHCxM90UJLLZ9eBb1X38FHKQA
 0U9jFdx34/KVPxd6kvn1NzA/gbaU3L1dS08Km0Wp1MoVXehit0ADzIxQvkegiDt3xOHs
 1YuGc/QXKdQeAn3e4Hlz078MD7m+s2QkiUZfIU0bcMZEJekditig4bFwW0xo3UD/ETYc
 QEi9X+mUQpS6CXcYBzPhIKJqlCxssTtBGMpXQKtzQXlk0Dmop/EcQ+s5wX9rS+az9p8h MQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyRBa3C1COa+jForNQqkslIMfv19mP6/35VY48+NuSfW5+OzaPsZo0JCi6mFTT/RtD5XXs/JcBinhAVNX5DNvx2HsO0eXKC8W1Xg6ddo3UHKknRILscJx4kENduzVOBYYFO9R1n4yrhkS+dWrPRJdtAqZN3LMG/0ovAYoG4gBJ9qX+i4DWtl/numv6EVSGmCVqga+o4A9QD9NNgJULNGNBduysEz1jz25f/Z54UPfMQzR7ClOeCocouHNJYb0AETTWU8pSgrTsA7779LOCfwGojsZSRHMSJ9DEnDsct+LOKHZMqDwDaCyzvGub+1Uc6Cp91xLEZVQz+C+iCss1tC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXcWj0GyWl4GI8QsCq3w+8yw//YdGoo7yEp8jmnoRc0=;
 b=U4/U+phPRXnTGJ3FbpBkXXvckb1PoFShT3gtTp4DWtHbFxAbu/EeX2Wttv3cy1JVgfdijJRVERoPofzFwOi4yDu6a7/Bgil5DVfLIz9VbF2aLADvjazXRdjWi/Nat96ye5uGCl7Dd3cucy7BHw4WzJQOAhh23dH7imd3PZEPgWwENapFIB/7TWTnuEOuFgS7mo+vioJDpHia/xC8JLt7F4ohIOMuqe/uQvRZoPukmRtWg/za8cgEgAq7yRGHVOdLrYRk0671rZSaMbvfBMrwDk+DV8zjpIQ4g9JRs52OAQ8YbIFAAre80/gTf3BUx5uwxBBSIQP8oo3K2F999viy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXcWj0GyWl4GI8QsCq3w+8yw//YdGoo7yEp8jmnoRc0=;
 b=YNoiEaWEGlTXCNnbYmZKAWM3OtYC3/7sS37R9IVQtmPlXWGo8fNM+r1bZ1GSh5iUUb2KLFUypmBhxcGgPlhrTtLCnYbguU8vf8qulaNf6ms1WzsGsWoAZmJklXjrE2iYgH+UsR4+HbUKT5BaqQREi0hxmw4Brw+CtVDSrJnFWv4=
Received: from BN6PR22CA0048.namprd22.prod.outlook.com (2603:10b6:404:37::34)
 by MW2PR07MB4122.namprd07.prod.outlook.com (2603:10b6:907:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 16:16:58 +0000
Received: from BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::20) by BN6PR22CA0048.outlook.office365.com
 (2603:10b6:404:37::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT006.mail.protection.outlook.com (10.13.183.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:16:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquH016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:16:56 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGqVJ031823;
        Thu, 27 Aug 2020 18:16:52 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGqov031822;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 02/13] phy: cadence-torrent: Check cmn_ready assertion during PHY power on
Date:   Thu, 27 Aug 2020 18:16:40 +0200
Message-ID: <1598545011-31772-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9e407f-908c-452d-3b9a-08d84aa49f30
X-MS-TrafficTypeDiagnostic: MW2PR07MB4122:
X-Microsoft-Antispam-PRVS: <MW2PR07MB41224CFBEA173B69B9C879CBC5550@MW2PR07MB4122.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FAwnAXAerOK5XjhtcxfKg77u+yz0gcpdaLHnCF2w7z/IbRDqsQlBMzYIHy7faevoDoijwzAZzg0lxLV4i8JwpxgMNYNY8ZbaXUFdWjRKfb6bQL9st9ooBP6ZjUsjUIKDtG7iUGNU+OC2nLA+aKZQZwM+Xgwyf836R0NG/GbAyjGZyODh+DXKydnhKSGJi1wb21WOVPWtfYX0Yhie5zpyyKCWuZ43UtoB6pYZ2xROKGv/UUslGD6LjYH9+YBAjoTJU/GENL13XaVeAg76Mdeof3y5LYfPaF0TAPAG2FLOTuZy8fcg0ttNm3L7Ve6h850hWNFItHG3BskqDTUGqU41t62+IXwSd/i1BpAnnvSxG/9+qb1INL6C4/K9nlNXSQf+/8WwP5mVKuu0FyMw+xb8+mcfRvVyYTbmXicGwE8JT8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36092001)(46966005)(5660300002)(8936002)(47076004)(70206006)(2616005)(8676002)(70586007)(4326008)(36906005)(36756003)(42186006)(316002)(110136005)(54906003)(6666004)(426003)(186003)(336012)(81166007)(26005)(82310400002)(86362001)(356005)(83380400001)(82740400003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:16:57.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9e407f-908c-452d-3b9a-08d84aa49f30
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4122
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=970 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if cmn_ready is set after both PLL0 and PLL1 are locked.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index fcd1a2617f0a..af307af2f221 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -32,6 +32,7 @@
 #define NUM_PHY_TYPE		2
 
 #define POLL_TIMEOUT_US		5000
+#define PLL_LOCK_TIMEOUT	100000
 
 #define TORRENT_COMMON_CDB_OFFSET	0x0
 
@@ -183,12 +184,16 @@
 #define PHY_PLL_CFG			0x000EU
 
 /* PHY PMA common registers */
+#define PHY_PMA_CMN_CTRL1		0x0000U
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
 static const struct reg_field phy_pll_cfg =
 				REG_FIELD(PHY_PLL_CFG, 0, 1);
 
+static const struct reg_field phy_pma_cmn_ctrl_1 =
+				REG_FIELD(PHY_PMA_CMN_CTRL1, 0, 0);
+
 static const struct reg_field phy_pma_cmn_ctrl_2 =
 				REG_FIELD(PHY_PMA_CMN_CTRL2, 0, 7);
 
@@ -237,6 +242,7 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
@@ -1570,6 +1576,7 @@ static int cdns_torrent_phy_on(struct phy *phy)
 {
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	u32 read_val;
 	int ret;
 
 	/* Take the PHY out of reset */
@@ -1578,7 +1585,21 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 
 	/* Take the PHY lane group out of reset */
-	return reset_control_deassert(inst->lnk_rst);
+	reset_control_deassert(inst->lnk_rst);
+
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL1[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_1,
+					     read_val, read_val, 1000,
+					     PLL_LOCK_TIMEOUT);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
+	return 0;
 }
 
 static int cdns_torrent_phy_off(struct phy *phy)
@@ -1643,6 +1664,14 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pll_cfg = field;
 
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_1);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL1 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_cmn_ctrl_1 = field;
+
 	regmap = cdns_phy->regmap_phy_pma_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_2);
 	if (IS_ERR(field)) {
-- 
2.26.1

