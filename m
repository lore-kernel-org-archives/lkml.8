Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA75E208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IssFgC/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIACIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:08:09 -0400
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:64865
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgIACII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRNmVoz5z6dpciCVwa1zQtXFaNYKEsWAcbnfWhKIba4j6NHJm6dVSKA7AVTupgNboJ1LwV/8H3qv7I2g8wBTcgnGabkg4ng2/D+b6nodcrO429ykY8J2eYNCQD1bFhL1Icak+2ojcXbiZH7geNCW6mch6pK/OzwkkdAoknQYC90qv1M89cLZZi7zoLWCYw8krXy+o242K0wbliCjsNn7kmH4o3SLMU7mKMhkxxURKeN3eoMMXsIBV0uGSc0ysKBrwRs2STFL88gLcGCJcSS96V0rb7MSGM1qbcbr0JRRkh+ukT3wGbzo3LafeKse6RLkSBLPuA+qPRetZbL08vKrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+NazmLuNG8c9HYs1fDjzbg2LB4YU4yl5HPQ3Tk7LkA=;
 b=H26mlhe5vCPyxxhGaEgPLg6ZwqL0SyyIBG4nfPf48G2VJxc5G05XcHSHlA2iH30+LA8hvlczl5zrVWWEHp0B3aTBx20r5ARe2xI0IJipt4K6CfF146MFlpsQJm389xNwLVtBF2KD3DmYp7rvbTvySYmOQk94eAa9fTUUY22J/BRewL1YvpNS/jbBe/baaGJoc5rKUDAXE5No2x3VNMtJfx7NhNu2SLw6Pax61mrHvOQPsEb13g3gOjgOduJi9YbI7EzHm6aXjaqkzqVmJkCL1trFJQTkbmEU4I1QrN6BkdPdzB2WzNe37bnpLEdVuIWgQIURcTaF0QsI6CSBU0DYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+NazmLuNG8c9HYs1fDjzbg2LB4YU4yl5HPQ3Tk7LkA=;
 b=IssFgC/eKtV7aG+GQqWVXKylB0kjj0fm5hMzfsu9nFV/JMLd6eCRdQN6xw/Xj78+x3T0+Ftgre4zgrQWu0unsN1GDPNZuOdRFTEd/q3C03ILn3r3iMaUPAeJYUOX8FxAvTPbxSsvlgfWxHw/04LWINunrYu8Vjgt2PFe+KezYcM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0401MB2302.eurprd04.prod.outlook.com (2603:10a6:800:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 02:08:03 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 02:08:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, Anson.Huang@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 RESEND] ARM64: dts: imx8mp: correct sdma1 clk setting
Date:   Tue,  1 Sep 2020 18:21:49 +0800
Message-Id: <1598955709-28688-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0135.apcprd04.prod.outlook.com
 (2603:1096:3:16::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0135.apcprd04.prod.outlook.com (2603:1096:3:16::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 02:08:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70d9755d-b698-4136-f471-08d84e1bdbdd
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB230208228AC11B6DD255B838892E0@VI1PR0401MB2302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QRsh/gb94/wTU8ck0CZZ+z7fk4ssuce7Y1j5TZOmL7K05SmH3PMGzDbGI8L4oCcQmRRXD1ZbJfMQbUBTQhT5Mv4/H4Nz444PKM6Xdr5RP4d9LZZhua+iHFh8I/Svl5BTcXGVf4YD7IL5vsloIlLyXBMKLDJ0LcBizhrmIfBYfg0M3+S4yVvfsSPr2WkHyzfVtH+c6N0e3/Z2nBne0bFvQmGHiMS7fftSc8Nn0eJ8i1l47lhM4i4kxDm2Dhylsvg7i8/FNWlm/j4vR1mL6neYKYOkt0IenphoFTr7RKLbYoiyJGzsaEvuHDUnCmk9u4OT7NCuBXMEsc3bwjzf9+lpkkgzy8d59Rrk3vekPE0el1MVrvlWlh/UiKNf8E2ACgE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(66556008)(16526019)(4744005)(6506007)(6636002)(956004)(316002)(2616005)(186003)(26005)(52116002)(86362001)(66476007)(66946007)(6486002)(6512007)(36756003)(8676002)(2906002)(5660300002)(478600001)(6666004)(4326008)(83380400001)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bPnOO750MHdaqV9owwSmp2vEqljKdzukZbHrZzDfggG/LLsz+wMPiXP2H/NyyE/77o346VCFbbAzHOISHexyomrgxBKb4aT/I0ckTFvqB76d5EHkyn4lwPOU4ovQSnz2ZRPkrPPH666p/Kf8rF8L+0ciHElDvQIsW6gKkDSSFCyu6OPBALA4rxfsb7Z/rXBC3aDArBWaxtR5QhlFHRDiMlXXU9DkdOcAFo1fCzeU3nkeNLLgSKHcKX0AikIPnepoCHit9UGKD5arL1X5QstXbFSGXViroDw7oVx2HqQG2yqtuIAw+vYEheFWvLRSkXCjPgnQ605z09Z7GQY2AuAVB5fJKg9TQhS39WHcsUzlkEeTcp+A1dtHeYrvkZQyO2iev3RwIlMNvqgY/W0QmVuiCtZFh4nMz9v81JlNE6ZBUrsS/NtHYm28n6NU717IBL6mgeP30ld2ZTX73THciYCNwjIzS4iUC54rsmg5PdwUY5J7bjOF23jAX+kxeUylIwvBftTeISyLvoFBArR15eA3+6QnVCadS6qL1F5tV4SNIrsBLB9bIUVFlzC+uOmM5OaiLeUu2y7Cy1FznTlS+N2Q4vt+mv0SvG5ZLUM6khnbVIvSzCkHl9n6cPYVSr+nRYHeQcLK2OmoCVcy8TpAZTdObw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d9755d-b698-4136-f471-08d84e1bdbdd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 02:08:03.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ6RPURIJiR6wmQZ9rUw5G9h1oWdSx2QyLzstgS6o6G9aBaSsrt034n2QDHTBrslQBElV1gCluGamLnoAatYCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct sdma1 ahb clk, otherwise wrong 1:1 clk ratio will be chosed so
that sdma1 function broken. sdma1 should use 1:2 clk, while sdma2/3 use
1:1.

Fixes: 6d9b8d20431f ("arm64: dts: freescale: Add i.MX8MP dtsi support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cad2dd7..6038f66 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -702,7 +702,7 @@
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_SDMA1_ROOT>,
-					 <&clk IMX8MP_CLK_SDMA1_ROOT>;
+					 <&clk IMX8MP_CLK_AHB>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
-- 
2.7.4

