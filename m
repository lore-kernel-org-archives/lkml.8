Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03486C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34D224689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="A5kkjaiD";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="p9CSkcoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgAVKpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:45:53 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34728 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729609AbgAVKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:44 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAgdfU009205;
        Wed, 22 Jan 2020 02:45:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=WoKLg5Vq4899sLAioibizhdQsRc0TQXUDlrIYW4XABk=;
 b=A5kkjaiDxX/WE9SG7sK9RANwtin0piDI/t3eks4CVDE2Vf+AH7Bo0XYK9A3UmYZR1nkE
 GPB3P32dW3bJJlFjSnqLKf5OKvH7eCizbvXONNR86M+i41wq41yfQfg/9hVRe+ICCKvn
 68ew6OgUNJQ9E7Iflu9BA/SGFGnd3RYgakPDonhMpKeJJtQcD4eKMpw1Ot5o13eJozZV
 JR5c8bsSZQNKsjGPF3YU3Cnm8fSTk/nLv9I73Y0HbDg6BYJ7AFEpt2+oqkVQGUOoohPF
 1eHNZr9UqaTOpA5bRb1qS8cDWLrsuI/2Xa8xS9Edd11G2Y30NjyhU41i3Fneikm3y+a5 TA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mgyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlYSqpcX4tWHaW/OrpBF6uHa3i2vGdqT0qZ+PDL84FHZHvHT0qw+0LKu7CRF+55WJRd8DnbB14QZfZexJrwl0kO4nOyoV6APd2RZZmbNbMUD8ADVnPzW4bza5N+vAipUjO7SiBCM2rg9XAnQz4ew0G7dOLyB7TFxdcYlgBmqzvl3eYs9lRNyTXlRa2S+kQQRFfPQqssfuKq1oLvGDHvpqA4nszBKYM8fQHoKLoMSpHE5a7bmwFpNtjhFuFPwTfp473nvCuNe+7DfkVG3X/2w1HjlFyH0bDJ9mG9eMT8FwLVMD9Gr6Q6CRz/PnWk8bX5a7Hrre3jjeRNdsJtuggeABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoKLg5Vq4899sLAioibizhdQsRc0TQXUDlrIYW4XABk=;
 b=nDu8Y9CmMAu/5GC8NLoVV5Q8fPOc/omxbFZlczjq0YozVBDwUMHaDo9QgGaW2bCazOAVwKUiYXwuyzdObj2zNwQ6ME/3pvuumjtEJx4MakQMWTXAjRxJdR7LOluoaoufHtXiMlbJTyScD8q3OEZcyL9ygan3w7jJtp07S3G3m1TeRwyosLpykx1tcUB4Ut1DIgw5EMZKzExFnZe+UE/h5+R12jQGbo1Yk0WBRoQXeDiHb+TEK5SC4QaRkvOAmJyjn/oTTvB4GEtOP9FBr7kaQE/6l2YwkpMq+VlY3etVKmuYrPOLWJhe1FZK5GBb3mJbbrtosHbd78Y+b6dM5uAF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoKLg5Vq4899sLAioibizhdQsRc0TQXUDlrIYW4XABk=;
 b=p9CSkcooddjgP11R5WO3au+oIb/6ml782bbDZyHkJZMqM7E8nGnkVcuPv25DdQo4+VuhFcaSFBE5waVU0v8fm4nhRmvyaMXaomcwHkYq3tgq4HACbr0QTTiYeZg3cOqEm3iNFPHLuwxrta84s8upbofMLhgpP9NJ1sEmTzuVyQ0=
Received: from DM5PR07CA0118.namprd07.prod.outlook.com (2603:10b6:4:ae::47) by
 BN7PR07MB4547.namprd07.prod.outlook.com (2603:10b6:406:aa::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 22 Jan 2020 10:45:31 +0000
Received: from BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::201) by DM5PR07CA0118.outlook.office365.com
 (2603:10b6:4:ae::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.25 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT047.mail.protection.outlook.com (10.13.183.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBN001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:30 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:25 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:25 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjPIC007355;
        Wed, 22 Jan 2020 11:45:25 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjPhm007353;
        Wed, 22 Jan 2020 11:45:25 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 14/14] phy: cadence-torrent: Add support for subnode bindings
Date:   Wed, 22 Jan 2020 11:45:18 +0100
Message-ID: <1579689918-7181-15-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(36092001)(199004)(189003)(246002)(26005)(42186006)(70586007)(70206006)(478600001)(186003)(26826003)(36756003)(7636002)(110136005)(5660300002)(316002)(4326008)(336012)(2906002)(6666004)(356004)(2616005)(107886003)(86362001)(426003)(30864003)(54906003)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4547;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9211cd2e-97b1-49db-5ba9-08d79f2833d8
X-MS-TrafficTypeDiagnostic: BN7PR07MB4547:
X-Microsoft-Antispam-PRVS: <BN7PR07MB45476EA7DCAE9599A261CC3AD20C0@BN7PR07MB4547.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:102;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rEgaIyJrzllimexDKBGKctikF5/Ra+a2ktDHmAHSc2efSzqE+pZ34JJ4i0ACobMlCbs/nKiNuemjIlVq0EnB+PIXZrU4KGJDBupfjP5Cjj5Kbk2CC6l6eamisRaPEJSirgb1tvQBXNO+I7xYMedqZ5dnXdFxENrA51Y0Fx4kQT0YIL0B3i7QTOY89GWUvIwdMH8pUtASHPIinRKNy5E/bK7CBlYo9N5bIDfKJZt/NqREsd3IA6+HL4yDnNz0+W52I3XqQqNGbGvBIjbCnqsyAGtP6e9QBesgd+7IQ3UCMzxeLCrge6ycuvMdhbe2pNyv1gvPtdYW6Wa0j7hTjJHGZ3vxY5minXXJkpW5mdFrJDoti6MoDYVxUjUE3AzPEqNgJN7OaiJd8o7fz14jGikUPa3gm4M9c4Ax1U2PSyxz8uxfTF2qTCP7wnZdgqGInXBvwI/5m9Ujz5M2Nj1nJUddz0i7HqEI5Lg8TU/NkrldGkQPw3J/R59C8zmVbYaw0vt
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:31.1511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9211cd2e-97b1-49db-5ba9-08d79f2833d8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4547
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

Implement single link subnode support to the phy driver. The driver
only supports PHY_TYPE_DP with master lane as 0. Add reset support
including PHY reset and individual lane reset.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 293 ++++++++++++++++++++++--------
 1 file changed, 218 insertions(+), 75 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 851a685..78252c2 100644
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
@@ -1678,12 +1726,21 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (!cdns_phy)
 		return -ENOMEM;
 
-	cdns_phy->dev = &pdev->dev;
+	dev_set_drvdata(dev, cdns_phy);
+	cdns_phy->dev = dev;
 
-	phy = devm_phy_create(dev, NULL, &cdns_torrent_phy_ops);
-	if (IS_ERR(phy)) {
-		dev_err(dev, "failed to create Torrent PHY\n");
-		return PTR_ERR(phy);
+	cdns_phy->phy_rst = devm_reset_control_get_exclusive(dev,
+							     "torrent_reset");
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
@@ -1691,78 +1748,163 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
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
@@ -1790,6 +1932,7 @@ MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
 
 static struct platform_driver cdns_torrent_phy_driver = {
 	.probe	= cdns_torrent_phy_probe,
+	.remove = cdns_torrent_phy_remove,
 	.driver = {
 		.name	= "cdns-torrent-phy",
 		.of_match_table	= cdns_torrent_phy_of_match,
-- 
2.4.5

