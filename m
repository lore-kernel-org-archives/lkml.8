Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4604C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73ADB2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="loCr4f3/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Z480/lYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHGLqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:48532 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbgHGLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:35 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhVmR011321;
        Fri, 7 Aug 2020 04:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=0KpaA+NVDAqhOZtgwLBJycbqxkBtZHuTEYObhDYLA7Y=;
 b=loCr4f3/rrdTZqcxbx8+3cEpGprwV/LKY3JOpurmI44cYrl9j7J6Qg0L93W1/PXLUlgQ
 fUR5HRW3CvphYr9T+87qGHcShd8F4ZpK7Y/rl7GPr7FRbBzHfpQliwrnSJE23ad/S0E2
 nv4mznjpO0fnqzrHDKq6AUDMXOL4TMGs/xgbk18NM1swgC2qotbL7FaayhrvXd7vI9jV
 mIzTXYoaQGtZD+RRT30lfpWMfiB7nNCw/HLWx6/cv4fhebsKG5jvDROPPGaGy3Byjfb4
 urSXGwLiGI8u7Fo+ykC7PpXC3Jr/mKTaUK6LdSF4s7NkQB9fJjs8P8QHRyrO/uYgMFc3 1A== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLdYBfp9f355ugRNZllZb7Wp6LJwDubI2cY81d4N8pq1X/gmyTAn7OzyN+/pPpi+au9HC2gwD/3vzue3k94wBPeLIab8eLJm5ye+loWGfAvyUNbIeT4MJ4ebJVQ3qXUmozJi7RGrbjE5UePQENrQrrqE238YbLakMiu0uTKubI1tlAcCGxlA6msHXM8s6iEvll8sZcOcVvvUK8NwSSUuvtkKDmMU/3zDM5XDED9nF6n5z+/ULD8ZLP8cLbIxQrXmV32n67MRzLevvVBQaMrfxR5Bo90EFGo3BMl+jGWWPx15x/1R+oW+KcJmueFYeSGBe92KNy32AX3UdMWbndLMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KpaA+NVDAqhOZtgwLBJycbqxkBtZHuTEYObhDYLA7Y=;
 b=SErOOjC/tqcANEH+s3v5/lsA4Al885KBr4VGTvY8V1RLkeLYaSmHT2UJ4vnuftbVW3UGpDi2DT5gv9DiDs5MdqbLFgwkqelq8KIUz1r162rZE/rQ9y+mK7N/QU3jWCRyYPh/a20phEcy2hSQFPXnei09NkTGxEFNnzfEbo6PfbAJ105UVIb3kfYKeOI4xKn+7y3nmkggi31f9Gg/tQxpF6IgOiABiu+ZmiU9IIIYeh5L+UcUdDit1R36uogGsInZTpVlCSvMRtCNNSkz8MW97fYoQZTaSwVZcrwYtgvGR2bnqm0a6D3DL5Fkf1Z3YUksniL1ulE+MZKmckXrVsZOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KpaA+NVDAqhOZtgwLBJycbqxkBtZHuTEYObhDYLA7Y=;
 b=Z480/lYTDfC7Eqqy0CHSBABVVI+OsFlFY3O7+zcbEPsOyQc6wv6HS4UnId7gF6IItCyJALveHTnRpmnsEZ3WfrgiZdwrcecFDicLvlpatrn776q+Y/rGc9reAu1yuqcBq+IHVjXOJgZWG+IEGiHfZubgn35YznZsavrCgW0H/B4=
Received: from DM5PR18CA0049.namprd18.prod.outlook.com (2603:10b6:3:22::11) by
 SN6PR07MB4927.namprd07.prod.outlook.com (2603:10b6:805:ab::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 11:46:24 +0000
Received: from DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::c7) by DM5PR18CA0049.outlook.office365.com
 (2603:10b6:3:22::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT005.mail.protection.outlook.com (10.13.178.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PF029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:22 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk93v000865;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk9Qr000864;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 10/13] phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
Date:   Fri, 7 Aug 2020 13:46:04 +0200
Message-ID: <1596800767-784-11-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc81c57d-f115-444d-0e6b-08d83ac782b7
X-MS-TrafficTypeDiagnostic: SN6PR07MB4927:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4927FABDC15A472862F6C404C5490@SN6PR07MB4927.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZO6AZkX68hZ2Vuanr93CF6zJqV1hV9q1TfTS8Bnx63Ktx59apNkNWsxuByx20Uj/70zGd1n+24t0f77IWLj0N/tUoiffN4TfLbdi5eYUp65mC7DXkJ1kgX3EV7EjxO2VvVr0EuIJiyp9x0JsJcN+0OzeoPFvKYLYDoX4tJQ9Z35IhTBDNArs45b5p+gTsnuQPHZVLfd+0MXkQWoYpLk6ASdOeEmsfp9UsYqYQTIvVb2Mi6yPDoPBtqe/Lthiqc9T+f2gNQ2uCCBc0GLslKS/I5UVLEQn6RxCRIXQA86IL5P+qc+jtDjwC/MsFYnec5Tzd4DtOUCTof1nR1khWyViM4RUeXWs+j+/tFjYJfy1RBtEhFyLddYMKH2hYSrCJU2j0WF4k6LR3fLOGtMxmaGsKuMnF9Y4vkhx9x8RcBDNKiE=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(36092001)(46966005)(42186006)(316002)(8936002)(36906005)(2906002)(70206006)(336012)(5660300002)(36756003)(6666004)(47076004)(186003)(70586007)(2616005)(82740400003)(54906003)(110136005)(426003)(26005)(86362001)(81166007)(478600001)(82310400002)(4326008)(8676002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:23.8153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc81c57d-f115-444d-0e6b-08d83ac782b7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4927
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=806 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single link SGMII/QSGMII configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 89 +++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 216b25512a08..b291b63afba8 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1824,6 +1824,13 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (phy_type == TYPE_DP)
 		return cdns_torrent_dp_init(phy);
 
+	/**
+	 * Spread spectrum generation is not required or supported
+	 * for SGMII/QSGMII
+	 */
+	if (phy_type == TYPE_SGMII || phy_type == TYPE_QSGMII)
+		ssc = NO_SSC;
+
 	/* PHY configuration specific registers for single link */
 	link_cmn_vals = init_data->link_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (link_cmn_vals) {
@@ -2543,6 +2550,28 @@ static struct cdns_torrent_vals qsgmii_100_int_ssc_cmn_vals = {
 	.num_regs = ARRAY_SIZE(qsgmii_100_int_ssc_cmn_regs),
 };
 
+/* Single SGMII/QSGMII link configuration */
+static struct cdns_reg_pairs sl_sgmii_link_cmn_regs[] = {
+	{0x0000, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs sl_sgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0003, XCVR_DIAG_HSCLK_DIV},
+	{0x0013, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals sl_sgmii_link_cmn_vals = {
+	.reg_pairs = sl_sgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_sgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_sgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = sl_sgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_sgmii_xcvr_diag_ln_regs),
+};
+
 /* Multi link PCIe, 100 MHz Ref clk, internal SSC */
 static struct cdns_reg_pairs pcie_100_int_ssc_cmn_regs[] = {
 	{0x0004, CMN_PLL0_DSM_DIAG_M0},
@@ -2701,6 +2730,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2708,6 +2740,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2734,6 +2769,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2741,6 +2779,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2767,6 +2808,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
@@ -2774,6 +2818,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
@@ -2800,6 +2847,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
@@ -2807,6 +2857,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
@@ -2833,6 +2886,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
@@ -2840,6 +2896,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
@@ -2871,6 +2930,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2878,6 +2940,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2904,6 +2969,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2911,6 +2979,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2937,6 +3008,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
@@ -2944,6 +3018,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
@@ -2970,6 +3047,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
@@ -2977,6 +3057,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
@@ -3003,6 +3086,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
@@ -3010,6 +3096,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-- 
2.26.1

