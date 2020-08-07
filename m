Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992CFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C57C221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="o12DxfLD";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="1htnYoz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgHGKNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:13:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30858 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728152AbgHGKNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:13:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779vT8B023751;
        Fri, 7 Aug 2020 03:12:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TmbRzDrhmhEFNzqBfocZEWUvl991H/aYQVfSIx3O+QA=;
 b=o12DxfLDR4Upt/5T77hmc3wORPAvzNvlMmyvMEcn2Z9XLWTYEXrspol5bceFYXsGjp7z
 VInQjChDC/ubDvcZ+pjzrC48whmRtfBYQS9P+vvGkeH7tu7fmXkqGCX65nYYBODda1ew
 yYqC74OHiBERutN6n1SkGo0tgm6wJ1n+1ESekGrskBCufU717oocld7hUc3xv9VEn6ao
 LCYKUusc4MwzMek/Ljm4D6HpmFOOd5e/u0rpZafFsqh/rgtJvOOjbA+2f7PatyHWikhI
 ciFVh1P3QD6Nn8MvTdSooZ6ZT7Vg1RwiE/5/QoArY+SkXoEb0cmaZaVRvzoHSBM3nceo yQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0m4rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZ0+ZTnZSeUVMYzk9oLCg4FVaBBrz+SrXRnEBapXIwgzvIkllqj8dUHUH9WqzFjXdcgKemnITUiRhlqDBgrWLQiNvWojAXFvgRiAVp4DQFWg0FPdT6/NWbDwb1XUtp6giaVJlO4vID73Wg79RL7mSIQDS2kTSeElBm+G86y6rxvDS3Hm74Fqy+FYkv5i3PGLnRxwXwXUPes1To5DcYbt4jc4UpkiD8Nv4GGTj7evscOJ4YbPZImOdUX3MWvjDVTL0Spoq60q9DcbQ0Z9Mq/LhgGQ/8/l2ea3JHgXWHq9A6WdZd+SuVwJXDwuzKGmnZia0/j3rUMXj+IYEp0+aaMiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmbRzDrhmhEFNzqBfocZEWUvl991H/aYQVfSIx3O+QA=;
 b=aXxNeFMn6shA6/pn/898JMgWHm+YEjyS8IAD5UgLToKxIvOPvnZv4L2dkQmktOm1TDNhQzaCNk4MlMVzuXRQxjpQR9MVFCM5KjKQhM2EAu1IW+q52EKEw7+l1sqnZJfamGgGQjUwGoxO8/Tu5xUvDJhSfqPYpL4KCfsl/WmoZXqJt4NQCrvgyKnouQuOvcEMb4DJ9bpWNlhCR1VOCMYTtG7giNJ9bXX+3b3x1PfuCYR/KFHHla2YgFIK0a02dX8EKtNkXAGpqydXQVbM1I58zOvBja/5zWGBLAA1OPa7jqIN5M3a/0pfcPuVDfmM6l82zqXzjh6mTEnOAD+N+QEgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmbRzDrhmhEFNzqBfocZEWUvl991H/aYQVfSIx3O+QA=;
 b=1htnYoz2Us06OCYPUPYHQkHBj1pN/awmyY63gfQbV6Q/dTpitgWdT1KyAqnJAmyiRD2UdXgORZe2ZDDhWrP0Od69lC+h07CYrwsADNTBzEDdKt+LuZdCcE8NSUcHq1uhqCcqj63EC44scz5yrCjG2GYqfGzFhWL/998HFBvULcs=
Received: from MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18) by
 BYAPR07MB4344.namprd07.prod.outlook.com (2603:10b6:a02:c6::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 10:12:55 +0000
Received: from MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::b9) by MW2PR16CA0005.outlook.office365.com
 (2603:10b6:907::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT038.mail.protection.outlook.com (10.13.180.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5f021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:53 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACkxk013395;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACk8F013394;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 4/7] phy: cadence-torrent: Add separate regmap functions for torrent and DP
Date:   Fri, 7 Aug 2020 12:12:42 +0200
Message-ID: <1596795165-13341-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f546b4e0-6fe4-438d-d387-08d83aba73ce
X-MS-TrafficTypeDiagnostic: BYAPR07MB4344:
X-Microsoft-Antispam-PRVS: <BYAPR07MB43447DE87FE2781B20B6A3E0C5490@BYAPR07MB4344.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCmiBWBjcz2eS98P79FDRFNKPXC21CdVEhoD817pL/VnAr4N1w2PU8S3nIiuBlAMf7gaKiFM447CB+VjooGyUWYSGr7C/bZ4tiakPM7M7L1RK8EaTz98VNw1NIvyTDNNHByPuiGIQvzMxCAhDplLYJatfaQw0MUx0ZsNFBhOik1VDkl7CrU76HZfSGkzq78fBXq9Rnhv2IH8vgIso0eIbH/jOsO2kF3s6XqV2JOsL4J75vczZHOJSW+xN68fOx9Ei8Mx2413UzOFS2/OvPq7RdoZsah8DS4SiIuamorg3xhASSrF0UWaqm5Ih8OqrRanaiePAyuRylezjhaC/RQ0zVeFbhgtm6ArrRSRPiWIIlp1xItMAUSGGMMS1qZqWLHukdhtbaA/eAw9aSV8itPQ7mB32NWxJfu8G0BL81qU4k8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36092001)(46966005)(2906002)(110136005)(70206006)(54906003)(70586007)(316002)(47076004)(36756003)(26005)(478600001)(81166007)(36906005)(186003)(42186006)(82740400003)(86362001)(2616005)(6666004)(356005)(336012)(4326008)(426003)(8676002)(8936002)(5660300002)(83380400001)(82310400002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:55.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f546b4e0-6fe4-438d-d387-08d83aba73ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4344
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070075
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
index 8ef97af7308d..aff85e55348f 100644
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

