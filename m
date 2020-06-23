Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8D820724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eGC5XVIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgFWHBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:01:35 -0400
Received: from mail-eopbgr40075.outbound.protection.outlook.com ([40.107.4.75]:62429
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730793AbgFWHBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Z+vc6O///h31N9oAalx8hHlREJAa3x7G+Sf/SUqbT1lvRl4DvcnURl6juAMvSBj+Cd+YV/yMfvcBtjiG3JYVAyp/4OihuK5S7OceOODyDhr/RRaSkOyqqEDhW3xJ5y3bBfwBe7hWnx+Lse+gRzNnYJovveT2vImI09KfWMAPNlp8fOmueHthNyF2OrYolmZtHIesrrchy7TE6flpg0amETNx0SAlgisj8xk78AYJw0k3rT4gTrzvJwf0eVw8Fh8eduMhQHHakbEJNboAb6IqpMckehv1sEqz7mV0tKNhqhw3Mh9ARVfPc4FvNysssMBfT5ZHVOceDiDXtU6GVMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsQxHD6Ioi18/pcivDAqWDmzwr/sf74RCsJu177TEwg=;
 b=NDK6Ii1IdOJlojQHgQTytGdaHKSo0CbgpC8/oaDV8bHUCTNgbDf9Z+FbJZdsE3Aj8Kesh1IAbcPO+YEWK0Ih/5yIMuPiIYjZSp8/ylqRs75DhMERNgWFMwhZ+EIVBvt9i8KGVmojogUUIR2vgAG0/RkuCKVFUpC6aQGsFmItyQmwwGsHaXHSyfJn92Y7eIYez3JZ0rjEnpANo04AJlEmOLX14zHQMP5L0nnYpETYw0BE9GERaG87Yfi5Gng5qL4nG8wBfcCKRYRwb8+rbCd6jNFFLn7wM5bDqPxuH99ppDPVLfGPzYCQ1YzQLWY0MnBdPy/tQyQ9jaCmTjpOE2hgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsQxHD6Ioi18/pcivDAqWDmzwr/sf74RCsJu177TEwg=;
 b=eGC5XVIE+ZOiwF5HwcgoGNscVZWvqvQHOzdTTqmJbFt/LhpGpWAkyHbnL3dL8nyBxYD+UHSwtxmbFdrSOoKjCh9NFuqskUzbcfV6DhGi4jCL/O3RNX57olGta2me4CHVLhHLY2Qdh+2yfnqDm0zG/e/4pwGupwSvoSYXuiXttk0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2711.eurprd04.prod.outlook.com (2603:10a6:4:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 07:01:29 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 07:01:29 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, fabio.estevam@nxp.com, kernel@pengutronix.de,
        aisheng.dong@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/3] arm64: dts: imx8qxp: add alias for lsio MU
Date:   Tue, 23 Jun 2020 14:49:52 +0800
Message-Id: <1592894994-30015-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
References: <1592894994-30015-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0101.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::27) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR01CA0101.apcprd01.prod.exchangelabs.com (2603:1096:3:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 07:01:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6c18e20-0d8a-4878-3516-08d817434093
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2711:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2711EEB08B194128BA9BF38388940@DB6PR0402MB2711.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vW08guiLU45/fiEyQaAVGdX+WnNgzyV3A0xbn5VoO3OwVyvYkQKMf+vTTfg+IuYeITUXyiGcFogvG6WVuiRbysou6pdn6oQoWMqg1plCFVGEOv+0cCOnXyWFCjNEPHBsjTJHVmfHQCCb05NLwH/JDhlg2f2u3vKtFJyB9xpxgVV3BbI4tXdZnihrF7yiudKSkz+fxbIIbMTiNiDJmMGNH4s338P5c6eFpGY3nog6ySXiUpzuWm44ZYc/bho6B/mBuc17MsSWDZCzJaE7Vh/ox+wAHkaAROnBSJLRNA+KPrYuz563AAXZCCsPi6Tzo5F8N7cs4Fk+9qspYucApojmy6W6JTpYGeMLO0YLY2AqdCmC0UiZzadKeo4tP1IAn0iEh47LIKmUfNRN152uVss9uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(26005)(4744005)(478600001)(6486002)(6666004)(5660300002)(2906002)(186003)(316002)(8936002)(16526019)(66476007)(66556008)(956004)(2616005)(4326008)(66946007)(8676002)(52116002)(86362001)(36756003)(6506007)(6512007)(69590400007)(9686003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4of9nJHWlnguVj6TACQJYN0m47vgJyfAIR0dH7gnqA1EGiMIlBpZXW831G+EC+X9+H/Hv1r6b7NFRIfoBmscNfG8tYJQ+5JlQVD/EdFO2wEdQU+n1Z2MrAzgB2dUUd8HtlL/671G6DyPbwGoQsPllSrNbTFTXbxVVeENz/791rtbRnmIS7qLFehX23Uk/V+D1BzfSrWRHWXoxE4m//+CS/nKBZVsT/0WP03jReyk8ATLoKNDXDoFP7rdaTMrlaYPIWeIhHZ1DmDdGVwtcV+E7pm/WvdYoygY+bB6OE6SavKXYxtKazD4kDM9wE2W0R9AEv3LY+7YI3CmAHkwFRg5Gp6PswthWP8Qr/xBdCpEUYzDJ2iH+bm7uHCY/p3Nx7yeYIz6ob0SMw1vBIuV8h07DWzCvkGnIzWyYkrEHDhiTY+iF+BNbwC5mPvi2NbKVBiKBGir0wMY83XRahEzYSo4hFD18rzD+c2ZTJPaxhMj+X0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c18e20-0d8a-4878-3516-08d817434093
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 07:01:29.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dOdB7BEGStHjH/qEuJgKU0AjBpZwzjt4o0sjATFQCTTd5FuUoh0gJOcM8svk4rfEq1paGtjdRX7rYUSGfnVag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add lsio mu alias for all lsio MUs that could communicate with SCU,
imx_scu_enable_general_irq_channel will parse the alias to get
the mu resource id, if using other MU, not MU1, the `mu_resource_id`
is not what we expect, so add alias to fix this issue.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index d1c3c98e4b39..33363c127478 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -30,7 +30,11 @@
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
+		mu0 = &lsio_mu0;
 		mu1 = &lsio_mu1;
+		mu2 = &lsio_mu2;
+		mu3 = &lsio_mu3;
+		mu4 = &lsio_mu4;
 		serial0 = &adma_lpuart0;
 		serial1 = &adma_lpuart1;
 		serial2 = &adma_lpuart2;
-- 
2.16.4

