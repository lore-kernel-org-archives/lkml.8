Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F43C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889D82075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DFGo86yn";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="drtepdnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgHGLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:47:20 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50050 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgHGLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhUFP011316;
        Fri, 7 Aug 2020 04:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=15yUdAu50eDeu+mcbDg/IWsbJ81BZ4cZee1j/SFb/Vw=;
 b=DFGo86ynyOLRX8zHlQb5p5sftd5KI6goICAIy/WuVjh4bFRwcal+Gnyc3xlCuhkxV0S8
 1cLFAts4UyspyAuoro9QNwCQ5zyiecGgc+jy4Of55353uytkwqAaRvuy7ijLgpEAlSdm
 +OiOI3KQIfRzwT4xj36MM/yDxqiI233A/ep3wtUKwi1mVRZ9Z57TLJncE6h6j3NigJKb
 dTWpPaHNSVuhbZ1FuulqgoO9nHcrYWiyBpDcWYiXURDQg8ADbKGvgAk/oP5yTKt4Iln0
 IsgtsdyuEkbgrpKhKiO+FsgPQKKQOrtKS7WjkcWaWJIOk7fMnga5sAW4EMiyqMVb/7MZ xA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYISVvUg3yDcnb1aPOgLpaJV9UXgQqTX5SATWmso2+IYLIoE1+HI0Z71lYDIg07MMLr0vOP/k+Hp9lnJZo4lemR3DIU2V56AXfNRVNyqaWuozAJyVpY/ZqHnmTStIFzTJ9nThFHwOtNyZdkbJRY/AhuZLFBUq/bIO1eZLsSoUkK2f03xmncyO6Mx8S5S0H2NUJ/FsSNS5p0wyfdXq2+dRllc90PR7yNb5t+V4d2YiVEdzMw0lAxVPn7lgX+4oYJkqYR1bknW+lQ3LwaFTS5c5rFUoiyq0LON6KDbKb0KrCFKi5WIiGLlUECMPbCMxavJudxwhpHM26G1hhuQbbJc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15yUdAu50eDeu+mcbDg/IWsbJ81BZ4cZee1j/SFb/Vw=;
 b=BbxKL26WMp8LUznQPwV+iVqV3njSTQaVyBYpii1+sWbKsxlI6FQ6nTjqLKKQi0m4y2LZSDwFJyoMUnFrkYkXEcx6uRo51zEq5MO0HB1XxoVmZa5fiZoepwkSQmTNRsgRJLa9+E0Efqzho53RRpPEx7hL/oZ1jrb7oSikxsPsysSzA3ACe8dW7IGP1Iyyd/526McmnWvU9Y0U0Iia32bTMGzyNOk1XvWF5wdg626N8pvXfPPDHSwQ0pSICV3wCa3SNQoLaKlDthw+D5JLmb7bkBhkXLCKUnZ0xULkafdMwKK/HM+vuztfurZHx5qlNbgjyMoR9sJ9r48fpTCuZQaTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15yUdAu50eDeu+mcbDg/IWsbJ81BZ4cZee1j/SFb/Vw=;
 b=drtepdnCSVgFlaB/QWAykUiIs/T0/QweQ6Am4Ih6YV9xkd6GMogfRDqWr9gygGtmoDr/f66KioxJiAOECNXvTWiSskULxPR91G5JIg69+AFAoRB6q+Gj44eD3U+ZaxRyCz0HoC8YpWMyY9OdiV/0Gx1RKkiTluOPwDDD2PFwz+8=
Received: from DM5PR11CA0010.namprd11.prod.outlook.com (2603:10b6:3:115::20)
 by BYAPR07MB4359.namprd07.prod.outlook.com (2603:10b6:a02:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Fri, 7 Aug
 2020 11:46:23 +0000
Received: from DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::5e) by DM5PR11CA0010.outlook.office365.com
 (2603:10b6:3:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT027.mail.protection.outlook.com (10.13.178.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9PE029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:21 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9fY000852;
        Fri, 7 Aug 2020 13:46:09 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk99s000851;
        Fri, 7 Aug 2020 13:46:09 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 07/13] phy: cadence-torrent: Add clk changes for multilink configuration
Date:   Fri, 7 Aug 2020 13:46:01 +0200
Message-ID: <1596800767-784-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dff46143-336d-4f41-ca35-08d83ac78209
X-MS-TrafficTypeDiagnostic: BYAPR07MB4359:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4359AB16F58635240158C68EC5490@BYAPR07MB4359.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXeDCzYa4KvENpApdGrU7Dt4fc5j4F1Gl1Ov8QwX6HIfQ2/1ToVvglWO3Le736DWvA6BmfkHt7o+HCMt6zRMHRPPVA3cQRWW+yQc5CemNaF1jNRtis958d620VWzY5fiCVoqJQEpx0/EmkSyH7Q4xHQeh9nPB3FoycBETYoZLr2EbmygryPz+4RuRZCE7UtQLn5QaQv6WZGcusoj4TK500oBp+Uz+BZoYiB8CBmPx6PM9GgZfr2+G5vv1IjUZHvjTBAFdFNIwlVYbdBGNUchC5etYJ6T3CSO6PEeHRnQ9gw9+aaTqQdgNH7FTkbCHMBoEyWYPy2T4FMhxALhcJrQPjIUJSjME6LbyawAOscrGAZXFJ1MNUdbrbeDLOYG8R7A5xypFMqHRy3a1J3Umo34l/3oixg/2/LoDg7Sa7o4EwM=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36092001)(46966005)(8936002)(8676002)(82310400002)(186003)(83380400001)(70206006)(2616005)(26005)(70586007)(356005)(6666004)(336012)(426003)(42186006)(81166007)(110136005)(54906003)(36906005)(316002)(478600001)(2906002)(4326008)(86362001)(36756003)(5660300002)(82740400003)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:22.6828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dff46143-336d-4f41-ca35-08d83ac78209
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4359
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

Prepare and enable clock in probe instead of phy_init.
Also, remove phy_exit callback.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 41 ++++++++++-------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index fc5720845ec7..691d4aa5b2ed 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -273,7 +273,6 @@ enum phy_powerstate {
 };
 
 static int cdns_torrent_phy_init(struct phy *phy);
-static int cdns_torrent_phy_exit(struct phy *phy);
 static int cdns_torrent_dp_init(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
 			       u32 num_lanes);
@@ -305,7 +304,6 @@ static int cdns_torrent_phy_off(struct phy *phy);
 
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_phy_init,
-	.exit		= cdns_torrent_phy_exit,
 	.configure	= cdns_torrent_dp_configure,
 	.power_on	= cdns_torrent_phy_on,
 	.power_off	= cdns_torrent_phy_off,
@@ -977,14 +975,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-static int cdns_torrent_phy_exit(struct phy *phy)
-{
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
-
-	clk_disable_unprepare(cdns_phy->clk);
-	return 0;
-}
-
 static
 int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
@@ -1825,20 +1815,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
-	int ret, i, j;
-
-	ret = clk_prepare_enable(cdns_phy->clk);
-	if (ret) {
-		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
-		return ret;
-	}
-
-	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
-	if (!(cdns_phy->ref_clk_rate)) {
-		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
-		clk_disable_unprepare(cdns_phy->clk);
-		return -EINVAL;
-	}
+	int i, j;
 
 	if (cdns_phy->nsubnodes > 1)
 		return 0;
@@ -2072,6 +2049,19 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = clk_prepare_enable(cdns_phy->clk);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
+		return ret;
+	}
+
+	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
+	if (!(cdns_phy->ref_clk_rate)) {
+		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
+		clk_disable_unprepare(cdns_phy->clk);
+		return -EINVAL;
+	}
+
 	/* Enable APB */
 	reset_control_deassert(cdns_phy->apb_rst);
 
@@ -2246,6 +2236,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
 	reset_control_assert(cdns_phy->apb_rst);
+	clk_disable_unprepare(cdns_phy->clk);
 	return ret;
 }
 
@@ -2261,6 +2252,8 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	}
 
+	clk_disable_unprepare(cdns_phy->clk);
+
 	return 0;
 }
 
-- 
2.26.1

