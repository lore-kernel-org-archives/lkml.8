Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE77C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530BF22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="k52zsuxW";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="e4l1IGwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgH0Ov2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:51:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3154 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgH0N3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:12 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDS8jB004819;
        Thu, 27 Aug 2020 06:29:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=IV5Ny5eHB/cmqvEUtlVUH3Wol4YvRS9tKopyd6YUMb8=;
 b=k52zsuxWYj/HzJsfyqYjbo2OMY8P2l9C6LmsbN3GOGUoYlRkYNs4H/Z2tc5NPUf1AHKS
 D4gZeHUUm/hM4rKMlgXxfPEVZBrbpacafkk+a3+20ABmu6CWGqXIBzT5htm8qN+5nOz+
 1dPdXQqJuzDtl4vIPWBN/zhMDWoWTpq8S99HzNs55aGV8eHneY6VzE3SzuYq3P4VBlPk
 rTvQE48c1Fzn/EubrqS9AjsJXMUfMZ60P+MV6WKJ5XXBsqcppJw79I83kXLYXzGrEruS
 Ac9MP4fNQdfknLyZjPnfqXxVkErnQECF8bv7FWiYBbMzCjjLkHuCsXu9a0BQTe227F9V dA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww45dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWHCK9Jf1S4UWN8gn7IVylI2QmYZ6I6JeDMcOixLu4irvCoT6JMxw6zYSTgtxWEhCtWVmhNrJeaEGR86SXqXavtuWHPgg/b7oH0azYDCCt9rk8CgCTkGQhgs2+dBDPD0WbhNy0WWQ6Irl3uIdXl1Rruoc6sO/JuLYmMNLpeXP13lH/ux0k1QpHqvDaQh7vi1fhyMQ/ru1+PH0pph/JvJxHCESd8wHSy8ZAj97aRou91a/Mhys866XsOByVjxis12qQB1LFhIn4v101RHx/h1eJIdgPIm7XYU1Uu1NoohLN/+JClRcuICHigEORCydDHhCVApN7zvfxLdjTZK3jPT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV5Ny5eHB/cmqvEUtlVUH3Wol4YvRS9tKopyd6YUMb8=;
 b=ZtaGhG342FuWCIiqBHitAu7d2cGuUqNyW8cAeRoYZsIfOcOJDeYDa1ac9bMiWDc0w8mZBltlREsEP6HhPC4BKPMxoPtSdvXiizpJtOYIt8CO6+zET3K+RfIPGpg/d/Y9Nsmr1GOvGDna/A1jS2FgwbwgXpBB71MS6FetDB58cI4svEw07bOpHGwKiCuwB8TmdpZxxofpWhU6tDLm0QI2XJoB9a6O703M3P/JSiS2nt7BWSCdAYwExAuAsA3wVQqjT5PiZMwOeR4p2i24LbMgzP0HOcIR60o2gt1bRejgoyjwKURr8WJ3i+I18Kds/EH7xSh7EngVR8Y1pfYEpferKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV5Ny5eHB/cmqvEUtlVUH3Wol4YvRS9tKopyd6YUMb8=;
 b=e4l1IGwSJjzl5J/npCUQ9c9oY2cCFJDR0d8Rtf3D8JEavFVTWqAGwpmrsxBM2d+dpxRs/O7sTr6JNXYuUGEv2fn0n7C9c7nTh4FpRLv7fmCGTKaVO33Noa5VQ0r7o2F7/oF5oriWpBG59Kp13Lw3KOEB5X7W6LrwHDN6VyTd2Ec=
Received: from BN6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:404:f7::25)
 by DM6PR07MB6028.namprd07.prod.outlook.com (2603:10b6:5:18b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 27 Aug
 2020 13:29:00 +0000
Received: from BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::2a) by BN6PR11CA0063.outlook.office365.com
 (2603:10b6:404:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT040.mail.protection.outlook.com (10.13.182.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:28:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRi001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:28:58 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrJs018746;
        Thu, 27 Aug 2020 15:28:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSrve018745;
        Thu, 27 Aug 2020 15:28:53 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 2/7] phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg addresses
Date:   Thu, 27 Aug 2020 15:28:47 +0200
Message-ID: <1598534932-18693-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98ca282-9435-46f8-1c41-08d84a8d2850
X-MS-TrafficTypeDiagnostic: DM6PR07MB6028:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6028298D0DDB02642CF2B231C5550@DM6PR07MB6028.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpefefLy8yQDnZ9drBVSb5nSrJwV+btbXoerBLgOLOQFabOCFWpWc5twtKMW9rfCr7L5ERbVMJDg05f2Kz2A0Xon1rP/xbH2kqxOSOjmANeygGkTZlbWI3nxdsmvT1kaU+G+NsimICnQsO8YCkTExUHYkq4xgqK6AcOvIFurKd463ryG2bGcRfDdQ0IGQ9GyPURuBq3lepAtKsS1+nKt7HpY1d8UmwWKmKZTlSbeAKK5iNaMY4TUBxRCFLX0GFsvip74QeS52ye/Rn2M8Z84CbOvNnadMjti+hTrnszZkNu80BqQdkhxcVmJ8vduPPFO9B5SArhYCcKj35WRMk4TGucbvvwsyj7ODfEASL8pgUCLAXSYHW1hyKr378kgQcOK3kPLXAZoID31O30yjvkvSIEk3QiUN5q1BSNLywRga48=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36092001)(46966005)(186003)(6666004)(47076004)(86362001)(356005)(81166007)(36756003)(82310400002)(2616005)(82740400003)(83380400001)(336012)(26005)(478600001)(5660300002)(426003)(4326008)(54906003)(110136005)(316002)(70206006)(8676002)(70586007)(42186006)(8936002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:28:59.9748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98ca282-9435-46f8-1c41-08d84a8d2850
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6028
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=828 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to get register addresses instead of
boilerplate code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 98f644ae0a07..566edf0e7937 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1705,7 +1705,6 @@ static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
-	struct resource *regs;
 	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
@@ -1740,8 +1739,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->clk);
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
+	cdns_phy->sd_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cdns_phy->sd_base))
 		return PTR_ERR(cdns_phy->sd_base);
 
@@ -1831,9 +1829,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			}
 
 			/* DPTX registers */
-			regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-			cdns_phy->base = devm_ioremap_resource(&pdev->dev,
-							       regs);
+			cdns_phy->base = devm_platform_ioremap_resource(pdev, 1);
 			if (IS_ERR(cdns_phy->base)) {
 				ret = PTR_ERR(cdns_phy->base);
 				goto put_child;
-- 
2.26.1

