Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2506C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B042420700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDZShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:37:03 -0400
Received: from mail-co1nam11olkn2047.outbound.protection.outlook.com ([40.92.18.47]:24736
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbgDZSgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgdAKw9UK9Fet4vgcPx079mVOLeiE1gH2Ne7A9hJBaMLXtmlPs/psRjm7S1nQavm1fWLLM2ovFbxQf5dEIi0+4fsbHn/T4Ucxv461Dd+GoRpqw4HbnkcVvOiKhB0IV9Gsv0tI9Mhqjq//yfQd8X6OOsqI/tfF7u3KkVN2GC0X0xqnBpei3sjfv6C/9iUxnWD679zxEzGfHjrTKjfxYEce4PA/Im3RIkEqaFaPRQNKk0/RgL2wFyYnKCL/8S6Pl8NlN4VwRWmPRW6qcxKjyi5InwNufIgE1kP8CxfCxva535mlm14ECEAfcCFLMQbtTZphegXa3TrTiJQq9b7UTEx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GoKGzDksUV+1pa4zLs/FMuMSMNxUNRuVNG96wFu6fs=;
 b=k6cUN7vprcSNLHCQmctm27HRwwk0skd9DQjO1syyoZ05vgN+ttnC+4nm3x90a/nYe/nRN+Vn4PHWFXGz1sZ/25KyR1Xr0yqTDsVKjZ0wFNtXSr3Uja92wIN1G5lrieFMURiCPguU8GPPzdfm6rry2z+s04zIEsF4xHTMgZDPQ6TCT6C07geqnf41DReQPUfJAfgAeLXfJcYLaIaZa+t8E1fcscby8wd2m1HjDtyUQoJYUoKCUKywVT4VPXIBJZxUsiVY0flTG1im8j6ZWAKVPrRiUln/JPQPkLg+/8gD5L6qqHon+vtypiijtoYMJbbKlzK3nzctTHqDs6XtVHDHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::41) by
 CO1NAM11HT017.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::418)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:47 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:47 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:6F411540C49EC7C8EF69A1D3083A3F16EC9E7F5EAE7B576A8A33AB78CAA3BB70;UpperCasedChecksum:12B53BB0BA3ED815D8CAC83D7148B4CF19C1C929596979B7C75944CFC863DA93;SizeAsReceived:7802;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:47 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 12/13] arm: dts: s5pv210: Correct FIMC definitions
Date:   Sun, 26 Apr 2020 11:36:03 -0700
Message-ID: <BN6PR04MB0660823C87DE000BCDF36C3AA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-13-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:45 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-13-xc-racer2@live.ca>
X-TMN:  [T1QFinePHD3IlFiX76UppSP0EfdViUWBuaTwjBdUAaJVt+FyA6TsWKLxp/lYTxu4]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: dda40351-596f-4e81-b90f-08d7ea10c683
X-MS-TrafficTypeDiagnostic: CO1NAM11HT017:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwTPbk3vJnxM4R1w0zCBIC50uxU74ryWOsDsfYbFvw0po5EjUAt3py40bRejDXKc+nUoy90TaXY0RwhuTXVZ3Dk05DrwGRSX4OQdCKkll25rf8/TXdufgTAzzoaOmF+oOsnBqU/1xA/gWnF5ludzXgsbKECFr+7kKHCRIwg9OXl8J66cnEDOWiP6PKkxv74tuhuu2Ma8/PrigHsasZDAng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: dyXSMkztdwt/tBAH3iSlxYnlRUbnOGtQ0Anp6IiQuRNgMOcI7Mumez60n43N346TNZwBoHmxrzsav55QJUf75Q0cDRAHjqzw8sSqb7rl/Glk2P/8RiBWxM05OJ7PZdJPBqCEDewAagAKm6gQUDrZ+333t/kRuK8UXbRfUASO7I294PcK1+iidYelTHC189w+BcriV+gU8dhNR3KgAU/shg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda40351-596f-4e81-b90f-08d7ea10c683
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:47.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extended mainscaler is only available on FIMC1 and there
are minimum pixel alignments that differ from the default.
Additionally, the cam-if interface is available on all three
while FIMC2 has no rotators.  The lcd-wb interface is supported
on FIMC1.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index b3b6ad2889f9..3cbf6c05f42a 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -626,7 +626,7 @@
 				clock-names = "fimc",
 						"sclk_fimc";
 				samsung,pix-limits = <4224 8192 1920 4224>;
-				samsung,mainscaler-ext;
+				samsung,min-pix-alignment = <16 8>;
 				samsung,cam-if;
 			};
 
@@ -639,9 +639,11 @@
 						<&clocks SCLK_FIMC1>;
 				clock-names = "fimc",
 						"sclk_fimc";
-				samsung,pix-limits = <4224 8192 1920 4224>;
 				samsung,mainscaler-ext;
+				samsung,min-pix-alignment = <1 1>;
+				samsung,pix-limits = <4224 8192 1920 4224>;
 				samsung,cam-if;
+				samsung,lcd-wb;
 			};
 
 			fimc2: fimc@fb400000 {
@@ -653,9 +655,10 @@
 						<&clocks SCLK_FIMC2>;
 				clock-names = "fimc",
 						"sclk_fimc";
-				samsung,pix-limits = <4224 8192 1920 4224>;
-				samsung,mainscaler-ext;
-				samsung,lcd-wb;
+				samsung,pix-limits = <1920 8192 1280 1920>;
+				samsung,min-pix-alignment = <16 8>;
+				samsung,rotators = <0>;
+				samsung,cam-if;
 			};
 		};
 
-- 
2.20.1

