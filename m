Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF9C2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gviksKtj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hPDSs6Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH0QSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:18:15 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727860AbgH0QRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC6Yn005478;
        Thu, 27 Aug 2020 09:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=1pbuJ7tXXc7eE5y9qYgQ/5lw+vrs3X/LypyS0gnoRlY=;
 b=gviksKtj+t6NU8prcCW658YIeZMjsXplmIfSpO5xccNLE84vN7lSHFYkRMnY/kV8ii/p
 rB6tJBmAV6O40/gPdGRfYGnPzSsiReYQIWYSFKwaDEZbyx1rBFzjoMkYKBPz78oLstK8
 eeeHdpX2ldavcQpRXnhKEZFsk6gniQ9xhWigO2G7ThKDvr2AamoEoQSCkZ7BlBqp0gzM
 gB55rRIp2xz+PDkohgLaW/IBPGcoNGzNwqLk55wq9VE5pvxeDD7L3/UT4LFIlfewZtfz
 jcF9bPbqQNSfzaihaGVoVGmguKMTp3pvUxTVKTlyFJn5QOiDAIhNP3Ycj2OdBREtN0/g 2g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZ3z9rQPtn71sb9kMiQkocYIcCpUp6LlhGWglq3kohyjZ1zlubDIUjEucpO2LjaqGGf3plRa5Myf2e4XqUFBxjBYjP5VNttR6O33M4QQGpEsR4jIoWSNn3eFmBprPAdfrA1tqkWlw3i3VQSwR2hrV7QAniNtzZNY8J0g6AeVPnOZbnhf3FI9WMVaJvYOm8X68nVkGDlAsg1q8rFtt+PPys0JUDBicWaVvNMMvDH1q+zsR6ggp3PtahzGLlRogTVU2xtim5Jgux0auuvLGJIYZ1dlx6jV4TKhu3K3Xhv33oqSpynZeD/0LRv39fRjwN57byNBr2xEOflgbOEAaYtJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pbuJ7tXXc7eE5y9qYgQ/5lw+vrs3X/LypyS0gnoRlY=;
 b=iB+y6q6CYrk/qxAPdc9/jcnyVMfMMczYEQfr0FnB8Bhc6JNvIlFk7Vj2Sx8luqDKf09Uvvwmkw9TFSgSmKKvphj5cCwaUkK8gDN75wMvmtoDXlZD6bcDXZb1AL5wt8ltbNSvIVxtPNTUFcUall0lZoqrH0z3MtwYwEXoRVY6bn+E5m05X6jvNUVvV6VzWT0oZA25Ut5Jvn0LJmW73oguuuMl6TQ0Gy50HFJpFsqED6IdOMaJikjm3fA07Cb9CPvr2LdoIWbeSkSyj3imu7XiOcTy348sAirlcwIkJpAwvf/ERzM7rpuWlcQ9AgRGiNwEDodltmIbhV35ROa0d2dCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pbuJ7tXXc7eE5y9qYgQ/5lw+vrs3X/LypyS0gnoRlY=;
 b=hPDSs6Ka5jq20oAIXsBqoSFnx9A4sC0Mxmcf0f0rMBFrNkx8IM5SEaRCj8c/uDuFqaK1B37I8roA0n94zB5Mk+OZsrH/VjfXA3Z2PZDc4nVXrUfCeHFMJSlpv0oW0heFnTnyijiao3RJtaHje4Xoh8bXuPYAlJgZPyhghIdUMR4=
Received: from BN4PR10CA0007.namprd10.prod.outlook.com (2603:10b6:403::17) by
 DM5PR0701MB3671.namprd07.prod.outlook.com (2603:10b6:4:78::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Thu, 27 Aug 2020 16:17:07 +0000
Received: from BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:403:0:cafe::ca) by BN4PR10CA0007.outlook.office365.com
 (2603:10b6:403::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT046.mail.protection.outlook.com (10.13.183.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquQ016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:05 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGrbu031862;
        Thu, 27 Aug 2020 18:16:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGrA2031861;
        Thu, 27 Aug 2020 18:16:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 10/13] phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
Date:   Thu, 27 Aug 2020 18:16:48 +0200
Message-ID: <1598545011-31772-11-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2536890-93ba-4feb-857a-08d84aa4a4ca
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3671:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3671E184D8745EEB3E449C68C5550@DM5PR0701MB3671.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1guVdUc4xzmx1WifbFftCPD1V5jA9wwa2JgS3iuUXFlKCnA91rZ56h3Nzq2BaalvshJ5u3Ymg9uP0TpuEU3wOExqkrD8cOzxJbYDpsgBUZsM5hy5vHYgNq+vjZcaf7YfhtnlSIl55aqafnd4nrgVA63d48WMYhwiqIogMdGEo9oCDzgsARCSxGia2cMSczikZxUm8XQJqtG7cwq+zcKgDW+L7NU5b9MocfLStM7H8BFSHQucVcIniXnXYuXcvaY318VPjyq5yBX7ibl6xou5CiIs43/Lo/wOj8HhfYvWgRS9ED2FuapichWqTGeUkz/Q7pT0vPpMHtdnzsOVj8tSCrrBKwk0AD24FfjqX+qT868C/ggGhTcEcvzJCkvhUUt+u9P6EvrPvFDWNnb5PbQUT3WSS72iF0/pE6H21sPk7OI=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36092001)(46966005)(478600001)(426003)(5660300002)(54906003)(70586007)(2906002)(4326008)(110136005)(316002)(36906005)(70206006)(2616005)(336012)(26005)(186003)(6666004)(42186006)(8676002)(82740400003)(356005)(8936002)(81166007)(82310400002)(47076004)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:07.2483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2536890-93ba-4feb-857a-08d84aa4a4ca
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3671
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=774 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
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
index d678e9b37409..5bc9bbddcc9c 100644
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

