Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66456C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D0520767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PUs3FG9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370354AbgDOMt7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:49:59 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:6154
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S370331AbgDOMtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/gz7f+ztMBvqDACi+7S/4cYNpqSHInu2w0+5DM5GRc+Zoj1eY4/is4iKA+RMv1NUYXIfxfvXcTRAE1cBuoJjnf9uq0Mqo06TLh076E4KSyN0fLqFQHrTDiCEeLOtVmtve/0AIEc4/bgQLOTljN6gjyUNTUVGUK3X1D+QtO+k2d/g6noinTwJw+zDmzWy9INZLL2I2LaNZRVWVzn0CDxEz96vcTcBxZnhGfBM+5kmyFM8aPPpNqZPD2Vs51fiHSzH+T2H7ph2gPBhFEnsFtYyuT41HgcR8tfauBujynWdf7griUKo4bktO3gdrQjLFrUf7eRW82ATOFYRHCktpMADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIEvLfEbCBne0yrheUJUTQlFVtJK1ofjZg0FllMfg9A=;
 b=PUGD+PZTQYBYiQ7EJX6FvMKQfZycuepNA6XbrHcNSbJqGKa81zSrtTsc2zowh4fEalxsml5D7ka0yCgeT3l0nSsKt8TEGoiRr4U7l6y2NyTAUnGHLxHRRhxcNkOUA+5XD7bTDjz8fikZiin9SLfFxZ7GpS6K+mgdfgxr/AzbOne59JWAVBk76CAvzIZTXb2Os6J8qRo+qTd4eHourMM8DevfMH1k0TRl11cXcureRYMTqAZ9QZUUgoRzP1LzvL/nkj92lHGYeia9XMM6mjEdN13yMFrYdZ4pYn41FrZ492Gchv/JdWus1/jKe/qkFF3P+1y3VNfynIoxqnW74j7LPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIEvLfEbCBne0yrheUJUTQlFVtJK1ofjZg0FllMfg9A=;
 b=PUs3FG9uRYqIr+DDBO2KAebw77M8bGyqr036MxhHF7Y7nR7asjIulCCgVmYeDLCdeHOgYPjJnDHbbj8EFv6OQMl98ON37XR7yVHt6CrndPjhtS9B3ek/I7P8+IbTV6hm4iJWk33W8dW8awzMBtDRxFiEol77+sdA+HMNEvtb3ew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2856.eurprd04.prod.outlook.com (2603:10a6:4:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 12:49:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 12:49:05 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, sboyd@kernel.org,
        robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/4] ARM: imx7ulp: support HSRUN mode
Date:   Wed, 15 Apr 2020 20:40:45 +0800
Message-Id: <1586954449-17463-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR02CA0098.apcprd02.prod.outlook.com (2603:1096:4:92::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 12:49:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04963e18-88ab-4d00-26e1-08d7e13b6162
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2856:|DB6PR0402MB2856:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2856A023DF2AC95AE1F0E84E88DB0@DB6PR0402MB2856.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(6486002)(66946007)(26005)(186003)(52116002)(16526019)(6506007)(956004)(5660300002)(2616005)(6512007)(4326008)(6666004)(2906002)(316002)(8936002)(966005)(69590400007)(66556008)(9686003)(36756003)(81156014)(8676002)(478600001)(86362001)(66476007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEbg8EuudIuM4/rnOgjGDDhyqX9CYGRVY1pz0p0M5xlGeyH0I1mHLapKvd6FElTbbaLZR7xnNW2DmMCSd91EnasB84e0nx3Ew+nndkO9gp9XWP2pIfqYJVywPC5FG58Av9wJ+zruw2IChT3lbFdutT8ScoqryyDKLqQWJv8v3fog3wRQoB0jFhiD6FKmNq8UopQKL/D4QVHdhdtSw+C0N7L42M8x/4Z/leg0BHyMnDQI7KODUDSOrMgMNhTuiKqP0LJyT+c9GpKF6UKR3rLADpSEb94hiFzFvbGoG+rAjhNcDbOqbBDK3vFw+9iMqZNhTZcDvXIXSFShq3xPVXatwOQPyyVIsG2De/BKFKZ3vZ3vJSSMEOJK6nO4zx3+6CN4x42AFt6U0TYtvPI0MR+pC8WO60qT6e/mK9P8UWjbyTEVU2RuT5F871zxrFvnRsrFpVHva7hfMgC7rqxew+Ult6ed9I9sSdDEsK15qK54kiVcgedaOx4fvN1Ca9P8NiIH1GI4mzH6fsQEAQIN2gSPhbFPCmGpusAZq2iRjq91K6ZGkkyEPz9EK5e/cDkY4G/l1+M7AAGmcYi5qakGajIjPA==
X-MS-Exchange-AntiSpam-MessageData: GpCtVy5EZMcR7cXx5YNzlGk21DiTbh22AE4lxOeQpkg/HFgoxGMxI87ZdoZEZqpVaOvbORCh43OOxk8v9p6BH0kTYgsm0ybm1ohgedm2JUuUJu4JgrrOAHMAG/UkH4xlvoFEuS2aznAN6AdnLsxKSg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04963e18-88ab-4d00-26e1-08d7e13b6162
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 12:49:05.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07q4yyGNAs2ekuccTaR69yGGekr9iCi3WMFGnk/hyj99aapjjF/7MZnn/oZRofamZ39M1Vemz/c4LfsGEPqjFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
  Fix dt_bindings check
  The same patchset was wrongly posted as V2, 
  https://patchwork.kernel.org/cover/11485107/

This is a splited part from V2:
ARM: imx7ulp: add cpufreq using cpufreq-dt
https://patchwork.kernel.org/cover/11390589/
Nothing changed

The original V2 patchset is to support i.MX7ULP cpufreq,
still waiting the virtual clk being accepted. so to decouple,
this patchset only takes the run mode part.

Peng Fan (4):
  dt-bindings: fsl: add i.MX7ULP PMC binding doc
  ARM: dts: imx7ulp: add pmc node
  ARM: imx: imx7ulp: support HSRUN mode
  ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN

 .../bindings/arm/freescale/imx7ulp_pmc.yaml        | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi                     | 10 +++++++
 arch/arm/mach-imx/common.h                         |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c                | 14 ++++++++--
 arch/arm/mach-imx/pm-imx7ulp.c                     | 25 +++++++++++++++++
 5 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp_pmc.yaml

-- 
2.16.4

