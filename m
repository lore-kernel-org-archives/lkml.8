Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA8C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA9520700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDZSga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:30 -0400
Received: from mail-co1nam11olkn2054.outbound.protection.outlook.com ([40.92.18.54]:39745
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbgDZSg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB30yC2WjZ/VQd3/vwbpaNZEm9qasyOl3/ayUMEe0q6OxPcjZIH3zlu4CbGGLTnQJltiU/I5vg+/nvGHlhFLCAxy/jeVyDV0OW3Cm4vO4BYr7qh7jpcLFriK6nfj7sdxBuyY8B8ROU4Jr7tkqhHsk7Y3uKwreOkroNxlqfKRmY3MRGML4VLfyVyKOfRltOrZf2aSHOzfpx6iZ+uaFdX19J1VnhkB4KBhIy833QaZt3az0TCZtDFUmwOYRpktzaVMZlv02/noIcw/n8RzZRHgX/8Qhx7SfjRStWHul2CWgVa+kBvyi4Pca4xOmEBP/fW85HPYeOeeSrAoFuPUjlKIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQPOA1QD9GTVHUlU+BUHXvxBpBudTQ+4UbWWmc0Qg+M=;
 b=SC2Dw3hzKf1HZjP2IwXL8rVkRXKMSGx/Ks6oiF+PAYXTPg7cPtaaMQRSEMBTDWNzoO1ehxwLnoH6VaNtEwZtos4PXEg9HaSGrQW+D8sW/4+y0MI1w/e5pObRwX5FFhOUqhqyXM4MQclZVyZYqjvWVbKTutzIixMkIeikNXvrsg/e6MXerUz1hBA8CPZUboo0qYISHOmRHy1q8wqM1lZS069cu+2mpPkbnJSdz3o5aoMPNKKIDz0EhMRDtNP359WyvcR948avBlQ6KOAFxmvf09DD+UihcBelvQvGX0H5cZZM/hWQwIIIb72YLMkE3y6HX6I3rcI9z5p1VPyLthEPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::53) by
 CO1NAM11HT030.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::136)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:25 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:25 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E01E34F719E0316BD58CC9781BA07AFDB707C4524EA80084F3CD0E5697A8F625;UpperCasedChecksum:60ECD18AB8EBF18EE2D5DCA52688EF124A1DD4F6798AD3B5287099079BB7A8E2;SizeAsReceived:7829;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:25 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 01/13] arm: dts: s5pv210: Add helper define for sleep gpio config
Date:   Sun, 26 Apr 2020 11:35:52 -0700
Message-ID: <BN6PR04MB0660C858441E09A44992F5E8A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:23 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-2-xc-racer2@live.ca>
X-TMN:  [buK8LiGiln34NSFlZ/t83sGSBv6ZpHHnbAVI40Z8qEJP93THUGl8zLbzcNBiT8pw]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 879d1e1c-43a6-4f5e-8db7-08d7ea10b94f
X-MS-TrafficTypeDiagnostic: CO1NAM11HT030:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwW48xF3I+Sngj9nLygkrlWkSfGJtkZbxSxNVgvd6Sz7Oaw8yoiTl9sSn6LOESX7LWRDtO/l9QWXsa93voeMQUPwnEJdWK0v1kXfaVtNHKM4KVk2tJP41j11wpNpw1Z2kjoVagop2JtlGruKmBwgXfu1KPW04iUqnSWt2S+uwt8crMFksqTnnCpoY9q26JdeDk79Om1fBBC6XAGny14VtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: zgu4v/O/pYS8/CMLF4u3Vc7zkdhmmYM4lmaApDbX1s4/M65UurapyWQK7hgOM1EgvNIUmqR4yQxkVOaCw+FlL4CF6aDzZ5O2trlaJS9cO6DMc9xK3SCp0qkRI28PERKTcGKu4t8XBGF553DQd0noBA9ndmBe7nxkVC+TMYBqE5UTzQG6Z5akXi9e5IJ5wTWOhmJ0ORcxPFzffA27NhRjew==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879d1e1c-43a6-4f5e-8db7-08d7ea10b94f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:25.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify writing of sleep gpio configs, add a common helper
similar to what is present for other Samsung CPUs.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index 7f0c9d447871..609f323d0805 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -18,6 +18,13 @@
 
 #include <dt-bindings/pinctrl/samsung.h>
 
+#define PIN_SLP(_pin, _mode, _pull)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <S3C64XX_PIN_PULL_ ##_pull>;	\
+	}
+
 &pinctrl0 {
 	gpa0: gpa0 {
 		gpio-controller;
-- 
2.20.1

