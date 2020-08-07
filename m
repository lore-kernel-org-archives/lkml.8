Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BC4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38082075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="KDLJaZVk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="FbMSeHug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgHGLrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:47:15 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:19332 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728368AbgHGLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:36 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BjYOq031923;
        Fri, 7 Aug 2020 04:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=1MT0Vs1sgMYuXtbZfgSznaxQMuQllV/XL/q/GU/wApo=;
 b=KDLJaZVkuQH1glXsqHulMWYVeeu6bt3E824868clMp+QBFC5nJ4c8jiUpCqRNNMBSxEn
 7nOzF+10WEF4LawL1kcHu++uO26biDZXlwdWkRNkZom7TfakoUbrGX8LAY4kYzfIxXl5
 1/2b2tHKu0IvscsAM2Tv1GlDovi6XyMusEwi8LyLLDyVUBoMyWSsPudlf5JS2k0P/XOx
 SDl1RtxWVuQEc77S4FZMxdMxs3ImHim0GahiGa8b/pCMfbXfrPBpDnp/EIsB7xBGNd3g
 oxfdqBY98cSaIvEhOTBUpM7P1QT0iSvo/+LfInrVL2A+OLEPpKb915NsAYWc419BoLpV vw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gy61d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr0H6Wt8LdMKLxsx91LdAtHvv5uA0VuDnnU2/gblZg1Nlw665WRw1/zouXzr8Rp0s33hlGQKScsE5nW+RiT4HJI2osmgtFkphQgnB/uHkOQI/nCPsG/aBtcUlJdROuNriwq5iw5AoEzOX0BYbMkEmldpEFQiBqaCQrUeoKQeofXANonMoQKu4DJlHe67hoel4W+LAQTV6th6n7zULN03kdFQh7mQ+mN2hEoP1cpdQ32BZXIHWyVcG/v3dC9d5vxUo1jZYixgJAi9Eth/v+lTb1atu73G+s4VRz7d1xxHsqekYbWlyGRZpwcNI5l3sjJE57dscP5MyspMhkvAvJ/CAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MT0Vs1sgMYuXtbZfgSznaxQMuQllV/XL/q/GU/wApo=;
 b=hUJ/HZfte/v2/WNgOpuZIQynZbgznEo7ZjGdDhK+EfwFIkBOwPocjZu4T2hjjwveFCqnZYcH3JPSZh20TCizGY80sU3jQzOMJA1rzgv5QH2SsSshkvvKDWCfrQc81/ezZvo+e5D4Mq9yNHL3PGy41i+Pa0s0xRAw1njxqd6l3XRROl4JQDSvMLT/hTFaN0OhrdVfy0r7uRzcTOewOWwbS0gWFRhfEzsBbZt/uH2izEyfgZ+AnKfel6DCOoDUldMEKqniI+Uvk63VwUBe30DJUbiHJ/VsC5DrkZM+vOLLuteJd15iMNMUf6q0rpbV+u2C2ua9ZW+5pcH6YDlILtVv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MT0Vs1sgMYuXtbZfgSznaxQMuQllV/XL/q/GU/wApo=;
 b=FbMSeHugPq57rRAXtEeg4jF970fZ3Ef/6sA3YY3xhoRnv050SPbZkvG1PfTScNZODJhm0FjuTx749J5k3CQr/RwenwWWq1RZsWkk4skE9+qBHPtyUc6Z4snKTTmWZxlcddq9zPNtcI1X7cJ8qEDwVTEKfA/FfKLiK2e01QgpSWU=
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by DS7PR07MB7621.namprd07.prod.outlook.com (2603:10b6:5:2cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 11:46:24 +0000
Received: from BN8NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::2d) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.13 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT048.mail.protection.outlook.com (10.13.182.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PG029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:23 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9BL000869;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk9Js000868;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 11/13] phy: cadence-torrent: Add single link USB register sequences
Date:   Fri, 7 Aug 2020 13:46:05 +0200
Message-ID: <1596800767-784-12-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1e1f61f-b537-48fd-e931-08d83ac78329
X-MS-TrafficTypeDiagnostic: DS7PR07MB7621:
X-Microsoft-Antispam-PRVS: <DS7PR07MB76217C28C38ACEF221A4CC43C5490@DS7PR07MB7621.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCuE2WQwl3eOFoTeWau8DSfGkHNo0nEPvtH2LT+4KvxpxA9Aa1whfsnlNCS5DXzveExv7DsddS+ZzUlANnJfXpVA2va6U6/RThnCfT3HnbsPNT8jelY4maSQqckftpTARoy+b7Vp4OOhenImrsg3ReIbEVR00y9P3S23fKCpc/jkbxv3EW8IKZawUR69nlXEx1uRgBZdb8WX4GgMYvGxCCYx77BwtmpElikzCDP/TSzY4UXRZSXhXmlPeKF+rQxgum7Kdgnqux4O41ymXlgl4FheT1CNTVmXyIRDb4xRM512CLZE3I3+Jcnpuuf3NQ732l4CBk3G4aFb7P2H/dG5d53EpMf7cMnuEKHAufovzc/AV9u8ghHGYm5PihFtmNp7k4bcLOhajVb6CTw9BKxslLvSsY1dVKomQb1o4BmWMxo=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36092001)(46966005)(110136005)(54906003)(86362001)(186003)(82310400002)(426003)(36906005)(8936002)(36756003)(26005)(42186006)(316002)(8676002)(4326008)(2616005)(336012)(82740400003)(5660300002)(47076004)(6666004)(2906002)(70586007)(70206006)(83380400001)(356005)(478600001)(30864003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:24.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e1f61f-b537-48fd-e931-08d83ac78329
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT048.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7621
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=844 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single link USB configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 260 +++++++++++++++++++++-
 1 file changed, 259 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index b291b63afba8..9b4eb4647401 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -29,7 +29,7 @@
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		5
+#define NUM_PHY_TYPE		6
 
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
@@ -82,6 +82,8 @@
 #define CMN_PLLSM0_PLLLOCK_TMR		0x002CU
 #define CMN_PLLSM1_PLLPRE_TMR		0x0032U
 #define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
+#define CMN_CDIAG_CDB_PWRI_OVRD		0x0041U
+#define CMN_CDIAG_XCVRC_PWRI_OVRD	0x0047U
 #define CMN_BGCAL_INIT_TMR		0x0064U
 #define CMN_BGCAL_ITER_TMR		0x0065U
 #define CMN_IBCAL_INIT_TMR		0x0074U
@@ -159,13 +161,16 @@
 /* PMA TX Lane registers */
 #define TX_TXCC_CTRL			0x0040U
 #define TX_TXCC_CPOST_MULT_00		0x004CU
+#define TX_TXCC_CPOST_MULT_01		0x004DU
 #define TX_TXCC_MGNFS_MULT_000		0x0050U
 #define DRV_DIAG_TX_DRV			0x00C6U
 #define XCVR_DIAG_PLLDRC_CTRL		0x00E5U
 #define XCVR_DIAG_HSCLK_SEL		0x00E6U
 #define XCVR_DIAG_HSCLK_DIV		0x00E7U
 #define XCVR_DIAG_BIDI_CTRL		0x00EAU
+#define XCVR_DIAG_PSC_OVRD		0x00EBU
 #define TX_PSC_A0			0x0100U
+#define TX_PSC_A1			0x0101U
 #define TX_PSC_A2			0x0102U
 #define TX_PSC_A3			0x0103U
 #define TX_RCVDET_ST_TMR		0x0123U
@@ -174,27 +179,37 @@
 
 /* PMA RX Lane registers */
 #define RX_PSC_A0			0x0000U
+#define RX_PSC_A1			0x0001U
 #define RX_PSC_A2			0x0002U
 #define RX_PSC_A3			0x0003U
 #define RX_PSC_CAL			0x0006U
 #define RX_CDRLF_CNFG			0x0080U
+#define RX_CDRLF_CNFG3			0x0082U
+#define RX_SIGDET_HL_FILT_TMR		0x0090U
 #define RX_REE_GCSM1_CTRL		0x0108U
 #define RX_REE_GCSM1_EQENM_PH1		0x0109U
 #define RX_REE_GCSM1_EQENM_PH2		0x010AU
 #define RX_REE_GCSM2_CTRL		0x0110U
 #define RX_REE_PERGCSM_CTRL		0x0118U
+#define RX_REE_ATTEN_THR		0x0149U
 #define RX_REE_TAP1_CLIP		0x0171U
 #define RX_REE_TAP2TON_CLIP		0x0172U
+#define RX_REE_SMGM_CTRL1		0x0177U
+#define RX_REE_SMGM_CTRL2		0x0178U
 #define RX_DIAG_DFE_CTRL		0x01E0U
 #define RX_DIAG_DFE_AMP_TUNE_2		0x01E2U
 #define RX_DIAG_DFE_AMP_TUNE_3		0x01E3U
 #define RX_DIAG_NQST_CTRL		0x01E5U
+#define RX_DIAG_SIGDET_TUNE		0x01E8U
 #define RX_DIAG_PI_RATE			0x01F4U
 #define RX_DIAG_PI_CAP			0x01F5U
 #define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
 #define PHY_PLL_CFG			0x000EU
+#define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
+#define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
+#define PHY_PIPE_USB3_GEN2_POST_CFG1	0x0023U
 
 /* PHY PMA common registers */
 #define PHY_PMA_CMN_CTRL1		0x0000U
@@ -222,6 +237,7 @@ enum cdns_torrent_phy_type {
 	TYPE_PCIE,
 	TYPE_SGMII,
 	TYPE_QSGMII,
+	TYPE_USB,
 };
 
 enum cdns_torrent_ssc_mode {
@@ -327,6 +343,8 @@ struct cdns_torrent_data {
 					       [NUM_SSC_MODE];
 	struct cdns_torrent_vals *xcvr_diag_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 						[NUM_SSC_MODE];
+	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					      [NUM_SSC_MODE];
 	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					  [NUM_SSC_MODE];
 	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -1813,6 +1831,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
+	struct cdns_torrent_vals *pcs_cmn_vals;
 	struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
@@ -1861,6 +1880,17 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		}
 	}
 
+	/* PHY PCS common registers configurations */
+	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pcs_cmn_vals) {
+		reg_pairs = pcs_cmn_vals->reg_pairs;
+		num_regs = pcs_cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
@@ -2153,6 +2183,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		case PHY_TYPE_QSGMII:
 			cdns_phy->phys[node].phy_type = TYPE_QSGMII;
 			break;
+		case PHY_TYPE_USB3:
+			cdns_phy->phys[node].phy_type = TYPE_USB;
+			break;
 		default:
 			dev_err(dev, "Unsupported protocol\n");
 			ret = -EINVAL;
@@ -2301,6 +2334,143 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Single USB link configuration */
+static struct cdns_reg_pairs sl_usb_link_cmn_regs[] = {
+	{0x0000, PHY_PLL_CFG},
+	{0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs sl_usb_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals sl_usb_link_cmn_vals = {
+	.reg_pairs = sl_usb_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = sl_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_xcvr_diag_ln_regs),
+};
+
+/* USB PHY PCS common configuration */
+static struct cdns_reg_pairs usb_phy_pcs_cmn_regs[] = {
+	{0x0A0A, PHY_PIPE_USB3_GEN2_PRE_CFG0},
+	{0x1000, PHY_PIPE_USB3_GEN2_POST_CFG0},
+	{0x0010, PHY_PIPE_USB3_GEN2_POST_CFG1}
+};
+
+static struct cdns_torrent_vals usb_phy_pcs_cmn_vals = {
+	.reg_pairs = usb_phy_pcs_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_phy_pcs_cmn_regs),
+};
+
+/* USB 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs usb_100_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
+};
+
+static struct cdns_reg_pairs usb_100_no_ssc_tx_ln_regs[] = {
+	{0x02FF, TX_PSC_A0},
+	{0x06AF, TX_PSC_A1},
+	{0x06AE, TX_PSC_A2},
+	{0x06AE, TX_PSC_A3},
+	{0x2A82, TX_TXCC_CTRL},
+	{0x0014, TX_TXCC_CPOST_MULT_01},
+	{0x0003, XCVR_DIAG_PSC_OVRD}
+};
+
+static struct cdns_reg_pairs usb_100_no_ssc_rx_ln_regs[] = {
+	{0x0D1D, RX_PSC_A0},
+	{0x0D1D, RX_PSC_A1},
+	{0x0D00, RX_PSC_A2},
+	{0x0500, RX_PSC_A3},
+	{0x0013, RX_SIGDET_HL_FILT_TMR},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0C02, RX_REE_ATTEN_THR},
+	{0x0330, RX_REE_SMGM_CTRL1},
+	{0x0300, RX_REE_SMGM_CTRL2},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x1004, RX_DIAG_SIGDET_TUNE},
+	{0x00F9, RX_DIAG_NQST_CTRL},
+	{0x0C01, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0002, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0000, RX_DIAG_PI_CAP},
+	{0x0031, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG},
+	{0x0003, RX_CDRLF_CNFG3}
+};
+
+static struct cdns_torrent_vals usb_100_no_ssc_cmn_vals = {
+	.reg_pairs = usb_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals usb_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = usb_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals usb_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = usb_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_100_no_ssc_rx_ln_regs),
+};
+
+/* Single link USB, 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs sl_usb_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0064, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0044, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x006E, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x000E, CMN_PLL1_SS_CTRL4_M0},
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
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR},
+	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
+};
+
+static struct cdns_torrent_vals sl_usb_100_int_ssc_cmn_vals = {
+	.reg_pairs = sl_usb_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_100_int_ssc_cmn_regs),
+};
+
 /* PCIe and SGMII/QSGMII Unique SSC link configuration */
 static struct cdns_reg_pairs pcie_sgmii_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -2749,6 +2919,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
+			},
+		},
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
@@ -2788,6 +2965,22 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+			},
+		},
+	},
+	.pcs_cmn_vals = {
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+		},
 	},
 	.cmn_vals = {
 		[TYPE_PCIE] = {
@@ -2827,6 +3020,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+		},
 	},
 	.tx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -2866,6 +3066,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+		},
 	},
 	.rx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -2905,6 +3112,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+		},
 	},
 };
 
@@ -2949,6 +3163,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
+			},
+		},
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
@@ -2988,6 +3209,22 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+			},
+		},
+	},
+	.pcs_cmn_vals = {
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+		},
 	},
 	.cmn_vals = {
 		[TYPE_PCIE] = {
@@ -3027,6 +3264,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+		},
 	},
 	.tx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -3066,6 +3310,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+		},
 	},
 	.rx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -3105,6 +3356,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+		},
 	},
 };
 
-- 
2.26.1

