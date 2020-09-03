Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F42C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0092086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W28BevsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgICKPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:15:22 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:9610
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgICKPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:15:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiCVc+fVnH+t86ax41JYlU1dgzZFg4tx1KFMbUUjm2kZdOYgAmqYxlKGWfM9SFD9DwiBoilpn4v03ZJtGUfdKTxitst2l8TLgvmBRDDsU5vKI322ooFf+xpwDeQGWBmK+p2Zg+nLUJRB99+QOR9f3Et7AydxW/pE8+OoiHRMwOFBbRwvOHU7PkmciJm4k7sh88Fkz/gqkSP5w9PQtIDhKNqRBCTxdybiv7E4+y6LGieXOnIHwkn91t1Hsy8Sif5TFv2tZUF+5BVbkpx8393FK6XPkwKaS89Xw2ziSH1qCFQFJmpRIURZlmvbIxs5of12VxNGuoaOJ330AXdSrsm/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtqEfuojKpv/SBI5SAGMCnBDbi7LY9KjxJKWJ1upQFk=;
 b=W7TeG4qmSWaow5rVWojQwP6c7fKViY2zeN+lkKQjqKgu3d5JkofAOtvmTVscirGJHoVtfniGkxo1xgK2rlGyzGuIRrskdyFWzGyZBwtRWOi1Ym4ZEI3t97285NZyafoDX+AlHJXT+DDIf1HQFFr6cgrpbI12YgopIMio49QPvVpnlzfDakryWIWMNqFmxP1OlMXZH9dgfpm6TyDzHMqpEdV/J6WcNBVtcRTOcQD2ea7Wex67Pjm8Xop08RA1qbvq1YfY/pwEHJqni2NUJJZD8ngN9BYvP/+vvfvsYCHx2GOpSDCGwSbQtKYLHflNenWTxm4u8KQcZVnPv3Sv5xGrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtqEfuojKpv/SBI5SAGMCnBDbi7LY9KjxJKWJ1upQFk=;
 b=W28BevsTsDVA+Fv4m7TeyjA7qusvgC3Aqp+tVVWcIJAfpdbpxYtJorBqDmrBY9Y0lLTao9oZqH8e9DBNobm5hhMConUW7FIuf0CKef4LKzAB3j4G7uDYsk5PWnOEyKTHGZD52CU7NhrvJTWSXi7lpDzOags+dcNId0UH2xea20k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR04MB6404.eurprd04.prod.outlook.com (2603:10a6:208:178::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 10:15:15 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::c10b:eaf9:da9a:966e]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::c10b:eaf9:da9a:966e%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 10:15:15 +0000
From:   fugang.duan@nxp.com
To:     shawnguo@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de, fugang.duan@nxp.com
Subject: [PATCH 1/1] ARM: dts: imx6sx: fix the pad QSPI1B_SCLK mux mode for uart3
Date:   Thu,  3 Sep 2020 18:05:21 +0800
Message-Id: <20200903100521.10464-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To AM8PR04MB7315.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d4::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SG2PR03CA0132.apcprd03.prod.outlook.com (2603:1096:4:91::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend Transport; Thu, 3 Sep 2020 10:15:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d218dbf-7e80-4595-73d0-08d84ff2402f
X-MS-TrafficTypeDiagnostic: AM0PR04MB6404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB64046647C0E25EDCC4999D7CFF2C0@AM0PR04MB6404.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNqMx0Y9LpSAWLO6Uaa2rovhZIChtywAek/ZRpRYjssONPItxEJzCaiZdXBNiTXtB3Fs+XhHVaHgcDSOf+lDqBggGl1un8hB2T/s1U8zuyzavkhd82hA2ki5OYzlzKGkM10NrSrI6o+Jz7seXWxqaX5rp+8ctg1r03Vg6mPpSRKiUXN1lsplF2awxLbTkL/XZv3OqnY9xQBKD1dM22I/eUgFoxZoz9Wk/DDjyDqfx5lAKLSpYwNCBB5UzlbpxuH/M8Q77Z+pGRCGC6LhPugMqXoddQFkV9f2H4uJOl//37kpgusMTc9p/qek3AeOh/o43BTmVueXG3B/Hui0VUSbHRrHNM6UiDdnmFr8+rJBHEathdid3VWIW/M6KPBBvTYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(66556008)(66946007)(6666004)(66476007)(36756003)(316002)(52116002)(1076003)(5660300002)(4326008)(8936002)(2616005)(2906002)(83380400001)(9686003)(16576012)(478600001)(26005)(86362001)(6486002)(956004)(8676002)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0c92g24hfzrI7pT9xD5ldXWjX2qmlatLsFN9FbpykxAdGveFyJ76m97zokjqnkDwMjH+VzzuXVMoYgKIJIIrGBm0yM3r4ona2w+O8bL1ScT0PkliD8mTyHQ00/ePUdkKsDCjM6DRfIlCwTlhWdUs8MzbYqNdrpLcyhHJfo6D8QQVvjx+YRja0D4B+oUBY9Wn0d+xkaJDDemheShreGGPlHkRR1Dmrx8k9xYjE2dbF2nVROmmCEF7anEdLAHWkHLBPgsHydgxMEJf/otLKVskISyEESzU8ILFGM9Kv/KBphvoBXuwX4HraJH4+OpQvE79zhODZZaWSaK/6kpl5+tCahX7gO/YjVdJjmXeHVTBenkNJ06jQXFXQT4OyWRQFTZtdD7G2FOvBZo8kCOjU/fLxQs5SEGTp343sAa49IC+nGl6RsCx69GNq54Yl+nw61Q+mzxAnzfXaBPTNjS4Qf1GkYBtTIRe6R42ZNuO+NFfKTzNm9YojIaIbBk9A8+k/GVy31IopZEBc9O7pQcBPjxq3+q3WG7vGDWdtyNQpzmGGthtHZ0Uc/ZedXWu341OzND4ZIHZZPatdOnkiBLJ0cW7d2LBROkAKCCMbQczO5+GMOaSv2lstDmJCx+KnTiVIdkHmcKucekjYp+GBmz4cp23SA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d218dbf-7e80-4595-73d0-08d84ff2402f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 10:15:15.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfv5m+FXsZd1mu9J7/GUQMSiUPxjMkII0xI5Dj0/GM767F8v/PsXAArEMKj57U32VsqVXcPibEwMaE12escrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

The pad QSPI1B_SCLK mux mode 0x1 is for function UART3_DTE_TX,
correct the mux mode.

Fixes: 743636f25f1d ("ARM: dts: imx: add pin function header for imx6sx")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 arch/arm/boot/dts/imx6sx-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx-pinfunc.h b/arch/arm/boot/dts/imx6sx-pinfunc.h
index 0b02c7e60c17..f4dc46207954 100644
--- a/arch/arm/boot/dts/imx6sx-pinfunc.h
+++ b/arch/arm/boot/dts/imx6sx-pinfunc.h
@@ -1026,7 +1026,7 @@
 #define MX6SX_PAD_QSPI1B_DQS__SIM_M_HADDR_15                      0x01B0 0x04F8 0x0000 0x7 0x0
 #define MX6SX_PAD_QSPI1B_SCLK__QSPI1_B_SCLK                       0x01B4 0x04FC 0x0000 0x0 0x0
 #define MX6SX_PAD_QSPI1B_SCLK__UART3_DCE_RX                       0x01B4 0x04FC 0x0840 0x1 0x4
-#define MX6SX_PAD_QSPI1B_SCLK__UART3_DTE_TX                       0x01B4 0x04FC 0x0000 0x0 0x0
+#define MX6SX_PAD_QSPI1B_SCLK__UART3_DTE_TX                       0x01B4 0x04FC 0x0000 0x1 0x0
 #define MX6SX_PAD_QSPI1B_SCLK__ECSPI3_SCLK                        0x01B4 0x04FC 0x0730 0x2 0x1
 #define MX6SX_PAD_QSPI1B_SCLK__ESAI_RX_HF_CLK                     0x01B4 0x04FC 0x0780 0x3 0x2
 #define MX6SX_PAD_QSPI1B_SCLK__CSI1_DATA_16                       0x01B4 0x04FC 0x06DC 0x4 0x1
-- 
2.17.1

