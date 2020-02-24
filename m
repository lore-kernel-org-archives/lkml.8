Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DBBC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E912080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qg0zf+/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBXMVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:21:09 -0500
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:4353
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbgBXMVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:21:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRSpCH3MopZXovxP8JvDHsmVKEzoOSf4n7hR8TGepZphB/CXrJBkH/+p0F3kNmaY4/eJ5Sm3WfdZbY4fR9Qw/yKnAEp+foJYX0fK4EtXOjE3obJVmqMsnPgIjgpuXn0EkkyY0rXur1Sb0IxhakVvwRJ1cVhSd5PDeqztCff9hujlXjb8rrop6BcGT/c1lwZIZ+D1S9j9MJX4vGlyVYMxS17UgJ9FATIuNxch7o5PbE9PCHbEOSyuBgZB5+ML1/5Zv0ds2ceOISP1jYavbeDSBmuVICLB2GdMbWnldBk4OtrRDiy12RIBqDWdiI3mwPOz2a9LI7aHJnXCEEQ9C3HoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04xwWlKpfUL5XJz/UKIeC7AAetjrv4OYHyJM2OF5ZMU=;
 b=iaxP8CKUBL96LKPuTQDNftps24L84IfeY+Jm1p1SaoagEA2FSgKwYVeKjk9GAI5OU4jhNqF2SU3WoUko9BO530buzD2vwgjvorFi11QQDUv12U1QfiyGU/6To1977ZgjSsVmeNjtZ1pwEH7De+igJ47EwUcHUVtBLoxj2WVnklSUG98FuRxhS2rAxLxybe8JQv1fAzucOdUm+gOnCGdi739ZRhgAoAGHzBT+GCrWFGnZB4Zr3ZW+eQ2IaJ6n2GldolQWk3fBk4YaECQhnhSoLnboDckrbeb8Jcw89B4TYhBXTyOWRCQCzkenzpivi0iUE900sKa/S2opQI6boakBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04xwWlKpfUL5XJz/UKIeC7AAetjrv4OYHyJM2OF5ZMU=;
 b=qg0zf+/uM+bqT++BcdsdNRttRhHsIkmE2QtMD//FokdaafmgVGMltLQbrnV2KuFAFPptrcI7Jp+3Bzb/lkAZAYHtfomhmr2oxAf68Ub5ZUFWbWgJ8o7OoXOX+q69RDANI9LK7t6sx5N1/QY5IAfsI4g1rIZSBkeKRIfZG7+Ipas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6289.eurprd04.prod.outlook.com (20.179.35.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 12:20:54 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 12:20:54 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, leonard.crestez@nxp.com,
        o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        m.felsch@pengutronix.de, hongxing.zhu@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] mailbox/firmware: imx: support SCU channel type
Date:   Mon, 24 Feb 2020 20:14:31 +0800
Message-Id: <1582546474-21721-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0077.apcprd04.prod.outlook.com (2603:1096:202:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 12:20:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95d77886-9da7-46ab-f12d-08d7b923fe7e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6289:|AM0PR04MB6289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB628992EF2030FA99A0D4875E88EC0@AM0PR04MB6289.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(189003)(199004)(6486002)(66556008)(5660300002)(16526019)(316002)(66476007)(956004)(2906002)(478600001)(186003)(66946007)(36756003)(4326008)(26005)(86362001)(15650500001)(6666004)(81166006)(52116002)(6506007)(9686003)(6512007)(2616005)(7416002)(8936002)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6289;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 806otxI4zRBdyE+kbKD4PYV8lEKZxca2OY7Zji7+Iu+xaobqdU/+fgYH9jU+8M9sUgAGdv1iDCpNacnXW66RJ1OpGUZOiVUdpI+Im5DvzWm52M/l2rqpvh3abGP6SWs0JTl4p5ONlsxXM6Ok1aEiWxJnlIfFxeLaOUyDoAJjys+NK+rRrBMkMyXYXkqyHaP4O1BsEfPh+aXqk3uz1f6vW1SMfdPo7ktsJ5xwP+jPyvYd8jL8BOwstrAOW/Dqm7CGneR5fxEu4+njsIRc6aXxJvWiHz2VyBvmd0Z+egFc2xc28Z2RvDbuOL5g3LMR+Wwk5K16kfYY5wwTTG3E5CwIwPU0GUmqUuC+Kgjp5IpiO0PFGwwF9hB2IkyqMUQkPN7+JUBi8Fq4DbZTEgl5dy5tNpuoWIyxwBwcAmtPj7uf3ga3Ei1NLYCqS7jV4DOF1zgD
X-MS-Exchange-AntiSpam-MessageData: P/bh15ORX3FvZrT4EEYcOEh5xQoHsgZICsPdmMYeDsfjTU+6bU9SvzhIqv8J3ycGSmeDd7xD96gNi3kpc+MHdr2pg5MCFnn84rKsagQWRyAuvhv7pC9s1p3QD2bVGT5esJQop/yti+7eK3H8XWp8Fg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d77886-9da7-46ab-f12d-08d7b923fe7e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 12:20:54.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hB3er9aBN/5I9bN7+7Q16u0MnAHjcFuW3dryhw3op2Csq4BK9ghLCDdiOACE7csSaVT9rw1Wy8At5A6K3o28IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Sorry to bind the mailbox/firmware patch together. This is make it
to understand what changed to support using 1 TX and 1 RX channel
for SCFW message.

Per i.MX8QXP Reference mannual, there are several message using
examples. One of them is:
Passing short messages: Transmit register(s) can be used to pass
short messages from one to four words in length. For example,
when a four-word message is desired, only one of the registers
needs to have its corresponding interrupt enable bit set at the
receiver side.

This patchset is to using this for SCFW message to replace four TX
and four RX method.

Pachset based on i.MX Shawn's for-next branch, commit fd7eba9fa1f534b710.

To test this patchset, I applied the below diff:
 diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
 index fb5f752b15fe..c5636624726e 100644
 --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
 +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
 @@ -140,17 +140,11 @@
 
         scu {
                 compatible = "fsl,imx-scu";
 -               mbox-names = "tx0", "tx1", "tx2", "tx3",
 -                            "rx0", "rx1", "rx2", "rx3",
 +               mbox-names = "tx0",
 +                            "rx0",
                              "gip3";
                 mboxes = <&lsio_mu1 0 0
 -                         &lsio_mu1 0 1
 -                         &lsio_mu1 0 2
 -                         &lsio_mu1 0 3
                           &lsio_mu1 1 0
 -                         &lsio_mu1 1 1
 -                         &lsio_mu1 1 2
 -                         &lsio_mu1 1 3
                           &lsio_mu1 3 3>;
 
                 clk: clock-controller {
 @@ -546,6 +540,7 @@
                         reg = <0x5d1c0000 0x10000>;
                         interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
                         #mbox-cells = <2>;
 +                       fsl,scu;
                 };
 
                 lsio_mu2: mailbox@5d1d0000 {


Peng Fan (3):
  dt-bindings: mailbox: imx-mu: add fsl,scu property
  mailbox: imx: support SCU channel type
  firmware: imx-scu: Support one TX and one RX

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  1 +
 drivers/firmware/imx/imx-scu.c                     | 54 +++++++++++++++++-----
 drivers/mailbox/imx-mailbox.c                      | 42 +++++++++++++++--
 3 files changed, 82 insertions(+), 15 deletions(-)


base-commit: fd7eba9fa1f534b7102f4762e25c991f78ec283d
-- 
2.16.4

