Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0AA21582
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qZuPvpOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIKDhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:37:37 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:36230
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgIKDhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnEaDkFAUbO8QNzmUiZjkWhrfYhVj6hRxvB/VeMJSx2Y5rw1oglj0F/wPPfhnYHkYiyKL1X5qQtUS9zDX4tFvntVAqmpcJGBgcFOw8/GOSOka1DushgS7SLNI9SdLxL1OW44VmAO4L5feRlKnWoMPgix4+7VS4SzZW4A+OSWXtSp1gaFlhGocBfGyl9H54gDqpAVV0Ldub24gYei24LVrf4lovSHIGbant6uLTOtQJ2tmiX40BQSXdTZEpwHzTwM8dMif5Z/YFR02Gbp/FtFaFxE/F/kWs057fpOcOfOSPEL3Q6UPMCmzN6Z5SOkYFqDQIp7tHXxAWJ+06xnLB3kxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjT/2byU6GPpHuwMWybUcm8JKst3khh/I1SXIrDRZCw=;
 b=WCVp5+ZLueJdhrjmaqHSBcCSw/pQd1b7Hw7KzAsqy1aXRsiKz+eA3PVykySIRQE1VDUcp7Ty/AUzIQsxdwIw1n+l+ug0Ee+BoS/kInw5sKYK5rzcVCvQb6PzkfU/hIp8fxviP/Z/IS3cJ/29DNcsXKfwiHCE3nwHeDb45CZ9/FVlkijvvL+pLcZFclVIO8rBcGP/s9HBxrl5QjyYTSkKughrZYhi5LJP781BIaDNeMJAtXldidElXTOWzUzDjd7ENMg4INbKkymJtPvt4Mty4RAC4tXGCh4ZVuQ+9g9gdeNx8JfA3SDLPZhZa3cgBypHCP0h3gU4Q0o9TeMecEChVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjT/2byU6GPpHuwMWybUcm8JKst3khh/I1SXIrDRZCw=;
 b=qZuPvpOAMF235MzFrJxuDNvEujtAgQGCE3WYuRCQYmCoMIEly4bwZwKg4IBeQ1j82D3yxMLiraHdslPUt1iRI3vhFqnRRn0aiVzE1obVBxbggL9FMwPymjADFI90H1ktd3ytOZ3dm/rJxkoFGE41UwiCTAsrSh4VTLbZky2T3hw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 03:37:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::24d0:f783:3c7d:e232%12]) with mapi id 15.20.3348.019; Fri, 11 Sep
 2020 03:37:29 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/4] imx: support i.MX7ULP HSRUN mode
Date:   Fri, 11 Sep 2020 11:30:49 +0800
Message-Id: <1599795053-5091-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:4:54::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 03:37:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7667c182-8325-447a-27d9-08d8560401e5
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5084582203AF6E9E16C85B5288240@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPEAuiJqElbPu95GEDBgUzlNtWr6ewnOrNupwazRMOCKJZd7GhLuDtvH4ueWveA0ENGNVzxyAkrgubo1XteN5jt3fhIfFZocThJTPmRHp/HevAkMI+d8IKSqlZmgBEgs32EjZhGHlx/s2kXXfnLq97MaYB+u5OPGDCw5YNk6hZfb3JZOMXcDlJ4Ypqr8dspemYBoi/XIpb09kt3Nkxdg7KN49mGWKFZURQveBPhxmD/T3C9T++DNJyarJPxjtaSwLaBPPzuJTuaTLmLm4TWHjQmG44YjfJQilaMMADuWEX8xmfg5d8NmvlpFbjU67FvijpbvBEAQLa102lwdELqi3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(2906002)(8936002)(5660300002)(4744005)(4326008)(66946007)(6486002)(316002)(16576012)(478600001)(66556008)(66476007)(86362001)(36756003)(83380400001)(956004)(2616005)(26005)(16526019)(186003)(8676002)(6666004)(52116002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fL+QGNtqR/PPjWG1HiJDoVS3tCyT/o97zT6F2day/FliaHNu3L2rPg4qyF45ZyBlj2AikXyROBIPwW0lBe7X6t2ZVVXx3uuq1sWZT8eXo5jPClBFzg353HkcQJ0yE/ww5DOOS25otsktKDC5eIqF/lrALzOR3J4hdoNkr9YAQW0KFqhpQbpjpwBHxSlWzbLrnZ5/nunWhs7gGA+thKHeCozSCuc+6/2bpFPCfUzJZ3KUCSqX+559MTg7PdvTyDmPMurGhUh1XgFk1xACSogHG5ILru56BKvw79nMJxVbtVBlAQsrLc1jisQIJ062RXrmPWbQWMEG8Fr2xHx6tZYfl2ROP2/nz33HiLnOh3bi979Lsj9htv1dcc3b1eOsuleXZa6rs77gBR9HyjIGv2URMWQjdSo7+fJ78uGTwiBBUrY+RtfqR12FH+UUtZ09/Go3sJdL3NI1nEwIlu+8AioSPxpGZFCZ+NUVMSweIA0zcPFeIJ1uIpuNkClrpSjSY0KXBtn/LM+jvHZCRzwWMGesp1CnKm8k9v+jSW5P1mCAWFU5tBgteQ5lY4zsCSCXUJsj8Ykzezlz96r7/ob5IaCyBD1VMIYUjI+4toKk+dW6lTRkaAv2cDJEo13t0eEQVk8LD0ejJwnq6DzMUKVLszoPiA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7667c182-8325-447a-27d9-08d8560401e5
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:37:28.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmAptcjVCBf68LQc2wBwuhx//ArTBDw1KMHxHJZs3u0GKH7Sv0o0QKsr1bKFx4TFZVF8QcV5DSnpec5FD3c5iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to add HSRUN mode support.
Patch 1,2 is to add binding doc and dts node
Patch 3 is to support HSRUN mode
Patch 4 is to use wait mode when HSRUN working per hardware state machine requirement.

Peng Fan (4):
  dt-bindings: fsl: add i.MX7ULP PMC binding doc
  ARM: dts: imx7ulp: add pmc node
  ARM: imx: imx7ulp: support HSRUN mode
  ARM: imx: cpuidle-imx7ulp: Stop mode disallowed when HSRUN

 .../bindings/arm/freescale/imx7ulp-pmc.yaml   | 33 +++++++++++++++++++
 arch/arm/boot/dts/imx7ulp.dtsi                | 10 ++++++
 arch/arm/mach-imx/common.h                    |  1 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c           | 14 ++++++--
 arch/arm/mach-imx/pm-imx7ulp.c                | 25 ++++++++++++++
 5 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/imx7ulp-pmc.yaml

-- 
2.28.0

