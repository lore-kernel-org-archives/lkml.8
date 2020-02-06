Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D23C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DA321741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="q1btXfyO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="czrImQiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBFGMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:12:05 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25316 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727806AbgBFGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:27 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669Nau016381;
        Wed, 5 Feb 2020 22:11:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=G3pXYurmHbs7tP/DITaPgI559ZervsK79iaqJGIBerU=;
 b=q1btXfyOE1Tuom8SmZ0MO+Ym2NR62lLWkwzs6sQ3zc90dXqAj1sd2MwJ/IEgWq2FVqpP
 LJ2/UpxoP2rWHWtz0Qucb8a2tlaUMKmCdQByCLmLFxK2OSsOdqvVUk/1LWvnO+YTQtrd
 5kVmYsXBAx4t10lJ1ylOCC7RdKJvJtm/7lG8EiDd2fI+FoG+Ingjq9TAMuY9aQ9RcLXM
 dlDNLNNWV5o040jvC2lE/NnGM0pi4x/EacneeHzxP9AtmApmBsYhR+sMONb3UbKnd/GN
 2+qmGofKyXp5aqzc+AxRqoNC2t2HbuSCtM+Re0NG55fKu+IPB8anHHjjOZA77u5eqnAj OQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunrb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEbWFNya+6f5L8CAsw8tzP0TB9Z2OtRc+RtdHBJHHZJSkURH++ezae5/9eYydy1NOfexrdOLxtEkQbURAG6LxDCa+eHXeACMH/TwkORDa5rY1jvZm+T8aw5q6Vv6EAQ65pJWrjio+VWWX671EyIgJMcZW4yEPV3sqQQNOYGWM+POmsiNQJFjkQxwhPSMVkNITZfGqcmzjVGuuEl7PsPZmRpKv+RK9OzT1nDvdKTzk4u2JBAOrhGWMjJQgmCaaew6En7jJ7vJNdRjwU2y4BpYI/aD4k9bfZfBHW1eHX+wEyIw1mgJyLHYBJapgIF+E8G8rFHNbCJY8KvZlu6/LM99Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3pXYurmHbs7tP/DITaPgI559ZervsK79iaqJGIBerU=;
 b=oeeNpp1RpJFLq737SR4acHbv76kRVy5fLnDbpFJJ1O6GidMJ8HQ6EIRInHooMiys1IZ0kknt3g3kB/36z6ufupqJ9XBCL/3NniS/3q8TgLyz4GdZhwtt4UjVzI7MzlL2vk2AgIfBPbN1FVxJGmorA+HkNBM9+UF5pE21Z3VxXC48EwU3xuiKX8Xe71fcXHUFt4QgQ0IN9vBPFV6rhEh6+Py6KCgQvaBde44g0QDIwjSUmgy5UDZagQfLpviZpE4dobhtnpEkzIpTDCkC7gf/5FXsPvWLNG3jtp3BJDTXV6ieBKleLevvCBQAsr7iOhyG/WhALlyBWhNw2V0DjG0B5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3pXYurmHbs7tP/DITaPgI559ZervsK79iaqJGIBerU=;
 b=czrImQiShX48r/0DLB1/0F4ssY9vgZ47UiDnkwVB4BQMrVPn8JW2FTJDGE7658k3SEblwDHwu/plmD/vjhk0idR3G1VgEBip3so5Kj+AIRrbrxLiGwmSKjdnFT3ChJ0FRq7TyO3QRflaABVExUvO/uVkHjvJXZr5iIZIyr2vggc=
Received: from CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18) by
 CY4PR07MB3064.namprd07.prod.outlook.com (2603:10b6:903:cf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 06:11:16 +0000
Received: from MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::204) by CO2PR07CA0050.outlook.office365.com
 (2603:10b6:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT028.mail.protection.outlook.com (10.13.181.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F9174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:14 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:05 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B4hx017078;
        Thu, 6 Feb 2020 07:11:04 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B4xp017076;
        Thu, 6 Feb 2020 07:11:04 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 13/13] phy: cadence-torrent: Add support for subnode bindings
Date:   Thu, 6 Feb 2020 07:11:01 +0100
Message-ID: <1580969461-16981-14-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(199004)(36092001)(189003)(5660300002)(30864003)(107886003)(36906005)(2906002)(26005)(86362001)(54906003)(6666004)(356004)(36756003)(478600001)(336012)(110136005)(186003)(8676002)(81156014)(426003)(70586007)(70206006)(316002)(81166006)(42186006)(8936002)(2616005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3064;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68545b51-b7ae-4b84-d766-08d7aacb5fb3
X-MS-TrafficTypeDiagnostic: CY4PR07MB3064:
X-Microsoft-Antispam-PRVS: <CY4PR07MB30644A33F29A1ECFB1400D46D21D0@CY4PR07MB3064.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:102;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/FBjcIM2EpJFmvO+D2WOrWfukt91ahY6Sj6GdkRyNC48G09c8HJl0fyD0tVeYHYKu5Hq7VoGPWSZJWh6PzUcUOwcrv07Gn1qC5nk+YrQKxlmSUk13olU7JU4+EesZvqhozE4IaAIX5ScMQq5PPR7TrgVppeNTByrTlnzhMtx0ClaEsLEyXg/S0DNd+mjToyRDv0/7ZO79dLl+rxn538bvnxSVOUQ2QiDt939LyeBE1dN7pVGrSfOBiKGMt+Viq4TdMZSp/xd8YJfeovfamzL1TLB74jbU7dNJAItpT7TbECUHV/IhsiVdJODN5YLLupsuo7hug31yHovZAZ5ummFt1SSQKZn/Pz/MsX5HYmpfHci8i8P/3F56rh7BTtfwyN4FDMf9Po9ei6QM7zP93mqmnHGq1jAy8ReVKUwBv75xjIUIYuMTk2VYxj0iBMgaTMmdKN5RTrazVVlZXXNIR66hSAxyy5XNfMKaWwPFCZHSklqdr/OTLrCjLxZttO8ywC
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:15.6359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68545b51-b7ae-4b84-d766-08d7aacb5fb3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3064
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

Implement single link subnode support to the phy driver.
Add reset support including PHY reset and individual lane reset.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 292 ++++++++++++++++------
 1 file changed, 217 insertions(+), 75 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 851a68590788..7116127358ee 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <dt-bindings/phy/phy.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -18,6 +19,7 @@
 #include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 
 #define REF_CLK_19_2MHz		19200000
@@ -183,14 +185,24 @@ static const struct reg_field phy_reset_ctrl =
 
 static const struct of_device_id cdns_torrent_phy_of_match[];
 
+struct cdns_torrent_inst {
+	struct phy *phy;
+	u32 mlane;
+	u32 phy_type;
+	u32 num_lanes;
+	struct reset_control *lnk_rst;
+};
+
 struct cdns_torrent_phy {
 	void __iomem *base;	/* DPTX registers base */
 	void __iomem *sd_base; /* SD0801 registers base */
-	u32 num_lanes; /* Number of lanes to use */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	struct reset_control *phy_rst;
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
+	struct cdns_torrent_inst phys[MAX_NUM_LANES];
+	int nsubnodes;
 	struct regmap *regmap;
 	struct regmap *regmap_common_cdb;
 	struct regmap *regmap_phy_pcs_common_cdb;
@@ -217,7 +229,8 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
 			       u32 num_lanes);
 static
 int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
-static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy);
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
+				    struct cdns_torrent_inst *inst);
 static
 void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy);
 static
@@ -237,11 +250,15 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 					   u32 num_lanes,
 					   enum phy_powerstate powerstate);
+static int cdns_torrent_phy_on(struct phy *phy);
+static int cdns_torrent_phy_off(struct phy *phy);
 
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_dp_init,
 	.exit		= cdns_torrent_dp_exit,
 	.configure	= cdns_torrent_dp_configure,
+	.power_on	= cdns_torrent_phy_on,
+	.power_off	= cdns_torrent_phy_off,
 	.owner		= THIS_MODULE,
 };
 
@@ -564,7 +581,7 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 /*
  * Verify, that parameters to configure PHY with are correct.
  */
-static int cdns_torrent_dp_verify_config(struct cdns_torrent_phy *cdns_phy,
+static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
 					 struct phy_configure_opts_dp *dp)
 {
 	u8 i;
@@ -599,7 +616,7 @@ static int cdns_torrent_dp_verify_config(struct cdns_torrent_phy *cdns_phy,
 	}
 
 	/* Check against actual number of PHY's lanes. */
-	if (dp->lanes > cdns_phy->num_lanes)
+	if (dp->lanes > inst->num_lanes)
 		return -EINVAL;
 
 	/*
@@ -791,10 +808,11 @@ static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
 static int cdns_torrent_dp_configure(struct phy *phy,
 				     union phy_configure_opts *opts)
 {
-	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
-	ret = cdns_torrent_dp_verify_config(cdns_phy, &opts->dp);
+	ret = cdns_torrent_dp_verify_config(inst, &opts->dp);
 	if (ret) {
 		dev_err(&phy->dev, "invalid params for phy configure\n");
 		return ret;
@@ -826,8 +844,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
 	int ret;
-
-	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	ret = clk_prepare_enable(cdns_phy->clk);
@@ -856,19 +874,19 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
 	/* PHY PMA registers configuration function */
-	cdns_torrent_dp_pma_cfg(cdns_phy);
+	cdns_torrent_dp_pma_cfg(cdns_phy, inst);
 
 	/*
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
 	 */
-	cdns_torrent_dp_set_a0_pll(cdns_phy, cdns_phy->num_lanes);
+	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
 
 	/*
 	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
 	 * used lanes
 	 */
-	lane_bits = (1 << cdns_phy->num_lanes) - 1;
+	lane_bits = (1 << inst->num_lanes) - 1;
 	cdns_torrent_dp_write(regmap, PHY_RESET,
 			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
 
@@ -886,23 +904,25 @@ static int cdns_torrent_dp_init(struct phy *phy)
 						      cdns_phy->max_bit_rate,
 						      false);
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
-				     cdns_phy->num_lanes);
+				     inst->num_lanes);
 
 	/* take out of reset */
 	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
 
+	cdns_torrent_phy_on(phy);
+
 	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_run(cdns_phy, cdns_phy->num_lanes);
+	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
 
 	return ret;
 }
 
 static int cdns_torrent_dp_exit(struct phy *phy)
 {
-	struct cdns_torrent_phy *cdns_phy = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 
 	clk_disable_unprepare(cdns_phy->clk);
 	return 0;
@@ -926,7 +946,8 @@ int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
-static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
+				    struct cdns_torrent_inst *inst)
 {
 	unsigned int i;
 
@@ -938,7 +959,7 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy)
 		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
 	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < cdns_phy->num_lanes; i++)
+	for (i = 0; i < inst->num_lanes; i++)
 		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
 }
 
@@ -1518,6 +1539,33 @@ static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
 	return ret;
 }
 
+static int cdns_torrent_phy_on(struct phy *phy)
+{
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	int ret;
+
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
+
+	/* Take the PHY lane group out of reset */
+	return reset_control_deassert(inst->lnk_rst);
+}
+
+static int cdns_torrent_phy_off(struct phy *phy)
+{
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	int ret;
+
+	ret = reset_control_assert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
+
+	return reset_control_assert(inst->lnk_rst);
+}
 
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset,
@@ -1664,8 +1712,8 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	const struct of_device_id *match;
 	struct cdns_torrent_data *data;
-	struct phy *phy;
-	int err, ret;
+	struct device_node *child;
+	int ret, subnodes, node = 0, i;
 
 	/* Get init data for this PHY */
 	match = of_match_device(cdns_torrent_phy_of_match, dev);
@@ -1678,12 +1726,20 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (!cdns_phy)
 		return -ENOMEM;
 
-	cdns_phy->dev = &pdev->dev;
+	dev_set_drvdata(dev, cdns_phy);
+	cdns_phy->dev = dev;
 
-	phy = devm_phy_create(dev, NULL, &cdns_torrent_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create Torrent PHY\n");
-		return PTR_ERR(phy);
+	cdns_phy->phy_rst = devm_reset_control_get_exclusive_by_index(dev, 0);
+	if (IS_ERR(cdns_phy->phy_rst)) {
+		dev_err(dev, "%s: failed to get reset\n",
+			dev->of_node->full_name);
+		return PTR_ERR(cdns_phy->phy_rst);
+	}
+
+	cdns_phy->clk = devm_clk_get(dev, "refclk");
+	if (IS_ERR(cdns_phy->clk)) {
+		dev_err(dev, "phy ref clock not found\n");
+		return PTR_ERR(cdns_phy->clk);
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1691,78 +1747,163 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(cdns_phy->sd_base))
 		return PTR_ERR(cdns_phy->sd_base);
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(cdns_phy->base))
-		return PTR_ERR(cdns_phy->base);
+	subnodes = of_get_available_child_count(dev->of_node);
+	if (subnodes == 0) {
+		dev_err(dev, "No available link subnodes found\n");
+		return -EINVAL;
+	} else if (subnodes != 1) {
+		dev_err(dev, "Driver supports only one link subnode.\n");
+		return -EINVAL;
+	}
 
+	for_each_available_child_of_node(dev->of_node, child) {
+		struct phy *gphy;
 
-	err = device_property_read_u32(dev, "num_lanes",
-				       &cdns_phy->num_lanes);
-	if (err)
-		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
+		cdns_phy->phys[node].lnk_rst =
+				of_reset_control_array_get_exclusive(child);
+		if (IS_ERR(cdns_phy->phys[node].lnk_rst)) {
+			dev_err(dev, "%s: failed to get reset\n",
+				child->full_name);
+			ret = PTR_ERR(cdns_phy->phys[node].lnk_rst);
+			goto put_lnk_rst;
+		}
 
-	switch (cdns_phy->num_lanes) {
-	case 1:
-	case 2:
-	case 4:
-		/* valid number of lanes */
-		break;
-	default:
-		dev_err(dev, "unsupported number of lanes: %d\n",
-			cdns_phy->num_lanes);
-		return -EINVAL;
-	}
+		if (of_property_read_u32(child, "reg",
+					 &cdns_phy->phys[node].mlane)) {
+			dev_err(dev, "%s: No \"reg\"-property.\n",
+				child->full_name);
+			ret = -EINVAL;
+			goto put_child;
+		}
 
-	err = device_property_read_u32(dev, "max_bit_rate",
-				       &cdns_phy->max_bit_rate);
-	if (err)
-		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
+		if (cdns_phy->phys[node].mlane != 0) {
+			dev_err(dev,
+				"%s: Driver supports only lane-0 as master lane.\n",
+				child->full_name);
+			ret = -EINVAL;
+			goto put_child;
+		}
 
-	switch (cdns_phy->max_bit_rate) {
-	case 1620:
-	case 2160:
-	case 2430:
-	case 2700:
-	case 3240:
-	case 4320:
-	case 5400:
-	case 8100:
-		/* valid bit rate */
-		break;
-	default:
-		dev_err(dev, "unsupported max bit rate: %dMbps\n",
-			cdns_phy->max_bit_rate);
-		return -EINVAL;
-	}
+		if (of_property_read_u32(child, "cdns,phy-type",
+					 &cdns_phy->phys[node].phy_type)) {
+			dev_err(dev, "%s: No \"cdns,phy-type\"-property.\n",
+				child->full_name);
+			ret = -EINVAL;
+			goto put_child;
+		}
 
-	cdns_phy->clk = devm_clk_get(dev, "refclk");
-	if (IS_ERR(cdns_phy->clk)) {
-		dev_err(dev, "phy ref clock not found\n");
-		return PTR_ERR(cdns_phy->clk);
-	}
+		cdns_phy->phys[node].num_lanes = DEFAULT_NUM_LANES;
+		of_property_read_u32(child, "cdns,num-lanes",
+				     &cdns_phy->phys[node].num_lanes);
+
+		if (cdns_phy->phys[node].phy_type == PHY_TYPE_DP) {
+			switch (cdns_phy->phys[node].num_lanes) {
+			case 1:
+			case 2:
+			case 4:
+			/* valid number of lanes */
+				break;
+			default:
+				dev_err(dev, "unsupported number of lanes: %d\n",
+					cdns_phy->phys[node].num_lanes);
+				ret = -EINVAL;
+				goto put_child;
+			}
+
+			cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
+			of_property_read_u32(child, "cdns,max-bit-rate",
+					     &cdns_phy->max_bit_rate);
+
+			switch (cdns_phy->max_bit_rate) {
+			case 1620:
+			case 2160:
+			case 2430:
+			case 2700:
+			case 3240:
+			case 4320:
+			case 5400:
+			case 8100:
+			/* valid bit rate */
+				break;
+			default:
+				dev_err(dev, "unsupported max bit rate: %dMbps\n",
+					cdns_phy->max_bit_rate);
+				ret = -EINVAL;
+				goto put_child;
+			}
+
+			/* DPTX registers */
+			regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+			cdns_phy->base = devm_ioremap_resource(&pdev->dev,
+							       regs);
+			if (IS_ERR(cdns_phy->base)) {
+				ret = PTR_ERR(cdns_phy->base);
+				goto put_child;
+			}
+
+			gphy = devm_phy_create(dev, child,
+					       &cdns_torrent_phy_ops);
+			if (IS_ERR(gphy)) {
+				ret = PTR_ERR(gphy);
+				goto put_child;
+			}
+
+			dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
+				 cdns_phy->phys[node].num_lanes,
+				 cdns_phy->max_bit_rate / 1000,
+				 cdns_phy->max_bit_rate % 1000);
+		} else {
+			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
+			ret = -ENOTSUPP;
+			goto put_child;
+		}
+		cdns_phy->phys[node].phy = gphy;
+		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
 
-	phy_set_drvdata(phy, cdns_phy);
+		node++;
+	}
+	cdns_phy->nsubnodes = node;
 
 	ret = cdns_regmap_init_torrent_dp(cdns_phy, cdns_phy->sd_base,
 					  cdns_phy->base,
 					  data->block_offset_shift,
 					  data->reg_offset_shift);
 	if (ret)
-		return ret;
+		goto put_lnk_rst;
 
 	ret = cdns_regfield_init(cdns_phy);
 	if (ret)
-		return ret;
+		goto put_lnk_rst;
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		ret = PTR_ERR(phy_provider);
+		goto put_lnk_rst;
+	}
+
+	return 0;
 
-	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
-		 cdns_phy->num_lanes,
-		 cdns_phy->max_bit_rate / 1000,
-		 cdns_phy->max_bit_rate % 1000);
+put_child:
+	node++;
+put_lnk_rst:
+	for (i = 0; i < node; i++)
+		reset_control_put(cdns_phy->phys[i].lnk_rst);
+	of_node_put(child);
+	return ret;
+}
 
-	return PTR_ERR_OR_ZERO(phy_provider);
+static int cdns_torrent_phy_remove(struct platform_device *pdev)
+{
+	struct cdns_torrent_phy *cdns_phy = platform_get_drvdata(pdev);
+	int i;
+
+	reset_control_assert(cdns_phy->phy_rst);
+	for (i = 0; i < cdns_phy->nsubnodes; i++) {
+		reset_control_assert(cdns_phy->phys[i].lnk_rst);
+		reset_control_put(cdns_phy->phys[i].lnk_rst);
+	}
+
+	return 0;
 }
 
 static const struct cdns_torrent_data cdns_map_torrent = {
@@ -1790,6 +1931,7 @@ MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
 
 static struct platform_driver cdns_torrent_phy_driver = {
 	.probe	= cdns_torrent_phy_probe,
+	.remove = cdns_torrent_phy_remove,
 	.driver = {
 		.name	= "cdns-torrent-phy",
 		.of_match_table	= cdns_torrent_phy_of_match,
-- 
2.20.1

