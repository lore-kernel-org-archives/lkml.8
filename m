Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6693AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF0820781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="BxeVnW17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMIrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:47:07 -0400
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:13856
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgHMIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibf17SIR8c4O2S9IDHppY4eVA1nF3aCYQEZb3Ljo4TiWXqpw1m6m4gUYwvoQcda4KKIHIP+dNwv3CUCeyvP1UZV4YaqHGt/EMseV7ZAdNX8x2JZEtCZ5PbPDckCFyQTOjCUOFRysey8xjFByFHSLyRnu1AU0rshkh3y56oHeU3LAnVvdHXRziKzoaYypf2QKJ7q7fT7YhcUu3z3btYM4lkvjEkPQEGs52JkRhQtwDyN9+QCeaQc4QU9oS9l5caChDhqsleTh/TrAImu9xaPv+TAql4YI5jJsG6BeU/eYgK/kf9ykW4VMGJRnmvEY+2+ELGswZz0HJN6fRugEk/THPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhCWVFZsuGcRc1ItRvg7yIqCXYWzaJIa3ypdjAmttJg=;
 b=R0WgK0WgkUIUho8O2sxgzjLJ5hVMBtnRhGPlYwe9TmGMjCowjj6Qjx1JYODmW9lHZ1dAMFliNQvCpxTjz+bwfQ1WioJb4svxTDEEbsPRtUdZUa+aDmN6xH19MYDPJVNC6olksFp9HDCt6K5I2WemH7Lnstk1WMzbQXBOnoo8IiRvvTNelLdv+p7OXhQi14jqemBXIbhoVXhuugA7pVyO8c7fCWEokeGWRIlFYcb5NRWn1ptv7ocRNGsYa2jnvH3EGkFIjP0yWhBn3mSDt5rnw9hP72ORcRScupo0t7G3ShBz511sXhEpOG40SjHCezgXz6f62eA+XFYY7vno9FU4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhCWVFZsuGcRc1ItRvg7yIqCXYWzaJIa3ypdjAmttJg=;
 b=BxeVnW17NQc7ar684WzY9aZZsJCRmfSmYu4wvCWINNjjQE2WenhCztDq0R4SXQ7lev8XPHHgRXnI/S0hDeQSqc/6fqmyJI4sJxUnIH39n1bxMG4l4YuXRxGKn50CaoEY434u/C6uuaKYOXOpzX2wD73R3xUhflDrMzs2kjlWuGM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kococonnector.com;
Received: from AM0PR09MB4067.eurprd09.prod.outlook.com (2603:10a6:208:194::14)
 by AM0PR09MB4276.eurprd09.prod.outlook.com (2603:10a6:20b:166::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 08:47:03 +0000
Received: from AM0PR09MB4067.eurprd09.prod.outlook.com
 ([fe80::f9a5:ed5f:e58e:d4db]) by AM0PR09MB4067.eurprd09.prod.outlook.com
 ([fe80::f9a5:ed5f:e58e:d4db%9]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 08:47:02 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     aisheng.dong@nxp.com
Cc:     fabio.estevam@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] arm64: dts: imx8qm: added lvds pwm
Date:   Thu, 13 Aug 2020 10:45:45 +0200
Message-Id: <20200813084547.20875-1-oliver.graute@kococonnector.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:208:14::31) To AM0PR09MB4067.eurprd09.prod.outlook.com
 (2603:10a6:208:194::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM0PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:208:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 08:47:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2.207.138.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9b635ae-2805-40c2-2b89-08d83f6572f0
X-MS-TrafficTypeDiagnostic: AM0PR09MB4276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR09MB427616229E9E3098691B79E8EB430@AM0PR09MB4276.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9sqa6LvfepR91ktARO7gZb85OMBiduSoqH6BSg3UoRfqDSyq5BzZST5R5fw5DGNbdAmPXQBmsSN1VsNGvaw3FsE7WKJUfQpvR3my+p8W307dT7kB0IaO/kH1//v9FhwBQefpVsNL3ua1snfgkDjV96MIdnZbZ3c2AtYPkQpVhLecyEKQllPuzMtnzi/kiscGfNzFHRGnVyXg1KA0xewkIvY9f+WLf0LoFEoRQnU4GJ6qcqFXRg39bc65AAlUMCkS5bfKwF6LN+yQXAEJzslzfP9F47iB95sTTuAOTcxvNg1G1Z4/HqpFHGep+C5sPuwzLXO36ejoUDF3Y5k3Q4M2fwYloK8mQN/TSKtMUlG5g1RGi1csNO/31EMoIpJrC9O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR09MB4067.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(366004)(346002)(376002)(4326008)(16526019)(186003)(44832011)(7416002)(6666004)(2616005)(5660300002)(26005)(956004)(2906002)(54906003)(6486002)(66556008)(66946007)(508600001)(66476007)(316002)(8936002)(8676002)(6496006)(36756003)(1076003)(52116002)(6916009)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ntHWylf2Fi998RgWVk/o0nhBK+d1jAvR7tgH1oMt3Z2F7zYNRVGwbI+MuSvQ8PWTezDpYN60/7+7ai+Zjrm/hGphCynFEl80GbBEu3/M469DA8xpynOu/g57xXM8zT5rM0L7mIpuSQqBvvui6nc2VPGGvvwxXyk7IcjPE/l8kRzbitJakprmbOgG+r3WQJXLesheDfoz4xtGsHJHKLBw2o7zabgmAyw/Db1zmOvOcAKywSpnTBCMNkMPYUTsk5tqjANVv+HLYfhVSrjtS+FM1ZY2HbEPhihiUqT3DCv4iHaYcY0W29bWeR56NdT1QLgc4UswuVBtD6hbrMrY7bHRECpKuTXI1E92aDurE+g7fjwO8YdPsgodh1CxsNTznCNCvTxobqImmGeNHvVArA51P0EbYx/FTr63UFRWXxcy4iAlj7wS+CmZrQzR5Q+CyGduyZxPZEaGn9Ct1d13Eta6fVsxHTtRcB5IGphXZ5bbXV1WEGhdDUsX7EDr6oOn+7hkqsoPiW/RO8SqDGV3TrFJbA5dJ3OzMm5Tb+TP/OUh3B6vFX2BVezcfWuFjjbHeK1WDdxPXaGizpMj5BJwfh2t9pUFxXjXIDHEs1IZqMAB+3PTkDBb2Dgh78B2FZmCW2g+0I36odyg2NITzsfnn8LUQQ==
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b635ae-2805-40c2-2b89-08d83f6572f0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB4067.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 08:47:02.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uoos/nXjlLcseuplLwoGHi32tTik3/w6cXV0IUFlyPYqAZp4RlxjaXk3erVYaoSZ5q8r6tNbj5qUCb3r7qihQ/CqfDP81NItdHfc11Cxzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Aisheng,

I tried to add lvds pwm to imx8qm.dtsi to get backlight working. But without
success. I'am running into this issue:

[    0.858737]  lcd0-pwm0: failed to power up resource 188 ret -22

Can you review and comment please?

This patch is based on your patch series.

Best regards,

Oliver

---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index fd0e706ea011..cf9aea4b26f4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -137,6 +137,22 @@ hsio: hsio@5f080000 {
 		reg = <0x0 0x5f080000 0x0 0xF0000>; /* lpcg, csr, msic, gpio */
 	};
 
+
+	lvds1_pwm: pwm@57244000 {
+		compatible = "fsl,imx8qm-pwm", "fsl,imx27-pwm";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x57244000 0x1000>;
+		clocks = <&pwm0_lpcg IMX_LPCG_CLK_4>,
+			 <&pwm0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		power-domains = <&pd IMX_SC_R_LVDS_1_PWM_0>;
+		status = "disabled";
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.26.0

