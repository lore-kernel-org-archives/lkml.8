Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63664C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E81821775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEAXuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:50:40 -0400
Received: from mail-dm6nam12olkn2067.outbound.protection.outlook.com ([40.92.22.67]:6328
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgEAXuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq45JtdJcy3d2gpRQddej5lNkWZeTKKmZCC+WAWastL4zXJklL6pMxYcHNuvrUPwhzemVx62Md/70iuv6bHxwnLsLQL0VaKZE4tRybBZGZf+pMhhoa5xmvrMLulsiOkc4FRDHSajFLeaKdg4YBQZWZYvzkbLUOY1lBkXoPSGpZZJYRWnfnpSYNCiGiMcwgXEslnxqNM9s7QX/1vduV8kPBHt/5u5Y2fXIJ0J4/H1ABvFlLyleRxfkfr5miOw0z0JfdHqaq8pOie5Nh70n+VWfIplqlO/ThYGiLds04yeGAkrnBDnq92lWLhPJXULZdnBwirJbshjRCHMU2/Q/trmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hHbPFWpsRbkefIZ4i541TbXLn8ODtJiK4zPWuqef1M=;
 b=O5gM+2X+i/xAviooq5tA2paqhwYK1BYES9/+vO65ocy7p/Fi3+Gw2I7qNrJSc0qDSgXkNbFP+oKCZaMzZiLkcQrUF/kqKCoN1oTNL7HrEX2FTqbwPt4oAsb79EKOcmAURBrmZ92NTmlw782o2OBOBA8Zm5tpYPjsL/03uFCfNxowxQ+SFDfKutr8lnpZWdXWTB8+vHCx0aZFmW8jWSWcE+uDDxy1HeRScqzPWrcQVaQObYDu7g1KD+F7vaDu9pUJmqKJwYrrP66AIUfvHrwxCLLoo1bQzQU8HR3ttYnaMssop6vCU0yy8bplBKZVi6D+2Gkk7jzdDAJcuO8fZcvdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4e) by
 DM6NAM12HT149.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::248)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 1 May
 2020 23:50:37 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc64::46) by DM6NAM12FT056.mail.protection.outlook.com
 (2a01:111:e400:fc64::460) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12 via Frontend
 Transport; Fri, 1 May 2020 23:50:37 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:1CF40882429895DE9D9A82BE1D1E601ACA0A71C02B8499FFD184B35D0538E6EF;UpperCasedChecksum:642801319F308311AD72BBFAA4CFDEC5981AFA26870A11F430A1015F1E4D94E5;SizeAsReceived:8958;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 23:50:37 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 00/18] S5PV210 and Aries DTS improvements
Date:   Fri,  1 May 2020 16:50:01 -0700
Message-ID: <BN6PR04MB066033FD7FF6E5C37747C7A2A3AB0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426183604.28494-1-xc-racer2@live.ca>
References: <20200426183604.28494-1-xc-racer2@live.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR17CA0058.namprd17.prod.outlook.com
 (2603:10b6:300:93::20) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200501235019.24022-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 23:50:35 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200501235019.24022-1-xc-racer2@live.ca>
X-TMN:  [DsVpGJGGst3MAdhFNnvR6RdkyndeK+opRMshOrhpvk6+samxXghKu4WEc9/SDWe8]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: bc9f038c-885e-4c5f-321c-08d7ee2a71d1
X-MS-TrafficTypeDiagnostic: DM6NAM12HT149:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JScvR5gTwNbRrRNMX4l4rkYmAqnRrpEWAeYrVRsRPUk4/FLwTcRsUNadeGodnjA2K5RNcC/NRlhLUoO2QFqvaTWXe8NuN4WqUUq9m4lGaUW7XzzN5Oehs8SoqahA1cKOVPCjmhzaQszw4Hh+134LxxFZMtPtWTzN3ULfIqAyGA9vCeGK+RBdNtfPp9JWKT2Ar06jw5BPdsxvSHzRr7fk2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 6XmTitN8zFx0jFp0lWb9DwwJKPIYarexUKavu1BY1UkyOwDfhgZU4sdmzO0n4Z1EzjLdGLcxGwjIyyQmVvQQpqk1G9/xK8umXTwoZT/e/QmSzrf33oFDztBLZnEHeO9RQZYplufYXkRdvLK0AxAR5APwhuHca0x/ia0ln54sU55qOiQsMx83yuHLWOEqD4/byiPn+Bpn253YvqP2QYPRMg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9f038c-885e-4c5f-321c-08d7ee2a71d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 23:50:37.4192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT149
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
added.  The GPI gpio node name has been corrected.

The patches have been tested on both a GT-i9000 as well as an
SGH-T959P and both can now suspend/resume properly.

Changes from v1:
- Correct ADC node name to match reg
- Restore removed regulator suspend state
- Split commit adding support for new devices into separate commits
  for each device
- Add note where sleep gpio cfgs come from
- Ensure subject of all patches matches subsystem
- Add patch correcting GPI node name


Jonathan Bakker (17):
  ARM: dts: s5pv210: Add helper define for sleep gpio config
  ARM: dts: s5pv210: Add sleep GPIO configuration for fascinate4g
  ARM: dts: s5pv210: Add sleep GPIO configuration for galaxys
  ARM: dts: s5pv210: Set keep-power-in-suspend for SDHCI1 on aries
  ARM: dts: s5pv210: Disable pulls on GPIO i2c adapters for aries
  ARM: dts: s5pv210: Add WM8994 support to aries boards
  ARM: dts: s5pv210: Add FSA9480 support to Aries boards
  ARM: dts: s5pv210: Add touchkey support to aries boards
  ARM: dts: s5pv210: Add panel support to aries boards
  ARM: dts: s5pv210: Add remaining i2c-gpio adapters to aries
  ARM: dts: s5pv210: Disable pull for vibrator ena GPIO on aries
  ARM: dts: s5pv210: Add an ADC node
  ARM: dts: s5pv210: Enable ADC on aries boards
  ARM: dts: s5pv210: Assign clocks to MMC devices on aries
  ARM: dts: s5pv210: Correct FIMC definitions
  ARM: dts: s5pv210: Set MAX8998 GPIO pulls on aries
  ARM: dts: s5pv210: Correct gpi gpio node name

Paweł Chmiel (1):
  ARM: dts: s5pv210: Add si470x fmradio to galaxys

 arch/arm/boot/dts/s5pv210-aries.dtsi      | 359 ++++++++++++++++++++--
 arch/arm/boot/dts/s5pv210-fascinate4g.dts | 249 +++++++++++++++
 arch/arm/boot/dts/s5pv210-galaxys.dts     | 292 ++++++++++++++++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    |   9 +-
 arch/arm/boot/dts/s5pv210.dtsi            |  23 +-
 5 files changed, 907 insertions(+), 25 deletions(-)

-- 
2.20.1

