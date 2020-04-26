Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C132C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D23520700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDZSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:36:26 -0400
Received: from mail-co1nam11olkn2090.outbound.protection.outlook.com ([40.92.18.90]:50529
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbgDZSgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXfpgTx6eoYSig8AdwWtrRglv+VW88LnPco7F42ZixUK5KhzWhckObBHmOP2l/5zGNyjWQAqzYITg4PZD0lQ2u+Y58zm5/LtVAM9OB2Xj6asyZxt96GZOLYzmXukC3mAqS29mbV7v7nTP7Gp4s3qvn/fLmN2MKPXJEmS0U1vvTve0FSG3h9lk6L0hHK6OAjNh2HP9wzD5Cs5SxJbV4lC8gx2LOSv2Ov9BO0AwRKOVr3mq3vSJmu9KIE/lNgitHfty6NvSOAuo10Nj9JZWSkhotnEuxv3ZbwD98JQgpeyaD+ikjsXjmB+Yyteut90927nlbfSocyJ2AoqZu3HfelPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcywinMjnpK4WOAZSBfupWLquL2Wu01bkRh8en6RQlY=;
 b=mVHr3SpDnBGadjvyILQysWRM6q1ScCL733GTxiK5koeoqV1TlVppX3ZXCCubaD7orndjT4UPIYE46iczixqfZTPLuRsUDfLTOMJtpJs0eEN4C6VJHkpPCdztifzoIrYVnKC0RQTS/qlSaW7NgJAcvVW3ThSQ4fH0kB35SN4aio8KLu257Q3dfUFfnGv5SxDMdAwmEgZFTBpBaOEONXgoiYWlGSPj9f2ocUmTJiAgIDnbf+UHmtX0vW9drluVuUbdT/ijJBcRKekaMovg0CuUYReUGn+SiUgYfcVMgLZ6gGfZyXbcI424gvdmvo/jpThgKphdJgIIMUPUledZH3R6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:3861::52) by
 CO1NAM11HT181.eop-nam11.prod.protection.outlook.com (2a01:111:e400:3861::187)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Sun, 26 Apr
 2020 18:36:22 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:3861::41) by CO1NAM11FT036.mail.protection.outlook.com
 (2a01:111:e400:3861::124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Sun, 26 Apr 2020 18:36:22 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BC40BD68623AE0CAE03B66BE37DE60BD39DDAB0164AE5E88A9B9D58EBA0C884F;UpperCasedChecksum:AC097712BB4445F4C74B189E03600CEB382BAAAECEC94F527DA420040C148F25;SizeAsReceived:8857;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 18:36:22 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 00/13] S5PV210 and Aries DTS improvements
Date:   Sun, 26 Apr 2020 11:35:51 -0700
Message-ID: <BN6PR04MB06601A5656CF70A4DCA7998BA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:104:1::22) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200426183604.28494-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb67:7300:9f89:4b96:de0b:cd14) by CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Sun, 26 Apr 2020 18:36:21 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200426183604.28494-1-xc-racer2@live.ca>
X-TMN:  [to+dQak2XqC2/BclHWaTlL3bVr/gudmUyPMTla7ew7w760pgdr6TSrLXDCmm4UpO]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0d886b55-8270-455d-55b7-08d7ea10b7da
X-MS-TrafficTypeDiagnostic: CO1NAM11HT181:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkmFbZUAr1PPdd4EVEilzJQPyUkaVCpE5u+/6eduu/TCyvHSKK4dpl45XkPM+QLHfNtKmiXyJTUvl9LdiJDswKGPiiWJQaajOWYpi4ibHDQe1t8R0LI4ZwgW0LwLoS9IQO/MOTB66Fkr5BphwbVB7wNV544ev14lNbwSnM4GCpuh1B0HF5JPO6SL7nMXXBQO+CkcALVO8G7sMS5VvbvjHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: DZmapemEEuu6DxSF5zpn6ec6IzjqIgYWFlZpjFL+ZQB4vqBI6e5L28hj3WCVyPe1WIm/aw4nOU4g9IRdKNXfryjp0loYE3pFCK6pbTVpSNs42XTVkGW9F2TJ6yIt5oqFjsCOwRt274wWpUIjICGGZYrhw5cl+tsANYR0Iz2NJyycg3Q6y097a5yW5Lbkf8lo8HfAkDzu8r+gg/FM2XSPXA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d886b55-8270-455d-55b7-08d7ea10b7da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 18:36:22.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1NAM11HT181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset makes several improvements to Aries devices which are
based on S5PV210.  Several pulls on GPIOs were incorrect/not specified,
sleep GPIO configurations have been added, and more devices have been
added.

Touching the common S5PV210 DTSI are the addition of the ADC node
as well as fixes to the FIMC definitions and a sleep GPIO helper
added.

The patches have been tested on both a GT-i9000 as well as an
SGH-T959P and both can now suspend/resume properly.

Jonathan Bakker (12):
  arm: dts: s5pv210: Add helper define for sleep gpio config
  arm: dts: s5pv210: fascinate4g: Add sleep GPIO configuration
  arm: dts: s5pv210: galaxys: Add sleep GPIO configuration
  arm: dts: s5pv210: aries: Set keep-power-in-suspend for SDHCI1
  arm: dts: s5pv210: aries: Disable pulls on GPIO i2c adapters
  arm: dts: s5pv210: aries: Add support for more devices
  arm: dts: s5pv210: aries: Disable pull for vibrator ena GPIO
  arm: dts: s5pv210: Add an ADC node
  arm: dts: s5pv210: aries: Enable ADC node
  arm: dts: s5pv210: Assign clocks to MMC devices
  arm: dts: s5pv210: Correct FIMC definitions
  arm: dts: s5pv210: aries: Set MAX8998 GPIO pulls

Paweł Chmiel (1):
  arm: dts: s5pv210: galaxys: Add si470x fmradio

 arch/arm/boot/dts/s5pv210-aries.dtsi      | 349 ++++++++++++++++++++--
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 248 +++++++++++++++
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 291 ++++++++++++++++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    |   7 +
 arch/arm/boot/dts/s5pv210.dtsi            |  25 +-
 5 files changed, 891 insertions(+), 29 deletions(-)

-- 
2.20.1

