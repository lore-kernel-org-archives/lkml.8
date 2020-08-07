Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E372AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86112075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Lh9MZOcB";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wcz7GKK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgHGLrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:47:23 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63234 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728354AbgHGLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:32 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BjYuW031928;
        Fri, 7 Aug 2020 04:46:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=wPmHxgzsU5J7eD21bj3DszuJIiEfZu0auvsqlDYhq8c=;
 b=Lh9MZOcBqhhVejjeRawMrfSOngmtjZz6ZNkXH/eIoUw8TLVzx36+lTcwe5C08bVSD6Dp
 /wHRZC1wAz9V+v3ckcWgLlUPkiBj9juJ3M3e14UUy14CM3DQ0AgmmKr6A7MXszQBK08C
 jh1rb44s+9MKSFC3mEiMA9/n26CiIHqkzc/1ijFo3K9IAzRIxGhFOSjV466FpgYYLdbv
 lPVPkfx6q8H09klhkKgD9foc0tBDDXGSPzlUcDlUfKQ/1yG+otIz5Wg/ZIzd8XHhQ/AA
 D05U4iDzXXw9JJHJYwyxQIdPscML2FYFNoCvbVr9YkWsWiQ7Rs1v5Cm3LKjab/fh3IsI jw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gy61cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8a9n6cYoe27YaC6Ihki5MI1AP99beHc/N8Id2GguhIi79rWoo4Y4bNDQe8xkOjO/MhJljVYxAiAItskqocz+dk6167JwYwQtLV5s8VPhtZJ0D2MtabejnsDOyOgAszIH2zw3Pal3E+pte7+5/86yJEWvU7Vfm5hU/ypJn+xEBRepejsgx4hb7TELFFNJ79ec7jDEq0lUtK++0hvL2lWsk12YxIyngiQKla3DW9LK2nLCnpeTRrPgp84D7Q8pLax19PtpGLhhd8wFOttUBbvy4NlpqKfnl0h2WHMLv/6auHGBKwyQ/wfkhNqFisdpeRikITbRhL3ZqmUfTcEi5qj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPmHxgzsU5J7eD21bj3DszuJIiEfZu0auvsqlDYhq8c=;
 b=lPkIHmbyysI6wXhTpGqRF4topw6dNHJZhUlPZI4OI7ZmHCykO6NiabEOWETM+y7szUFkP00JZrpM22fEJLBdzAYg6RTIZ1QTFfNAKWNQ4oI0EfBM5VrVc32yrdMDm49F+apzQipqXgixBwvSksCYWJ/2BRTgAEDsUoUaW5KWFRuActHRJiEkuFIX2uAZfJQcewCgGBVRwA8cBnlsm7myKJj+sspiyUFOrQSlInCwZcwuw1nFq95i2g4hXRB8sx3fmlIoecUVjARF+QQk7+wNyYqtlHGb5lfWqkq8FXsevQhmcpkN164ous2vPZxQJ9zVInXBgI8SbNqRt7bAjnBvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPmHxgzsU5J7eD21bj3DszuJIiEfZu0auvsqlDYhq8c=;
 b=wcz7GKK9Edf/j4Q9q/gKH50Wyvm58j1LqXgAQRMhFtAst7hwaouGKs/xQMuq+cDD8rP1SvKfDQRvvNukQE+22RxXLd/e4SRssoGnonYP4G8Yy62xw7N9fa9D0rCM4M4/NVroHZm5XimDD/yqYC/WbKmNtlksJl/SX63vCdsl3k0=
Received: from BN6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:404:11::16)
 by SN6PR07MB5742.namprd07.prod.outlook.com (2603:10b6:805:f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Fri, 7 Aug
 2020 11:46:21 +0000
Received: from BN8NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::94) by BN6PR13CA0054.outlook.office365.com
 (2603:10b6:404:11::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.13 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT003.mail.protection.outlook.com (10.13.182.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:21 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PD029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:20 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9td000861;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk96n000860;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 09/13] phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
Date:   Fri, 7 Aug 2020 13:46:03 +0200
Message-ID: <1596800767-784-10-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95bdc6b-b92d-4cee-e9dd-08d83ac7813f
X-MS-TrafficTypeDiagnostic: SN6PR07MB5742:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5742289B53B38AAD05B2BC8AC5490@SN6PR07MB5742.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+k1t/aMqAfHK/C9UDjrf6dmdcSoEr2+VlNzJ9dPMmnag+2yQQkSF7h88fd1XFvM+LlolQ2fCaqIKRS4gDv+0a4g6GhcZ+UL0O/HcNyULBErst34c8zl6WESeHeTsA9YzU3AciJ3xy8ibMcuZ+BDNs0pfl6JAqj1FjA7g1eEkeqRwpuv9eMcqDLtW3Zm7VwmV6Av/FyxHkxVZTgsUb7coD7VeVYQDPmYwGx2vZVijV6200qzkDwwhICKXBwNLUPSRFEtEpOOfokbcehO5diQM9+F+hKYvYMsvWiFxni+oobpFPoqnLk64kIb/LKQiJJWktw6OUvC+m7uQJ6eQAH8lZPiZBjhtlDub1dGInrEsXBWQOtC2IaHz3eheVEHUuL4r3+Htg1+/J8tNKL7QXygqReFnR/smYQ7sTEpVNtQIdc=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36092001)(46966005)(8936002)(4326008)(478600001)(36756003)(82310400002)(70586007)(5660300002)(2906002)(6666004)(83380400001)(70206006)(86362001)(81166007)(356005)(42186006)(82740400003)(26005)(36906005)(316002)(2616005)(186003)(110136005)(47076004)(336012)(54906003)(8676002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:21.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95bdc6b-b92d-4cee-e9dd-08d83ac7813f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=856 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008070085
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
index d01a44b93e99..216b25512a08 100644
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

