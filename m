Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F64206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tVNZ4tQV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pY+DtsVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgH0NqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:46:16 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:15268 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728114AbgH0N3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDJwaJ014981;
        Thu, 27 Aug 2020 06:29:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=AK+WGpUoNR7nO40iJKfuipo8O3Vq4Ysrs/T6PenhtNo=;
 b=tVNZ4tQVQGjkibAg7djRq9HiiLnbA2O1twa5pL6ycgt5EnTyQnJWz/6Ajrax+p7oeHbK
 r/TPBnCc91QTjeKGm5wT+gbS3d7C49/5JWuSkIobPKmRYHo2wMmYUJVLRJOiJqsEAyp+
 z9hJvHQ6UrKO3qp2t0eaKmFHT7nyKiANuKC0FTmEiNWHVF6lijxyeA2hLY1YDilkm/e4
 EhnTeoavNjFu63vvk08Iwnuvts3uIavnI3P6cuVOUt83FHu+8JUSfSDGM6Ty1PjnId5W
 kZUERAUGv+WqZAju3z7asdhVwKvjLDIAeFy/tITIHP8rp86MVOtGEQa4VHcRI0xbcsz7 Pg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxcnre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esj/t4lpMt8egwkvI9xp1KSXu7R4msricfUKY6DSzKPUi5FMWLnJTJqHgUYl8xBYqlSkN144wLEe2Z5BzvOfdJ+RmTmvDNYM01UaplOVXrCkxsl7LnCUslNBG/7nqWRFu3Ag4WvwWbNU3pxcZWRnRR7+pZ6c6tZeOHOWWbKFDNFT6pNWSofzWdZSuK/XfEoB6hOw/vVBx6/KqyIWKrQVFMbFmfm4x+YgNPOj0H6dnSyuJhQ0QNcWydTTeS6mGAVB0/yLPBMzGOW5/ZExt4qMCZ2HO/Ivx8ydVntZBgCYIPQJ60WLPg1wW11rEJiDi25lQNomqkZTDsB/pP5exkcO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK+WGpUoNR7nO40iJKfuipo8O3Vq4Ysrs/T6PenhtNo=;
 b=V7Gq0ROM1sZp9hE8YqUnKnBT+EKV/MNoOgMvZ3jszCdppOdneRVwMc+M9CoNlFp/A1CFgOZDKkUYa6F5DxfpUZLzPS+4H197Iy9hoRsqbLvrbgyGqaD7P/6Kn3YukY7rQszdPtRTqQ1AEdGoGqS67VdzfUevnZSOffivQTejJj9iDI7l3Zb05k+qYrEeCyTnrFdEMWxL2Qpd99ikZ9B6cqi/q9VTXIEuISc8PfdgRRK7ErKwq9TI0QXuTxPL2lQyzZDSLyHT8RG1gEAmBObau/BBNund6sB8hj0UJQ3rnDGoMkJIUX//VvwFBnA2CaK9dJFlluG4o4J9+rlsyTe+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK+WGpUoNR7nO40iJKfuipo8O3Vq4Ysrs/T6PenhtNo=;
 b=pY+DtsVqYnmcQejKleTPpS9lskuJd6PalgP8u26n/6wLY5/zkGuAITU4UBOY+DTgQamWIL6kXCMUSJoBr8cyanumQUWyXRB81Bf2EMwEVU6yfoWs4LhRPSrOKEqEzlebKyIUNhpne8lbczYAkElZtL50tBVlCG0Fx0rv0RLlgV8=
Received: from DM5PR07CA0157.namprd07.prod.outlook.com (2603:10b6:3:ee::23) by
 SN4PR0701MB3663.namprd07.prod.outlook.com (2603:10b6:803:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 13:29:03 +0000
Received: from DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::e0) by DM5PR07CA0157.outlook.office365.com
 (2603:10b6:3:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT012.mail.protection.outlook.com (10.13.179.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:29:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRk001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:29:00 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrgS018754;
        Thu, 27 Aug 2020 15:28:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSroG018753;
        Thu, 27 Aug 2020 15:28:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 4/7] phy: cadence-torrent: Add separate regmap functions for torrent and DP
Date:   Thu, 27 Aug 2020 15:28:49 +0200
Message-ID: <1598534932-18693-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c01b95-2c78-49ba-856f-08d84a8d297e
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3663:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB36632F043BF3CC13E08990BDC5550@SN4PR0701MB3663.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZDKP1Y9cM+rFrBli1mdtCNZteaJYRIx43e9pi7IBwt35WTkCaoD2frRUEFFsJqTGZiXZ+mgOOPMVOS8Vd7c37jsogj6TCk6mlm7lZF8uwpD7qGB6iQebsajsm9lQoqJL9dYMqVcBlRp9zsLmuEx9btMGyXwrU8qDu0cjNfHf4E/wi0T+mBoNFwtj8Scb34T86TRg93T3QaKzPlmbjbSwXx0wGxi8JjjnPR/Ilrv9u8GinxCNcE7mZ1Kpu9Ai5arJBhDyqId0C4RAoWuK6RvO1dhrpDKThGmvaYx///tZnVazw5kAV0RtVYKF5F+XnNiR5pLz2bJJ4SxlgpCmal/wAFIxSQdLaTaWEFacy7ayq1ai2kKc5Cjf+yyDrty7eoRorcOr4HU/HuDuADNq47fP+Yvxm77xp0K39csjLWbUv4=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36092001)(46966005)(8676002)(8936002)(42186006)(426003)(54906003)(4326008)(316002)(2906002)(86362001)(110136005)(47076004)(81166007)(82740400003)(186003)(6666004)(70586007)(83380400001)(478600001)(26005)(2616005)(36756003)(70206006)(336012)(82310400002)(5660300002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:29:01.9237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c01b95-2c78-49ba-856f-08d84a8d297e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3663
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added separate functions for regmap initialization of torrent PHY
generic registers and DP specific registers.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 99 +++++++++++++++--------
 1 file changed, 66 insertions(+), 33 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ee633c8bf2d8..66ae5b749385 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1584,7 +1584,24 @@ static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 	return devm_regmap_init(dev, NULL, ctx, config);
 }
 
-static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_dp_regfield_init(struct cdns_torrent_phy *cdns_phy)
+{
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct regmap *regmap;
+
+	regmap = cdns_phy->regmap_dptx_phy_reg;
+	field = devm_regmap_field_alloc(dev, regmap, phy_reset_ctrl);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_RESET reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_reset_ctrl = field;
+
+	return 0;
+}
+
+static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
 	struct regmap_field *field;
@@ -1614,28 +1631,44 @@ static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pma_pll_raw_ctrl = field;
 
-	regmap = cdns_phy->regmap_dptx_phy_reg;
-	field = devm_regmap_field_alloc(dev, regmap, phy_reset_ctrl);
-	if (IS_ERR(field)) {
-		dev_err(dev, "PHY_RESET reg field init failed\n");
-		return PTR_ERR(field);
+	return 0;
+}
+
+static int cdns_torrent_dp_regmap_init(struct cdns_torrent_phy *cdns_phy)
+{
+	void __iomem *base = cdns_phy->base;
+	struct device *dev = cdns_phy->dev;
+	struct regmap *regmap;
+	u8 reg_offset_shift;
+	u32 block_offset;
+
+	reg_offset_shift = cdns_phy->init_data->reg_offset_shift;
+
+	block_offset = TORRENT_DPTX_PHY_OFFSET;
+	regmap = cdns_regmap_init(dev, base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_dptx_phy_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init DPTX PHY regmap\n");
+		return PTR_ERR(regmap);
 	}
-	cdns_phy->phy_reset_ctrl = field;
+	cdns_phy->regmap_dptx_phy_reg = regmap;
 
 	return 0;
 }
 
-static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
-				       void __iomem *sd_base,
-				       void __iomem *base,
-				       u8 block_offset_shift,
-				       u8 reg_offset_shift)
+static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 {
+	void __iomem *sd_base = cdns_phy->sd_base;
+	u8 block_offset_shift, reg_offset_shift;
 	struct device *dev = cdns_phy->dev;
 	struct regmap *regmap;
 	u32 block_offset;
 	int i;
 
+	block_offset_shift = cdns_phy->init_data->block_offset_shift;
+	reg_offset_shift = cdns_phy->init_data->reg_offset_shift;
+
 	for (i = 0; i < MAX_NUM_LANES; i++) {
 		block_offset = TORRENT_TX_LANE_CDB_OFFSET(i, block_offset_shift,
 							  reg_offset_shift);
@@ -1690,16 +1723,6 @@ static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
 	}
 	cdns_phy->regmap_phy_pma_common_cdb = regmap;
 
-	block_offset = TORRENT_DPTX_PHY_OFFSET;
-	regmap = cdns_regmap_init(dev, base, block_offset,
-				  reg_offset_shift,
-				  &cdns_torrent_dptx_phy_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to init DPTX PHY regmap\n");
-		return PTR_ERR(regmap);
-	}
-	cdns_phy->regmap_dptx_phy_reg = regmap;
-
 	return 0;
 }
 
@@ -1712,6 +1735,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	const struct cdns_torrent_data *data;
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
+	u8 init_dp_regmap = 0;
 
 	/* Get init data for this PHY */
 	data = of_device_get_match_data(dev);
@@ -1749,6 +1773,14 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = cdns_torrent_regmap_init(cdns_phy);
+	if (ret)
+		return ret;
+
+	ret = cdns_torrent_regfield_init(cdns_phy);
+	if (ret)
+		return ret;
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
@@ -1831,6 +1863,18 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				goto put_child;
 			}
 
+			if (!init_dp_regmap) {
+				ret = cdns_torrent_dp_regmap_init(cdns_phy);
+				if (ret)
+					goto put_child;
+
+				ret = cdns_torrent_dp_regfield_init(cdns_phy);
+				if (ret)
+					goto put_child;
+
+				init_dp_regmap++;
+			}
+
 			dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
 				 cdns_phy->phys[node].num_lanes,
 				 cdns_phy->max_bit_rate / 1000,
@@ -1849,17 +1893,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	}
 	cdns_phy->nsubnodes = node;
 
-	ret = cdns_regmap_init_torrent_dp(cdns_phy, cdns_phy->sd_base,
-					  cdns_phy->base,
-					  data->block_offset_shift,
-					  data->reg_offset_shift);
-	if (ret)
-		goto put_lnk_rst;
-
-	ret = cdns_regfield_init(cdns_phy);
-	if (ret)
-		goto put_lnk_rst;
-
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
 		ret = PTR_ERR(phy_provider);
-- 
2.26.1

