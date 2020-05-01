Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C096AC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA19621835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgEAXvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:43 -0400
Received: from mail-dm6nam12olkn2012.outbound.protection.outlook.com ([40.92.22.12]:6312
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbgEAXvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+7mpwR3Dz9XZqPOeyNF8sj9Fx8TV9O+CQsmJH6gfUKmNwYUCbs5eFKq3uP+avb8ygqwyGhb2sdxEOqTposAeqc29+30DP0TAtlx+1HReBAw+7s+TaGJ+eddkMo4rW2OsBk1LiMZ19dK77zWswOZ0wM7M+bCIQ5SsPu1B81LFebf0nMDfVtjahCsQiOhEu/aMDGJwiISr9yoXzC6pZJF5Xv9W176oXrrBGuLf5/BKX5zSBeF5VlTkeL+yzCKUbHVreoFHZtsXgmBsU+vqjL794hWUZgFD1iRFz68/G7cdmYQc24Ms8tcuq2ipKnKvbe9lwuIiVa1/5X2g+A3+U/x/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHr/7WE+ogxMYf6hOleP7yRxnD2ewDqzINWt5DLoNN0=;
 b=jagqkHRoZS/a4VMt3gthgzlgScaqe0b7IxcgPav1/Am32XTEZzEC1zc6BRPVBzkAKmo5T/YI9WVz3v7UBXeA3rgXSHUhnJCv3jWdmgZGuqE211+6+TpTatiVd86FmJ9vZo991OUAVFbYyGmhcDPvC1Hi/A8hb8NjGca9iKS2ckBLVly54eCUR+jTUzNnVEnS9REqsJRS7wlnwbRV0MucDCtHhNJPM17C+7wMZMh2GbGODHGskI7I7v8Vd+sjsu2Bzem1XYNGYF5Swxre901esXvF4GC3+Fwt+NX/LlDcCeMBaV/oQLlWjyx8QxmiTEqeh+jyFdufFZBuCfKOflxpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4a) by
 DM6NAM12HT116.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::100)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:31 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BB0B0C1DB8AEBFAA843D4AE8F07C9D8C7461EECAAA9752D14FDEFECCE4E0E420;UpperCasedChecksum:C954E615F3E602F33734112D3921A2CAA2C0D90BD761C2D7962D51EF442691F9;SizeAsReceived:7870;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:31 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 12/18] ARM: dts: s5pv210: Disable pull for vibrator ena GPIO on aries
Date:   Fri,  1 May 2020 16:50:13 -0700
Message-ID: <BN6PR04MB0660C61E15452E1BC3B717EFA3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-13-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:29 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-13-xc-racer2@live.ca>
X-TMN:  [Ap+UONHn8F2u6LkEOl2UEuF5QkdNG0obwAG7GIzp5WYfAubwZIxWGHB3AwAKV9ek]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e447f098-a8e0-42b1-5bc1-08d7ee2a926b
X-MS-TrafficTypeDiagnostic: DM6NAM12HT116:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2P3mp3BGD5+VhNwXH5G4HGb7mTqCzW5KJY8iuVXhzFG6eKItaRG24rQFV1q6cAdJSB348nPYdJCUpYlQGQemEDQlprIvicX7lPiPUPD4Hck8OdFZLnXqNg+PFF0bkNX1J1ofPwr6CBNtFnnxg4HcjaLV45cmz9g45amJYai9WZGOWJr9VJ9Am0cNLZYWr7c8a+Cy7dH3c1MPu9Q8zhwA1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: wipelDvCqo7yGVKpRfaHAAKklbQr7d5WLvr63GrkOgyfvFE15E5msnAk1eFUEotq2oslgspyhxju2YityBFndXpCWoGWRITgcgHFV77M+o01SS6n0WRIXALrNjBFBT//fv9s5r1Yfivdnknt+xLL9mIah5a03OreqPW2e9cumx5uOADbbjZnBAhWGzfnRQRMlG+s9JyXzdqBpdU4DbhiqA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e447f098-a8e0-42b1-5bc1-08d7ee2a926b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:31.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enable GPIO for the fixed vibrator regulator shouldn't be
pulled in one direction or the other.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 0fa3de3c985d..945259aa5d55 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -52,6 +52,9 @@
 		regulator-name = "vibrator-en";
 		enable-active-high;
 		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctr-0 = <&vibrator_ena>;
 	};
 
 	touchkey_vdd: regulator-fixed-1 {
@@ -656,6 +659,12 @@
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
+	vibrator_ena: vibrator-ena {
+		samsung,pins = "gpj1-1";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	touchkey_i2c_pins: touchkey-i2c-pins {
 		samsung,pins = "gpj3-0", "gpj3-1";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-- 
2.20.1

