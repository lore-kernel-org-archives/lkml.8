Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B80C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595A121835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEAXvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:41 -0400
Received: from mail-bn8nam12olkn2037.outbound.protection.outlook.com ([40.92.21.37]:23264
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbgEAXvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6FN3plVO23Pc4Nzj+miOWWZfWSeMQX6kc9/oBpngCkuiu+DkJS5abYHbK1unB8ILLdGAzZKVpUZejHdPCtwgHOY4ab2lVagsJK54/U/Xbd14K3dbpA7kGWxQa/Tv1GbfJ2Kfs/pCWJCfhQSzyiA62/UHF4tO6w5/Kmu9IuMLAYHRSHsPeWzblmIbiX5DrIlDpjCn53qOATdMNP/IKz8dShhkG7k+kKrXLw3rPZRfv6Q+pY/dHFotTQc3IYxX06maQpVxO/Pe6FvHP/xo+dfpdOz893d7KbzG0hiCTSOwuxwWNim1LfxDrmjuPuEEGyT5eWM+tjrbGH6D8/32JJrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLYemwaEBXuCw81LNrqkz3hZdJmEbWyisRQ0BSVUp3g=;
 b=YtwPDMbUA+UAdFJfaXaI65gB1d+c4VJS/pdjRFYUN4nXP5Kfe58r5PVkT4cumUtj3o3U5GphOr/W0EguTcLrZqPDEqLoyur/kPNqKozIfM6IbP/Ffnnd9ogMy1ch5YV6c0zfoyHGEEITVxMx8TFFdA+p2bidi/BUefBeK+ofIzg1t+4/SkUAZosUlWKZs2QcDplrgTGrSJ5mW/mIhCmCk8TIGEcvBgHAfgIYQinJkeCb6UIiahbzbu6DPLldfeNAJKn6OjnMAgc0zKyRRWySz6eYFwgiiA4BRx4jKYrhw33skDQVLxll/ASHo5I+Zr80jkqi5Aj9uW2/6PI0nrAfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4b) by
 DM6NAM12HT076.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::378)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:35 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:35 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:034CAD3B5D64B008501C37F0046CAD80F9E1ECFE110D49C5935567E379B7AC56;UpperCasedChecksum:8B0120337EDC16162D9427B209D6F0EC6CEE581929211931145DBEEE85DE5295;SizeAsReceived:7853;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:35 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 14/18] ARM: dts: s5pv210: Enable ADC on aries boards
Date:   Fri,  1 May 2020 16:50:15 -0700
Message-ID: <BN6PR04MB0660E7785BAE8D0F44F6CE57A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-15-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:33 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-15-xc-racer2@live.ca>
X-TMN:  [HhvsrbqmRVjdm4jRYAFXKAiJJQ8B3wEOJUZcWEhqnbr8Ld75TURUw9/GC/GirMfT]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 7a9d2150-12d8-4be5-c2e3-08d7ee2a9487
X-MS-TrafficTypeDiagnostic: DM6NAM12HT076:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tvEpkKrP/D80qSAbz7FkbNpHGT04bYgAaUY+zN2r5y7QVqHA8AW2ZBCwyJup/v5oX5EhRPBsFo7VgY4ZJhySn7trcYNo0jX460u2QwqIYZFFD+9ff8RhA9TptQrqB7j1MWiDU0UWng90qC2P/x1eiQODKjPZWAEtXU/CUmgNuQhA/mH5TxmFS/oz6z2beCcPjovkMTwfOaxRqYfY1i5mQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: pm4V3/V4Ml0LrF8mo5GZH5Rfcq5zYRnUBhLSWF9JqelyqqUyXfanKKtDwH4NCee32UiMxSw1Mf90vz2ii/nYlHLc1CSOkxRlS2zH2T0tftWngqKxINijn68SHiV4FGDPQiG8f+jpBKOf0Okdm4aWrsgXGFr55a0xnVt9r0by1jOK247qHNPB+W9Ufjp7hfCql7zrRVU/xinIkuqiiHMWew==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d2150-12d8-4be5-c2e3-08d7ee2a9487
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:34.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On aries boards, the ADC is used for things such as jack detection
and battery temperature monitoring.  It is connected to ldo4 of max8998,
so only enable that regulator when we are actually using the ADC.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

---
Changes from v1
- Replace removed regulator-off-in-suspend
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 945259aa5d55..9f4694d71203 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -195,7 +195,6 @@
 					regulator-name = "VADC_3.3V";
 					regulator-min-microvolt = <3300000>;
 					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
 
 					regulator-state-mem {
 						regulator-off-in-suspend;
@@ -539,6 +538,12 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo4_reg>;
+
+	status = "okay";
+};
+
 &fimd {
 	pinctrl-names = "default";
 	pinctrl-0 = <&lcd_clk &lcd_data24>;
-- 
2.20.1

