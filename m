Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA5CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A5F2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="WqpK1vVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgGVGpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:45:00 -0400
Received: from mail-db8eur05on2125.outbound.protection.outlook.com ([40.107.20.125]:32737
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgGVGpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+00AhyJ7ZaEysAUia7mSsNot3x1dwu2ea8+bYHzm8vLOegJOe7rQ+BLpVsOTfmCrV8m6qal3qv3FkomiEJGRKnJHlmwic9vnoiQW4aaUt3ORSJq0WCoJDIcPaXX6oCRiisAcGOuomtLyvni9G6XCt5gl/qRgbmHpUGIqRJ8rbQaUN2sKI/MGK3EF9IGIYLU0e/5xBww6TPKhIpr/Rki8eAwJQ/u8jFALhV9arP/QGP5+YlEQLx9hHLAqG7kOXdv0rDAuG8o6AHwBaCWEm+NA6YSfxheSyKqPZk3U3pgML94R6UK9PhKEr6bmYVpng4ooHDZdhpqwt89uXjp2jym1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgsElpI9rEBedex7fkJCobJrw9uGtd2u3cWCnLUycPo=;
 b=h3GMmN8O4MkDG4JKkmMDFEVKbqLNZG0vOmKVr7cnRxO+/8MXcnftbMzFxisbRhsxQRab3JIUdE4WW8mlra9WVk6iKO+51/H+FRodSkhWO+1Y1fjRqE93NetG9i4ro/xYkNdLSc/VNoUAI2HpjBLLkPStjHFTaXD2sc9GgjFu9YHPVKCAMvAqg6kT5kBwDI/m5KHwve4rP5F8FHPXa7wr/MamwPSrPXqOgHy9A+9am3twSciJkTuG4Y5sU6erA6mrdeAdLAr9aA667MGOkmp2rCPxdyjh0crlcPY5aY1mDxgUdGYhf1+kGA8NMPcWfSBxurdNtKdKDxO6HSZKc9jMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.17) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=nokia-sbell.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=nokia-sbell.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgsElpI9rEBedex7fkJCobJrw9uGtd2u3cWCnLUycPo=;
 b=WqpK1vVG8L3cmbCnU5h6roodDd9LRTK4LsojHkTrpnipN7dYgCgJ8CIks9kQrCdSsiEOXoqYbokBFDiqDGTwUAamEUF4sB3ps5VCIPoOiFlV8UfVsLOp1Yl+L23vIVMMqXMaMOQhn0LnaOX9n8QHVzxmo5yi32/O8y6fRXYlWWc=
Received: from MR2P264CA0106.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:33::22)
 by DB7PR07MB5916.eurprd07.prod.outlook.com (2603:10a6:10:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14; Wed, 22 Jul
 2020 06:44:57 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:33:cafe::ee) by MR2P264CA0106.outlook.office365.com
 (2603:10a6:500:33::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Wed, 22 Jul 2020 06:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.17)
 smtp.mailfrom=nokia-sbell.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=nokia-sbell.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-sbell.com
 designates 131.228.2.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.17; helo=fihe3nok0735.emea.nsn-net.net;
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.17) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Wed, 22 Jul 2020 06:44:55 +0000
Received: from hzling02.china.nsn-net.net (hzling02.china.nsn-net.net [10.159.215.126])
        by fihe3nok0735.emea.nsn-net.net (GMO) with ESMTP id 06M6irj4025323;
        Wed, 22 Jul 2020 06:44:54 GMT
Received: by hzling02.china.nsn-net.net (Postfix, from userid 61462992)
        id 2EA464849; Wed, 22 Jul 2020 14:44:50 +0800 (CST)
Date:   Wed, 22 Jul 2020 14:44:50 +0800
From:   Libing Zhou <libing.zhou@nokia-sbell.com>
To:     joro@8bytes.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drv: iommu: amd: Remove double zero check
Message-ID: <20200722064450.GA63618@hzling02.china.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.17;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966005)(83380400001)(26005)(356005)(47076004)(82740400003)(6266002)(81166007)(82310400002)(5660300002)(44832011)(33656002)(8676002)(70586007)(70206006)(2906002)(186003)(1076003)(9686003)(4326008)(86362001)(478600001)(336012)(8936002)(316002)(42186006)(6916009);DIR:OUT;SFP:1102;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb0b24d1-85a2-4851-a29e-08d82e0abeed
X-MS-TrafficTypeDiagnostic: DB7PR07MB5916:
X-Microsoft-Antispam-PRVS: <DB7PR07MB591601B18D533CF44285900AAF790@DB7PR07MB5916.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqBVL/syC6fbYNUv9mPc6lnPfGoJzX2rTRo6UigTRDIzFCnbQ4+Eh1But837UU24b7c0cPk3X/bPv1fmvOvsiKNCRmPAlYZW+OULnhyqAqSi/Erek4yQN8FTk7QoLX4nNbiHzVhp+9B6lPjsdiSPLETFarNqG7kcRpo4+kxTzO7g01qwVXr9KiHYoS+ciJ02/vqxNQ0DkVeRm9XQIziehHXWPyBfe0JUSdLBLIu2xbyvkn7J7dIRZ80fmIqzXJd0m9yQh4ClW2lbmuy8YJm7W61t0os2L9A00q0foBWa5S7ZOx++14x8+qFh2Q9tlheo7gaC/X99uC2L+Doxc42Lo3TM0Cn6HhdH1EIHnmo10t6HUVK2+R5q9Ksr8zRb6lzlrWpl5WYlCveF4jUWxvw8Ig==
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 06:44:55.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0b24d1-85a2-4851-a29e-08d82e0abeed
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.17];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_pages() does zero check, therefore remove double zero
check here.

Signed-off-by: Libing Zhou <libing.zhou@nokia-sbell.com>
---
 drivers/iommu/amd/init.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6ebd4825e320..60a8a70b0d4f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -720,21 +720,14 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
 
 static void __init free_ppr_log(struct amd_iommu *iommu)
 {
-	if (iommu->ppr_log == NULL)
-		return;
-
 	free_pages((unsigned long)iommu->ppr_log, get_order(PPR_LOG_SIZE));
 }
 
 static void free_ga_log(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
-	if (iommu->ga_log)
-		free_pages((unsigned long)iommu->ga_log,
-			    get_order(GA_LOG_SIZE));
-	if (iommu->ga_log_tail)
-		free_pages((unsigned long)iommu->ga_log_tail,
-			    get_order(8));
+	free_pages((unsigned long)iommu->ga_log, get_order(GA_LOG_SIZE));
+	free_pages((unsigned long)iommu->ga_log_tail, get_order(8));
 #endif
 }
 
-- 
2.22.0

