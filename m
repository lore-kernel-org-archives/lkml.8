Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F330C47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8715E21775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEAXvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:51:37 -0400
Received: from mail-dm6nam12olkn2090.outbound.protection.outlook.com ([40.92.22.90]:50881
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728025AbgEAXve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTGa7nCeIG4/JlaGq1Tl6ctoem0OryOj/gWYSZfV4Ooslz8E1/8gPYForOW+tAHLZnjsRp00NxaRYlPqUPCJ+inXZGiJUoQMXQ2bttAANHVvR23hp6YkoaN4mYT8kDk6okJwQQVzzSEL07KRQ8tG0+n/C0XDc+WJDH9gnMtHCsbrvxDAb66eOK7XEdXc/xC9jGlD0C4SUwnSyULw+VIE5L96g71tQKUxXl7axHOOFL59DCp+v9Bk+SWRvUFr7b1OjvV2EKCL/Cip6l9fRObvTXpJNndZYbazPSB+2qFEp9s3ZBEXT6wJkIEXxAPFmxLuuEe7SS73lkwFkS59oTzn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgdsQHvzkLGsRuhYROf4sTojFixwdNIsWagrfzfwR7E=;
 b=D3UAwg9Cmx65wCx17KbDz5Ck1pXDdK+GHiCK2gdFRePaq0e7N7TgKtB8KJ/cNiUPanWIZOvQD6f8YoPOafKgaiw5VMZI9uVaYwC5pvqv7irJuX+93XjO4g16BFiTUUFAQjWZjvi0i807mmC3PnYDESt3RdkfRB0Q5aGARtIML3wsVPjr4nop1Q+3A0vX1n1wvneIZC1J6i9iovQ02oX70UUh+1cDWkTNMp7L3+yd9vLgIMzzwF+jZsl053Th2NblOEPGJmfporIde5VNe+fzJD79ye0GWp5QVghxpUQEmW3fZD0QAvCuYtwHg59nbsVjhEKcf0VhsMCsjF/pTvIXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4d) by
 DM6NAM12HT118.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::126)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:51:33 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:51:33 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:C66D8254CD5D15C498F8638EB97EF85EA76AC070D9FBD59916DEC013149543E9;UpperCasedChecksum:0D38F596013E77A39B35A53E0ECFDAA96FFABA7A163E7C4BE89BF2E8C5DDDC99;SizeAsReceived:7842;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:51:33 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 13/18] ARM: dts: s5pv210: Add an ADC node
Date:   Fri,  1 May 2020 16:50:14 -0700
Message-ID: <BN6PR04MB06609B8C5A80A74F25A73710A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501235019.24022-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <20200501235019.24022-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-14-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:51:31 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-14-xc-racer2@live.ca>
X-TMN:  [4gIaQpeN+CxbKgL4N4l7flQZSh2PZJWC/edP+PY3K7njFD82l1NcQNvFXeGGFOAq]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 891b1a9a-4511-4c83-83ab-08d7ee2a9399
X-MS-TrafficTypeDiagnostic: DM6NAM12HT118:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2P+9ZIo0Zd6gFlTOFraIGmRgpZIQM1R2ZorIp1wqx01hJLulXgv4kn30rr0NtlzxXkPKiP32RGc2NebnSfv+IxK5XvCvQe6vHYm0tIHdIXTmqd8FXWbf8U30bmxyflDms4az8cFNXxUbQ55PcjUUi6MwLYrNlXgvMrDU3dZr1A5SRqDgnTh1jrRmBNE909Z1vB9FDw1TNElxERm0DxWZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 9jZvuYHhfaax6iM5gdPpiz1E09rg85wAHqs+9zNR+cYYcC2XVXJhbqxTWhPIYBoTJw0DCxOjDFWl6vN7JZL31T6ghq7JA5OAnSVBP1UyDZwYohCBZbVzstdwlwjuHiAl1JHf4FkT0dDcxZIcelwv6yXto5e+LeSuOIFez6PgSIeu6UED0k49kPJbxitsPPk5MM1C8dRl+ralKU1RUcTlXw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891b1a9a-4511-4c83-83ab-08d7ee2a9399
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:51:33.3721
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

The exynos-adc driver now supports the S5PV210, so add the DT
node so that devices can use it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

---
Changes from v1
- Adjust node name to match reg address
---
 arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 2ad642f51fd9..30a0c39a310f 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -159,6 +159,18 @@
 			};
 		};
 
+		adc: adc@e1700000 {
+			compatible = "samsung,s5pv210-adc";
+			reg = <0xe1700000 0x1000>;
+			interrupt-parent = <&vic2>;
+			interrupts = <23>, <24>;
+			clocks = <&clocks CLK_TSADC>;
+			clock-names = "adc";
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
+
 		spi0: spi@e1300000 {
 			compatible = "samsung,s5pv210-spi";
 			reg = <0xe1300000 0x1000>;
-- 
2.20.1

