Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03283C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40F1207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgFMSpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:45:10 -0400
Received: from mail-oln040092004050.outbound.protection.outlook.com ([40.92.4.50]:56033
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbgFMSpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf5M2UphQE0ZQ9FYFQXrrBOBvxG+U+ZKCokTRa1pKt8dBZkW46k9Uu7qNUYZdGYurrQwQkSAttz9PQ+iyK466Jgxm76xqrlEUfuS2KOMykoD0Nfh2sfVFIHOOkugMkKw/OMqsLKfRNOflKXKsVmTrKEYrUba5zh6BWinSxbFWP1f3ixe9IOhwb0Ghlbd1/6Ca6eRzekjX44chMoIFmtXi3mrKc6OQmAlCqlVhKwFgmBstuke/oXOyEA7PtGHRfneSUF6yAu5rUOwWF7OqCCgOjx2B/Tus+QXofeunLybEm9gqLNScXWU57niIil2yCyuvLMJyUQPQxVhzadrMeTSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYTahL2jMwRCksVY8UcLQ3wvb9NY/xCM8WvhbK1A2AU=;
 b=AW9cTqkhrBWeROWzGa6/wSie4uRp1W3KFKkjI+2fGmJWk8Ud9h6ufkXJuXHmZU8xuCJxfB+YuTZ4Ck9HkviJvneJL9Tvy+uN2GlRMTCKHtCZjS/gjLBGXMCOOoIa/sFamFlW28cAP8ypans2DdoD3ti7FAzvGIUFtpx/n48AyXb6y35/aUiafxYZqM+NNX3nE/H37pYvUB9nnGclGh+oRXLKXv/yJjN0ry5yorviXhkBuapS1laqiV2t5BvDvHDlFGBT2122aOCOzeOdWcFOW0SVoRIE2XSMJUnCAJXQChQhwW/63+A1u07MmS1Muwio/RNbdQO8aOeWiqeeqFnStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (10.152.76.54) by BL2NAM02HT059.eop-nam02.prod.protection.outlook.com
 (10.152.76.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sat, 13 Jun
 2020 18:45:06 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e46::4a) by BL2NAM02FT048.mail.protection.outlook.com
 (2a01:111:e400:7e46::109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sat, 13 Jun 2020 18:45:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9BA1354240F8A7182780AAED1235D5697C636BB2075F896CE049DC9275FD93D1;UpperCasedChecksum:80DEF31A8F7157FA928DEB766E86D5E42919D83FB768F3DFF3612B76BDCF1B88;SizeAsReceived:7657;Count:47
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383%9]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 18:45:06 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 0/5] ARM: dts: s5pv210: Improvements for Aries boards
Date:   Sat, 13 Jun 2020 11:44:22 -0700
Message-ID: <BN6PR04MB0660787FD651F80CD0C22C2BA39E0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:300:116::32) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200613184427.23394-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Sat, 13 Jun 2020 18:45:04 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200613184427.23394-1-xc-racer2@live.ca>
X-TMN:  [dTSGaNHextpa+M8IcfaXs8MkgS7i4q1wmVa3srMNVRsCeG6lT12QraK26x7BronK]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 85a1dd37-e8fb-4155-8ff2-08d80fc9e3ac
X-MS-TrafficTypeDiagnostic: BL2NAM02HT059:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Jfu9KN6RCYhA0TMRIgUsNorxHYIhHBiUrxBq/Xsr0zVSFUAmBO6CFSnt81lIYxUtQZq1H0sIBH3YgNhREZwdLY6SWojCp1aMLQbmnp3pCaVNKKbD7dLvXYRi1sHC6/jZrCRY9TH5C4o9ljY2tN87bm8KqEax1v05RvMaoC+hH4+4v1RhuX0gUEZuF0j8c6MyYYoxb3zi7EtVwgZvJTd8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: j4qwSlhBO8SIwAeJctjXvxvWppQbIj5Jn4NcJ3UtxSCLqUb1mLf0c0P7W08oBiZVn9stG9245pwy4KC3CeMm90hx2QXFkzTogufF5D304wAsgUSXLyxxbssZEiih8W243ghXNdDB8jQYjk5VSkspjiD3HU1IBaDFKurLeq6zViUZJHogSRIqFhuPfL2oHoMtL3yRhK6nycynDMyokAexdQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1dd37-e8fb-4155-8ff2-08d80fc9e3ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2020 18:45:06.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of new drivers have now been added, so we can add support for
them in the device tree for Aries.  These are the accelerometer (bma023)
and the light/proximity sensor (gp2a).

Additionally, the fuelgauge definition was wrong as there is no interrupt
support on the galaxys.  The bluetooth definition also had some issues
with it.

There is one change to the common s5pv210 dtsi and that is that the gph3
bank was missing the interrupt-controller property.

Jonathan Bakker (5):
  ARM: dts: s5pv210: Add interrupt-controller property to gph3
  ARM: dts: s5pv210: Correct fuelgauge definition on Aries
  ARM: dts: s5pv210: Add support for GP2A light sensor on Aries
  ARM: dts: s5pv210: Add BMA023 accelerometer support to Aries
  ARM: dts: s5pv210: Correct BCM4329 bluetooth node

 arch/arm/boot/dts/s5pv210-aries.dtsi      | 90 ++++++++++++++++++++---
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 17 +++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    |  2 +
 3 files changed, 98 insertions(+), 11 deletions(-)

-- 
2.20.1

