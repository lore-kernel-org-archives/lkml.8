Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DDCC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7541221835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgEAXv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:56 -0400
Received: from mail-dm6nam12olkn2022.outbound.protection.outlook.com ([40.92.22.22]:56160
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbgEAXvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciS1YIFugGx1qIUtnhugOatGoeNjxEIJmvzcSR+oDVUbHgmKODMesngg7M+3nVZ096ihOUtcNF7RsBbF+ZfrwzeU6nylHKKS/0ptSLkAAYRlitYjr+VdqUywBXqjAe0wd6PD89t3cITIkmrR2HJqQuB1QkXgbFN7IY1JLhIrdlBMgAWNlr7P7GucUHUCH32JCFWtKZiRfOvne5Zsj6f/NemVhToSBrZLpYmbS3EoQOG1NRFwXn/hpzG/mZ5CPVChdeXEiz14AYBSbpchcvJyBiff+eBpwxKNucdqMVaxhgtxnBmkMFhOr+MEGkFYwlLo08XHNysnHtLjk/LvmSrM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5O1LOzz2sPZQKkPD2FEZaAIqrK1URX6n2USXrOZGY4=;
 b=MY1Btq/5Ka/dhqJLd2bPu7ygE+vrT3bVzTeK5LQ8i1uvNcRK6YqMtfEtcgUOfEwMj9HOQuqhbhxx0QiaPigcJeHtdrdT0v6jElS99k62HN2y8tjlKUDeJpLCey45zI4V+KTK8Em5qQs36zcgOYnggBM2QB2WTZCaq8zsBVIffsFR6FJ9VWQY80ShGUyWXrD52xbJvZ5pSBs79p12izbaUHAqc3jGepQin6a6fmD975VnmONBy8j8FYAmisRqPaYC4HJEj/DVQHl/e8WDmrxcso1XnfXS6gHGqO3onPjBBwPDcZLqt68S+c+hJ/kZaHcErzKhEgfx2w8iJfLooOjfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4d) by
 DM6NAM12HT118.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::126)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:41 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:41 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:500BD4FFDDA152933E5711F27EDDA5554E11B0EFC217C2C5FA8EF22AFA9B37A2;UpperCasedChecksum:376F5A11BF33F2485363DB9171BA7F4E04697A33EF32E87F25E6AA8627C9E564;SizeAsReceived:7853;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:41 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 18/18] ARM: dts: s5pv210: Correct gpi gpio node name
Date:   Fri,  1 May 2020 16:50:19 -0700
Message-ID: <BN6PR04MB06608BAC9303ECB0F6118AE3A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-19-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:39 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-19-xc-racer2@live.ca>
X-TMN:  [0ZkQ7nAcwNP61UKo6jm5CT6RYSlM87jxE50gKlmG/iNiAVPEIlo/p2aAykdGkuxA]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 45c080d4-55e4-471f-7ec0-08d7ee2a983a
X-MS-TrafficTypeDiagnostic: DM6NAM12HT118:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JepEKslIU/Pr/uwfG2+Y0K/uV9au7rZl+8ShLP7x0rdEdbVKiDnj1hYWWVOE76srjlFlIfKFzUaX5TDTD/zFAOjUS42FxqbYMclrVbz2fNwRYa154VEz9OjI999YCM1zbbqJLqjY6sXQiVE28Iy4MaXzkFzi5sdXVCTtyopAe56zc3sYoOkqLQN8OPcIXt79fT/hYoigJyjsZNR2YsQkIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: XQuTixmKn6b9MsRaBkt/+ezCRX3fnvFFTqeUwoKzBMasII7EW0kVOBjuksND2SeTj2J5ErRigCcnxRKMgLK1X1zo60EBpDzuEZtZgMMkNrVNsP7Jron9hiCoYkkBsmzACHQ1YI5jpQoY6QszecM8pb20o6gM4V/Q9eiAjqJeKFVExoqr+pSPrEdStDsuPrjWYlalEF7mizBq3x+88ySUAQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c080d4-55e4-471f-7ec0-08d7ee2a983a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:41.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node name was gpgi, but the pinctrl driver was registering the pins
as just gpi and the "samsung,pins" i2s0 pinctrl entries refer to gpi.
The public s5pc110 datasheet also refers to these pins as just gpi,
so let's make sure everything is in sync and rename the node to gpi.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 609f323d0805..5e8b66281f01 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -202,7 +202,7 @@
 		#interrupt-cells = <2>;
 	};
 
-	gpgi: gpgi {
+	gpi: gpi {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
-- 
2.20.1

