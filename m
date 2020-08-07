Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02832C433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58F022D07
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lJFK3Nuz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="j6mbo8Da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHGLqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:17664 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728270AbgHGLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:30 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhS1n011307;
        Fri, 7 Aug 2020 04:46:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=lYwxFwD+6VnVhVsqN4SVGapslaZqo8urWEB95Y29uW0=;
 b=lJFK3NuzA2hhoGBn5sv+So1N2Fo6qrcqNNCOnYtpFp9fOsX7yiFfMpgfrtE16H5I7dRr
 s9stsLimD+YFGlcNTga2lbWPtEfWcp+QNgK1K+Z/4YR0U9FQ+V7MeS+XQacu90bFeGlq
 JjR5TEI4ZQUAO3CeHjTWEPYqX0hvCb82JpaCj7vO4BS2oKZ6bJbmiiws/dwmvMagl2PY
 3I54gHR66p7DB2EMYAhSElVPCFGHYJNXoSGDM6BbhzOZRthRbiKjhVsZs4QYNlBHBK7r
 Jos0fg7Gw4dr9vO26XgEqV7PR98Rwl4prjc+nSBmMoNzQruLhqlGzKBVTlGv4IM5k6CZ fw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaVbtK9rN4a89Kx1/BPXs7miyI25D2uN2IZBVuEZgJ7Rkf5QFiuu/RE4XmDkYVLoQ9N9lg6zaJvPl2i1ftFdRd7MBthP6zWJAAW3vwfPK5VxkPSq6Mnp1NM0RGGhfm3L3ykrcl7yk10P381zczj48icyy+xwVjZwdXVIwtHLZW40s0AAmUNvzckYqv/MUqcr32MyYPMIIl48t6QEGQ/J8T6CwqEajEsy/Dqev9rlmx2yrZ6930FLEWamo6bfLcgaxKQz93E9FQdsoxJXrpY24Foz75rQk+ArHxV6+OXtkmvgKShNZExzbuIw9F31bGWWBeOveosQe/i+4X3oHSj16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYwxFwD+6VnVhVsqN4SVGapslaZqo8urWEB95Y29uW0=;
 b=cSpcI+wxHEE6GKHDDPEE17RANUVaOPcAao3cA/eslJPl3LZnI/uUwyFpmg+UPU2/VTceUbng2eWStgvJnp5dnFP8aGTgcdM6iQf5dnPbrrE/ziKL6A+o4b0Au1qvB4LmVk4FenB7LWumu/VD3pTVg3ebwKCOLYRJom0+ws4V3YW6PnYYRJArIMQ7nmiWMrwDMFKe8FB9gnqdbsrVN/xvVapzeC0VqbVk1j4ve8ayr2ueGf+166F+ZtCMgFlU1zJIdYaF9r4BvZmerrC5Toiqtk7TzJXBp4tGUwQm+ewXpQJSqkC3Ew5SQnXZ7Ta5BhYvofdaqhjEXdTbmNwbHMm1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYwxFwD+6VnVhVsqN4SVGapslaZqo8urWEB95Y29uW0=;
 b=j6mbo8Da7LH49a6qHPNzgaLROH78mVcwf85/wMM7tg5NF3beKxx7Z4DJyGue9aG/E+wpO1o6OyMRF7DKnOQKgMbS5IoYXZnocXdIjh1WaNVl1nVaBIQIAWovYtKatlJ/57fRFMF8jnVcYHh6IxraJZOLtQpcojCeacAQUcI6UfM=
Received: from DM5PR04CA0033.namprd04.prod.outlook.com (2603:10b6:3:12b::19)
 by DM6PR07MB6220.namprd07.prod.outlook.com (2603:10b6:5:155::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 11:46:19 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::57) by DM5PR04CA0033.outlook.office365.com
 (2603:10b6:3:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PB029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:18 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9Pf000848;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk9x6000847;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 06/13] phy: cadence-torrent: Update PHY reset for multilink configuration
Date:   Fri, 7 Aug 2020 13:46:00 +0200
Message-ID: <1596800767-784-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c09b79-bf2e-4547-c17c-08d83ac78026
X-MS-TrafficTypeDiagnostic: DM6PR07MB6220:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6220CC5B01549BB744B10AC2C5490@DM6PR07MB6220.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fJQuEUt/GRUA3rHhPuBkg7YOVijcBAGKtsJL0ZahDyc0fdH23fQjm3NLTpf+HnrCzIPwkgT9WtMpzVJtG+zD9GRoZu1F3uIK98GV7Uuwtf6nm5AOrfDZJ6G5cZ85YTZy3MjBmmXlX1SiFV1K9G2CGzu6rKLGoIDSDIfIek2ogfp689YLA3uoTeIjWIQdmnc9lcJOsvKzIBW58Q3GxE8+98Exlc9RJV5i+N3RD9IzDMdP2xG0Bab3ondLYFTYTimvQEHS+nHRU+OEQg84rAF08VBEcW8Zn5wpDsxTicj6cSPpVk4JOOkUWGwJGYrG3VgB9JTrHo8ErK6TAI1fEbGpC9jlf0waKo2FEeomRNccvc8JXfuDVoPT6bR2PRKRszNkcDmfsuKkZlC/4byCD6lIO5Y/26ejeAQSEOF5Yctfi8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36092001)(46966005)(82310400002)(36906005)(356005)(42186006)(86362001)(36756003)(426003)(316002)(26005)(82740400003)(5660300002)(54906003)(81166007)(110136005)(8936002)(186003)(2906002)(70586007)(47076004)(478600001)(2616005)(70206006)(4326008)(8676002)(83380400001)(336012)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:19.5192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c09b79-bf2e-4547-c17c-08d83ac78026
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6220
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

For multilink configuration, deassert PHY and link reset after PHY
registers are configured in probe and only check link status in
power_on callback.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 28 +++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index c55f8bde52f1..fc5720845ec7 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1603,13 +1603,15 @@ static int cdns_torrent_phy_on(struct phy *phy)
 	u32 read_val;
 	int ret;
 
-	/* Take the PHY out of reset */
-	ret = reset_control_deassert(cdns_phy->phy_rst);
-	if (ret)
-		return ret;
+	if (cdns_phy->nsubnodes == 1) {
+		/* Take the PHY lane group out of reset */
+		reset_control_deassert(inst->lnk_rst);
 
-	/* Take the PHY lane group out of reset */
-	reset_control_deassert(inst->lnk_rst);
+		/* Take the PHY out of reset */
+		ret = reset_control_deassert(cdns_phy->phy_rst);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Wait for cmn_ready assertion
@@ -1623,6 +1625,8 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 	}
 
+	mdelay(10);
+
 	return 0;
 }
 
@@ -1632,6 +1636,9 @@ static int cdns_torrent_phy_off(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
+	if (cdns_phy->nsubnodes != 1)
+		return 0;
+
 	ret = reset_control_assert(cdns_phy->phy_rst);
 	if (ret)
 		return ret;
@@ -1886,7 +1893,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
-	int i, j, node, mlane, num_lanes;
+	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
@@ -1989,8 +1996,15 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 						     reg_pairs[j].val);
 			}
 		}
+
+		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
 	}
 
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.26.1

