Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED405C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73AC207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFMSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:45:28 -0400
Received: from mail-oln040092005052.outbound.protection.outlook.com ([40.92.5.52]:59811
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgFMSpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWcUucdivqT09L29kCdKxE2kO8qy6BoP4/CYPG3ArOlLVhq1cUSG95gl7Pf+ApzmbN3D0Ux619fo+sBITLHRld0wPROu7uFC7pjvDNoC1I0uJ1mq/KW8YO41J/19cV5Jw5smUgL8/PDvAccKw1QhHzIEs4eJVisdawmMt/FoagnKr/nkOhXNEkkk97nDLzvCvVH9CtpUfHAdiN10OS2lgLK6gWmQTlbnMeHvpqMq1uo8HhchVNvzbRCSORARfufxFlXye7vrw9vbqt/bWbkvNTZvB4FcnaUc69SdlNCy0w67Y8JPMO9AIJqc7Pf7rXEt+4hOvXoiRcI1ZoEa7tfRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFf4K4khEPNJM8o6627pEv+rF9F0AxwtAAgwsqdy1Bk=;
 b=D53+w+nOXBuxv5T7TwvUcxQeQ3oayeb6vxzpKHj3IxVn2WUxsNKsmgO4zF29LO+OXFE70uqHBgq7et0C7sFRa50cJ4dIRpuUHnerlReeerj/lyWJEp1zYm2kngd/4PLyc1lzH8R4RsUV8tJnY9YmV8W98ujbXe4hcrU8P0HSSKSW+QIjbBIjF/S3vZ/KBFkiLc7Az1e9mF6rOeeaSpIkjmh/sjn/Et9XatHeopJL8dgZqoVLk8tviyeCWplF7+/tvjwghGYoDAg3Q1aua8tG5UYA+Y1e0ZdRf2x4yq8PHtoYwKHGdpgco6f/tj5u3aFmRHQA4Rj+nV1xRi1W17UY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (10.152.76.58) by BL2NAM02HT138.eop-nam02.prod.protection.outlook.com
 (10.152.77.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sat, 13 Jun
 2020 18:45:12 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e46::4a) by BL2NAM02FT048.mail.protection.outlook.com
 (2a01:111:e400:7e46::109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sat, 13 Jun 2020 18:45:12 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:006A9CC60C70A443D0FF6A1110AC46E1664D2D03D4ADD60286C8664298500BA9;UpperCasedChecksum:EED57D66A21F7192AAA8A3FB268901923D9CDF95850009AC979DD238F52DDCD0;SizeAsReceived:7759;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383%9]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 18:45:12 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 4/5] ARM: dts: s5pv210: Add BMA023 accelerometer support to Aries
Date:   Sat, 13 Jun 2020 11:44:26 -0700
Message-ID: <BN6PR04MB0660CD092750943F3129FCD3A39E0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613184427.23394-1-xc-racer2@live.ca>
References: <20200613184427.23394-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:300:116::32) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200613184427.23394-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Sat, 13 Jun 2020 18:45:10 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200613184427.23394-5-xc-racer2@live.ca>
X-TMN:  [4OzH7VKYy2RgfmVV1JfPNvQODrELG/AGPCSLf8ek5JpxaRhyh6bqUtdm8hwED2Lx]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 535f68b2-bccb-449f-0a04-08d80fc9e767
X-MS-TrafficTypeDiagnostic: BL2NAM02HT138:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WumNOr0o60wT6UP9eWB+UX5Enhw1ShhxECFoEFF34gli9Cxm/4A+esgW707VAppEe8meaPAXEwkwa6T0D8ciXUqPW+BxzDk7PARnfJYz2SsyYpFYTbbzNfs6umd8iX7UrDCi5fNGK47/23QbnsonmOruiFgtFtF14geeQFK8g+bK8MzBd4CfbAhWypVllSwA0tmUy5ICfVH68p8lOZ53Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: QxBeaHcfx0jtfdHdWu+o95iVsU+db0bfbZW6buV3ayYeBm8VBHok+IZqOpNG7YPB2xkGdS4xnUeGn6NgE8DW5lQEiKJQfjV9aRK2UhZI1MPgQMHVw8BCJ++1KhJ/qrTJBfqHZ6W2ufavV4LTReGf0yJeWR9l6JFB1vTG5YLniJz7zaVJs725Z5AjK3jNVeu0HdYIhPNDDycyzaKXmZakEw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535f68b2-bccb-449f-0a04-08d80fc9e767
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 18:45:12.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aries boards have a BMA023 accelerometer attached over i2c-gpio.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index b27d7c2e6dca..92ec0e133b25 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -149,9 +149,13 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&accel_i2c_pins>;
 
-		status = "disabled";
+		accelerometer@38 {
+			compatible = "bosch,bma023";
+			reg = <0x38>;
 
-		/* bma023 accelerometer, no mainline binding */
+			vdd-supply = <&ldo9_reg>;
+			vddio-supply = <&ldo9_reg>;
+		};
 	};
 
 	i2c_pmic: i2c-gpio-2 {
-- 
2.20.1

