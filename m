Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA08C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711192177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HJ1jv+lL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="sfaO3aAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHGKNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:13:00 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49330 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgHGKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:12:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779xV5N017233;
        Fri, 7 Aug 2020 03:12:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=W6kR9bqO/SXtohjSkwnoByNxRA33sq6e4iFzScgh94Y=;
 b=HJ1jv+lL3QHsoIKwFtjwGYZdJRmKQheX3rcSs8hxcq+c2goQyfyfQplSOPF4akbp6+j/
 /lQnbr0IECs8/UDHVJv4Wj3e6z9w0mUNqMuylxn8Kkyt/sfpb0Fhrka+qBlgchCqndoe
 BCLma33jy5h/SvOcuPgrjzdQ5Atw9w9QQGrdy0jIFExyJsAyvZZoESSFOedE+TZdl/gy
 GQWJoi06lIn7F6uaSQZRGisgnNjkdY8QZfpAoJBtK9jRcscV2XT5fHx7OlBR01Nw+Gmg
 Huw0NOz1MoQq4TyB5BOwmiXS5dU4BA1+XqAA6xO12AH4ggf2Go0Gtzmm4tl/yEGjY7e4 nA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 32n8gy5suk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAoC6jK1K5xvnXGYQb5kJfG0BIjMfb5EckL3PN/oFNuvpcHZlIPPn51TSZ3eAWNyHq1QZU22ccUPs0joiPHkUiNYKEcuOk7vV806vzmlkVMZyMGnxIghFPF+whgtFUOZs6NQPYq8h3XGai+1RQuUvWJ0g2dUTaTtc/SggSvEzkJQgcR1hQPSEvC2S2BaVQcnyVxT0yw1T/rcQVhEcXp7wOtoeCeNSGqIs3nsy9l1038VJyr3aIa3XrUM5+ADNpSXH0tc3QRbgR1YwjZyVlds7KntWA4MRU9OAJhBYgidnxJNmEYupcp4iuaRH+9gIWQSP5b9Syecf8VT3VaJWVJBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6kR9bqO/SXtohjSkwnoByNxRA33sq6e4iFzScgh94Y=;
 b=i8JtbLaJ2VW90qPzuLBDU9VB9YG+PGkb25iwlNIG4v7rgpiM41ZfIQQO+hO1W+fxiy2mdFW18LKWZihSokGd7lFY8UViMR/3diGXFsWIZ1qruaN5Ync9SiP4zY5pRso5Kt3GfG2P2fQJl/Xp1yYJalQa6hYm9h+MNHH6G2i2Zxjkbiv9OzZya0ZYhjUvVgzh0DlOmVAHdl5UjqLOma2escCwfAmQXjNTPTiNOx8Xl58aJDDpnKJk4Q7vLyVqGfAZENPQCwu+wZYp0DRmOwFk7bUxtqJbLCs6l58bHbF1Jo1awBRsQV8Aapll6cyELxVeTsPSLLE4gEFMxmmoISZx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6kR9bqO/SXtohjSkwnoByNxRA33sq6e4iFzScgh94Y=;
 b=sfaO3aArNicHg2bZXuClI4nA7KsowF3e6Bbu4wJ5iMqh9Z9puejmJEET+3ZtBccFK6ZRVFCtwW9V2KPqnX4JWzQlvVYaLtf51ZbDm4NCluifmH7OnBeJEnK1+zewIDCwtd76hpUdiSUjHtx+Vhw1akYAjXXmXa3to89IgcY2TC8=
Received: from DM5PR16CA0041.namprd16.prod.outlook.com (2603:10b6:4:15::27) by
 BY5PR07MB7298.namprd07.prod.outlook.com (2603:10b6:a03:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 10:12:53 +0000
Received: from DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::5e) by DM5PR16CA0041.outlook.office365.com
 (2603:10b6:4:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT024.mail.protection.outlook.com (10.13.179.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5d021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:51 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACkhT013387;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkuI013386;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 2/7] phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg addresses
Date:   Fri, 7 Aug 2020 12:12:40 +0200
Message-ID: <1596795165-13341-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
References: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a05f07ad-b0b5-430b-f01e-08d83aba7269
X-MS-TrafficTypeDiagnostic: BY5PR07MB7298:
X-Microsoft-Antispam-PRVS: <BY5PR07MB7298F35AEFD96460974CD90DC5490@BY5PR07MB7298.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z4W2UuFMO4Rk43ImCH7o7zybHOpDBh6dyQah229YeLt6RusoJLG+Nb+TiV3VI5iO+aypbX4QwjR22fLR6UoBlVATERvcz5pWmH6IiuAInL61Gx8VimWF+teAaLmMk6avL8uKdbeQNysGz9barqtOPGaC4Hf8M+hDYvu0gfSsmyMQMG4p7ks9wm1O7FIIqDFte8FcGihGUliyA+oRiHLhMp3z2uvSHUD06+hJ5UbA4tXJBHRvibwaFzSf+P9PC2zsyIhLY06JKwDRKGCO8976BuE+J7xDqNWvVv3lV7CZVUpdgoekCuWDrb+REbNtueVPXNQcvauzPb4iTXiwUD3EP2yG4rDjhWZARAWtdNwgUAoNi4RWv1/Dy3b/MVv/ZehVLrXE0AP98DBuBBHdY5u8+cRz/ceIvnRrn6c2pQpoQ/w=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36092001)(46966005)(2616005)(70206006)(478600001)(70586007)(47076004)(336012)(8676002)(83380400001)(6666004)(4326008)(82740400003)(42186006)(36906005)(356005)(82310400002)(86362001)(81166007)(110136005)(8936002)(5660300002)(54906003)(26005)(2906002)(186003)(36756003)(426003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:53.0109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05f07ad-b0b5-430b-f01e-08d83aba7269
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7298
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=885 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008070075
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
index 50c30d49300e..177120afcc35 100644
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

