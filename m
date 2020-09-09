Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84160C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454FD2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HSIHSKvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgIIQtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:49:19 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:20520
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730877AbgIIQHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjysOS7ratPOUxzGzvbwhWINL9b7IY9ClIrAgkipDVxH49Jjl0jzQ6hlSYVUkTigrLT2WY+zSk5jxkExFLPLm9uztlbxgxRwSMtfl9eQJbl+EK1nuAh9754zUUzqqsm2i0qTAAzRPFgOweQmW1VQzKW25++Jt+PvHpdJSFDDYvilUMQRCuKbs41RIlAua+0cwn51t586RiLpAHrIGrdxY1qBvR/5FuuU/i8qOrIexUJts9lNkGostmFHgN+66KKRQn5mU+CbHt9WB1m7chpQ023POrizO8J35fF5adFK/x/+U0ELfJB+roG8OtyEcI1p9Ef2s9JhypGs4ooGATcCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lihQTziA7S3zqAbrzv1N1gwI19JfbbVgdO1YVjxjwP4=;
 b=aCzVOz59LmzSZLUGtt/Sb8PAq4wpGKRak6XT1Is5JbyG+jp7B2piMmi/64xzJSOL395Vu/31WDlPb4kNyF01Ae76FsiA8wziPX/f6ShvAEzTHC6aAiG+A8gazUHnknlEnOdmsD4hmBXesHOlMhLNwZTPAt27by7mHmZpZePzRXGS/44n65n+AlflxrtXZsGAZSv1hTtJpHyGnOaJ4GJz7tQW4s86FnUvcy9uVCMcQJH3XKa8absEu2JjrOHHwq1ZTmQUMMvpxvblYMxYu50+eH9EiDagoUplqdYcHo80VAsP81nl2ezFRrV2Npdfdhx/rgfk3crHBhEo1jLWatRcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lihQTziA7S3zqAbrzv1N1gwI19JfbbVgdO1YVjxjwP4=;
 b=HSIHSKvtpHZQxWlIBKTh3dNxSuR7detZ8W2o5YolWP3U/Bf5A4YNiT2D/LyDcRkgY03pj7bGbBCtmKR9Fwnu5qIcPCywRENMb1okS8cdZ0/Whgb6RXVqCcThw3l/sqLO03lSIsqNuEZqhs8IIBKVwLZ6/d0fRw1k0jCnXUkrgKs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:44:57 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::1dce:f6ac:a750:5ed0%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 13:44:57 +0000
From:   Wasim Khan <wasim.khan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, V.sethi@nxp.com
Cc:     Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 0/6] arch: arm64: Add label to pcie nodes
Date:   Wed,  9 Sep 2020 19:14:30 +0530
Message-Id: <1599659076-28121-1-git-send-email-wasim.khan@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To VE1PR04MB6702.eurprd04.prod.outlook.com
 (2603:10a6:803:123::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03032.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0095.apcprd02.prod.outlook.com (2603:1096:4:90::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:44:54 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [14.142.151.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 244f241b-06cb-42d2-44dc-08d854c689bd
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB371037B5C96CA68360A7BA7CD1260@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAuT7rK9fUdZlH6A3VQCAN0lvboQianrtILTL3mBQJN2FhWVUOxxC8ludaRFICdqiQSc/jU8OdgBINdkxKugTrO8AVgS/JHTjIl3VS0VX2zzz7PXpqYlaaIbbskNfJJsK1CpSpnDBK50Fx2CitcMs4/U+c/NwzD7IIG/83/nH0zhsKZ/b6J1MSDw671MVG8eezfEtn9lrTA0W57Qsvlr0hqfdoJ+fbBHU+fLZ72dvdMFpnys7koFci9Cg1WwgIEJV1FuFuWpgiH3Fsxyy780PxKvzDdutmQLqk7OEBh7jRjLihT3sz5mQbmJUVc55r22mQzgKJHktZfxflGQTJuRi9Tulj1xUwuxVsbBIuwKs8u06aTx7vUbHDLGNNc7NmKm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(8936002)(5660300002)(1006002)(2616005)(16526019)(4744005)(186003)(8676002)(316002)(956004)(6486002)(44832011)(83380400001)(478600001)(66946007)(6506007)(6666004)(55236004)(52116002)(2906002)(66476007)(66556008)(4326008)(6512007)(26005)(86362001)(110426005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ubZhyrsAPh7/X9UVfOh2fW07py/N88GLliNHrIz4rjwguORYZyqme/6no7oIwhsR61Yjgaf7evILVdCj5osGw7xF6AbdXzN7puLW/wKbOqlp/tnZ33Vx8ZdYpIJNd/iRCcZGu4gUW5SrS7bQjVTsbqWCFVpIICjYVGtATvHxAiAQhacIvpIQFl7G3J6jY61ZRqLyDHxj9znZwtHwk2t1oruJElxKyk+Fyj5Sg8TRF455YmE7vIo6p1dxeKFIelEK2oV980056HeoyWEGWc1S7G/ayW++muXtFjwtnsTNF64mOpjoHI6u2a5eJpedf2BIqiumpGK8GBBMmhi5ERaftf0KQBhSdncVANklXSawd3MoWrzIVilbVBj57LVHo+V+TQH6e6AC153u5ymyGMmP4od/vLmBtpm702Www/rERLsN7Tzyvf2Wm5ckdmEWoYXdCJWCUlzGW2Lv2DtwDRow04TE1YKgVDyVdLv2vSkTEDFzl9Pt3OcNEevbD0vl8R+ffslVO4Z/dCiLCRqkRWQMkucITjZpPmv2uGnJfSfzgcm90VYhXn2rptLOK1pLgIElrlhzbzoh/BKZ0PHXKqDTzrFuiVWfeb4JpFSpCfKJnM1CdPJC9ocURCMnWmbgShcZeFXl63rhrX2Oc5Jp3DRP+w==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244f241b-06cb-42d2-44dc-08d854c689bd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:44:56.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh7z1xHVp+2kMPmtHOF5U6er00grRp/Y/eRO0wkX5+ctRLtGVvZAyn+0/vnh/RNO6Y3Gh4cLhUp5hQFUVZDkYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wasim Khan <wasim.khan@nxp.com>

This patch series adds label to pcie nodes
so that they are easy to refer.

Wasim Khan (6):
  arm64: dts: lx2160a: Add label to pcie nodes
  arm64: dts: ls1012a: Add label to pcie nodes
  arm64: dts: ls1043a: Add label to pcie nodes
  arm64: dts: ls1046a: Add label to pcie nodes
  arm64: dts: ls1028a: Add label to pcie nodes
  arm64: dts: ls1088a: Add label to pcie nodes

 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  5 +++--
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi       | 12 ++++++------
 7 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.7.4

