Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D37C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795BC206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ckBD9Rn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgELHew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:34:52 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:46131
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729105AbgELHes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoEVtvLIAmUuYT7w/KEoXjGC8LZVhy6FhGzHDQZNwfetg7nM5nrT0Ed7BgKmi/GzgfsA+ZSEhLCIX3XSDnMf4BInm5xrXchmkgxgwf1DwydyyE4W9j74E9Z6b/x2R2wV5nAsTvHWfC3r7xwJMBcdYyfmYLXw2czVdnzOxRWg8eothAaGJM70n8V4ShNcgIcvVwIZVV0whqP4T/zBa95K2UvFzmvMsQAejBNMK0a7/Ch0lJPlf7I8HT7MhfbChCszFX5LAW/JTo+QWg8Yu57NP5HF3/1sMX4mgsa3PmNd4UzAbs9GiGJHfaLdXM2UIrcbu2pX8CMaYi+KmOZwsxn1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbE94RXXb1PGc57/+DWQQG3Qm5eLZrZMgFVcM//jU8s=;
 b=JMnTHZ4B/ETda53Osu1G+WxbZRrPVMsOXBTWlCjm+WIBlPhO0dbYKtSFawCxakiBaThNMzjLubyZ7UViEbeyrc/P1TtOl5rUunV2ESUw+zd1NVFFxQxHxeOqZGDcolQJ5J2RmYY1Gi9AMnGnLgmxq+PahajOkxmsabIvC4bClB7hVbOQfUc5mtSJZ3+ojRWsz2FVsIjwyAfpuFXy/hnLiDcnzCgnEAAHjDab6yJO1qPU1ZIXJAaHOcU/6YRheG/Qvzm8vBi3H0//Q1CFe5FPV8b0KbiHjgNbp5BRFV0ufI+jwCOg4P5tQyamxyOJzd42bFKIx4A/zt6LwHJ8kwz56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbE94RXXb1PGc57/+DWQQG3Qm5eLZrZMgFVcM//jU8s=;
 b=ckBD9Rn+BKeqivtp3sRYbYQ7FL7rlJTaD/jEP5H1LqwCOdBM4L1o14JZsiK6732IORdJN9OF7sIzoEflDLv9Z83Y31du72y+TDUTsA1T1Q8mHWQVUwkpOXNA1NbnYIDJLxB8JoGC2vMLa0dEHF1cwW9CiZfWKv5P60karHKB9y4=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB5882.eurprd04.prod.outlook.com (2603:10a6:10:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 07:34:44 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::2924:94ba:2206:216e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 07:34:43 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1 RESEND 3/3] arch: arm64: imx8mq/m/n: remove unused compatible string
Date:   Tue, 12 May 2020 15:31:15 +0800
Message-Id: <20200512073115.14177-4-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:3:1::16) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:3:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 07:34:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fdc86f4-99f9-46c6-4405-08d7f646f016
X-MS-TrafficTypeDiagnostic: DB8PR04MB5882:|DB8PR04MB5882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5882012F7180F45186CBB5E8E6BE0@DB8PR04MB5882.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxdisFZZWnAvbv0wDdR5nUNbJvQv3PJnIsAuvYzXSyr5ek8Z6ubYQTU8T2ZnUteqdwN853YkNZ99PdLNBb1leKSbbRliKcuzL9uApd7VkKd52hghgCuNFWK6e9hBlMt1dLxcYdf62FIMQ3Oz4NFWEIQsfgNUixyww2qfyK55sLx5C73RcPySnwJ4RE1XDz7iHOZ5x/zqqjeWAN7XLrX5r+DxMeBEwb9ncDc4Vol4qSmvIcHzjpqvoeUht3FAYCe6K+geuMeAtCBZInQz2/4QLPPA9kWlKiGDNTjLj1LeXCCnffqZUzh4FQJKh0mUi8E0nDZEg8S0DZ2yxtJWWGab30R3HIZ1O9+N3epDUnrWDweHLTUJFpHJRUbYnFJDjQTRzWfqnrDBHnIQiPCgpmjlRBke62EWOmvWsdcPDJ27LiYLmPRlX8+UEb6G4f+beNUpB0BpnI+FcDrImArTqsp0mD7JoArh63pgjJqEWB4VGZl/wypeCzcvEi5VwDorJgOrhyFxzRohtaO9icL/Q6pnXGF++XH5xqI99QXWVGiGwXzMJMXnKQXfQo7NCcsFtkGAFUfGBrRx0rM85FpqYpkXwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(33430700001)(8676002)(69590400007)(33440700001)(5660300002)(66476007)(36756003)(66946007)(1076003)(8936002)(66556008)(186003)(4326008)(86362001)(16526019)(6666004)(26005)(956004)(316002)(478600001)(2616005)(6512007)(6506007)(2906002)(52116002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R39mFwyfNWpk6xH0RJcAAWZu3vdyGNwnjfuNooEgWgz5VpphGhhgQMwhQcRnE7Fnk2gP7939/pYcPy8HkaTmY9oY5D3sWibvMoCn7GFU3mjgN75Yh+8qH7mNge3aqLSIDvIey5klCEFPqKpfvKGJz6wSM5EjWX1A5oZ8X1beS6qgr3aqjsSEC1QwNqGQsEXk36mNvD0E6u6OWhgH1rS5IPxy8hzeOLKbQS8DP63BdoaxO2ez31tiQHkowtETOTE3aJdeAN5vkqMutUf9CgSRNr2L6gnnPlFmSckTgDxCK2Gy7ggh3rNKHLw9T5efLn9G2rBUFIa06TPqaPcTKzvW58oFPm8EVVua2ltHZ82MBFkqA45U6QqBaGsrrHKxIbbs9R2Q1i+LjTABOsFFX26mIFRID96bKq1/L8g1QK1t8guch0gH0ThISVpkDK9+E800IFnVKzkY2+Iw7ibT+Fi42i6qK7ECe0D/X8MAhsGJCkD3Pwa2FMAFLkhylnbS55kn
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdc86f4-99f9-46c6-4405-08d7f646f016
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 07:34:43.9029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxLfpfQNUWUrD/ux8UjFMbmsDUHQUpSA4UxCB+smJE33QEtaFaoD5S2oVTpYp27UqWaMUOa5tyf9C6uD4snitw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused compatible string.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1e5e11592f7b..136a6653252c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -894,7 +894,7 @@
 		};
 
 		ddr-pmu@3d800000 {
-			compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
+			compatible = "fsl,imx8mm-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a44b5438e842..76c8db04b4f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -793,7 +793,7 @@
 		};
 
 		ddr-pmu@3d800000 {
-			compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
+			compatible = "fsl,imx8mn-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6a1e83922c71..970ffcc664b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1213,7 +1213,7 @@
 		};
 
 		ddr-pmu@3d800000 {
-			compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
+			compatible = "fsl,imx8mq-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

