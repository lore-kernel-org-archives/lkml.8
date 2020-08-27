Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF9C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CB42073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PiUVPdrB";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RkH36tI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgH0QUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:20:37 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29308 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbgH0QUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:20:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGEBYm029422;
        Thu, 27 Aug 2020 09:18:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=U1OI0Ep9v1rrBhr4t0p22NXxMe72wbgmY/zHe4Qcmp0=;
 b=PiUVPdrBGr2AvZW35S+O7p6xv3dSbZS8JgdzxsLUe5ll2zQeiZXM8mVhBwq+Wsf8yaIC
 5eBVDKdEublI5699HkVhbHEcbKRMkUQVWCrXbjVn728OzvbOVat6kiTu82UlAIKZbcMM
 x1K6VxPgt+X/ebawS9WCF7LodNBLtvdLtth2C+9rqUD1cUaAeQmhm7kuFs8IkBrhopUo
 DstZcYjdCF6h6m/DM/Hz2Zoy0wc3mvo2/QZONVFq+pSgR2UmTyKhNjfsk7u8ynZYpUZr
 2Ql4CZn4VuR4+mtB85hUqF7lNg2o1wQU1+oDjVDeCYpymkbjpgl+U1FR/uL3flFXaOQl oA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxdb8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENUpLCS8Cq2AI/zqK74gvuFifrLxq52nKL0dIkGOd6j/nRRTZNe+M10Cjlw4qkiA38ucL5Qg+RS2hT6XEzf7pv2NW86gzqiL57bw/dM4aQPGY4P/Qrvyvm4J7Rc6MxpbWKQsygTtZcwbLNQRnlxLZs9tgS4k8y4j+Z0MZZP5qVJ6SbWN+Ncm05p7DVOw12Af+r3IxciKOcpDBYvT5WZY4rJc1GJI/L89uehfPlJRNWXsEVimRkh1G8rx8iCeL7QfsBK90Tiri/ymf3yIUY5WBlkyMS2wUX4xSlf28+9479zocht2fCravy1DpqzhvB3M+l72OyE+mhtPSTMQ4NnqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1OI0Ep9v1rrBhr4t0p22NXxMe72wbgmY/zHe4Qcmp0=;
 b=OVCDv27MFHPg2HvLV09BweqplxHztEYpHXzlV+WaLazOH0BMzSMU80tlaQumZe9zHCgPTkYINpPfdzKNAi8npwy+/WZFlTwBv8yVhb+zXNzPXiwEXDer4LPzeiYyYRn23q38JJEPwnkXFEgwuxSWZZ7V/BOmVuhZsS8uUdhZKR5wCRkmC5tlawYYzvtek+D6/a4oHzRsIMiRxH3tIqel5VSBpaqdjgclK2m3+VL9fF9XLkDeDaEPrTmBiiFdLS/acyG/lDduChrF58oZGznpUOXnJiaa99C3y9jXGk/DqIaM2VC/f1n0N8skSbGSBtqS/ZUxx0G7MyVS0erV6lyV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1OI0Ep9v1rrBhr4t0p22NXxMe72wbgmY/zHe4Qcmp0=;
 b=RkH36tI9gdiwkLRI0UCIthD7S6t8h2sTXRYtDRps6LQVFx7cnhDhldV6+fBjc+wbiiALoCMXbXX+LMMlxqWjQAqWSZ4o2j5rFRqdFK2cl/jSlqNcOnGFQFK2Jprnj9gEfbj9Jt4Rw9KcL2ZjBxUeN1ZZkQhAJj9M/W01R/FhOjY=
Received: from BN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:e4::17)
 by BYAPR07MB6039.namprd07.prod.outlook.com (2603:10b6:a03:135::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 16:17:06 +0000
Received: from BN8NAM12FT041.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::9a) by BN0PR02CA0012.outlook.office365.com
 (2603:10b6:408:e4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT041.mail.protection.outlook.com (10.13.182.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquO016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:03 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:53 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGrEV031858;
        Thu, 27 Aug 2020 18:16:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGrxR031857;
        Thu, 27 Aug 2020 18:16:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 09/13] phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
Date:   Thu, 27 Aug 2020 18:16:47 +0200
Message-ID: <1598545011-31772-10-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b46c1dc8-dddc-4c89-04cb-08d84aa4a344
X-MS-TrafficTypeDiagnostic: BYAPR07MB6039:
X-Microsoft-Antispam-PRVS: <BYAPR07MB603966E7CF08088D764E709CC5550@BYAPR07MB6039.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSTLZRn+oXpbsIKghXB5N5USeo7QqUca2nz6tpsp9LYjYPOEEFHenD0FKNBolB8n2R43kRuYorg7k0MI7DaoLUyhrf5ct5NQ1NRHRmep2Gg+BVDdI5GJh6J7DES8TplkoXSVSIM8d2/NEB47EiXKqWba1HU7MD+VaChpDSx7Dlrb7N3xz1Fe8e9wqaJnnBJw2QVhQsuT1aakPp3GyMLvm9qYOmVm9KcliNlQtyDSri9FEUrtxHeEa1kkWTJUCmW11MkWApnXkxraI8iNiDkWhgpUfarvqiFZe6t/zE+ztMj/L4t10F+aNLCUG6HChbocd1wwV6OAYGMy4bfCWxQod07jM6liIq7UqqFF1UE5V6XQVI+yO3dof9rBeSVL6t3a4RqQti4LMt9R3lGRFkqRV9WZrCUpY15Bvjo+MEPyza4=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36092001)(46966005)(2616005)(336012)(42186006)(316002)(81166007)(82310400002)(356005)(36906005)(478600001)(2906002)(8676002)(86362001)(83380400001)(426003)(82740400003)(70586007)(47076004)(70206006)(186003)(8936002)(110136005)(4326008)(6666004)(26005)(54906003)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:04.6891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46c1dc8-dddc-4c89-04cb-08d84aa4a344
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT041.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6039
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=753 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include PHY_PLL_CFG as a first register value to configure in
link_cmn_vals array values.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index eda3839762cb..d678e9b37409 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1830,7 +1830,14 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		reg_pairs = link_cmn_vals->reg_pairs;
 		num_regs = link_cmn_vals->num_regs;
 		regmap = cdns_phy->regmap_common_cdb;
-		for (i = 0; i < num_regs; i++)
+
+		/**
+		 * First array value in link_cmn_vals must be of
+		 * PHY_PLL_CFG register
+		 */
+		regmap_field_write(cdns_phy->phy_pll_cfg, reg_pairs[0].val);
+
+		for (i = 1; i < num_regs; i++)
 			regmap_write(regmap, reg_pairs[i].off,
 				     reg_pairs[i].val);
 	}
@@ -1907,8 +1914,6 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	phy_t1 = cdns_phy->phys[0].phy_type;
 	phy_t2 = cdns_phy->phys[1].phy_type;
 
-	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0003);
-
 	/**
 	 * First configure the PHY for first link with phy_t1. Get the array
 	 * values as [phy_t1][phy_t2][ssc].
@@ -1944,7 +1949,15 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			reg_pairs = link_cmn_vals->reg_pairs;
 			num_regs = link_cmn_vals->num_regs;
 			regmap = cdns_phy->regmap_common_cdb;
-			for (i = 0; i < num_regs; i++)
+
+			/**
+			 * First array value in link_cmn_vals must be of
+			 * PHY_PLL_CFG register
+			 */
+			regmap_field_write(cdns_phy->phy_pll_cfg,
+					   reg_pairs[0].val);
+
+			for (i = 1; i < num_regs; i++)
 				regmap_write(regmap, reg_pairs[i].off,
 					     reg_pairs[i].val);
 		}
@@ -2283,6 +2296,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 
 /* PCIe and SGMII/QSGMII Unique SSC link configuration */
 static struct cdns_reg_pairs pcie_sgmii_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
 	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
 	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
 	{0x0601, CMN_PDIAG_PLL1_CLK_SEL_M0}
-- 
2.26.1

