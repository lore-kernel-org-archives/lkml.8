Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5062AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DC420786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kgPalvkC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="2uEsmKIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgH0QUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:20:42 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:3578 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbgH0QUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:20:40 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGECUV029433;
        Thu, 27 Aug 2020 09:17:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=o0stDWm9B79hgYSq+YkEDQgNwG2RJzQhBR68nueFG3Y=;
 b=kgPalvkCOFiIY3gO+9z5U0O0NaYmmFxvkvLZ+UaMijc9JaoUzgCbiit+JmQWioxeD3u2
 4+anO9/pSxQ4y5bHSchH/dXuN6t48kUGNf3HST+lQsHuPaZX6cWKNXnl/M7Wmvc1scaw
 Sg1+uDpU3dXTspbu6A4Sqba126+E0ECHFWjIGDyYHo3KLikQbTxlsgMl0GxlXS3fDNHZ
 7T9mviBX2UkqbsnYko3Ffu32PMr5S7tIiDWEVfesWYRxCa+Mb/Z51iL16J916YUBepsO
 zbr6MgKWOfeg5HEYUPvAbb2yFdvXmnY3zEsiR9fKVeThXy++EG/qWYwXe1fQSLnv7Dn3 DA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxdb07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/B0crec4SNcHRoFEYnt/91K8cqFXjvF/vg6BzNztKrb+v0VR/YjV8HU0yAIxBikBKq/5uhJGMnks/CinVFtCgZhMcTXuLlfrQJVkNjI0s0XiHvl4nP8Dh13+M8l1xRCX74hBD5DepoIPjXPfN6QsDZvKVANc3u3gmvJdCYV4bPXU7T06hKfytQH/f3UKBixQfNeJ4xbfCiyjC6uchoJsuzmR9E7hDYbjWM0te6OMwfPtALxrsHJQEmPjPOdfwK0/1II32yUdwdDiNMLyFwkjDRjo7l31CMsbYGShYTwYGUoWVv+CyWjOu2Q+UyURXYZQPIztbAJ8ZWMqka9saLD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0stDWm9B79hgYSq+YkEDQgNwG2RJzQhBR68nueFG3Y=;
 b=YB6x9MEvVr2fCJ5wT6Y7AiNEEytMPF79F+azgI7ZvG4p3g/bToBhCdSm7xvD7PwTXsS6kcPOmw+NSAPAWpNP6plYPc8mKnoNexsFW4lAGADds6mP0veUSzvARAmkXzjqE3g1OllHFlo/f2UGT5MigQi9U0Z67hLfugLsquq4MrZu+7A5iBsuuHPJ+resbU+IZX0Q2Knq194l7SMW8Qe79JbJMKPgG7M6y4VeYj3vBPSru1hjyRPOO7d/qr2vVJyk0EjPwEwuY/iJvMgpZjLnt72abncty1wkwel/TbfrvEEQ76ShVeaxFupOOyIFXg2NFw2zm/NbwD4i0YTbheCjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0stDWm9B79hgYSq+YkEDQgNwG2RJzQhBR68nueFG3Y=;
 b=2uEsmKIWuhdYF7wmHviyA3lHw2r2jrV+QkMDy1hBfR2kwlD4/ZPMGqi612Res49Ty95+5pV3dZYwhU1SzQ1048rbYnQSEbkElORUPxhJJWEHewqcYq15v4H+q1blIvCpprlMfagshTpul4fguEHUnGExsNnmk/kzWG6+yHgbhGA=
Received: from BN6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:404:65::34)
 by BL0PR07MB5521.namprd07.prod.outlook.com (2603:10b6:208:81::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 16:17:02 +0000
Received: from BN8NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::af) by BN6PR17CA0024.outlook.office365.com
 (2603:10b6:404:65::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT003.mail.protection.outlook.com (10.13.182.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquL016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:17:00 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGqYO031850;
        Thu, 27 Aug 2020 18:16:52 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGq7f031849;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 07/13] phy: cadence-torrent: Add clk changes for multilink configuration
Date:   Thu, 27 Aug 2020 18:16:45 +0200
Message-ID: <1598545011-31772-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9386c071-d729-4510-8d71-08d84aa4a1b9
X-MS-TrafficTypeDiagnostic: BL0PR07MB5521:
X-Microsoft-Antispam-PRVS: <BL0PR07MB55213897FFE5EC92AAD6D617C5550@BL0PR07MB5521.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaedIrmY0bUjuFISQl4rnxdLBOY0GW0c5XjIuZGf3YOl4kV/p8uCZFL/GwhIva2EV7YLR1hvYfBKyX/3YXyK99la9uq6kfDGYqpaLdbtuuwvpr3lImV5B1LnA6Wr+TNw90I4W+Ma0ok+3msfRMfC2/TReaipIW0GHT5IQKAGCQCVSDnliJiJoLlhnt8cOLe40xY5OzWoDBCRM84WEBh0VKSVzqsQswaq95bbOJYjX5TZ6gkGHSgpcW0UIZc0TvS3qn0CvUYV+URO/rERG9bO+7gbhVH1YL2dUoJXC/t8m/7jNVl9mDIxt3gHh19DsZ411jmxeUQbLaxTOOlf8YQYnm+LtAjCiBklbHzPS8zkGV6eOrTL5ZlOm11IRz4nSRxYFBdUyq1XyGJxbao99AcqOjyUSyO9DXYca+OJxiN+0Ls=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36092001)(46966005)(8676002)(47076004)(70586007)(86362001)(26005)(6666004)(70206006)(478600001)(83380400001)(316002)(336012)(36756003)(8936002)(186003)(2616005)(4326008)(426003)(82740400003)(356005)(54906003)(5660300002)(2906002)(82310400002)(81166007)(42186006)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:02.1039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9386c071-d729-4510-8d71-08d84aa4a1b9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5521
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270120
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
index 56673806812f..9a87ee39a15a 100644
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

