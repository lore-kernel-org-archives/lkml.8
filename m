Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0EDC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E849208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgDZShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:37:15 -0400
Received: from mail-co1nam11olkn2039.outbound.protection.outlook.com ([40.92.18.39]:41807
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbgDZSgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmUQePHa302rqBAWeQAwp1OIsKGVS2twnUdn5vhBnbS9kPNvoPIwWrf/1EWpdhoEzbU6YFunKTGWfPJ4IAR1tLhIUkWpnGjEm4RRcm6kuSBZz8eEQ3OxhOuzPxp8ipn6/IzUHRPR621VUeGvk2ajW15k6SLVkIqz137F1VLyjGlyuBSiOZ9GnffnAIBnP6d1gGEYQQNAmLY4ILaA1L9V7cm9zil94BglLsynCRlzrx4UXaJvXJcUyyojRAo8hJcJLObFNxSEx1V3mEdxHfJhVf02nnzhg0BwXRYP++JEb9Xz8+cYkKm86nHwfV1sVL5IdatlQFrvZIUTYVJilUTwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGNu/3xbaNpxsSVgC38hQUUTNLQvJatNnd7VJDjZmo8=;
 b=kAwGX+rZ1gAWckNQzLhaHDNXRRPNaoqkXMp/H7Jvty2jCMKplfRdBkHq7nwoxHZ/68d/3ve6cH5XcEZmPMBArLBYDuPAdO99mQS7/JmSiA5/CdJWn5TPhcZvH8+4VPkhVfHQQW/1CN8Q8Eyywyl0ozSFbj1xc9VBuReEKaR4yauTYhmGg6IURBMDFABH076BZvPb/QOk5S1rQmHyIFOggJw2v54Y/t6BgHyNjgNZj7QV6HEMR/juo8CnIRauWgPC9q05jHp2sBMSIa31xyzCcBJLVHqZHNIyhVauhBqkSifbJW/+pvuDKlvSgkXghrh/mDW07riKfZd+qhbAJ+peDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::43) by
 CO1NAM11HT216.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::194)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:41 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:41 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0FAA18BFDF6FEF50702D1810A579857AC1D3B97FC5E888D4DD16731D088FF30B;UpperCasedChecksum:94698D7E4028FF6EDA7CE0C44A1CEE41E6917A84E305466176DECDF2D878ED5A;SizeAsReceived:7817;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:41 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 08/13] arm: dts: s5pv210: aries: Disable pull for vibrator ena GPIO
Date:   Sun, 26 Apr 2020 11:35:59 -0700
Message-ID: <BN6PR04MB06608D9568CCAD70636186E4A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-9-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:39 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-9-xc-racer2@live.ca>
X-TMN:  [eL/F/hsHCqqUua+uKmFk550XRqm0dZAYKLj5vRIBTGBKZ+oIY6U7YS+U/JMR3aqh]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 350e0e33-029d-4bc0-741d-08d7ea10c2b1
X-MS-TrafficTypeDiagnostic: CO1NAM11HT216:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1ynnP0il1ar7GiZTSBJjovVRK7t3MCkFr8u6BuObsn+Hqj6efBmcRnebmhMGjoXN+irHSiRLHrCV5b9MRAg9H9wX4Q945I4opdjfMpU3Qmo3I5sA8FL49SiyeOuk6cjMAXchN9dJTeO2ylRXLmJJ4mds7aLg63t7/BaPMF2+7idVM59zy5lfBG8gp4ia4gfCUzXlbeI90VjSNfrj+4L9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: JcEHELp7K/VZt5WCr8t7lYl8nlOfql8QlszdlcOx78QyRZyK5jC0fHIm7q8b0TlffFEBq0px4Acj5emlYmWzPnWbFEVDVsscRhNW8Nx3bHGE0VFYHTPeN79otJXGvpar5yqQ6hRDTGS0N2dwiB+Q7imNSyK6E/XngHrEHmC9YhFy2iIUf2admG2qtRKvF0jwDysAzH6VZt0sz13yZqETPQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350e0e33-029d-4bc0-741d-08d7ea10c2b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:40.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT216
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
index 12575d64aa06..f30bdcb9c083 100644
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
@@ -642,6 +645,12 @@
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

