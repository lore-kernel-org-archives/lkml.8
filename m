Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C741AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F36D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GDG/CV9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGJCOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:14:24 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:37078
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbgGJCOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azr8gQ0xctdNMhuFrxgmv2mlCeHRDry/fhPq/A19WbcX1ChrpLxo7jLm8coiu/54lDeZd6a8N8EYlniW7suecK6opoMbz24yq+MnwLH00/DG91cieT9xl4W9kYuGt/0afSIyp2SPIeON2DHGDc3JFUT8F8esNPpy1D+jj4wg1ikP+nUah2xvaOrxIu5wOPY/Ker2phtxWkOpEmhsFC5mhnMA48Axpi+2nBSisGdCW8uNYvITNL6hUXacNU/i5tFaiAQAwHIZUoXzWGrQaBGfkeh7sZCOQolFUYSoSxNY+gWuAP7qcPCTagN3efBT8uA8m5EYOkuKAJ8cnK93RsP38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0QYca7GiIvKXgsx4y/ok3v22BftPaHRr5wI7cEoebk=;
 b=VvB+ZqWU9dIS2SeRVfgZ2RqIenCjE79luTuC711WrPPhZ12guY5QUI8ZDmEGRQwLXe4ad5wbRXvr/b60HGL14WBRn8+QV1W2Q9geyF7RmpifYup3Vzfs4WHOF0wseS4v/4MhxOzsKGcUGImYS2VIT50KwHO7wLduHqMdJ0tK6cSUXh7jJ7XOylHHXefKg53NPiPqy+UVXBC6BggOwmyG2oe25cXt1mjQ4U4ADsblG12O6j6LR+YV+0KSwWTXeAqO2ujM94P6PPKNt8VCAvVdeZlkr9P/jf235pUWH9l+2xq8YqQXpfCM2LSseoc2iKf8++iONj1sSxjA1Ht6qaHAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0QYca7GiIvKXgsx4y/ok3v22BftPaHRr5wI7cEoebk=;
 b=GDG/CV9RKqzD3O/Rt0Uh+CqdgYDqir+hiDPfPiV9l+GlhW3d7ZMijmNVUhGxyucOSyw4VCDtmaHutCZAT2fWojh1FTovgb+GaHt4IpmQS3alJr+CB+GMiSIyUgin3cx0rSMuO6kNnXXreRDgkpewhR3oQKoWC0I7pNN1z3RyX5s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5082.eurprd04.prod.outlook.com (2603:10a6:10:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 02:14:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3153.032; Fri, 10 Jul 2020
 02:14:20 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     arnd@arndb.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Support i.MX8MM
Date:   Fri, 10 Jul 2020 10:10:53 +0800
Message-Id: <1594347053-30361-1-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:54::24) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.67) by SG2PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:54::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 02:14:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce4641a6-2cc6-4cf8-fa56-08d82476f4a1
X-MS-TrafficTypeDiagnostic: DB7PR04MB5082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB508290C6141AEA8E9E9CFB7E88650@DB7PR04MB5082.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: US0le3W0KRntgEzev01SokYyonFr91Ue+BC1pKiUm8GOCCHkRE51sc/yTGppwrPX9YfDvWBNPe/ePVgsPVR0AxDuQ5GUy7VJBMbmYHwLKzoeU7/6hqHOQHjjhg1fYVyjzWzPhfxBVoLxSDO2Bmz6mVFdP3kb1ctovw9XJMuC/dBJ8bq7HfeFw9I5fHnJNnWyvhYO23QW6wpGFMQYsr2HfTZyp6boOKUlhx6B/de4qU/nFsJPkgKZIJJg37wFqWE0hTMiwDoUW00+Lv1tkp8Ti4Fdg4hu7t7nLVVkBZ12CUDpdMMrviyXLJxkpPj813gOhaEub6/b5a5j9e2tGaWL6NuGYSE/W18sTPTvyxpvBlZhvKqm3yPjHPLWXFVq4SdwbjOWkWQyDhmhiPcw/7DaZcAH3KP/KXQzQxsc6GouSM5tSgiELulIqH+vkZPklyiHe1D9yMrGistOYSFATKB4MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(86362001)(6666004)(478600001)(83380400001)(4744005)(66946007)(66556008)(8936002)(66476007)(956004)(5660300002)(966005)(316002)(2906002)(69590400007)(36756003)(26005)(2616005)(16526019)(6506007)(186003)(4326008)(52116002)(9686003)(6512007)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WLaaSyo0QOVrRPcKUpy0IKcVvlrOOLv4agpoxCmLZZNOVrBggBr5dntxVyajLPzUTEYPjHBBhLAXPqBDmV0Xc+mp6C5qONwQ9vXxFkQF6lRuqkPUZ5+L0t/GfqhM0mT585qi6vxzbHmbGB9ZkcncORxsDGGOgZT2dDMkwPACyfyzLVrxMU7yzfhosjRdyU2myUv3590NUuByUS/LX+ysO8kaFiRDi9hBkhIR2ww2W8fGbD7uYrjN3AjISjjLNtMa1o7PyDnlrixFa+BoZoxgums/BoTfr7QvLTuIBPabALuzyVG49CBzTath297sWbZ1HAWist/f4XGApfQnIJZcB0VEIzBtkgfFumZDdNpgvrt2y7xCrdOycbWRlwIM9XhzNp3ER70sKg0bAKGMrmA79WL6Q9QT9MILVTVUIo6mHa2NEAdBxjl/L4mtT11eofkNlIHTV30skYU870suOMLJB3+3F/PD/WW6ilPqv4Wgi2TgnpPEaN7gMdpGAiADwJSh
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4641a6-2cc6-4cf8-fa56-08d82476f4a1
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 02:14:20.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOT1c7rKLcDvnfFKtEd9Yx4jrIBJMwI1bgTHzOIOYiJTlngYxi9jybI6BTM9+uhI0bCUjEHBWfToXB9YHjnzgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MM is built with AArch64 hardware, this is to support
it could run in Aarch32 mode with clock and pinctrl driver enabled.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

To make kernel boot, needs the GIC_V3 select patch:
https://patchwork.kernel.org/patch/11655383/

 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 87e6400c436b..cb335478ac37 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -217,6 +217,7 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
+CONFIG_PINCTRL_IMX8MM=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_SIOX=m
 CONFIG_GPIO_MAX732X=y
@@ -406,6 +407,8 @@ CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8MM=y
+CONFIG_SOC_IMX8M=y
 CONFIG_IIO=y
 CONFIG_MMA8452=y
 CONFIG_IMX7D_ADC=y
-- 
2.16.4

