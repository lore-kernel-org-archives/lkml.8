Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49D6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBB620789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgFMSpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:45:22 -0400
Received: from mail-oln040092003013.outbound.protection.outlook.com ([40.92.3.13]:14558
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgFMSpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:45:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P507bCeM8Yn7Yn2v2otVQ7FwETBcyw9KJJwCKYF1oS/9II7Ds1giodur8KjVvSoSNXEcwIs47KHZWOaVf5jeMMym033en2pjgpURP0/HBaIc2lDsRsCRbU5LQHPsRt84wNuBPKn/vmNa9sazBH5SlehnsO4jlWxlhHOwzK6KQT3quiTv8mpykvPQNV7u1twVtdoI3RLqKAgvu40Al4P+p3BC0FcdnLHAxlqx29cBfo4Blh4SvFwCg32r1Meb6Ktg4PZy3Tll+G45xQopXZZvpB0N+CkC2JjWjRTCk1sAVVhxkOdnQQphkfMHXb3y/QFXnB6ebct34jpoU35Z3zK84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhgaG2itpjVJj2U6Sm2JnF3Q3J1Hcik19w9S1eepDcQ=;
 b=MNgJ4yr2Goyvk5bVRPa5fDtZhCrrL3ylz0EH96Lp2LTgmB+1j5uirqnQkg18yV/wrltP9yYn9z7m5O52arZDwWOzjPpU+bz4nBlwOgOwqCURnQ7vPP+hHxHeYxOAaVLVpYptAYUOjo6kaflijjlaabdQCJCmYlzsmLhIFyPkXKSirmU2ze4Hn3JvA484f7ed+JOZMF0kzFh3KfPG2mNPBAClcQP6DTUC3GLMO/EYyIfNUHLt+I/WshOkklomecRD2BCwaXIRnWQWfyL2meJJzPlfV5X+odJwKHX6K6c3BqmFnRW/NNmOdWTTjzEpCdRO6f7drHnfFUIzQVOm49w/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (10.152.76.53) by BL2NAM02HT181.eop-nam02.prod.protection.outlook.com
 (10.152.77.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sat, 13 Jun
 2020 18:45:13 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e46::4a) by BL2NAM02FT048.mail.protection.outlook.com
 (2a01:111:e400:7e46::109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sat, 13 Jun 2020 18:45:13 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E8ED144F710C56955811B6AE5F20D011D162CCBB8A386BAD1C88BDF5BF958619;UpperCasedChecksum:9CCC785411FF0208F99FA5FE3D52CA827EDE11E2563E5AE8365DF47952D2EEF5;SizeAsReceived:7757;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383%9]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 18:45:13 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 5/5] ARM: dts: s5pv210: Correct BCM4329 bluetooth node
Date:   Sat, 13 Jun 2020 11:44:27 -0700
Message-ID: <BN6PR04MB0660B2069DE8F1C81D894C75A39E0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613184427.23394-1-xc-racer2@live.ca>
References: <20200613184427.23394-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:300:116::32) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200613184427.23394-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Sat, 13 Jun 2020 18:45:12 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200613184427.23394-6-xc-racer2@live.ca>
X-TMN:  [LYFzZFzZ4n/LJPyPcdS/qrkZLlAEZ1yIXF0/6owonAWsM0nRd3y2WN3nODK8Eowh]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5d50a82d-92fc-4006-9140-08d80fc9e845
X-MS-TrafficTypeDiagnostic: BL2NAM02HT181:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /778A9UKMUFV9BDpn0rmzsqcrCDau5/J5P6vnu6yqSvGby0Ini/T30inqDkQgUg01R+RXgQmQIVtpyEFA9YvrNMK4aGYxyyHaUNY1FrLzvEhlMyQNQFj15cV2+iOFjeSW8ndGgC1nSU4gUUG4QXpEk0tLqQOx6c8skqKU70UOiugn0YIKkBaWqn6I+xDmslo4abIATXopvvqvJVakJuE5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: h5d6o1pTkuW96zcrHKmflqPOz0LlyWxJmTysKjbjP1x8t+NVh6Qd6p9yl802w+/38ci7lHwP/hDGdt3oFldZSFXvZBJSv58U9e7m75HUL9EEqzcBZ8+6o+JVQ1UE0wk+9lMaHxI6yAhMRE+eWAExfBOZc32aytjLFTy+7BeFbgkDjZgJiwfVmeIz9Ox+6HIZQWcksSYiApCIJgbpRQxo9g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d50a82d-92fc-4006-9140-08d80fc9e845
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 18:45:13.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues with the bluetooth node - the wrong
compatible was used (because the bcm4329 compatible didn't exist
when the node was added), the max rate was incorrect (due to
limitations in the samsung TTY driver which have now been fixed),
the clocks were not assigned properly so some rates didn't work,
and the some pinctrl settings weren't explicitly set.  Fix all
of the above issues.

While we're at it, update from the deprecated host-wakeup-gpios
property to the host-wake interrupt.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 92ec0e133b25..822207f63ee0 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -629,6 +629,13 @@
 };
 
 &pinctrl0 {
+	bt_reset: bt-reset {
+		samsung,pins = "gpb-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	wlan_bt_en: wlan-bt-en {
 		samsung,pins = "gpb-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
@@ -654,6 +661,12 @@
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
+	bt_wake: bt-wake {
+		samsung,pins = "gpg3-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+	};
+
 	gp2a_irq: gp2a-irq {
 		samsung,pins = "gph0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
@@ -845,16 +858,23 @@
 };
 
 &uart0 {
+	assigned-clocks = <&clocks MOUT_UART0>, <&clocks SCLK_UART0>;
+	assigned-clock-rates = <0>, <111166667>;
+	assigned-clock-parents = <&clocks MOUT_MPLL>;
+
 	status = "okay";
 
 	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		max-speed = <115200>;
+		compatible = "brcm,bcm4329-bt";
+		max-speed = <3000000>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&uart0_data &uart0_fctl &bt_host_wake>;
+		pinctrl-0 = <&uart0_data &uart0_fctl &bt_host_wake
+			     &bt_reset &bt_wake>;
 		shutdown-gpios = <&gpb 3 GPIO_ACTIVE_HIGH>;
 		device-wakeup-gpios = <&gpg3 4 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gph2 5 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gph2>;
+		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
 	};
 };
 
-- 
2.20.1

