Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29949C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEAB22C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mA8tdtDc";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mx99qd++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHGLq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51172 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728408AbgHGLqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:43 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BjPvU031439;
        Fri, 7 Aug 2020 04:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=90C7THb0gvJ3YxTErY2NvXP0pa1QNssNKm4Y6moWSJQ=;
 b=mA8tdtDc3pKfaNmdPS9SnlbiEzDtgozhSfLD2oMo3kFfvi5u9+wg0a0cpjNUJ/aQw/0F
 MXV2aUS48UKB0kSDKYhmNfSRjtTiwm0IwmygGfhdpt9512ZKaVrDzWcdHV3N0tF1th02
 n20V7HRPnKfHiFuacCaCId4onnNAB0no62GYyRBjVftgy/B7OgPuXYIQNtCrJiAVoTDO
 kVdESuf5uhFiUm9cARWenlJwtriVqbLa3hTUu3eId3rENhsoQIOh/+dy0Psf5cmIX0Z/
 5O7q/QxSPRb9+n48+urUKr9FrwbgXyigJ50SN/xCNUfSwpWakRAWTuxhiZMdeLXmi0lU 7g== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2055.outbound.protection.outlook.com [104.47.45.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gy61d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1G5ZzTAQyeKKDT1X1OwvbUduHMpDxD/9hjOcMgxUqRhMmfyWQwjjxL/KFLD/8yAobcbQit7/hX2F5ewt91dAaIeLYNPtTGsg5lV6+1hVrsTRr4JGUp2YLhzADmrBqxfcMgLhj9uTVTN/3ma4GkLb81z4SuVWEvz/VFUMfcPUtxsOvcK7HSg4xk4Y8ZBGNyxwlKyEHF15emXJnVpiysvAP7RsTQ20AAiOvycr3QgsN0Cevm2zJ02xEHbGZYD1YGyM++af4yS55JkcriIaWKBmAwnu5+7DDXzg3ap1exasgUGSqlgPzbc8M+m7SE83PcbedJA5swI8p+9d3VDqUJXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90C7THb0gvJ3YxTErY2NvXP0pa1QNssNKm4Y6moWSJQ=;
 b=WfA/oCdmKURBxy9jSxVC1wHvQZgk4YHjNuEmRSLFUg2J6Tc8iSQEy7S4+CVFsswq7GIoyXqHjaZ2U2KyRsCsh3ynY3l1RcAqPV+7UqQsDxTdcsHMrrkl2O0YcXP2XQDReaoFAmvyRPGzssWSQSjmKCmOCy5U1jDesPcRHrXjGW4at6ehe13IEk0IhQFAoCrlGZL5PmNTc3TDMTEJ7wSMIjl/FFtdgmo0NT2pd+iAHf7FBqqPFowmopUNAbqOsVELJP4OIUI8O1qT5Wnnzeexj69LhVe/8aNpFG8155sadNc9dwyqu4twLZT/Swj2dotSwSBIo7jSNVEA4yoeiQTfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90C7THb0gvJ3YxTErY2NvXP0pa1QNssNKm4Y6moWSJQ=;
 b=mx99qd++nC04H3VIXzMWYS6Xb5jB8iTEQ4sLofPVTl64rZmuMswAPjuNgiA+Hs1M6gRIyvFYrF6eBE9UyeDRTjPcCM62dI0/i7AHC4syCG6tnHyYaOKoIzGtXMI3vsIAk5KA1np2aV64cC5URarqzOgqe1qpnnADyyvnL1pidtw=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by SN4PR0701MB3741.namprd07.prod.outlook.com (2603:10b6:803:46::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Fri, 7 Aug
 2020 11:46:27 +0000
Received: from BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::71) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT025.mail.protection.outlook.com (10.13.183.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PI029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:25 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:10 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:10 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9hV000877;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk93d000876;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 13/13] phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration
Date:   Fri, 7 Aug 2020 13:46:07 +0200
Message-ID: <1596800767-784-14-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9b9233-00c3-498b-d8bb-08d83ac7847c
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3741:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3741AB6DE23F9D9DF6555482C5490@SN4PR0701MB3741.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ2FtPxn6hDOpPHVYhpJYlnsty7VwXcfTfhYLbwOkJqJQXsYd27Nc6A4V8sJHIcfPCWoAFKsswevKCNSaupamf/zzNB/PmdB4JRu5umkOLZ+s/IGPh9toVx//OKVtEUiTBGQ+bUQTODfNUIFnyGfOFM+ETc8mwHpWswB/JhyhTgL4wH51xAg+OQcUmSAdZEbBwLysDYtrMuH7TsKuoh86wArZQyuQKdL5+34ehbyvKYlcksTbteYkvit38AncWvvCfzqTmOh7cdj6PTVcdr6nEDGz3uVCP9k1gCZs3JNmu8EOVRZWm+I3K6Grxf+8swzvy6qVC16THVUTNMjRDMXNghWDnjWb1GhDW19P/ghtg5qS6ZJ12+aIvDGlpx19dhvBqaWl2X5Eb2wuUT9DH1G+RYaRujJ1UKv6OEkBU1VoFk=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36092001)(46966005)(54906003)(70586007)(110136005)(86362001)(8936002)(426003)(70206006)(36906005)(42186006)(316002)(336012)(2616005)(36756003)(4326008)(81166007)(356005)(2906002)(82310400002)(26005)(478600001)(82740400003)(30864003)(186003)(47076004)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:26.8232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9b9233-00c3-498b-d8bb-08d83ac7847c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3741
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=831 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB + SGMII/QSGMII multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 254 ++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 3eafb72014fa..124d00e07f85 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2346,6 +2346,40 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* USB and SGMII/QSGMII link configuration */
+static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
+	{0x0002, PHY_PLL_CFG},
+	{0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0601, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs usb_sgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs sgmii_usb_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0003, XCVR_DIAG_HSCLK_DIV},
+	{0x009B, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals usb_sgmii_link_cmn_vals = {
+	.reg_pairs = usb_sgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_sgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals usb_sgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = usb_sgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_sgmii_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals sgmii_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = sgmii_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_usb_xcvr_diag_ln_regs),
+};
+
 /* PCIe and USB Unique SSC link configuration */
 static struct cdns_reg_pairs pcie_usb_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -3019,6 +3053,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3029,6 +3068,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3041,6 +3085,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3075,6 +3129,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3085,6 +3144,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3097,6 +3161,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -3111,6 +3185,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -3145,6 +3229,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3155,6 +3244,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3167,6 +3261,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3201,6 +3305,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3211,6 +3320,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3223,6 +3337,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3257,6 +3381,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3267,6 +3396,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3279,6 +3413,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
@@ -3318,6 +3462,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3328,6 +3477,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3340,6 +3494,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3374,6 +3538,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3384,6 +3553,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3396,6 +3570,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -3410,6 +3594,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -3444,6 +3638,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3454,6 +3653,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3466,6 +3670,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3500,6 +3714,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3510,6 +3729,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3522,6 +3746,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3556,6 +3790,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3566,6 +3805,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3578,6 +3822,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
-- 
2.26.1

