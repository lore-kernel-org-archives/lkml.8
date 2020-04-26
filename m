Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB96C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71D32080C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDZSgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:43 -0400
Received: from mail-co1nam11olkn2026.outbound.protection.outlook.com ([40.92.18.26]:38912
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgDZSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lABNv7ITKSjBckaWzPVx4H3V38gOfBXn1qbRU4l6v3x4iyvHfK/ALw/g+9E6MSPh/xMQWD8c7ils8qBZ9H0c+K7s8jqpaY2nHqQwHBHWfWVVdJHkmHzm2OHXwpOQIzxfqekYNBQEpD9jZNtmz87rjEIYnPq8ka8bKUUTThyUU5TOYdOR+hkG6Yi1AGRLOGJ73ov2U9m/KPfRbGBj9u2QZ2nAoFL4ioPHgVq1FLGshCWoXVrrEr3F/kuGH88CRX7pLm/eN6bPM/P3tRYwy6GGTnN9i0nBqpJFJxQn9+uwASjnGfLS8OTQgcMoOjwHLEBREPRL8TirXorngXDfh1+n/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADm1QCIora5F5xsI9vKan4SPBQw/v8naL7czrKxd8Rw=;
 b=er09ETFt0waCXiOp/ieYChYQQ+EOT+x4PNaEyJ+i/iY0tG7P47WvVv/QuXdgp+Bm9d3MJEl6X9pVvSJ1wuoG947SqUFtQMv7j5ISq79Xhi8+JVfOo68rq7hfNfQeRLDad/qcdSl/it8UzyKPXqshN8FBgnOCMGpkH5ls/WAFxJJFWCGl0P2UQ8C/DzPywV+Ws+OngNuc4P6N0qaRCnqtvAdZyUzZw8KmgT1mp/PH7batN1YGnvbomScTb5rlOZHvwlJDJAnSJl2uZ30yFOVstv17SCt2LrABtkxwz2uiBBaYpkIErcK2ha1e6SeOZ1q3dIAGxLSjnGOsxPDbKsjkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::40) by
 CO1NAM11HT235.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::252)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:33 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:EA5F9FD55E70672CA3059BFE9FE96795BCA50A2D6DB1471EB5559CEFBCDCE7AE;UpperCasedChecksum:686DFADDA5E372A30375280C053A85FAADD06BB4ADCFC3DA1ACC72F6126D59C1;SizeAsReceived:7810;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:32 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 04/13] arm: dts: s5pv210: aries: Set keep-power-in-suspend for SDHCI1
Date:   Sun, 26 Apr 2020 11:35:55 -0700
Message-ID: <BN6PR04MB0660BEA3352F245D0771576EA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:31 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-5-xc-racer2@live.ca>
X-TMN:  [cFIMDdM5JYMMSsbH+HSgtOPiDl5tze8Q5kLY9mZmgETb+nQEn5vSDYdvAMiXY69u]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: acc0ead9-9e7b-42d5-ac05-08d7ea10be07
X-MS-TrafficTypeDiagnostic: CO1NAM11HT235:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1pVPzGRGpz+Lqp+0XAojC2sUUr3/g9MsBUdurr6DGUlIcGAIfIexBraHWF+OikAZd+UNdQ5880UPh7ML+B0xP0CJ5m9wCL3lCDYrvh3ayXN+luxUf86eFP1qKCcAhwaXAzLRQ2p+ArGbCgftnMMbDyUm99cKGWpAgIsEskd4yzhFlPiSktP5YDyBhyMiMNCNZ2QfkrnFrXrE/qrQdOnXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: lj6DxNaJcduvnfRIvlzIIBHx4Zbr3Eo1cTQPwk4Bm2+hnMBFusPFIO64yxRMhpy46wQ67QDDaROKQwe6CXnllGLBKSW64QIkLAn6L+IO4rIgaqwWH2wFUd7ta0e5T5/3iUmnHiOXSEexZrMw5UTFj2b+ME3Faw/ukXdGZ2pFS5LNhTCldAsiUZZHNO7yQf3GkFMCk5FQlQAJGljmbafmWQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc0ead9-9e7b-42d5-ac05-08d7ea10be07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:32.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDHCI1 is connected to a BCM4329 WiFi/BT chip which requires
power to be kept over suspend.  As the surrounding hardware supports
this, mark it as such.  This fixes wifi after a suspend/resume cycle.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 8ff70b856334..d419b77201f7 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -454,6 +454,7 @@
 	pinctrl-names = "default";
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
+	keep-power-in-suspend;
 
 	mmc-pwrseq = <&wifi_pwrseq>;
 	non-removable;
-- 
2.20.1

