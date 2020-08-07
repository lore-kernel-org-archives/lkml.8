Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3094FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7272075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jYCZplYF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ULvCBN48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHGLq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:57 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:51902 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbgHGLqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:38 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhS1o011307;
        Fri, 7 Aug 2020 04:46:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=joO/aHmlwdFUPSJ4WT/mqa7RpQZvi2fNb1pYU2ktpzI=;
 b=jYCZplYFg4qH2P94wvHw9AQvvWh1D39/JDW+pgUJV43xBg7/JNvciscsVld+xZo94QXb
 btSjbYxdidcKle89GmdPMpjGE2yGIq6j+gnSIX35b8pUJoaCVBy7CmVFyEwGHrKlmINS
 pVc8sxD1DMyPOvu0WaAfTw9DeHmJmGo8/9eD1ewmze5KL8AG26qSVyEt9evacQhbesE0
 eAR+zRVrTPHgd2L5ZWkgHucWQWAg+R2YmSfKlrYnwWHW2Dq5AY6ZPK8cYHSGZqYht5iZ
 Z2eyH7i1jtOTSz+plApVUe7d/zNIt0lXqMMORJIX5BEHZKCBgdeoE41cHPbTocCSASeW mw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFeQGySn6b/RiAyKa/4G6gGpq8aKa1pfurXMIIUe2jE7jrJQ3GZZgeZ+fnVnatpY4zW2S6NKW8LnuNtIphu+ZH75SKfwjMX+Pt1pmJ6pMn0CCiDXeeoa2vPsACzRcssrrmGfN/hwYnEh4VE68Xkcj9KQ3fKazqxvvBBAQ14iQW0hJqcQhWvLdV+GcVgfRBV5VB314Nukftedm5TYh8qIW3ridfWfIBDfyGCRPgf83eC7d3igl+szttqMfaUBgu2J6XDIwrqHg1YvHb6xpIQMCqUOMelxsrEsRJRPrvrY6rI4oDoc2kxcqJztt6RM7Oa8/Cl35VtrTLStw6s3ows96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joO/aHmlwdFUPSJ4WT/mqa7RpQZvi2fNb1pYU2ktpzI=;
 b=koI4tCe52DeRj5PQHvX2dzRzGVhWH+ZjK+qsZ8R4LOnE41+NGV7wMbIsj2wsxgZCdOmBSHCWLbBphUDrJ0VB5zVR2KBUGH3NJqfhXqhajtQfXQIo6FqKn0hap1jwhWAhBt+acecHQNMYUJnIXG4ZFlJgXSdGsM/1pvwnoyYKUOAIV3bJvCZQ1SLuM9iFd1y8aMnq+TLkAA7uyiiyCbL7SQGRPcV4Uq2qa6uoiVyspGRva4Mg7dqihCwGJBQ0lyHQdBMREcKaKq36KdyYcgDvwRR/tGyUuF0IGXAqTI6cIcYZoHi19C/7e2KOCHNc2ILcppcPUWknQaqbbCVzOHK/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joO/aHmlwdFUPSJ4WT/mqa7RpQZvi2fNb1pYU2ktpzI=;
 b=ULvCBN48msPEKeOiVzo5G+UbMKwAf0ipOuBj+gqpHkWYqJs9nCxxa4mHeQMQ/XuhtioTnAL6CTCOjkLFYr+HLCm9oAw+HRks45L7esok8g0sPkOzP1+2YfyVWKrV0Zs5R+C8yZ2djws/xMiuVoQacIl5r2c+KxpGgv7l/sqEkig=
Received: from DM5PR21CA0027.namprd21.prod.outlook.com (2603:10b6:3:ed::13) by
 SN6PR07MB4223.namprd07.prod.outlook.com (2603:10b6:805:62::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.15; Fri, 7 Aug 2020 11:46:26 +0000
Received: from DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::7c) by DM5PR21CA0027.outlook.office365.com
 (2603:10b6:3:ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.2 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT051.mail.protection.outlook.com (10.13.178.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PH029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:24 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk91A000873;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk9Jp000872;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 12/13] phy: cadence-torrent: Add PCIe + USB multilink configuration
Date:   Fri, 7 Aug 2020 13:46:06 +0200
Message-ID: <1596800767-784-13-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc73c9ec-99f4-415a-105b-08d83ac783f8
X-MS-TrafficTypeDiagnostic: SN6PR07MB4223:
X-Microsoft-Antispam-PRVS: <SN6PR07MB422335E72C68E74CED5653A1C5490@SN6PR07MB4223.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTbmyRufzRUoVSZqzkhfyRZ9h0pm/G9XK/qdGFc84vlin0/w+H9n6v1mgfA3kMYJxapdt1Ua360o/p6pnDs/nJZFoAlp/ankMsurMM9IiwBbIuf1i9epj8Fz6vjKbZ6KlFDWn2Gf3DRxpEe8kUrB3xJoKvzwUB3wlxxtteoiUIqI+6X9P3To9FQan3XWLVrpef0TjWT7nroPrq6wxvNXCdvWFaZcvVAGGZKuXIhbGweZ4C89McdGL0JK5sgZF2AmgduSTIRzc5n4oh5j0T+9/crPurdqPhqP7fF+BjnyjRFy2Mx0beVQsyvi8GMOZWF3v/7iVOiivwRTJDC1giebCGU8/WmVTcRNm2/C/w9jrvtWf8K6dVq9/T5+HmzLx8zRff1pmoBs1vIY0qu3MkLDqXwrwxjM8+msyRboeXyk9H8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36092001)(46966005)(86362001)(81166007)(5660300002)(356005)(8936002)(110136005)(4326008)(47076004)(336012)(36906005)(316002)(42186006)(82740400003)(54906003)(478600001)(26005)(6666004)(2616005)(82310400002)(186003)(8676002)(70586007)(70206006)(426003)(36756003)(2906002)(30864003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:25.8861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc73c9ec-99f4-415a-105b-08d83ac783f8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=767 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe + USB Unique SSC multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 216 ++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 9b4eb4647401..3eafb72014fa 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1938,6 +1938,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
+	struct cdns_torrent_vals *pcs_cmn_vals;
 	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
@@ -2011,6 +2012,17 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			}
 		}
 
+		/* PHY PCS common registers configurations */
+		pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
+		if (pcs_cmn_vals) {
+			reg_pairs = pcs_cmn_vals->reg_pairs;
+			num_regs = pcs_cmn_vals->num_regs;
+			regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off,
+					     reg_pairs[i].val);
+		}
+
 		/* PMA common registers configurations */
 		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
 		if (cmn_vals) {
@@ -2334,6 +2346,100 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIe and USB Unique SSC link configuration */
+static struct cdns_reg_pairs pcie_usb_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
+	{0x8600, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs pcie_usb_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs usb_pcie_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x00C9, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_usb_link_cmn_vals = {
+	.reg_pairs = pcie_usb_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_usb_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_usb_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals usb_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = usb_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_pcie_xcvr_diag_ln_regs),
+};
+
+/* USB 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs usb_100_int_ssc_cmn_regs[] = {
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
+	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
+};
+
+static struct cdns_torrent_vals usb_100_int_ssc_cmn_vals = {
+	.reg_pairs = usb_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_100_int_ssc_cmn_regs),
+};
+
 /* Single USB link configuration */
 static struct cdns_reg_pairs sl_usb_link_cmn_regs[] = {
 	{0x0000, PHY_PLL_CFG},
@@ -2898,6 +3004,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -2925,6 +3036,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -2944,6 +3060,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -2971,6 +3092,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -2980,6 +3106,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -2999,6 +3130,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3026,6 +3162,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3045,6 +3186,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = NULL,
 				[INTERNAL_SSC] = NULL,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3072,6 +3218,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3091,6 +3242,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3118,6 +3274,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
@@ -3142,6 +3303,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3169,6 +3335,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3188,6 +3359,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3215,6 +3391,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -3224,6 +3405,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -3243,6 +3429,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3270,6 +3461,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3289,6 +3485,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = NULL,
 				[INTERNAL_SSC] = NULL,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3316,6 +3517,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3335,6 +3541,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3362,6 +3573,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
-- 
2.26.1

