Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C1C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E3F2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/9tfaqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgD2KJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:09:16 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:47200
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbgD2KJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:09:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWn2z936aNg80UCW3Lra2N4NL1eIlp8AIcUPdD5hhB1PjE7wDkz3ZQxtEK88NNUSwPhgPnVU3ZV5QYQSyMwoteWeQgA4VC1w6xY7XzniupHNa0ZjOv/5BeLPJv8nnbFv/f2DXr5J8j7xCAPuq8KKP2SCLRxfU0eCng02NsxoXj12k5JfNm0I6yqzwbw5iCMNTbcqR/nnckQ5W1qyefr4BqYA5pJgMhrWnhVYIBLpRk83km4/BxtnGCSrCkTbQobI2LvJs/l9G9yQ7YSQ+h6+zDfctutp7jHZFcSpafU6iBjQz5IO1hJ+alny7q4CUa76coQ9053SbhsJDVS7TpvdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Btrju7mTfPpAUft/YhgqT08pFUm3sGRrvHZTUmb9O4=;
 b=KFUSY0gzrxrVUHGiWIsNjKHlijrsLICIZ9VpwwRln70fZUX6kgVkPcMtT/HGJw48dYewkrSbkLqXO5kQuAHiJLZxBIgWhJsR2FNTmbY4+U61Q2DFBK0B6y72ftMS9VrRJAYgzSHVOUFeAXBAgTBFyqcXO7YiKcQOJJ/diXuPFiCQWH/Ci2ov9Xfwvz5HviaubxzLuOuaoyZCyb9GO6zyUX/XN0HGM3HOAQbibf1wJTMlLQHOcAuqZwi8wPSgrOA9F1FZnw2B2a5c2F2O83wPowFCKa2WapQkRbURgeF/N+Kau1gUUCWT+dksi/TYXHX5GHEbnGwWML8CegLserX+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Btrju7mTfPpAUft/YhgqT08pFUm3sGRrvHZTUmb9O4=;
 b=V/9tfaqRoll/mRW27QS08DvOtBhUbzfIlBdaxBY/IpuZQOg/+VtFPZVUIZJEE6FPi3TLS6/xPpRGaiZwgDohSqkIQw3y/uzkQ+f0CDkATop14pwRzqnvbmlcVl0xz3WRQ6t9w+bkQvmQeMcD3tTPv8zQguH2wbj1+jVfgtnHJXE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB2745.eurprd04.prod.outlook.com (2603:10a6:3:d7::12)
 by HE1PR0402MB3340.eurprd04.prod.outlook.com (2603:10a6:7:81::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 10:09:12 +0000
Received: from HE1PR0402MB2745.eurprd04.prod.outlook.com
 ([fe80::e802:dffa:63bb:2e3d]) by HE1PR0402MB2745.eurprd04.prod.outlook.com
 ([fe80::e802:dffa:63bb:2e3d%10]) with mapi id 15.20.2937.028; Wed, 29 Apr
 2020 10:09:12 +0000
From:   fugang.duan@nxp.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, fugang.duan@nxp.com,
        aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec" compatible string
Date:   Wed, 29 Apr 2020 18:04:14 +0800
Message-Id: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To HE1PR0402MB2745.eurprd04.prod.outlook.com (2603:10a6:3:d7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611.ap.freescale.net (119.31.174.66) by SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 10:09:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5df26dc8-85eb-4510-397f-08d7ec255d16
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3340:|HE1PR0402MB3340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB334056F40CBACDFAAA4334DDFFAD0@HE1PR0402MB3340.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB2745.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(478600001)(9686003)(6512007)(5660300002)(16526019)(36756003)(6506007)(186003)(956004)(8676002)(2616005)(316002)(66946007)(2906002)(6486002)(86362001)(8936002)(4744005)(26005)(4326008)(66476007)(66556008)(52116002)(6666004)(32563001)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlhyfKOY24NmlzmPmliy9vsyCOmDpOHWVbXRyR1ZlyrWOuPhVdaDEAaWlqzpqFj3dweDAzKB5LplTnVxAD+KAOsOE7+nxpSLHxlI7uaFrWZhLoboM+4VX07D2/7jU5ZgpRGWcVQhOg2OzifsXqCeiSP3gG19gH+yTLLFHtuPpeoLSf11Jo7XnyLHzX2anl2ngTCjZ2BqZp+2YYMnCo62QaQQd+LzIPlMu9TorUqeqogJWK9cdBQIwkmKERqmLTWbb2rVBjPRO/PpkGrfMxNBsT4VvltWL0QWThMT+t7bxKVN6JGGm8+2BZNVkCoSgmN1n7ccgp4T6q8jfhW5TJ7HS4F1u+HpHinNXupTSskiviCweKLkZ6eM1kpB9roVDelNNjVqd8wMbY+NVcRB9FDMLB+m009alBQCrwTxtLNyR4+AP4BSuDjHrXWhmcf//mXp6s0dfWnUtYCczYsjDezqs2MHzyoervmJ+9BagoBeFkseBED/9n6PRjAy7bVrl2yeYU8QKaq1AaG+xdPAgaYzFQ==
X-MS-Exchange-AntiSpam-MessageData: o6QdV5nSxwrt9tAjSvPEuVMsi+lmHKyj3hY2SmxAuBGchbynQrEtsSSETFZDGrnRMI5hKvYt34ShYuwqctpyIYyRBxl4joVNBOV6R+VBTF8O6TP0d4PwhKRQ9IeaP7yHdNRlIFbbpwLu+IvTGqrr6wA3lYROIF4wCcLpcP3zknzAGwGHPSSn39qW1D/IkbP63VPhxsYHen9zglecOU5lOFyDmizD8MKuodU91U1pQ9eJGW1jbs0s+tzODpwLutznBYx8GkOUMidkyHQepnD3+DNTPBTYqkNFSXAxxT6d+cDiwoZ43L9z4EYS0RG9n/KE3yh2I189UoUze/O24Ml5MgKVLW003u+R15EGJ2rvoN4MwuVVxK6B8hG+glioA4opssAtzGY3t0/tYOlSIcBsctqE3QW2Q5vC0QU4LBujB9B5D19UIoGT22jR5vnzkKLuLLduZt0U2v+tWUHT6uuOE+FB86vS4zIywco7qj35aehSa1G4CASKaHEPuRl+VIu9k5z+iimJlXKb3Wv3l5s5lV/Je8zATVy2CvzpSFoXqtfzZbosAe9Q2u6yUd0eFwD/mPsQetjsiSCgSgEQhD47kWSbG9akpTc7pDa4ir3cg9tcxajwc7wkQkS47IToPTeB1kCfTXuW4FyExNpR+kmlgf74GQBsFZGxwRHfcFcWsmO5M+BebASKqrOsutXHJAni6VPLNIVIzh+sPZPIbFuYmubBnKVwq8nLZMpJ4o4X5Ulfwqrc/iWcphppI9h11Wto1mGxb0R1E3eTveQtfcl2yG26bBSXT8YHMRGd9w0g+xM=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df26dc8-85eb-4510-397f-08d7ec255d16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 10:09:12.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auLYe492ZV/m6UFsRqkZwdhVawXc+KmCq5GGumkt79ZMsYmCkNZaddiWY3SYRHxaMj8eqBSwSHP03ifhPPjsig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Add "fsl,imx6sx-fec" compatible string for fec node, then
i.MX8MP EVK ethernet function can work now.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b1616e59d58..b5df957c5063 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -615,7 +615,7 @@
 			};
 
 			fec: ethernet@30be0000 {
-				compatible = "fsl,imx8mp-fec", "fsl,imx8mq-fec";
+				compatible = "fsl,imx8mp-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x30be0000 0x10000>;
 				interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

