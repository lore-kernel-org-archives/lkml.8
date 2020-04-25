Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4FEC55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634FF20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDYRhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:37:39 -0400
Received: from mail-dm6nam12olkn2058.outbound.protection.outlook.com ([40.92.22.58]:14055
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgDYRhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2TizQo5kVRiRSc8hxYDlDoDha30SaeXNBuVvjsYIHvzdVK9ULMYxXj5DfzPczZi/qtZ5t+5DbEQS9DDOOIySH5I+XAayBR9MSnk36LZeR/yCS8SoZg4oMx7MMK9lvI5dECGgTaNPOuD3BPPAfy6qi1JljMz0GZTY5xiv3Y57gV8q0eI/aPHYMW3AEDtfNGsuj2i04BUsaV5o5dgNyzWzhPzpiea2APxnBQQm9fkJSQkDsBVFWb7+4BZ6dlEUgwKKc+W2nfb/1zIJJdk5DTmbptnQzH0tGLq/0kkNiLH/wk5m8PWTYIMxsW3fOZ2s6JgY+EZdRAGjyDaHu7haXgyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzoduUAfLzwJHXUtbOjXQoIexcvrY3NhwVpMFw+kJ50=;
 b=iOxBNbbQTxk0pZ2R8ni4GAtwLIiAzZ7JqqhJLgKJVdkGBqNmzFHejRgTRU5D//PWr7FOAeDo5wdKapGMxyPXhdPCCcr3z4jGDUyGFTPXjH0iI6tL6gy7LHMb3hKgM5nHiPGLqTJ/5BAc/hCMcLBPJTKA2/ZqdZUCvFDhYcJZFTuWIekmXkXz+KmCEwTT29NhbQM9+7uMzogNpALDxVW6pVWiGWAG18v2lrClxobMdyEugSE3l1eYdREjvEfvxio0MwdhXOyfQmww1hE0hWBLmfiK09iMbG4W02z3vYBBpHXnpGdCfa+Drn0k0Kq08WkrEoQPo/DRUkcZ6b/SZQbrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT029.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::41) by
 MW2NAM12HT029.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::107)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Sat, 25 Apr
 2020 17:37:36 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::52) by MW2NAM12FT029.mail.protection.outlook.com
 (2a01:111:e400:fc65::318) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Sat, 25 Apr 2020 17:37:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:94A59D1FDCDF676FB8A1B301A79826542D80A39ADE83E0711FE596880FB821B8;UpperCasedChecksum:489414C5B6C32313D3B60B85E8E8761BC7E4DA77ECFF0B48AFB1A5DEE4B21972;SizeAsReceived:7684;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 17:37:35 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     linux-kernel@vger.kernel.org, kishon@ti.com,
        s.nawrocki@samsung.com, kamil@wypas.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH] phy: samsung: s5pv210-usb2: Add delay after reset
Date:   Sat, 25 Apr 2020 10:36:33 -0700
Message-ID: <BN6PR04MB06605D52502816E500683553A3D10@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200425173633.5337-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by MWHPR21CA0060.namprd21.prod.outlook.com (2603:10b6:300:db::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.2 via Frontend Transport; Sat, 25 Apr 2020 17:37:34 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200425173633.5337-1-xc-racer2@live.ca>
X-TMN:  [B54rNRZTBhzgXuuzZBQR0i9/FNfef+ansMfbzHi47tThhRtLFA7QgW7nYKX2r6mZ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 56dac2f1-5111-4d9b-e112-08d7e93f5740
X-MS-TrafficTypeDiagnostic: MW2NAM12HT029:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWnwXW5Y/z1LCPxFZwynzryIr6xVqir1wps+O4EmLqFPmrhpfaEJBld1f3CxX/DtDgsY5wCvIo/uKGZo4i5NY+gTcxMXquK2WQx3rQcnA/jPN1C45+ANhzver5Lfg3qLNlkE0VvMg0Pn0JKxYjX0a+6S61CUCkd0FSmzeXRbXTcg6NWuyOpmXuvumV9/No94PRYpzKrhCS92LY/uLw35OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: YEVxpuB7zyyLoYvetW28lfA3hR3orAzcz2r7wDQexOtu7DFadw0GCHzi3oDfuRFvm7gf0+94z8JRVo+7yNBPRZlawsNiqPagZ5N7Nm4IkqAUujEnN4JTVIOV1KA4L2YhJI6YpzGfgp2L4R6T1Q5HYqLk5nitdXr01K3mVfZBf2yNx6yrhgCTxN7Gtof3ZRiu/5r7ejAfiOYncRJC/k7oaA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dac2f1-5111-4d9b-e112-08d7e93f5740
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 17:37:35.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB phy takes some time to reset, so make sure we give it to it. The
delay length was taken from the 4x12 phy driver.

This manifested in issues with the DWC2 driver since commit fe369e1826b3
("usb: dwc2: Make dwc2_readl/writel functions endianness-agnostic.")
where the endianness check would read the DWC ID as 0 due to the phy still
resetting, resulting in the wrong endian mode being chosen.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/phy/samsung/phy-s5pv210-usb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/samsung/phy-s5pv210-usb2.c b/drivers/phy/samsung/phy-s5pv210-usb2.c
index 56a5083fe6f9..32be62e49804 100644
--- a/drivers/phy/samsung/phy-s5pv210-usb2.c
+++ b/drivers/phy/samsung/phy-s5pv210-usb2.c
@@ -139,6 +139,10 @@ static void s5pv210_phy_pwr(struct samsung_usb2_phy_instance *inst, bool on)
 		udelay(10);
 		rst &= ~rstbits;
 		writel(rst, drv->reg_phy + S5PV210_UPHYRST);
+		/* The following delay is necessary for the reset sequence to be
+		 * completed
+		 */
+		udelay(80);
 	} else {
 		pwr = readl(drv->reg_phy + S5PV210_UPHYPWR);
 		pwr |= phypwr;
-- 
2.20.1

