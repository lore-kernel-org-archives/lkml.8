Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01FDC55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD77820A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDZShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:37:16 -0400
Received: from mail-co1nam11olkn2061.outbound.protection.outlook.com ([40.92.18.61]:35235
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbgDZSgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHlnwr502X2bwwvoavNpFoCuNpju2t9ejYfPe9+Whw3EAWeFFoSsHi+YVbgVY40p8K+OrU19/t4Pm8MjGibVmFkNZ21W4zKWtvG5eKC9VhagIOiaTsICnbW+T54oq0g4o6mINHdzvi0GgMWn97qrZgC0wMfN+wrQ8K2DxN34kRCeDQdwwjYLAmWiD8szyV3UpeTQu3az87LwEIbwsVzSi3yHKEG273zGoQZDxhLtiF2lkSkLwrOqSqz2+nRPBPd5Vq3oDfvGBImgr4Q1CKknXqrW34bQN69TDJbRocGWQ6WTksPO5aULlPSRXJb5Zjrj/mRcT+ciPzH5sylMZ7ssdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN3YzdF/wnL3hIWhRkaPqBP6Y72JqMDzTT6ZdUZZ9Yg=;
 b=iAr2C2je11keFa190q7qXk1mDUfeYk4N7vni8n8JqnTMpCKx8nRMh+Cy3QJOBT0lT3apgSgKi0sFzGCOZcWHpjtQ+yya6kjdN4XLnAQqBpDQPaSP4Jytf5PHvDGTfjY3f0+XMeVLlx1j8QEbn2dVL2qYyXLkVlJhcz0ZKnUHgSu0F1TI7KOj0v6K9qLpcV8fOoPAGp6ASlGWvLjrgJCKezGYe68ESHTHKcaC1AeqpnFWeztpjznMePdR3rsXEMgqCgCIMGI/JoBGFsgbU2YQ2GLxOTci96gb1R5Y1AJwTvNwPYViy0B0eqV4V0YBdfIMcQY0DF66y6ZiIlkLFv8gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::49) by
 CO1NAM11HT084.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::296)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:36 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5F10509FC3320B7EFF673AD6D8CEFA253D459EED2554C8E058F87FC39848115F;UpperCasedChecksum:4AB90F327A7B48435C8EB54E8351E025C09317A31AA93FD23F061501063840E7;SizeAsReceived:7818;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:36 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 05/13] arm: dts: s5pv210: aries: Disable pulls on GPIO i2c adapters
Date:   Sun, 26 Apr 2020 11:35:56 -0700
Message-ID: <BN6PR04MB06606817DE468110FE577158A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:34 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-6-xc-racer2@live.ca>
X-TMN:  [j70oA7TQKUoUjRVsjR5RJCmnNIw2nj9SWjJOPAKrXSUEwUHSvDOIXE9yK0FO6QvG]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4d7cce88-197d-43f7-43a4-08d7ea10bff1
X-MS-TrafficTypeDiagnostic: CO1NAM11HT084:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmYXdj/MZUfDVEnk0fUp6Zc6nJaPEZN9onVwZwAbdn8N72BhUTmCUFnLVE3VQjoNlBvy4NPN8Kz8qCRGsFAlPzRPFdxCqMfhQXzloB312tX4jLEmSv/G6BjBCU45FBS4xa9KHjw76/XMIbqERXiIMmUQs8zAcjzLIKQbztjjz55ZEP1H6g6ktkq7gmGJ2/TQbEnL3mngajhFU+UPa+YNjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 4s0Mc8ZP09YoZmvtUdCQPGuILQx4HohDOB8I1SJpzq9J7+NMdS2Zwm8qsBXM0Ly22zE7lbTs8iT0jhX27cD7AUHfS0IWKZNjnwh0I7SkJn3mWlwyRA/gHKizuseqO7zk2x2rSqcKrZMvIobIVB0lHgCMttW/H/3RAlXFAIEf5bXJ3yEhin3UzY3UJybnCw3zFHmQpNbgEDKuuk+bsK1OaQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7cce88-197d-43f7-43a4-08d7ea10bff1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:36.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bitbanged GPIO i2c adapters have external pull-ups attached
so the internal pulls should be disabled for lower power usage.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index d419b77201f7..f83df426f2b6 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -65,6 +65,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_i2c_pins>;
+
 		pmic@66 {
 			compatible = "maxim,max8998";
 			reg = <0x66>;
@@ -314,6 +317,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pinctrl-names = "default";
+		pinctrl-0 = <&fg_i2c_pins>;
+
 		fuelgauge@36 {
 			compatible = "maxim,max17040";
 			interrupt-parent = <&vic0>;
@@ -438,6 +444,18 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
+
+	pmic_i2c_pins: pmic-i2c-pins {
+		samsung,pins = "gpj4-0", "gpj4-3";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	fg_i2c_pins: fg-i2c-pins {
+		samsung,pins = "mp05-0", "mp05-1";
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
 };
 
 &pwm {
-- 
2.20.1

