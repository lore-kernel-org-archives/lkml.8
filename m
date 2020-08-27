Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25275C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C882087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FhFieMHG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lUYFVlAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgH0QSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:18:03 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1884 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgH0QRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC68D005481;
        Thu, 27 Aug 2020 09:17:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=+q9gkbaKleIkZ82AlQI4j6By6jxUoNaSEQVfEC5RVOA=;
 b=FhFieMHG1WTYJWWoY2qmbgdNOGUnBT4XD4BPmZbEK5ngsNikBD5+bf5kdHzdR1AaJerh
 3C6VOFK75BIAPDqZ+hRuR4ja/vihDjKwfnFWVwA/WfcN0n+NLW8MtTtYIbFzWMgAwz8J
 uA5JCoF2wPcn8uDFdMrnevOUoYHGnGn9PB7jqZwqOk2OftegsV0jpcR04e9rZW5SR7gz
 XVS+DR4fwJFfxi3HpcCXbGbmzkePa4tyw36/IqbV5txacYOPZURtkIpx3jlC7vfmiqVT
 vjw9CqIx5V+oKTGd4Sv3yD91T39iyMlRmp+YMaTNySRoITMuojEIFsODTfHg/9zt1ice pg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4trw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATqIuYtdqjM8xWKKZx5nexmWZSiYJVV3TDb5L6mkwZEYyeJEiOVNVt/xzX4GwxH2+QyZWAn8o/mhPRp/i4FhwmQSCNwWuYDi0nUZo1vp4DSA5Q64ZHpmbj5Qq71LMojza8/8omFSsTnOH2IYX+qtFFMbbju03mDQqV0SL6W8BATo1YS/nxORvlsgTTcO3mnZj/RnFw04cr0+P7U9kMQxhvaQMhQa8zel8kPudvUJBPOU6GGbTCyxN8PxH5Xr1gQoEgRRL5oZLUWJ7D1vY0dZLHSOvzKRN75faqLHUH+obDErn1/aCc+7id65ik/PWsDoqM67O3pACrQCzlTE9sT6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q9gkbaKleIkZ82AlQI4j6By6jxUoNaSEQVfEC5RVOA=;
 b=GywafXp6pKTNoBWVbp8u4KapDPk88Ty/scZR+bYpmI5bhOF4y4HHbxVo5Iq4kYw3jPDhVOKGzAXEyEqrV0CyM7e5+Ga2zc0dhx7ZwgyqTNXRPAFQOCiCoAtAIdUFmZXI2Tp+h3lbBbt5hiKOxqfSJmNbSkahB+RCZel791EX6wucTC2EXW2RclgXwkL3Huf+57kLG3Z6HR4W0ylQvYECaKKu9u8Q1e1RLm0reLd23kgZ2z+TN9yKkk6FAg+mRH4mxX/XTG4hVAr/lISHGGK5Gl6JjmdDLQ9lNDkdDb6Z09ra/kEAHUoexpXFi84VJ812bdRWX+y2E29NSUrUhNcD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q9gkbaKleIkZ82AlQI4j6By6jxUoNaSEQVfEC5RVOA=;
 b=lUYFVlAgEW5p2BPPb0ne46RNN0KyuxWIQch7EyuD/HbAzbEZF2tLe8lacQXLcJVv6HfsFMmEsivgjrLuw4l3DM5+TK9QzUHwfHb7fwBe0cISofdOfvQUErezwUag+uiqnL9y2P4Kyd56ZMjcRorVSoXUWklHWaGT1Zg7+xL3WZ8=
Received: from DM3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:0:50::26) by
 CY4PR07MB3864.namprd07.prod.outlook.com (2603:10b6:903:d2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 27 Aug 2020 16:17:10 +0000
Received: from DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::52) by DM3PR03CA0016.outlook.office365.com
 (2603:10b6:0:50::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT058.mail.protection.outlook.com (10.13.179.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquS016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:08 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGrKP031879;
        Thu, 27 Aug 2020 18:16:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGr2X031878;
        Thu, 27 Aug 2020 18:16:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 13/13] phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration
Date:   Thu, 27 Aug 2020 18:16:51 +0200
Message-ID: <1598545011-31772-14-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac20ac0-cfc2-4df6-6e96-08d84aa4a625
X-MS-TrafficTypeDiagnostic: CY4PR07MB3864:
X-Microsoft-Antispam-PRVS: <CY4PR07MB3864A2533F599F82ECD5865FC5550@CY4PR07MB3864.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gutYsfANrgHo3UVQvayKJG6/qKi9QXVllL6IsJEIeSV+k7IN/04g55LOEM/B4VQMNCEPot7hZN7G/qALxaMcFBQCMMf8xw32KYnPQdIgIMH9CgyNev7qD9FK7azIwFmxaVDQLADD1SAAEf+Ahj/npRvE+OCJu2CKI0BfVIiC0rSYYtv2FaPWbU++jgrB8yiahShbDgrcGXJZ/gVmmalDOWRSZviMqo+r3h2/dT7G86EByqbKdZUdxGHGJZ35nTdlHreCZPE05YtCZZvwjMtWxs+JSHwDfv7FU2SYO9XvYDHHCZ09bQRNg62Qjcu1pCZJ+/+9rlQ+3UvP8R79DY8pnTfTW/8aIn9xkU13+b+/tuu4N81hRiXLuVWZXkKWg0BKnJZNcTtgNP9QPBWQUwIPCl13jT3WAn6oTjeLg7oVnFs=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36092001)(46966005)(42186006)(8936002)(47076004)(70206006)(110136005)(86362001)(36906005)(316002)(70586007)(186003)(82740400003)(478600001)(336012)(8676002)(54906003)(4326008)(2906002)(30864003)(82310400002)(26005)(36756003)(356005)(426003)(2616005)(81166007)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:09.4528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac20ac0-cfc2-4df6-6e96-08d84aa4a625
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3864
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=735 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
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
index d2b9d1396be6..c22594a26c40 100644
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

