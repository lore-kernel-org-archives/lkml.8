Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0709BC35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB94422527
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e19+4dJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgBYDXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:23:35 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:49061
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbgBYDXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:23:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baKBD0/Lw+zV2o3TsHaGAviQpeGyMNI5rA0TiJi0W/1JfctgdkfyCu9RIfFeNQ4qDHUvealsswFcZihrtje16xvcRsJrJnYeJxxw3sTDv3gUh1Gd7mG/qlOWSgy8qyr55u5QfwBIidokwWPOpirufGwwIgM4gLRAPK0862bs09yC9qKdFDFiA+7cdFYC14A6HtK7s5x/ZFj6qb7PeWwiFy2eBCsmonwt21Xh6o5G354snyeyjW4S6r+i8RblTshCA4XAPzUT36Xghp6dlkxjd3KfnFtmTETFo8FGuu5ILZGja9PIePta5XxQ9snZjbxzbVRG6GofsT908AjSeL46dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seLbO9qiGfWraA32vqLUDiLFPPAw5xqA/W/KZBMl6KQ=;
 b=GpFAAM7HwRiApMoDs31Yl2kxu9RSZN1p3NsF22izPXNNe/7ycSkdaHEdL7m7TZ3vonwcUsdB8Sez5mKtYU+1pEyqE5HOUNCz4B1DZFX1KG08mFm/aUV8I1kE+GmdnGyGkLqKC/w9G+4LrC36PoaPUuMu+4CHoqnJBpT344c0nP7sbdon42v9gKjLGm7k7OYx3i1u1CmB7p6H+tZL0vNr+tmnQYN97zel5M7R5EdrEXdZoGXOlkB28rvEFGlgaFrzdfLUGeIuTN4U1KRzVjjrZc0u89VyxvsoL1xh3cD3HdN3ampFJoZAGwjv53uAl7xMI+tUfSLIRieDVCH/jGE4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seLbO9qiGfWraA32vqLUDiLFPPAw5xqA/W/KZBMl6KQ=;
 b=e19+4dJPAa1PYFnzowxH7ZvYU0/SJ6rep6j+QO7BF/XQ/CMNXu6HLr/jeup35kjuG/VZIcvq8us9NWMfBoD3CudqCCiBeXwDd2bEMUj19/DIHQBOrZuAha7lEuDhW19A95+EfyAUds1EbyOVhAFeT7X3Qa9++EBS520CJeZwBhg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5938.eurprd04.prod.outlook.com (20.178.112.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 03:23:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 03:23:26 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] mailbox/firmware: imx: support SCU channel type
Date:   Tue, 25 Feb 2020 11:17:05 +0800
Message-Id: <1582600627-28415-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0089.apcprd04.prod.outlook.com
 (2603:1096:202:15::33) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by HK2PR04CA0089.apcprd04.prod.outlook.com (2603:1096:202:15::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 03:23:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8aa062ef-16f7-4d97-0dfa-08d7b9a213db
X-MS-TrafficTypeDiagnostic: AM0PR04MB5938:|AM0PR04MB5938:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5938819F3B8567D61CD8656688ED0@AM0PR04MB5938.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(6486002)(8676002)(81156014)(81166006)(316002)(15650500001)(66476007)(66556008)(52116002)(66946007)(5660300002)(8936002)(186003)(478600001)(9686003)(6512007)(36756003)(86362001)(6506007)(2616005)(6666004)(2906002)(966005)(956004)(4326008)(26005)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5938;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu7Fo9Q9YgCfsvTTPRx/WKq2Ui9llSeXlAlDEEpo1ItlhlM5Itmlv7IIUgPPHnrFJCuCLUWx+lI3bpZRkRmbOEO1sRJ58Kxupm1RYaZJpF59H6WuPtbm4RqQclNK/6k91psP/D8JM4qq3rLvsVW5fWYJDFNaXGu2IZKp5dg8cFe2dzaXxzr1YDjdwhFm0IVeeZPDriBPc15C5ETgdBTgdCeeOuqGHBilD5k5+5oflw1QpGnvowYOCh1btVwlO7K4KSoGKSp2DkpgUgZ8Dr3KYjJSdJuLrUudoDUenizqcXLUi7RXg++XqlRsdrnM9Kq6G+YHzgCMMAAVjpNauOQ7EK1w6yX7mf+MlbY5xre2VnmJ+JyzFPov1wTVCqpqy2PBllesd5LUK2epBTZyOOlRZNoawalU+fZYjnxGGernyGz0WMjxDLwytdyA/JaxRFN5mRVEdp2sICJZqvA3ALXxnlq//vg0wVavjNhwgVfxH1iDAF+kiuJNQhZ3Xr4quUVbZecCXTRVAhvdEA1S8Q3zZA==
X-MS-Exchange-AntiSpam-MessageData: BF0/PDAuU1FKj+iABuAs1dme1cg/heups8NxKBC1Wt4pcrG8VL2Z7qy8yzbkCo4BS7DEh2UrwoDlf7IpukdxRWI/6tXHnBY8mzLZ2ZZoVamTytwdfCC1zckAZghWfp7iInzlkDFHJgcwByODV7oGfw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa062ef-16f7-4d97-0dfa-08d7b9a213db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 03:23:26.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59mVzFiydMYMFY9zqFqH9JwmpFrvCxb0wNfnvKHObwGjycBHITrnBmQJ+EehoLt2joDzzI65J0vIMZG1Xm6RMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Drop patch 1/3 which added fsl,scu property
 Force to use scu channel type when machine has node compatible "fsl,imx-scu"
 Force imx-scu to use fast_ipc

 I not found a generic method to make SCFW message generic enough, SCFW
 message is not fixed length including TX and RX. And it use TR0/RR0
 interrupt.

 It might need https://patchwork.kernel.org/patch/11395247/ to avoid
 build break.

V1:
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

Peng Fan (2):
  mailbox: imx: support SCU channel type
  firmware: imx-scu: Support one TX and one RX

 drivers/firmware/imx/imx-scu.c | 48 ++++++++++++++++++++++++++++++++----------
 drivers/mailbox/imx-mailbox.c  | 46 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 15 deletions(-)


base-commit: fd7eba9fa1f534b7102f4762e25c991f78ec283d
-- 
2.16.4

