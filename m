Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E102075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CfN7veip";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="m406boSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHGLr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:47:26 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:13368 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728159AbgHGLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:32 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhO1V011150;
        Fri, 7 Aug 2020 04:46:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rTrJXZuqOXBXoEJmhJVylW/FOC/OH5tLVkHssWKPUqs=;
 b=CfN7veip/OdKlqHtP4jhnWgqZH+wBdYMsBiuldrc1biPOxQjGBDM9u0/J0RKKbbZI0An
 uax/Z/KbcCCSz1St8DmMa7TA02HNnmDweXghNMqV/dcNMBKNPfEWsFXx9d3RdEmuya45
 mUvolbX3T0SmHIPxnOWf/EQmAsAycsC/ZOH0fYMTIofKh59qMvyr3nCGKzgSCic9Yxuw
 pxibF2C2ypMA/B7ql4c05NSJjOm2TODMRUXSfN31fMntN2gAiBU2HNyRZss+DQXsYcuS
 A5ryENhxXgIrZ1UFS0hE7eDDh3J+IOyBqoPCG3mTyyE0TWNl7uVnaMs6PASULElqakRl vw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com ([104.47.51.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAXxO6tBQHYi8bh7ynGQqwEUh39/BY8EZWrW8jC7e5rbOsq+3SEFxT5kBrIMZIEfDAHElm/XoQp4Ue1BT5/XLiON53FLEJN6CadQa85Iipp0pbcIvlwpSYMB/+Fk2mGRgACrFRKYsKN0AAYhzfxmMhpNRVhJsxs1aCJWB/SWPaUmyj9glduveDgdGhqfBIYIx9axnGsq6kkPf+vXku0XRgd5Mx+ijXIs/cIk9089z6yH5F4WVgFOPOI1e/Aw/P1uCL23YxvTc/PQFm3WtNAPY8ov5StkzpQ4FmmiFnycL4+u2w3ziGkXoHyVK6wbYNs4UAUQa/COKmO+Q1cJStG4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTrJXZuqOXBXoEJmhJVylW/FOC/OH5tLVkHssWKPUqs=;
 b=X37mYY5SzwkJwbe5c8me2bDGjhWK7jNfcX19WNWBCnVm7bVbDBvEUc/6c3z7KWQQ4Yp0rD25QLjXF6qZDkLc/SjcJqWhQTfa9sAJZGeV1IpR8DH82wExhEtcz6s4OujfC5WoG+9lSsm8MOscLZbq2Nonjwf0iTOrk2gx/cgU0fkhqMxx4sCbQI9fLGQhb75ZZLgVD6lK/nPq7kQIQtPf7DAE2psUCfN/sFqIJhprUQjJwKl7YQ21WsK6DDNerguzWmhecNoM053h0xrrnGwJ1NreAIASDsp8Qr/GWfG4A8ywFM1v2w2rQiitbMbvR+C2RxkgW3nuC0HElHu/OVA8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTrJXZuqOXBXoEJmhJVylW/FOC/OH5tLVkHssWKPUqs=;
 b=m406boSVs/HChCqh786BCFMjiT6uYASsK4KIV6dZ1qzhUfYlBU9pBbuCxU0T6dgn45Cq+MDmOoF/uXY36vvCfdMmYo1LgmfrWsKdO5E3r01KXVcqfG3xYhUvzqyM7GztEl5jZaip64mhJXxL/Do7FRGg3wwBaGcgSU9IZxn6DWE=
Received: from BN6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:404:65::31)
 by BN7PR07MB4467.namprd07.prod.outlook.com (2603:10b6:406:b6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Fri, 7 Aug
 2020 11:46:18 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::43) by BN6PR17CA0021.outlook.office365.com
 (2603:10b6:404:65::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PA029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:17 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9Ng000844;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk9Rt000843;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 05/13] phy: cadence-torrent: Add support for PHY multilink configuration
Date:   Fri, 7 Aug 2020 13:45:59 +0200
Message-ID: <1596800767-784-6-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4668d822-e701-487a-4efb-08d83ac77f6b
X-MS-TrafficTypeDiagnostic: BN7PR07MB4467:
X-Microsoft-Antispam-PRVS: <BN7PR07MB44679979475F3C8CBA13564BC5490@BN7PR07MB4467.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqRw6ymGOmtJO22ZtwmutvVFY9S91CKgUCQhF5UbrR9J+VkjfCMpS1TiMHQY55xTwoXEk39Mg5lrO5cwgUQ3LQmEeGGwpRxJ1a+BDsLUXlWfIzQVCZ/bGH8JWMVsKOCj+cwjXB2BGy2KWGXI1TPbPxyTbhDcf3xk7T7KJ66PEoFHJ4ZZ+kLXAwxU30KvJg3N4/aS5I0VzFWQ1TwEdNKDB9Ma2f2Sg4J4h1+UEhpNVC0FdGnlWxFFTGgvU/pXtC7+LUw39Yr7NQqnFoDyN+dvxw8QWs0reEttS8OOspM4QeG7NVPzFyv/pb3Cvtp4E0Gu37vjLS4aInWGb14xMyW05eRdJGRzcbaPsZWZNbl88T5cF5QydJEAnmwX0g/DWIC6NPRdI5rYJ0eN7h1y6/9PUSaSv+vi+09OHnmHWtt0y6U=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36092001)(46966005)(30864003)(70586007)(5660300002)(2616005)(8676002)(6666004)(86362001)(36756003)(426003)(70206006)(478600001)(336012)(110136005)(54906003)(82740400003)(36906005)(186003)(26005)(2906002)(356005)(82310400002)(81166007)(83380400001)(316002)(42186006)(47076004)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:18.3197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4668d822-e701-487a-4efb-08d83ac77f6b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4467
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for multilink configuration of Torrent PHY. Currently,
maximum two links are supported. In case of multilink configuration,
PHY needs to be configured for both the protocols simultaneously at
the beginning as per the requirement of Torrent PHY.
Also, register sequences for PCIe + SGMII/QSGMII Unique SSC PHY multilink
configurations are added.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 783 +++++++++++++++++++++-
 1 file changed, 757 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 7ccdb3105783..c55f8bde52f1 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -29,7 +29,7 @@
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		2
+#define NUM_PHY_TYPE		5
 
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
@@ -127,8 +127,10 @@
 #define CMN_PLL1_LOCK_REFCNT_START      0x00DCU
 #define CMN_PLL1_LOCK_PLLCNT_START	0x00DEU
 #define CMN_PLL1_LOCK_PLLCNT_THR        0x00DFU
+#define CMN_TXPUCAL_TUNE		0x0103U
 #define CMN_TXPUCAL_INIT_TMR		0x0104U
 #define CMN_TXPUCAL_ITER_TMR		0x0105U
+#define CMN_TXPDCAL_TUNE		0x010BU
 #define CMN_TXPDCAL_INIT_TMR		0x010CU
 #define CMN_TXPDCAL_ITER_TMR		0x010DU
 #define CMN_RXCAL_INIT_TMR		0x0114U
@@ -143,6 +145,7 @@
 #define CMN_PDIAG_PLL0_CP_IADJ_M0	0x01A5U
 #define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x01A6U
 #define CMN_PDIAG_PLL0_CTRL_M1		0x01B0U
+#define CMN_PDIAG_PLL0_CLK_SEL_M1	0x01B1U
 #define CMN_PDIAG_PLL0_CP_PADJ_M1	0x01B4U
 #define CMN_PDIAG_PLL0_CP_IADJ_M1	0x01B5U
 #define CMN_PDIAG_PLL0_FILT_PADJ_M1	0x01B6U
@@ -151,6 +154,7 @@
 #define CMN_PDIAG_PLL1_CP_PADJ_M0	0x01C4U
 #define CMN_PDIAG_PLL1_CP_IADJ_M0	0x01C5U
 #define CMN_PDIAG_PLL1_FILT_PADJ_M0	0x01C6U
+#define CMN_DIAG_BIAS_OVRD1		0x01E1U
 
 /* PMA TX Lane registers */
 #define TX_TXCC_CTRL			0x0040U
@@ -173,11 +177,20 @@
 #define RX_PSC_A2			0x0002U
 #define RX_PSC_A3			0x0003U
 #define RX_PSC_CAL			0x0006U
+#define RX_CDRLF_CNFG			0x0080U
 #define RX_REE_GCSM1_CTRL		0x0108U
+#define RX_REE_GCSM1_EQENM_PH1		0x0109U
+#define RX_REE_GCSM1_EQENM_PH2		0x010AU
 #define RX_REE_GCSM2_CTRL		0x0110U
 #define RX_REE_PERGCSM_CTRL		0x0118U
 #define RX_REE_TAP1_CLIP		0x0171U
 #define RX_REE_TAP2TON_CLIP		0x0172U
+#define RX_DIAG_DFE_CTRL		0x01E0U
+#define RX_DIAG_DFE_AMP_TUNE_2		0x01E2U
+#define RX_DIAG_DFE_AMP_TUNE_3		0x01E3U
+#define RX_DIAG_NQST_CTRL		0x01E5U
+#define RX_DIAG_PI_RATE			0x01F4U
+#define RX_DIAG_PI_CAP			0x01F5U
 #define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
@@ -204,8 +217,11 @@ static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
 enum cdns_torrent_phy_type {
+	TYPE_NONE,
 	TYPE_DP,
-	TYPE_PCIE
+	TYPE_PCIE,
+	TYPE_SGMII,
+	TYPE_QSGMII,
 };
 
 enum cdns_torrent_ssc_mode {
@@ -309,9 +325,16 @@ struct cdns_torrent_vals {
 struct cdns_torrent_data {
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
-	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
-	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
-	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *link_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					       [NUM_SSC_MODE];
+	struct cdns_torrent_vals *xcvr_diag_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						[NUM_SSC_MODE];
+	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					  [NUM_SSC_MODE];
+	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					    [NUM_SSC_MODE];
+	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					    [NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -1787,6 +1810,7 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 static int cdns_torrent_phy_init(struct phy *phy)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
@@ -1809,11 +1833,14 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		return -EINVAL;
 	}
 
+	if (cdns_phy->nsubnodes > 1)
+		return 0;
+
 	if (phy_type == TYPE_DP)
 		return cdns_torrent_dp_init(phy);
 
 	/* PMA common registers configurations */
-	cmn_vals = cdns_phy->init_data->cmn_vals[phy_type][ssc];
+	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
 		reg_pairs = cmn_vals->reg_pairs;
 		num_regs = cmn_vals->num_regs;
@@ -1824,7 +1851,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA TX lane registers configurations */
-	tx_ln_vals = cdns_phy->init_data->tx_ln_vals[phy_type][ssc];
+	tx_ln_vals = init_data->tx_ln_vals[phy_type][TYPE_NONE][ssc];
 	if (tx_ln_vals) {
 		reg_pairs = tx_ln_vals->reg_pairs;
 		num_regs = tx_ln_vals->num_regs;
@@ -1837,7 +1864,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA RX lane registers configurations */
-	rx_ln_vals = cdns_phy->init_data->rx_ln_vals[phy_type][ssc];
+	rx_ln_vals = init_data->rx_ln_vals[phy_type][TYPE_NONE][ssc];
 	if (rx_ln_vals) {
 		reg_pairs = rx_ln_vals->reg_pairs;
 		num_regs = rx_ln_vals->num_regs;
@@ -1852,6 +1879,121 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	return 0;
 }
 
+static
+int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
+{
+	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
+	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
+	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
+	int i, j, node, mlane, num_lanes;
+	struct cdns_reg_pairs *reg_pairs;
+	enum cdns_torrent_ssc_mode ssc;
+	struct regmap *regmap;
+	u32 num_regs;
+
+	/* Maximum 2 links (subnodes) are supported */
+	if (cdns_phy->nsubnodes != 2)
+		return -EINVAL;
+
+	phy_t1 = cdns_phy->phys[0].phy_type;
+	phy_t2 = cdns_phy->phys[1].phy_type;
+
+	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0003);
+
+	/**
+	 * First configure the PHY for first link with phy_t1. Get the array
+	 * values as [phy_t1][phy_t2][ssc].
+	 */
+	for (node = 0; node < cdns_phy->nsubnodes; node++) {
+		if (node == 1) {
+			/**
+			 * If first link with phy_t1 is configured, then
+			 * configure the PHY for second link with phy_t2.
+			 * Get the array values as [phy_t2][phy_t1][ssc].
+			 */
+			tmp_phy_type = phy_t1;
+			phy_t1 = phy_t2;
+			phy_t2 = tmp_phy_type;
+		}
+
+		mlane = cdns_phy->phys[node].mlane;
+		ssc = cdns_phy->phys[node].ssc_mode;
+		num_lanes = cdns_phy->phys[node].num_lanes;
+
+		/**
+		 * PHY configuration specific registers:
+		 * link_cmn_vals depend on combination of PHY types being
+		 * configured and are common for both PHY types, so array
+		 * values should be same for [phy_t1][phy_t2][ssc] and
+		 * [phy_t2][phy_t1][ssc].
+		 * xcvr_diag_vals also depend on combination of PHY types
+		 * being configured, but these can be different for particular
+		 * PHY type and are per lane.
+		 */
+		link_cmn_vals = init_data->link_cmn_vals[phy_t1][phy_t2][ssc];
+		if (link_cmn_vals) {
+			reg_pairs = link_cmn_vals->reg_pairs;
+			num_regs = link_cmn_vals->num_regs;
+			regmap = cdns_phy->regmap_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off,
+					     reg_pairs[i].val);
+		}
+
+		xcvr_diag_vals = init_data->xcvr_diag_vals[phy_t1][phy_t2][ssc];
+		if (xcvr_diag_vals) {
+			reg_pairs = xcvr_diag_vals->reg_pairs;
+			num_regs = xcvr_diag_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off,
+						     reg_pairs[j].val);
+			}
+		}
+
+		/* PMA common registers configurations */
+		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
+		if (cmn_vals) {
+			reg_pairs = cmn_vals->reg_pairs;
+			num_regs = cmn_vals->num_regs;
+			regmap = cdns_phy->regmap_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off,
+					     reg_pairs[i].val);
+		}
+
+		/* PMA TX lane registers configurations */
+		tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
+		if (tx_ln_vals) {
+			reg_pairs = tx_ln_vals->reg_pairs;
+			num_regs = tx_ln_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = cdns_phy->regmap_tx_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off,
+						     reg_pairs[j].val);
+			}
+		}
+
+		/* PMA RX lane registers configurations */
+		rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
+		if (rx_ln_vals) {
+			reg_pairs = rx_ln_vals->reg_pairs;
+			num_regs = rx_ln_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = cdns_phy->regmap_rx_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off,
+						     reg_pairs[j].val);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_torrent_phy *cdns_phy;
@@ -1922,6 +2064,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
+		/* PHY subnode name must be 'link'. */
+		if (!(of_node_name_eq(child, "link")))
+			continue;
+
 		cdns_phy->phys[node].lnk_rst =
 				of_reset_control_array_get_exclusive(child);
 		if (IS_ERR(cdns_phy->phys[node].lnk_rst)) {
@@ -1953,6 +2099,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		case PHY_TYPE_DP:
 			cdns_phy->phys[node].phy_type = TYPE_DP;
 			break;
+		case PHY_TYPE_SGMII:
+			cdns_phy->phys[node].phy_type = TYPE_SGMII;
+			break;
+		case PHY_TYPE_QSGMII:
+			cdns_phy->phys[node].phy_type = TYPE_QSGMII;
+			break;
 		default:
 			dev_err(dev, "Unsupported protocol\n");
 			ret = -EINVAL;
@@ -2059,6 +2211,12 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		goto put_lnk_rst;
 	}
 
+	if (cdns_phy->nsubnodes > 1) {
+		ret = cdns_torrent_phy_configure_multilink(cdns_phy);
+		if (ret)
+			goto put_lnk_rst;
+	}
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
 		ret = PTR_ERR(phy_provider);
@@ -2092,6 +2250,311 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIe and SGMII/QSGMII Unique SSC link configuration */
+static struct cdns_reg_pairs pcie_sgmii_link_cmn_regs[] = {
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
+	{0x0601, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs pcie_sgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs sgmii_pcie_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0003, XCVR_DIAG_HSCLK_DIV},
+	{0x009B, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_sgmii_link_cmn_vals = {
+	.reg_pairs = pcie_sgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_sgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_sgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_sgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_sgmii_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals sgmii_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = sgmii_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_pcie_xcvr_diag_ln_regs),
+};
+
+/* SGMII 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs sgmii_100_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x3700, CMN_DIAG_BIAS_OVRD1},
+	{0x0008, CMN_TXPUCAL_TUNE},
+	{0x0008, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_reg_pairs sgmii_100_no_ssc_tx_ln_regs[] = {
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3},
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x00B3, DRV_DIAG_TX_DRV}
+};
+
+static struct cdns_reg_pairs sgmii_100_no_ssc_rx_ln_regs[] = {
+	{0x091D, RX_PSC_A0},
+	{0x0900, RX_PSC_A2},
+	{0x0100, RX_PSC_A3},
+	{0x03C7, RX_REE_GCSM1_EQENM_PH1},
+	{0x01C7, RX_REE_GCSM1_EQENM_PH2},
+	{0x0000, RX_DIAG_DFE_CTRL},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x0098, RX_DIAG_NQST_CTRL},
+	{0x0C01, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0000, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0000, RX_DIAG_PI_CAP},
+	{0x0010, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG},
+};
+
+static struct cdns_torrent_vals sgmii_100_no_ssc_cmn_vals = {
+	.reg_pairs = sgmii_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals sgmii_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = sgmii_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals sgmii_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = sgmii_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_rx_ln_regs),
+};
+
+/* SGMII 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs sgmii_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M1},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M1},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M1},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M1},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0050, CMN_PLL0_INTDIV_M1},
+	{0x0064, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M1},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0036, CMN_PLL0_HIGH_THR_M1},
+	{0x0044, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M1},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M1},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M1},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x0058, CMN_PLL0_SS_CTRL3_M1},
+	{0x006E, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x0012, CMN_PLL0_SS_CTRL4_M1},
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
+	{0x3700, CMN_DIAG_BIAS_OVRD1},
+	{0x0008, CMN_TXPUCAL_TUNE},
+	{0x0008, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_torrent_vals sgmii_100_int_ssc_cmn_vals = {
+	.reg_pairs = sgmii_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sgmii_100_int_ssc_cmn_regs),
+};
+
+/* QSGMII 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs qsgmii_100_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs qsgmii_100_no_ssc_tx_ln_regs[] = {
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3},
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0003, DRV_DIAG_TX_DRV}
+};
+
+static struct cdns_reg_pairs qsgmii_100_no_ssc_rx_ln_regs[] = {
+	{0x091D, RX_PSC_A0},
+	{0x0900, RX_PSC_A2},
+	{0x0100, RX_PSC_A3},
+	{0x03C7, RX_REE_GCSM1_EQENM_PH1},
+	{0x01C7, RX_REE_GCSM1_EQENM_PH2},
+	{0x0000, RX_DIAG_DFE_CTRL},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x0098, RX_DIAG_NQST_CTRL},
+	{0x0C01, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0000, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0000, RX_DIAG_PI_CAP},
+	{0x0010, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG},
+};
+
+static struct cdns_torrent_vals qsgmii_100_no_ssc_cmn_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals qsgmii_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals qsgmii_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_rx_ln_regs),
+};
+
+/* QSGMII 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs qsgmii_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M1},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M1},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M1},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M1},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0050, CMN_PLL0_INTDIV_M1},
+	{0x0064, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M1},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0036, CMN_PLL0_HIGH_THR_M1},
+	{0x0044, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M1},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M1},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M1},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x0058, CMN_PLL0_SS_CTRL3_M1},
+	{0x006E, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x0012, CMN_PLL0_SS_CTRL4_M1},
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
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
+};
+
+static struct cdns_torrent_vals qsgmii_100_int_ssc_cmn_vals = {
+	.reg_pairs = qsgmii_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_int_ssc_cmn_regs),
+};
+
+/* Multi link PCIe, 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs pcie_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M1},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M1},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M1},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M1},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0050, CMN_PLL0_INTDIV_M1},
+	{0x0064, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M1},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0036, CMN_PLL0_HIGH_THR_M1},
+	{0x0044, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M1},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M1},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M1},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x0058, CMN_PLL0_SS_CTRL3_M1},
+	{0x006E, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x0012, CMN_PLL0_SS_CTRL4_M1},
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
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
+};
+
+static struct cdns_torrent_vals pcie_100_int_ssc_cmn_vals = {
+	.reg_pairs = pcie_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_int_ssc_cmn_regs),
+};
+
 /* Single link PCIe, 100 MHz Ref clk, internal SSC */
 static struct cdns_reg_pairs sl_pcie_100_int_ssc_cmn_regs[] = {
 	{0x0004, CMN_PLL0_DSM_DIAG_M0},
@@ -2174,25 +2637,159 @@ static struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
 static const struct cdns_torrent_data cdns_map_torrent = {
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.link_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+		},
+	},
+	.xcvr_diag_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+			},
+		},
+	},
 	.cmn_vals = {
 		[TYPE_PCIE] = {
-			[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-			[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-			[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
 		[TYPE_PCIE] = {
-			[NO_SSC] = NULL,
-			[EXTERNAL_SSC] = NULL,
-			[INTERNAL_SSC] = NULL,
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
 		[TYPE_PCIE] = {
-			[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
@@ -2200,25 +2797,159 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.link_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
+			},
+		},
+	},
+	.xcvr_diag_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
+			},
+		},
+	},
 	.cmn_vals = {
 		[TYPE_PCIE] = {
-			[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-			[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-			[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
 		[TYPE_PCIE] = {
-			[NO_SSC] = NULL,
-			[EXTERNAL_SSC] = NULL,
-			[INTERNAL_SSC] = NULL,
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
 		[TYPE_PCIE] = {
-			[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
+		},
+		[TYPE_SGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
+		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
-- 
2.26.1

