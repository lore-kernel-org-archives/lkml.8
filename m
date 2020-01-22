Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE47AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFAB2468C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FMLZGm0r";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="7zdDJFGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgAVKpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:45:47 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:18288 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729530AbgAVKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:41 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAgdfS009205;
        Wed, 22 Jan 2020 02:45:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=ksnkI2QsdbN431sSM59ZOJNm1W9s+Eo5/oFMNCdYaIY=;
 b=FMLZGm0r2ChjWYhVXYyLOEjfI7T9fxl9q/0NmjWbV1JhHNbwobxvQ2r+N3L5aHW91FK8
 547SyFAM1/nSLiVvgfQHN+/RJH2lrrlJ+2AnKD4L9jsj/tZbp67VTIye4aFNvX9XBic3
 sBg8h+GpcPFAeqSSeQ0qh+pm9g127F6/G/W+3U8c6v7aIh9dXDO4NgxuFAnfkAr9fZnp
 +ZywQ18ykcvY5HIfGDfR+WltPl5Uf47JbhWxw6Lqxd0JnblbHhiwKtng8p43YP5eGPir
 f9jhFibpOtyeGDoRguvdPg8jWu/q8z8u9zxp0NJBEC6J7BuZTe23g7lzQG03IhEk/x75 qA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mgyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uiv6Dd6JOYgTPfBX6B03nZF8ch/9M1QUVE9LEOEnwePsyCDCn2Yii5vspdlkYIdRtCSoeeFiup7s3ws0sTSia0Abb4GI76tMZGNh8OKi6aCGzfc1DJtMWCjYBNA6lHy7k1DHuGzMwplse7tL8B5Bag/89jL0bQBYTO7tCrE0LkoO8VJoFSp79PhpG9nbAZ3piU9tBmGITQVFMWvvWflRtEAHhTIHiW19dqc0EP2i0+0la7xYFcx5UmKXRMExlnResCie78iBvHrIUfQnodSpQUqcOCGeMuOEI7x8vKClraFuErihEYb8shZ9quWWOwtdmEqtUwGR8FVAOZcHJ7TxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksnkI2QsdbN431sSM59ZOJNm1W9s+Eo5/oFMNCdYaIY=;
 b=PpZBFfgxD7LaeEALHj794I8g0VWQLxG/LcYrPGEvrmaUlgQRSHlXnDOB4pDnxoQTtWb1uVEiXyHAx+1emwCAk41RCfcxVnVBQFlxWkIk1kBjfalWiEhBv7FisMgW1r2kpvvggm/4QF7jKnJX03PKldsX4JbgjtcZUCrZXR2zVZAwMg60UMa0MoijDsZss3Nu4tJ1ZowbDEdY+DwAz9atruQ20hE6rLvLFYutnPqhLYSmsMt6saIjCSKFdsK2pXWZBqExFOg0ka9KDq7wtwL0AmByECXfFqW1nCLLzaargsHHrM0j8uYsWqli7gg+Nh2QZ+CoOEFGw4w8zDCyRXKbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksnkI2QsdbN431sSM59ZOJNm1W9s+Eo5/oFMNCdYaIY=;
 b=7zdDJFGy6eumBmv5ho/rHaSatV8Ej99t4SHvh44q/d9UTGu01gQL8Dnf3hL3SrwSO1MZFPjkshJdE0I0kxUIIaFdKXBzfqOih+7fcBKdwDUPUMP8mK29kVG8q9ZZOSM6XjoPILmMMiKPC2vmWql6WxaX77oH4IjJLQ5NScwft0E=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 BYAPR07MB5015.namprd07.prod.outlook.com (2603:10b6:a03:16::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Wed, 22 Jan 2020 10:45:27 +0000
Received: from BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::202) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT040.mail.protection.outlook.com (10.13.182.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBD001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:24 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:20 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:20 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjK8g007250;
        Wed, 22 Jan 2020 11:45:20 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjKkH007249;
        Wed, 22 Jan 2020 11:45:20 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 04/14] phy: cadence-torrent: Add wrapper for PHY register access
Date:   Wed, 22 Jan 2020 11:45:08 +0100
Message-ID: <1579689918-7181-5-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(36092001)(186003)(54906003)(478600001)(4326008)(356004)(26826003)(110136005)(6666004)(107886003)(26005)(2906002)(336012)(426003)(70206006)(36756003)(2616005)(86362001)(70586007)(316002)(42186006)(8936002)(30864003)(7636002)(5660300002)(246002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5015;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 295c30f8-45a6-47d4-80bc-08d79f2830df
X-MS-TrafficTypeDiagnostic: BYAPR07MB5015:
X-Microsoft-Antispam-PRVS: <BYAPR07MB50155E508CF09B44B9547BBCD20C0@BYAPR07MB5015.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHe5lLvX6HZMCs4U0SEq3gmFMqxaYL4Yr4yiOt9tC3m8H6zWBdQgSoPlPPk6cQzDIK0fIyT+ztrgO6FkG4pnFpqq2cHEt8NMWN4AWv0plf5B36Hd+rIkwypBqjGRTyPnB8svY2BQmpy5zaummaz207FpVZQ4aydH7p+Otx70V0OJ2HLTue86bITkuJT2WZECyztmVSBG2wPSZA1tV3K+4qvCBkbxkXN/8OMiWFbgt7EpVSQ138dpxcElXMREUZcMzdF80IXPG8N7fZrLfUIoZDpTs51gVaih8w9P5jJ0+xbgHS3Pty9DmdBLF2mW+jMchAOrl5hhvWnzCirI1N/zsoh0pTjAXEQr9q+lQbn4QjFty76CbmANziz0nHDwuG9SCOmWTrw5mFMLQnDXEsniEOlgib5OIlZavqwY52EDWjMXQryFSyfmFEVxiujw4yDlCFi4CWW9V34NDFxc0dQ2u+64yXGP08f7qbo72tWorYDSFsJEDTxZaUI1mTYw8w1q
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:26.2317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295c30f8-45a6-47d4-80bc-08d79f2830df
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5015
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add a wrapper function to write Torrent PHY registers to improve
code readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 142 ++++++++++++++++--------------
 1 file changed, 77 insertions(+), 65 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index eb61005..59c85d8 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -132,6 +132,14 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+/* PHY mmr access functions */
+
+static void cdns_torrent_phy_write(struct cdns_torrent_phy *cdns_phy,
+				   u32 offset, u32 val)
+{
+	writel(val, cdns_phy->sd_base + offset);
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
@@ -234,34 +242,35 @@ static
 void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* refclock registers - assumes 25 MHz refclock */
-	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
-	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
-	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
-	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
-	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
-	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
-	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
-	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
-	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
-	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
-	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
-	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
-	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
-	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
-	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
-	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_SSM_BIAS_TMR, 0x0019);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_INIT_TMR, 0x007D);
+	cdns_torrent_phy_write(cdns_phy, CMN_BGCAL_ITER_TMR, 0x007D);
+	cdns_torrent_phy_write(cdns_phy, CMN_IBCAL_INIT_TMR, 0x0019);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(cdns_phy, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_INIT_TMR, 0x02EE);
+	cdns_torrent_phy_write(cdns_phy, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_REFTIM_START, 0x000E);
+	cdns_torrent_phy_write(cdns_phy, CMN_SD_CAL_PLLCNT_START, 0x012B);
+
 	/* PLL registers */
-	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
-	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
-	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
-	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
-	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
-	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
-	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0409);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x1001);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_REFTIM_START, 0x0318);
 }
 
 static
@@ -269,41 +278,41 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
 	/* Assumes 25 MHz refclock */
 	switch (cdns_phy->max_bit_rate) {
-		/* Setting VCO for 10.8GHz */
+	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0120);
 		break;
-		/* Setting VCO for 9.72GHz */
+	/* Setting VCO for 9.72GHz */
 	case 2430:
 	case 3240:
-		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x0104);
 		break;
-		/* Setting VCO for 8.64GHz */
+	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00E7);
 		break;
-		/* Setting VCO for 8.1GHz */
+	/* Setting VCO for 8.1GHz */
 	case 8100:
-		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
-		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
-		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
-		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(cdns_phy, CMN_PLL0_HIGH_THR_M0, 0x00D8);
 		break;
 	}
 
-	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
-	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
+	cdns_torrent_phy_write(cdns_phy, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(cdns_phy, CMN_PLL0_VCOCAL_PLLCNT_START, 0x0318);
 }
 
 static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
@@ -313,7 +322,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	unsigned int i;
 
 	/* 16'h0000 for single DP link configuration */
-	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
+	cdns_torrent_phy_write(cdns_phy, PHY_PLL_CFG, 0x0000);
 
 	switch (cdns_phy->max_bit_rate) {
 	case 1620:
@@ -324,7 +333,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 	case 2430:
 	case 2700:
 		clk_sel_val = 0x0701;
-		 hsclk_div_val = 1;
+		hsclk_div_val = 1;
 		break;
 	case 3240:
 		clk_sel_val = 0x0b00;
@@ -341,13 +350,14 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy)
 		break;
 	}
 
-	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
+	cdns_torrent_phy_write(cdns_phy,
+			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
 
 	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < cdns_phy->num_lanes; i++) {
-		writel(hsclk_div_val,
-		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i << 11)));
-	}
+	for (i = 0; i < cdns_phy->num_lanes; i++)
+		cdns_torrent_phy_write(cdns_phy,
+				       (XCVR_DIAG_HSCLK_DIV | (i << 11)),
+				       hsclk_div_val);
 }
 
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
@@ -356,15 +366,17 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 	unsigned int lane_bits = (lane & LANE_MASK) << 11;
 
 	/* Writing Tx/Rx Power State Controllers registers */
-	writel(0x00FB, cdns_phy->sd_base + (TX_PSC_A0 | lane_bits));
-	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A2 | lane_bits));
-	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A3 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A0 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A2 | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A3 | lane_bits));
-
-	writel(0x0001, cdns_phy->sd_base + (XCVR_DIAG_PLLDRC_CTRL | lane_bits));
-	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A0 | lane_bits), 0x00FB);
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A2 | lane_bits), 0x04AA);
+	cdns_torrent_phy_write(cdns_phy, (TX_PSC_A3 | lane_bits), 0x04AA);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A0 | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A2 | lane_bits), 0x0000);
+	cdns_torrent_phy_write(cdns_phy, (RX_PSC_A3 | lane_bits), 0x0000);
+
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_PLLDRC_CTRL | lane_bits), 0x0001);
+	cdns_torrent_phy_write(cdns_phy,
+			       (XCVR_DIAG_HSCLK_SEL | lane_bits), 0x0000);
 }
 
 static void cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy)
-- 
2.4.5

