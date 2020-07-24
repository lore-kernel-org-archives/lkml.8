Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B53C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4F72074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Do62pTL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGXLlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:41:21 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:38062
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbgGXLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:41:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLFHoUKKcL4ftb8v9+Ri4QvA6XVqgnG4bXB8yLaU4sefgP4GwxMWI+17mXirPxg/0sWSqe66Dp4aoVaKBQgDm7rfokMTVeI1TW+DvFDR4KmpjNHeTdxhXagHJlskwhwwqFPHNZ1gzQpMoSJEHiXWPLIcoqP5doaB+PEq1Dnyfdsa6MoU6b9UlH89uUafjEVGjKFJzdfG8shBZFM7C6cy549BAK9uhbi0Ti4cuNxvdRWsOfvmI0XpEcXdWzFnq1RFy0oth6sE2nNd1A5HjHSLwCPX0xpOOFw7/5NAc0UPq+I4SBhRU7uB+7FaGL2Izt/7peTKehudivAacDxeRcvdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsHO/KvBMsQBpTI0T/MHRQPaSwEqDCU7+44Wnneh4aM=;
 b=RmX7erBU070N4oHuc5sqcN0mQQh5LsggZe1hX7FXwJdJbGXwM+K69+LuJtv+RPCcc+j1GLPMge+/LiGula9R1cCbKDTz6AMAmyvyroToEcZgFNmW9BcJhq/Cyn1UudxMc6VloWn/6SOoNwE0VcZFANREVOlkjWh38kf0E1jLaxP5Qfj6IlNAB4bKemw6aSsYudwLg3axl1CA1pL8otL00AwZtuJYiO9cdhscT+hWh8ZF1OSlFn5PiWI8xkfPq2AU2dFAPtzQRXPGgyp8KyWcHGPzdIALjDIK/dlXmdWp/aJ2onG1hSSD6nZ0ByAR6SMGL2mHsfVLyQYLCFR6dKfU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsHO/KvBMsQBpTI0T/MHRQPaSwEqDCU7+44Wnneh4aM=;
 b=Do62pTL1dtrr8JNZWO4cLY0HjY3Z67Ig1RU8jPMQ1O/c12rKcCj3oOxSC3sdsj1Mq+qa9nPSBfSzHlXs2E5yEZMzq5PpWaL3Y9iH1iYLMRK87z8ty/IrbLRmNvNSXtXv7Yg7Op5kirU20lIjLfvQpZFATpykMnMnC7lGdo6bKMw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR0402MB3375.eurprd04.prod.outlook.com (2603:10a6:803:2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 11:41:17 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e%3]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 11:41:17 +0000
From:   Vabhav Sharma <vabhav.sharma@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     V.Sethi@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: qds: enable lpuart1
Date:   Fri, 24 Jul 2020 17:04:42 +0530
Message-Id: <1595590482-26833-1-git-send-email-vabhav.sharma@oss.nxp.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from uefi-OptiPlex-790.ap.freescale.net (92.120.0.71) by SG2PR03CA0097.apcprd03.prod.outlook.com (2603:1096:4:7c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3239.9 via Frontend Transport; Fri, 24 Jul 2020 11:41:14 +0000
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [92.120.0.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1ee4ff6-69d2-4278-9034-08d82fc67a4d
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3375:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33757AF15B20EFB1FBCB8AC0B2770@VI1PR0402MB3375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIVHPUIPvyM4PhPLh/c/GdfT7tUERzuPjdOGJMWy0sCdO4dHDyy/USOU6ZdxWKXCINaJdREElzOp33MH3NcRAzottzFQtbKguEPACRisXI1asTLcPCtDnM6P43AhXxzX9d4pZNwlWRNugnqrmjO3XfFpOsx4Byo5OtLZb23KjDjLitK2+oh2s7QHIPrjkm9DZhC7C28D7N0UOQDysSJu2BDsDbOiQnlVMvRUaN/aEnFMaTwoD4kAHYmiEQVyaLjPrA7ZSMmEhOtx3XBhq/26kVFJG1+RmhNsyUeCHjdGMudbTFsDL7FRMsnx8bArFlZtgbDE/n6mi0pG9ptq3kcl9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(5660300002)(478600001)(66476007)(316002)(86362001)(4744005)(66556008)(4326008)(66946007)(2906002)(6506007)(186003)(6486002)(83380400001)(8676002)(26005)(16526019)(956004)(6666004)(2616005)(6512007)(44832011)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TrF6YiOAr3JZXmc9yWEYdI9QsElB9Dx/uBPBZ8JBj4xn7H75orTuwB84vxz349w6Xq2WZz7PWrPl3q1MEUw4k/4VcTlfjpoeWQJ0+qEPJGUBPgBwXDptXL10sNR4sHhPU3+BIMH/8bs+f1vOAIIlGooXystugiLe+3UAbd3JSivzeo8E7fFK9hM+R8BXSEbH7gYO/DXdAhpmICawIMb0dEG0yCNpMXUqjD88/BLCLUBSUg7PdUeuwopxQfsF0k2o35bMOewFzwHrR+VX76t+iL9Vvb0EEmY+CRblYR3R52ctPt/jTxyNiQ7KDGrvCIL11CXWI8cSgKp6xuIv2zUJ62aTFe96UnIt84d0DQKtotru9sWLSIcybnERpAMnccRJeGzVhNkkbai2wzaxwLeLt44mHMTHMIimBjBDdjbXrw8lhHNwG97gGV6WwJwDQ/JDyFll0Szshhr86GLalsqUbItiPmAN6cv5mBQSQoPGihs=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ee4ff6-69d2-4278-9034-08d82fc67a4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 11:41:17.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsWDyzBGbYbNZj0QdPLrKymqT2asFoARt/SzJdGJj9ynRVnOuvvd1h4xcHOOZFkUYGiiWlvNFw2wAFBxmCQNpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vabhav Sharma <vabhav.sharma@nxp.com>

LPUART nodes by default are disabled in LS1028A device
tree, Enabling LPUART1 node

Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index dd69c5b..045f748 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -228,6 +228,10 @@
 	status = "okay";
 };
 
+&lpuart0 {
+	status = "okay";
+};
+
 &sai1 {
 	status = "okay";
 };
-- 
2.7.4

