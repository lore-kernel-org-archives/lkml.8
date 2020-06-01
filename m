Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9141C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85712074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rOhrAMwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgFAIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:30:39 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:20832
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbgFAIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4fdpVFx+IwIh8BQu/aXSeKmbFB7J49e5TsZIB/vb/0tyPvTe9l37G+zVo4yRvyeUM22E+uOnM/EKv5gZJO9pn6CkglCrpbeKY7NGuVOOzuBAIEQU07JASh+wKed4KxPlOZHWjTfJJ2JrDuch+bWJLDERw7Xg0bmVNfLXKK26NMRDcqsn7XwfWL6t9th4QuH/tyUExudoDRurOz+ceB7IXHr2vEIeO8hX7VRTvqTUMfWN2mrs3yyLkSFxwKMGjmHwEisZt1tMFDPsUHfFm1zaZxqnVUq1rqY+8bbzfHpikZF6EhCkr7ZzzNm82JhZdm4Cp+zdy/rdH1Mwzh+6ab3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0WWSRyqY1GNfMcjDj7fbIkoFDBf127/I4OYgLWzXXs=;
 b=FDyNTLRLFTfXKtpIMjpxv1s3TV5w9T2WE/jbcEzqlo8HHU4ATSyXPu8/iawLgp9ehrV4P3TShL8agHu56uIOls8k/5XmxjyhCe/8+Y5ezXIyXLUjBDCpBtAw68m1UDpLtZ8DkQp9aedKkNmUcN97Ensy1uVtg5GQWbFJebfM3jyz/fhhTBAzpXcGV5vJ7viIokZJD6GSSxUk+D+vWVBTxkkrLbsgocZpaXAQcfmqalklXnUPtiWbjVpzVlAZGrTOAjFGEjsG3NCOED3ZLCuQFj581uNYKrbf7ke1yAT4v5lpC/HnyHCxY0yHQ5gJRMsajZexmV0M6A/Ih93qeyoKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0WWSRyqY1GNfMcjDj7fbIkoFDBf127/I4OYgLWzXXs=;
 b=rOhrAMwVL0cv3oWTQa4dQUFRqxcBzHIHdPH8TMVmOWJVSZN5vtNv6Enlki+JnJcgLMbganM1yZGBB7k+7WqVHPdQxfkhApTrULgVVKQiR/fgruz/2SYeWWE8aNUKOlc7nh1imMXYB30yG2mZZyU2CWrpte7yDNWh9X68kXmWe30=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2728.eurprd04.prod.outlook.com (2603:10a6:4:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Mon, 1 Jun
 2020 08:30:34 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 08:30:34 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        linux@rempel-privat.de, jaswinder.singh@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/3] dt-bindings: mailbox: imx-mu: support i.MX8M
Date:   Mon,  1 Jun 2020 16:20:00 +0800
Message-Id: <1590999602-29482-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
References: <1590999602-29482-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0044.apcprd02.prod.outlook.com (2603:1096:3:18::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.27 via Frontend Transport; Mon, 1 Jun 2020 08:30:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8916943-98f8-4040-961c-08d806060d71
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2728:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2728F0D645136B93E32FDEEC888A0@DB6PR0402MB2728.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXkxen9tb44n9vZier3+MjpogY5EFbNoBjrhlV1EI3ZyPMeI5SV2OaXcdyZHYnSJn6QEFcRuEmXsre0LZFElFXuMq/Q7xW7Ueq/+eyzxWDz6shPqZKGr0rpbxEwFHXiR9oDUeele/3yDee7dN4QIwUw9Fy7H7K33iEXzttnzoersItJdGEwwCaPmvOsFNIo8PjGLy5DfEt+jYHpnp9A4GoWiCZuYg+/MHNfXXyqaLcj86b8mZ6BtLjTNuS2eIfrtjrHHoCwBHvRPKJ5FZ7OtLOjrEG37VzpEbCeeCxErldJAtutk/cGNOaeBWVJeZvFMxvCbgXiSumgyWpMxs2M0YY/gI+M+cxZQmG2xrwBOkzUm0uOCbGc0F9sBggFX7qNhOtISdEfcz2mnF0QiKJey+HTMNy+Hso06eFBdl/F/+1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(316002)(36756003)(6486002)(6666004)(15650500001)(478600001)(86362001)(8676002)(4326008)(2906002)(83380400001)(69590400007)(66556008)(26005)(2616005)(6512007)(66476007)(8936002)(956004)(16526019)(5660300002)(66946007)(52116002)(9686003)(7416002)(6506007)(186003)(15585785002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tHLmOc4P9QQJNO/ctJO8+J/HJslCeTWcl1XnfCWdyYTLLGs4iPC4BVjtrozc6bSVMpUfXzzqBlLMV3PNVkxLV3hm6pUcB58RbAfLwPXG1bVsLDhgyFs9AmQsA4xeJsEVmBX1L4smVpF6zG6Wdi9lFCuaJoEgr9QB1w/IqaADVGx6ZJ++k3StrYQIlxb0RlUcVcK4XznopjGR0RNd6SnBBWUAlMUj++aStIOdbncdipKIxwNUSDPNM/SyHoxpFBV/VoHl/vmOpNzIctxvhkTx76yzfFZfWu5TGyStdq9oHVRDB2hFp/Buf/UtKfcyRa2Gk4yAXmTImpaHtgsZbjW3pquQzMQ6SGRsNvv7dPaD9lSXaPU06d8lyOc04s9tG93srnK7+7MotLjGcnHHw0PRtULzH4kxhiudjnvRzlYU19cfD7NyYuugEQrBIBLNz2CHC39vIcNH3iEb/nODXZ6FyUHLQjuqpLxKKDuP7IZxbRaOmqtmnPXBZthDnHDct1xo
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8916943-98f8-4040-961c-08d806060d71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 08:30:34.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCHAdkZq8chLf81n2TM3Mahp3Xqqepzlddvr4CvKu502DuNPhyBaP7Taih9/20Pbz8CPQ/g9IYOCgmhrOdEMCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MQ/M/N/P compatible string to support i.MX8M SoCs

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
index 26b7a88c2fea..906377acf2cd 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
@@ -18,7 +18,8 @@ Messaging Unit Device Node:
 Required properties:
 -------------------
 - compatible :	should be "fsl,<chip>-mu", the supported chips include
-		imx6sx, imx7s, imx8qxp, imx8qm.
+		imx6sx, imx7s, imx8qxp, imx8qm, imx8mq, imx8mm, imx8mn,
+		imx8mp.
 		The "fsl,imx6sx-mu" compatible is seen as generic and should
 		be included together with SoC specific compatible.
 		There is a version 1.0 MU on imx7ulp, use "fsl,imx7ulp-mu"
-- 
2.16.4

