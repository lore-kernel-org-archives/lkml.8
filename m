Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6752177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Dh3GCI4T";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HimEJC4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgH0QS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:18:26 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1898 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgH0QSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:18:15 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGEBYc029422;
        Thu, 27 Aug 2020 09:17:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=W0QEKHCsSnyHn8wzXCkCnuY52jtOUHvaEA246RF9pUM=;
 b=Dh3GCI4TJbYNdepRHZqvByDUZHUpr6zaKyHd+BLqbfPEJpPMruZlSt2bcgCo3ID/ZFKU
 DYIs1xoAtJ7a65gHxfiVQpMSJOOxnp6Ge+MqQ8Ecwg4Zu/pJrEWxOS/URLipcxprfMMU
 Vm3y+Vm4qLnIMFH7gM9dGXqeUso89M5zS2qWV/FGAwO59yn1QVsdiWDIikK8uQsTXu5o
 fH6jE+fwiUyyT6PXMMUo3lusTnsGkKDEc0BVU8/1kRRa5hHGBBCG5B349FHapH799IY4
 guNiZ48FJyY2mz2O9C7XNhB38PdsLPdVzxaLV/piQQsyvBVzgtWCqF/sC979tFAFZeQT uQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxdb14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ2ORuonB90F8yYV3jv6giHv43gE+DDrJzIPTjUlfwYHqCb7BKWWeVgEGyANNmZawXWAG4hbtY0OSVbS+ISbU6D+2X3O5EoXssKuRl/YvjioK76eAO5VM3qkojeejxgGvK2M7XOrtSw9cB3m5sSeX8PeGiMB0yTsvMzDSjmxxtzjI2uHeuwTnwNTboFiNHwwd/OiiOkkh7T8uXvZN4NKQ2MA+KZHAPJ0YGWM/wclfqqYSGKs0XuzCm7AAZD3aOhpyZdoao4nDF+9gF+dtburthKJYvwbo2FLS0BallUv+nfzO4W6cCEGKoq2G1KDlbzp1272geuIA8npkHJQfuxrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0QEKHCsSnyHn8wzXCkCnuY52jtOUHvaEA246RF9pUM=;
 b=nfsVpfxPtJ64aZVeEmyqCLtVYkINQOr35yVIwYhpsVUqXxbJ5Ejb1aTb0T5+66crMRVbZqM/A+6Xw9INA/FQJ56E6mmDTYscpSrAiIuXQxlXMhDNzdtQvs9JP0RUJDueldek4uc5VjJTCaYjktQ4JuJj5DN4TAn5V/dJGcStqIpgxw/1USsdvEc0klmrzbUKN2zlnNFMuMUt5nDGzxKGZopz+7ao/WJfOPavc9g7qLWuqFibOe8lVVit7urPBmH7aNpJLfVjUgHhKTFlYG3zNGxNuXj2bdDJjl3rpk1bEHhnd+psBOQA330vjL8CgnDf8Sd0ALreCIvar+bXgIagbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0QEKHCsSnyHn8wzXCkCnuY52jtOUHvaEA246RF9pUM=;
 b=HimEJC4WyrcOkjBEmiDnW9OoS4Ytv+TGLgUuzEQDrWHAUJaGGYPbTQxId/2hzOtgPkq09Tn/djRLpikBVXAvqUPz7FIqdJo4j9j6FtoyIIgYXAGK9aGzOah/BsAI8K+f2b9kZUQYp4p0lMk+AEPFc8zlEJsElYSb4hqlxiLk4C8=
Received: from DM6PR21CA0026.namprd21.prod.outlook.com (2603:10b6:5:174::36)
 by SN2PR07MB2621.namprd07.prod.outlook.com (2603:10b6:804:7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 16:17:09 +0000
Received: from DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::41) by DM6PR21CA0026.outlook.office365.com
 (2603:10b6:5:174::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.3 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT029.mail.protection.outlook.com (10.13.178.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquR016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:06 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGrdY031874;
        Thu, 27 Aug 2020 18:16:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGriv031869;
        Thu, 27 Aug 2020 18:16:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 12/13] phy: cadence-torrent: Add PCIe + USB multilink configuration
Date:   Thu, 27 Aug 2020 18:16:50 +0200
Message-ID: <1598545011-31772-13-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 276f2933-46fd-4280-fac0-08d84aa4a57a
X-MS-TrafficTypeDiagnostic: SN2PR07MB2621:
X-Microsoft-Antispam-PRVS: <SN2PR07MB262119FE1EE4B2682EA41A7DC5550@SN2PR07MB2621.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phEsN9P36HoL7YSiViXtdglefDLwHLFlncArqFxLtiVmGk7tav67DgyKB0N6BzI8CzQWfCYlzV7DdJvKZ0H0RdvWLM3M8Ebh6AO94d0TNiJerclGz+Zb7iTIUKxY8z54Qm3mXQ13y7C8jondaskopdBRccKcMEQ1eDJXhnxXES8/GD2NHY4MhnUM0rt6ISlQaAqB2QOdMtFPTi8+CvU+39oGK1e8F5oqfbgT7YKyXON2gzqKINNaH5WbsDSSPhQWZZCcdEhZy4ST8BWdBmSOy6Tr16nJqxVmVl+xTmhMFq3UhX7541KTe63rekhlXkGiRAX0owGJDcLSOmEIw1rpBpw3ZwLhTE5BTpVX1TxYqJVB6MmMut3Ovt+74R9YydkLdoDZfSmqB2Yjsh/dQMtfVzbZfkfFEqnXyP/fd2KHlLc=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36092001)(46966005)(82740400003)(8936002)(47076004)(4326008)(478600001)(2906002)(70206006)(36906005)(8676002)(336012)(30864003)(70586007)(5660300002)(86362001)(54906003)(186003)(82310400002)(81166007)(426003)(42186006)(356005)(110136005)(26005)(2616005)(83380400001)(36756003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:08.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f2933-46fd-4280-fac0-08d84aa4a57a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT029.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2621
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=716 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270120
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
index a444184acca3..d2b9d1396be6 100644
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

